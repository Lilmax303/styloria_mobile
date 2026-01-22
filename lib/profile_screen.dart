// lib/profile_screen.dart

import 'package:flutter/material.dart';
import 'profile_picture_screen.dart';
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';
import 'api_client.dart';
import 'my_reputation_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _loading = true;
  bool _saving = false;
  bool _loadingReputation = true;

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dobController = TextEditingController();

  String _username = '';
  String _role = '';
  String? _profilePictureUrl;

  // Reputation data
  double _averageRating = 0.0;
  int _totalReviews = 0;

  @override
  void initState() {
    super.initState();
    _loadProfile();
    _loadReputation();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _loadProfile() async {
    setState(() => _loading = true);

    final data = await ApiClient.getCurrentUser();

    if (!mounted) return;

    if (data != null) {
      _username = data['username']?.toString() ?? '';
      _role = data['role']?.toString() ?? '';
      _firstNameController.text = data['first_name']?.toString() ?? '';
      _lastNameController.text = data['last_name']?.toString() ?? '';
      _emailController.text = data['email']?.toString() ?? '';
      _phoneController.text = data['phone_number']?.toString() ?? '';
      _dobController.text = data['date_of_birth']?.toString() ?? '';
      _profilePictureUrl = data['profile_picture_url']?.toString();
    }

    setState(() => _loading = false);
  }

  Future<void> _loadReputation() async {
    // Only load reputation for non-provider users
    final userData = await ApiClient.getCurrentUser();
    if (userData?['role'] == 'provider') {
      setState(() => _loadingReputation = false);
      return;
    }

    try {
      final reputation = await ApiClient.getMyReputation();
      if (!mounted) return;

      if (reputation != null) {
        setState(() {
          _averageRating = (reputation['average_rating'] as num?)?.toDouble() ?? 0.0;
          _totalReviews = (reputation['total_reviews'] as int?) ?? 0;
          _loadingReputation = false;
        });
      } else {
        setState(() => _loadingReputation = false);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _loadingReputation = false);
      }
    }
  }

  Future<void> _pickDob() async {
    DateTime initialDate =
        DateTime.now().subtract(const Duration(days: 365 * 18));

    try {
      if (_dobController.text.isNotEmpty) {
        final parts = _dobController.text.split('-');
        if (parts.length == 3) {
          final y = int.parse(parts[0]);
          final m = int.parse(parts[1]);
          final d = int.parse(parts[2]);
          initialDate = DateTime(y, m, d);
        }
      }
    } catch (_) {}

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      final y = picked.year.toString().padLeft(4, '0');
      final m = picked.month.toString().padLeft(2, '0');
      final d = picked.day.toString().padLeft(2, '0');
      setState(() {
        _dobController.text = '$y-$m-$d';
      });
    }
  }

  Future<void> _saveProfile() async {
    setState(() => _saving = true);

    final payload = <String, dynamic>{
      'first_name': _firstNameController.text.trim(),
      'last_name': _lastNameController.text.trim(),
      'email': _emailController.text.trim(),
      'phone_number': _phoneController.text.trim(),
    };

    final dob = _dobController.text.trim();
    if (dob.isNotEmpty) {
      payload['date_of_birth'] = dob;
    }

    final updated = await ApiClient.updateCurrentUser(payload);

    if (!mounted) return;

    setState(() => _saving = false);

    if (updated == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).failedToSaveProfile)),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).profileUpdated))
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (_loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text(l10n.profile),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profile),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Profile Picture Section
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ProfilePictureScreen(),
                ),
              ).then((_) {
                _loadProfile();
              });
            },
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: _profilePictureUrl != null
                      ? NetworkImage(_profilePictureUrl!)
                      : null,
                  child: _profilePictureUrl == null
                      ? const Icon(Icons.person, size: 40)
                      : null,
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.tapToChangeProfilePicture,
                  style: TextStyle(color: Colors.blue, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // ⭐ NEW: Customer Rating Section (only for non-providers)
          if (_role != 'provider') ...[
            _buildRatingSection(isDark),
            const SizedBox(height: 20),
          ],

          Text(l10n.usernameValue(_username)),
          Text(l10n.roleValue(_role)),
          const SizedBox(height: 16),
          TextField(
            controller: _firstNameController,
            decoration: InputDecoration(
              labelText: l10n.firstName,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _lastNameController,
            decoration: InputDecoration(
              labelText: l10n.lastName,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: l10n.email,
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _phoneController,
             decoration: InputDecoration(
              labelText: l10n.phoneNumber,
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _dobController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: l10n.dateOfBirthYyyyMmDd,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: _pickDob,
                icon: const Icon(Icons.calendar_today),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: _saving ? null : _saveProfile,
              child: _saving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(l10n.saveProfile),
            ),
          ),
        ],
      ),
    );
  }

  /// ⭐ NEW: Builds the customer rating display card
  Widget _buildRatingSection(bool isDark) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const MyReputationScreen()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey.shade800 : Colors.blue.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark ? Colors.grey.shade700 : Colors.blue.shade100,
          ),
        ),
        child: Row(
          children: [
            // Star icon with rating
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.star,
                color: Colors.amber,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            // Rating details
            Expanded(
              child: _loadingReputation
                  ? const Center(
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Customer Rating',
                          style: TextStyle(
                            fontSize: 13,
                            color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              _averageRating.toStringAsFixed(1),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              '/ 5.0',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Star row
                            ...List.generate(5, (index) {
                              return Icon(
                                index < _averageRating.round()
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                                size: 16,
                              );
                            }),
                          ],
                        ),
                        Text(
                          '$_totalReviews ${_totalReviews == 1 ? 'review' : 'reviews'} from providers',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
            ),
            // Arrow to indicate tappable
            Icon(
              Icons.chevron_right,
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
          ],
        ),
      ),
    );
  }
}