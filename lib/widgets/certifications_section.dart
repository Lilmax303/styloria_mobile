// lib/widgets/certifications_section.dart

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';

import '../api_client.dart';

class CertificationsSection extends StatefulWidget {
  final VoidCallback? onCertificationsChanged;
  
  const CertificationsSection({
    super.key,
    this.onCertificationsChanged,
  });

  @override
  State<CertificationsSection> createState() => _CertificationsSectionState();
}

class _CertificationsSectionState extends State<CertificationsSection> {
  bool _loading = true;
  List<dynamic> _certifications = [];
  int? _trustScore;
  String? _currentTier;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadCertifications();
  }

  Future<void> _loadCertifications() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final data = await ApiClient.getMyCertifications();
      if (data != null) {
        setState(() {
          _certifications = data['certifications'] as List<dynamic>? ?? [];
          _trustScore = data['trust_score'] as int?;
          _currentTier = data['current_tier'] as String?;
          _loading = false;
        });
      } else {
        setState(() {
          _error = 'Failed to load certifications';
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Future<void> _showAddCertificationDialog() async {
    final nameController = TextEditingController();
    final orgController = TextEditingController();
    DateTime? issueDate;
    DateTime? expiryDate;
    PlatformFile? selectedFile;
    String? fileError;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.add_circle, color: Colors.green),
              SizedBox(width: 8),
              Text('Add Certification'),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Certification Name *',
                    hintText: 'e.g., Licensed Cosmetologist',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: orgController,
                  decoration: const InputDecoration(
                    labelText: 'Issuing Organization',
                    hintText: 'e.g., State Board of Cosmetology',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                // Issue Date
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    issueDate != null
                        ? 'Issue Date: ${DateFormat('MMM d, yyyy').format(issueDate!)}'
                        : 'Issue Date (Optional)',
                  ),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: issueDate ?? DateTime.now(),
                      firstDate: DateTime(1990),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      setDialogState(() => issueDate = picked);
                    }
                  },
                ),
                // Expiry Date
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    expiryDate != null
                        ? 'Expiry Date: ${DateFormat('MMM d, yyyy').format(expiryDate!)}'
                        : 'Expiry Date (Optional)',
                  ),
                  trailing: const Icon(Icons.event),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: expiryDate ?? DateTime.now().add(const Duration(days: 365)),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      setDialogState(() => expiryDate = picked);
                    }
                  },
                ),
                const SizedBox(height: 16),
                // Document Upload (REQUIRED)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: selectedFile != null 
                        ? Colors.green.shade50 
                        : Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: selectedFile != null 
                          ? Colors.green.shade300 
                          : Colors.orange.shade300,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Icon(
                            selectedFile != null 
                                ? Icons.check_circle 
                                : Icons.warning_amber,
                            size: 18,
                            color: selectedFile != null 
                                ? Colors.green 
                                : Colors.orange.shade700,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Document Upload *',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: selectedFile != null 
                                  ? Colors.green.shade700 
                                  : Colors.orange.shade700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        selectedFile != null
                            ? 'Required for verification'
                            : 'A document is required to verify your certification',
                        style: TextStyle(
                          fontSize: 11,
                          color: selectedFile != null 
                              ? Colors.green.shade600 
                              : Colors.orange.shade600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Allowed: PNG, JPG, JPEG (max 5MB) or PDF (max 10MB)',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton.icon(
                        onPressed: () async {
                          final result = await FilePicker.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
                            withData: true,
                          );
                          if (result != null && result.files.isNotEmpty) {
                            final file = result.files.first;

                            // Check file size
                            final maxSizeImage = 5 * 1024 * 1024; // 5 MB
                            final maxSizePdf = 10 * 1024 * 1024;  // 10 MB
                            final ext = file.extension?.toLowerCase() ?? '';
                            final maxSize = ext == 'pdf' ? maxSizePdf : maxSizeImage;
                            final maxSizeDisplay = ext == 'pdf' ? '10 MB' : '5 MB';

                            if (file.size > maxSize) {
                              setDialogState(() {
                                fileError = 'File too large. Max size for ${ext.toUpperCase()} is $maxSizeDisplay';
                              });
                              return;
                            }
                            setDialogState(() {
                              selectedFile = file;
                              fileError = null;
                            });
                          }
                        },
                        icon: Icon(
                          selectedFile != null ? Icons.swap_horiz : Icons.upload_file,
                        ),
                        label: Text(
                          selectedFile != null
                              ? 'Change Document'
                              : 'Select Document',
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: selectedFile != null 
                              ? Colors.green 
                              : Colors.orange.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
                if (selectedFile != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        const Icon(Icons.attach_file, size: 16, color: Colors.green),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            selectedFile!.name,
                            style: const TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        TextButton(
                          onPressed: () => setDialogState(() => selectedFile = null),
                          child: const Text('Remove', style: TextStyle(color: Colors.red, fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                if (fileError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      fileError!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                const SizedBox(height: 12),
                // Info about verification
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, size: 16, color: Colors.blue.shade700),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Trust score will be added after admin verification (24-48 hours)',
                          style: TextStyle(fontSize: 11, color: Colors.blue.shade700),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Validate document is selected
                if (selectedFile == null) {
                  setDialogState(() {
                    fileError = 'Please upload a document to verify your certification';
                  });
                  return;
                }
                Navigator.pop(context, true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );

    if (result == true && nameController.text.trim().isNotEmpty && selectedFile != null) {
      await _addCertification(
        name: nameController.text.trim(),
        organization: orgController.text.trim(),
        issueDate: issueDate,
        expiryDate: expiryDate,
        document: selectedFile,
      );
    }
  }

  Future<void> _addCertification({
    required String name,
    String? organization,
    DateTime? issueDate,
    DateTime? expiryDate,
    PlatformFile? document,
  }) async {
    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final result = await ApiClient.addCertification(
        name: name,
        issuingOrganization: organization,
        documentBytes: document?.bytes,
        documentName: document?.name,
        issueDate: issueDate != null ? DateFormat('yyyy-MM-dd').format(issueDate) : null,
        expiryDate: expiryDate != null ? DateFormat('yyyy-MM-dd').format(expiryDate) : null,
      );

      Navigator.pop(context); // Close loading

      if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Certification submitted! Trust score will update after verification.'),
            backgroundColor: Colors.green,
          ),
        );
        _loadCertifications();
        widget.onCertificationsChanged?.call();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to add certification'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      Navigator.pop(context); // Close loading
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> _deleteCertification(int id, String name) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Certification?'),
        content: Text('Are you sure you want to delete "$name"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final result = await ApiClient.deleteCertification(id);
      if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Certification deleted. Trust Score: ${result['trust_score']}'),
            backgroundColor: Colors.orange,
          ),
        );
        _loadCertifications();
        widget.onCertificationsChanged?.call();
      }
    }
  }

  Map<String, dynamic> _getTierInfo(String? tier) {
    switch (tier?.toLowerCase()) {
      case 'premium':
        return {
          'color': const Color(0xFFA855F7),
          'bgColor': const Color(0xFFF3E8FF),
          'icon': Icons.workspace_premium,
          'badge': '💜 Premium',
        };
      case 'standard':
        return {
          'color': const Color(0xFF3B82F6),
          'bgColor': const Color(0xFFDBEAFE),
          'icon': Icons.verified_user,
          'badge': '💙 Standard',
        };
      default:
        return {
          'color': const Color(0xFF22C55E),
          'bgColor': const Color(0xFFDCFCE7),
          'icon': Icons.eco,
          'badge': '💚 Budget',
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (_loading) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (_error != null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text('Error: $_error'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _loadCertifications,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    final tierInfo = _getTierInfo(_currentTier);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Trust Score
            Row(
              children: [
                Icon(Icons.verified, color: tierInfo['color'] as Color),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Certifications & Licenses',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Trust Score Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                     color: isDark 
                        ? (tierInfo['color'] as Color).withOpacity(0.2)
                        : tierInfo['bgColor'] as Color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        tierInfo['icon'] as IconData,
                        size: 16,
                        color: tierInfo['color'] as Color,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${_trustScore ?? 0}/100',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: tierInfo['color'] as Color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Add your professional certifications to increase your trust score and unlock higher-tier jobs.',
              style: TextStyle(
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600, 
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 16),

            // Certifications List
            if (_certifications.isEmpty)
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey.shade800 : Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.description_outlined, 
                      size: 48, 
                      color: isDark ? Colors.grey.shade500 : Colors.grey.shade400,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'No certifications yet',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Add your licenses and certifications to earn up to 15 trust points!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isDark ? Colors.grey.shade400 : Colors.grey.shade600, 
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _certifications.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final cert = _certifications[index] as Map<String, dynamic>;
                  final isVerified = cert['is_verified'] == true;
                  final isExpired = cert['is_expired'] == true;
                  final isPending = !isVerified && !isExpired;

                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: isVerified
                            ? (isDark ? Colors.green.shade900 : Colors.green.shade50)
                            : isExpired
                                ? (isDark ? Colors.red.shade900 : Colors.red.shade50)
                                : (isDark ? Colors.orange.shade900 : Colors.orange.shade50),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        isVerified
                            ? Icons.verified
                            : isExpired
                                ? Icons.warning
                                : Icons.hourglass_top,
                        color: isVerified
                            ? (isDark ? Colors.green.shade300 : Colors.green)
                            : isExpired
                                ? (isDark ? Colors.red.shade300 : Colors.red)
                                : (isDark ? Colors.orange.shade300 : Colors.orange),
                      ),
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            cert['name']?.toString() ?? 'Certification',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        if (isVerified)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: isDark ? Colors.green.shade900 : Colors.green.shade100,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Verified',
                              style: TextStyle(
                                fontSize: 10, 
                                color: isDark ? Colors.green.shade300 : Colors.green,
                              ),
                            ),
                          ),
                        if (isPending)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: isDark ? Colors.orange.shade900 : Colors.orange.shade100,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Pending',
                              style: TextStyle(
                                fontSize: 10, 
                                color: isDark ? Colors.orange.shade300 : Colors.orange,
                              ),
                            ),
                          ),
                        if (isExpired)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: isDark ? Colors.red.shade900 : Colors.red.shade100,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Expired',
                              style: TextStyle(
                                fontSize: 10, 
                                color: isDark ? Colors.red.shade300 : Colors.red,
                              ),
                            ),
                          ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (cert['issuing_organization']?.toString().isNotEmpty == true)
                          Text(
                            cert['issuing_organization'].toString(),
                            style: TextStyle(
                              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                            ),
                          ),
                        if (cert['expiry_date'] != null)
                          Text(
                            'Expires: ${cert['expiry_date']}',
                            style: TextStyle(
                              color: isExpired ? Colors.red : Colors.grey.shade500,
                              fontSize: 12,
                            ),
                          ),
                        if (isPending)
                          Text(
                            'Under review (24-48 hours)',
                            style: TextStyle(
                              color: isDark ? Colors.orange.shade300 : Colors.orange,
                              fontSize: 11,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () => _deleteCertification(
                        cert['id'] as int,
                        cert['name']?.toString() ?? 'Certification',
                      ),
                    ),
                  );
                },
              ),

            const SizedBox(height: 16),

            // Add Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _certifications.length >= 10 ? null : _showAddCertificationDialog,
                icon: const Icon(Icons.add),
                label: Text(
                  _certifications.length >= 10
                      ? 'Maximum 10 certifications'
                      : 'Add Certification',
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),

            // Trust Score Info
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? Colors.amber.shade900.withOpacity(0.3) : Colors.amber.shade50,
                borderRadius: BorderRadius.circular(8),
                border: isDark ? Border.all(color: Colors.amber.shade700) : null,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.lightbulb, 
                    size: 20, 
                    color: isDark ? Colors.amber.shade300 : Colors.amber.shade700,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Certifications add up to 15 points to your trust score. Reach 80+ to unlock Premium jobs!',
                      style: TextStyle(
                        fontSize: 12, 
                        color: isDark ? Colors.amber.shade100 : Colors.amber.shade900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? Colors.blue.shade900.withOpacity(0.3) : Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isDark ? Colors.blue.shade700 : Colors.blue.shade200,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.shield, 
                    size: 20, 
                    color: isDark ? Colors.blue.shade300 : Colors.blue.shade700,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Massage Service Requirement',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.blue.shade200 : Colors.blue.shade900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'To offer massage services, you must upload a verified massage therapy certification. Include "massage" in the certification name.',
                          style: TextStyle(
                            fontSize: 11, 
                            color: isDark ? Colors.blue.shade300 : Colors.blue.shade800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}