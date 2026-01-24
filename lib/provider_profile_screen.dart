// lib/provider_profile_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';
import 'widgets/certifications_section.dart';

import 'api_client.dart';
import 'portfolio_viewer_screen.dart';

class ProviderProfileScreen extends StatefulWidget {
  const ProviderProfileScreen({super.key});

  @override
  State<ProviderProfileScreen> createState() => _ProviderProfileScreenState();
}

class _ProviderProfileScreenState extends State<ProviderProfileScreen> {
  String _serviceLabel(String id, AppLocalizations l10n) {
    switch (id) {
      case 'haircut':
        return l10n.serviceHaircutLabel;
      case 'braids':
        return l10n.serviceBraidsLabel;
      case 'shave':
        return l10n.serviceShaveLabel;
      case 'color':
        return l10n.serviceHairColoringLabel;
      case 'manicure':
        return l10n.serviceManicureLabel;
      case 'pedicure':
        return l10n.servicePedicureLabel;
      case 'nails':
        return l10n.serviceNailArtLabel;
      case 'makeup':
        return l10n.serviceMakeupLabel;
      case 'facial':
        return l10n.serviceFacialLabel;
      case 'waxing':
        return l10n.serviceWaxingLabel;
      case 'massage':
        return l10n.serviceMassageLabel;
      case 'tattoo':
        return l10n.serviceTattooLabel;
      case 'styling':
        return l10n.serviceHairStylingLabel;
      case 'treatment':
        return l10n.serviceHairTreatmentLabel;
      case 'extensions':
        return l10n.serviceHairExtensionsLabel;
      case 'other':
      default:
        return l10n.serviceOtherServicesLabel;
    }
  }

  final _formKey = GlobalKey<FormState>();

  final _bioController = TextEditingController();
  final _priceController = TextEditingController(); // (kept, even if unused)
  final _latController = TextEditingController();
  final _lngController = TextEditingController();
  final _addressController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  bool _available = true;
  double _averageRating = 0.0;
  int _reviewCount = 0;
  bool _loading = true;
  String? _error;
  String? _success;
  bool _isCreatingProfile = false;
  bool _gettingLocation = false;
  String? _locationError;
  String _currentAddress = '';
  String _userCurrency = 'USD';
  String _currencySymbol = '\$';

  // Portfolio
  List<dynamic> _portfolioPosts = [];
  bool _portfolioLoading = false;
  String? _portfolioError;
  bool _portfolioUploading = false;

  // Reviews
  List<dynamic> _reviews = [];
  bool _reviewsLoading = false;
  String? _reviewsError;
  bool _reviewsExpanded = false;
  static const int _initialReviewsToShow = 2;

  // UPDATED SERVICE TYPES LIST - MATCHES BACKEND
  final List<Map<String, dynamic>> _serviceTypes = [
    {
      'id': 'haircut',
      'name': 'Haircut',
      'price': 0.0,
      'offered': true,
      'category': 'hair'
    },
    {
      'id': 'braids',
      'name': 'Braids',
      'price': 0.0,
      'offered': true,
      'category': 'hair'
    },
    {
      'id': 'shave',
      'name': 'Shave',
      'price': 0.0,
      'offered': true,
      'category': 'hair'
    },
    {
      'id': 'color',
      'name': 'Hair Coloring',
      'price': 0.0,
      'offered': true,
      'category': 'hair'
    },
    {
      'id': 'manicure',
      'name': 'Manicure',
      'price': 0.0,
      'offered': false,
      'category': 'other'
    },
    {
      'id': 'pedicure',
      'name': 'Pedicure',
      'price': 0.0,
      'offered': false,
      'category': 'other'
    },
    {
      'id': 'nails',
      'name': 'Nail Art',
      'price': 0.0,
      'offered': false,
      'category': 'other'
    },
    {
      'id': 'makeup',
      'name': 'Makeup',
      'price': 0.0,
      'offered': false,
      'category': 'other'
    },
    {
      'id': 'facial',
      'name': 'Facial',
      'price': 0.0,
      'offered': false,
      'category': 'other'
    },
    {
      'id': 'waxing',
      'name': 'Waxing',
      'price': 0.0,
      'offered': false,
      'category': 'other'
    },
    {
      'id': 'massage',
      'name': 'Massage',
      'price': 0.0,
      'offered': false,
      'category': 'other',
      'requiresCertification': true
    },
    {
      'id': 'styling',
      'name': 'Hair Styling',
      'price': 0.0,
      'offered': false,
      'category': 'hair'
    },
    {
      'id': 'treatment',
      'name': 'Hair Treatment',
      'price': 0.0,
      'offered': false,
      'category': 'hair'
    },
    {
      'id': 'extensions',
      'name': 'Hair Extensions',
      'price': 0.0,
      'offered': false,
      'category': 'hair'
    },
    {
      'id': 'other',
      'name': 'Other',
      'price': 0.0,
      'offered': false,
      'category': 'other'
    },
  ];

  // Certification status for restricted services
  Map<String, dynamic> _certificationStatus = {};

  @override
  void initState() {
    super.initState();
    _loadProfile();
    _loadPortfolio();
    _loadReviews();
  }

  @override
  void dispose() {
    _bioController.dispose();
    _priceController.dispose();
    _latController.dispose();
    _lngController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  String _resolveUrl(String? raw) {
    if (raw == null || raw.isEmpty) return '';
    if (raw.startsWith('http://') || raw.startsWith('https://')) return raw;
    if (raw.startsWith('/')) return '${ApiClient.baseUrl}$raw';
    return raw;
  }

  // Flatten backend posts -> viewer expects:
  // [{media_type, media_url, caption}, ...]
  // NOTE: resolve file_url into absolute URL for the viewer.
  List<Map<String, dynamic>> flattenPortfolio(List<dynamic> posts) {
    final items = <Map<String, dynamic>>[];
    for (final p in posts) {
      final post = Map<String, dynamic>.from(p as Map);
      final caption = (post['caption'] ?? '').toString();
      final media = (post['media'] as List?) ?? [];

      for (final m in media) {
        final mm = Map<String, dynamic>.from(m as Map);
        final url = _resolveUrl(mm['file_url']?.toString());
        if (url.isEmpty) continue;

        items.add({
          'media_type': (mm['media_type'] ?? 'image').toString(),
          'media_url': url,
          'caption': caption,
        });
      }
    }
    return items;
  }

  // Convert a tapped POST index into the correct initial index inside the flattened MEDIA list
  int _initialMediaIndexForPost(int postIndex) {
    int idx = 0;
    for (int i = 0; i < postIndex; i++) {
      final post = _portfolioPosts[i] as Map<String, dynamic>;
      final media = (post['media'] as List?) ?? const [];
      idx += media.length;
    }
    return idx;
  }

  Future<void> _loadProfile() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final data = await ApiClient.getMyProviderProfile();

      if (data != null) {
        _bioController.text = data['bio'] ?? '';
        _latController.text = data['location_latitude']?.toString() ?? '';
        _lngController.text = data['location_longitude']?.toString() ?? '';
        _available = data['available'] ?? true;
        _averageRating = (data['average_rating'] ?? 0).toDouble();
        _reviewCount = data['review_count'] ?? 0;
        _isCreatingProfile = false;

        // Load saved service prices
        final savedPrices = data['service_prices'] as List<dynamic>?;
        if (savedPrices != null) {
          for (final savedPrice in savedPrices) {
            final sp = savedPrice as Map<String, dynamic>;
            final serviceType = sp['service_type']?.toString();
            final price = double.tryParse(sp['price']?.toString() ?? '0') ?? 0.0;
            final offered = sp['offered'] as bool? ?? true;
            
            // Find and update the matching service in _serviceTypes
            final index = _serviceTypes.indexWhere((s) => s['id'] == serviceType);
            if (index != -1) {
              _serviceTypes[index]['price'] = price;
              _serviceTypes[index]['offered'] = offered;
            }
          }
        }

        if (data['location_latitude'] != null &&
            data['location_longitude'] != null) {
          await _getAddressFromCoordinates(
            data['location_latitude'].toDouble(),
            data['location_longitude'].toDouble(),
          );
        }

        // currency
        final userData = await ApiClient.getCurrentUser();
        if (userData != null) {
          _userCurrency = userData['preferred_currency'] ?? 'USD';
          final symbols = {
            'USD': '\$',
            'EUR': '€',
            'GBP': '£',
            'GHS': 'GH₵',
            'NGN': '₦',
            'KES': 'KSh',
            'ZAR': 'R',
            'INR': '₹',
            'JPY': '¥',
            'CNY': '¥',
          };
          _currencySymbol = symbols[_userCurrency] ?? '\$';
        }

        // Load certification status for restricted services
        if (data['certification_status'] != null) {
          _certificationStatus = Map<String, dynamic>.from(data['certification_status']);
        }
      } else {
        // new profile defaults
        _bioController.text = '';
        _latController.text = '5.6037';
        _lngController.text = '-0.1870';
        _available = true;
        _isCreatingProfile = true;
        await _getAddressFromCoordinates(5.6037, -0.1870);
      }
    } catch (e) {
      _error = AppLocalizations.of(context)!.failedToLoadProfile(e.toString());
    } finally {
      if (!mounted) return;
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    // Validate service prices: if offered, price must be > 0
    for (var service in _serviceTypes) {
      if (service['offered'] == true && (service['price'] as double) <= 0) {
        setState(() {
          _error = 'Please set a price for "${_serviceLabel(service['id'] as String, AppLocalizations.of(context)!)}" or mark it as "Not Offered".';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please set a price for "${_serviceLabel(service['id'] as String, AppLocalizations.of(context)!)}" or mark it as "Not Offered".'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    setState(() {
      _loading = true;
      _error = null;
      _success = null;
    });

    try {
      Map<String, dynamic> servicePrices = {};
      for (var service in _serviceTypes) {
        servicePrices[service['id']] = service['price'];
      }

      final result = await ApiClient.saveMyProviderProfile(
        bio: _bioController.text.trim(),
        latitude: double.parse(_latController.text.trim()),
        longitude: double.parse(_lngController.text.trim()),
        available: _available,
        servicePrices: servicePrices,
        unavailableServices: _serviceTypes
            .where((s) => !s['offered'])
            .map((s) => s['id'] as String)
            .toList(),
      );

      if (!mounted) return;

      if (result != null) {
        setState(() {
          _success = AppLocalizations.of(context)!.profileSavedSuccess(
            _isCreatingProfile ? 'created' : 'updated',
          );
          _isCreatingProfile = false;
          if (result['average_rating'] != null) {
            _averageRating = (result['average_rating'] ?? 0).toDouble();
          }
          if (result['review_count'] != null) {
            _reviewCount = result['review_count'] ?? 0;
          }
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_success!),
            backgroundColor: Colors.green,
          ),
        );

        if (_isCreatingProfile) {
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) Navigator.of(context).pop();
          });
        }
      } else {
        setState(() {
          _error = AppLocalizations.of(context)!.failedToSaveProfile;
        });
      }
    } catch (e) {
      setState(() {
        _error = AppLocalizations.of(context)!.genericError(e.toString());
      });
    } finally {
      if (!mounted) return;
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _gettingLocation = true;
      _locationError = null;
    });

    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _locationError = AppLocalizations.of(context)!
                .locationPermissionDeniedEnableInSettings;
            _gettingLocation = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _locationError = AppLocalizations.of(context)!
              .locationPermissionPermanentlyDeniedEnableInAppSettings;
          _gettingLocation = false;
        });
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      _latController.text = position.latitude.toStringAsFixed(6);
      _lngController.text = position.longitude.toStringAsFixed(6);

      await _getAddressFromCoordinates(position.latitude, position.longitude);
    } catch (e) {
      setState(() {
        _locationError =
            AppLocalizations.of(context)!.errorGettingLocation(e.toString());
      });
    } finally {
      if (!mounted) return;
      setState(() {
        _gettingLocation = false;
      });
    }
  }

  Future<void> _convertAddressToCoordinates() async {
    if (_addressController.text.trim().isEmpty) {
      setState(() {
        _locationError = AppLocalizations.of(context)!.pleaseEnterAddress;
      });
      return;
    }

    setState(() {
      _gettingLocation = true;
      _locationError = null;
    });

    try {
      List<Location> locations =
          await locationFromAddress(_addressController.text.trim());

      if (locations.isNotEmpty) {
        final location = locations.first;
        _latController.text = location.latitude.toStringAsFixed(6);
        _lngController.text = location.longitude.toStringAsFixed(6);

        setState(() {
          _currentAddress = _addressController.text.trim();
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  AppLocalizations.of(context)!.locationUpdatedFromAddress)),
        );
      } else {
        setState(() {
          _locationError =
              AppLocalizations.of(context)!.couldNotFindLocationForAddress;
        });
      }
    } catch (e) {
      setState(() {
        _locationError =
            AppLocalizations.of(context)!.errorConvertingAddress(e.toString());
      });
    } finally {
      if (!mounted) return;
      setState(() {
        _gettingLocation = false;
      });
    }
  }

  Future<void> _getAddressFromCoordinates(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);

      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        final address = [
          placemark.street,
          placemark.locality,
          placemark.administrativeArea,
          placemark.country
        ].where((part) => part != null && part.isNotEmpty).join(', ');

        setState(() {
          _currentAddress = address;
        });

        if (address.isNotEmpty) {
          _addressController.text = address;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        // ignore: avoid_print
        print('Error getting address: $e');
      }
    }
  }

  void _updateServicePrice(int index, String value) {
    final price = double.tryParse(value) ?? 0.0;
    setState(() {
      _serviceTypes[index]['price'] = price;
    });
  }

  void _toggleServiceOffered(int index) {
    final service = _serviceTypes[index];
    final serviceId = service['id'] as String;
    final wantsToOffer = !service['offered'];
    
    // Check if this service requires certification
    if (wantsToOffer && service['requiresCertification'] == true) {
      final certStatus = _certificationStatus[serviceId];
      final hasVerifiedCert = certStatus?['has_verified_cert'] == true;
      final hasPendingCert = certStatus?['has_pending_cert'] == true;
      final isExpired = certStatus?['is_expired'] == true;
      
      if (!hasVerifiedCert) {
        _showCertificationRequiredDialog(serviceId, hasPendingCert, isExpired);
        return;
      }
    }
    setState(() {
      _serviceTypes[index]['offered'] = wantsToOffer;
      if (!_serviceTypes[index]['offered']) {
        _serviceTypes[index]['price'] = 0.0;
      }
    });
  }

  void _showCertificationRequiredDialog(String serviceId, bool hasPendingCert, bool isExpired) {
    final l10n = AppLocalizations.of(context)!;
    String title;
    String message;
    
    if (isExpired) {
      title = l10n.certificationExpiredTitle;
      message = l10n.certificationExpiredMessage;
    } else if (hasPendingCert) {
      title = l10n.certificationPendingTitle;
      message = l10n.certificationPendingMessage;
    } else {
      title = l10n.certificationRequiredTitle;
      message = l10n.certificationRequiredMessage(serviceId);
    }
    
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            Icon(
              isExpired ? Icons.warning : Icons.verified_user,
              color: isExpired ? Colors.orange : Colors.blue,
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(title)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.certificationStepsTitle,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(l10n.certificationStep1),
                  Text(l10n.certificationStep2),
                  Text(l10n.certificationStep3),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
          if (!hasPendingCert)
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(ctx);
                // Scroll to certifications section or show add dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l10n.scrollToCertificationsHint),
                    backgroundColor: Colors.blue,
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: Text(l10n.addCertification),
            ),
        ],
      ),
    );
  }

  // -------------------------
  // Portfolio logic
  // -------------------------
  Future<void> _loadPortfolio() async {
    setState(() {
      _portfolioLoading = true;
      _portfolioError = null;
    });

    try {
      final posts = await ApiClient.getMyPortfolioPosts();

      if (!mounted) return;

      setState(() {
        _portfolioPosts = posts ?? [];
        if (posts == null) {
          _portfolioError = AppLocalizations.of(context)!
              .portfolioUnavailableCompleteKycFirst;
        }
      });

      if (!mounted) return;

      setState(() {
        _portfolioPosts = posts ?? [];
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _portfolioError =
            AppLocalizations.of(context)!.failedToLoadPortfolio(e.toString());
      });
    } finally {
      if (!mounted) return;
      setState(() {
        _portfolioLoading = false;
      });
    }
  }

  Future<void> _loadReviews() async {
    setState(() {
      _reviewsLoading = true;
      _reviewsError = null;
    });

    try {
      final data = await ApiClient.getReceivedReviews();

      if (!mounted) return;

      if (data != null) {
        setState(() {
          _reviews = (data['reviews'] as List?) ?? [];
          _averageRating = (data['average_rating'] as num?)?.toDouble() ?? 0.0;
          _reviewCount = (data['review_count'] as int?) ?? 0;
        });
      } else {
        setState(() {
          _reviewsError = AppLocalizations.of(context)!.failedToLoadReviews;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _reviewsError = AppLocalizations.of(context)!.failedToLoadReviewsWithError(e.toString());
      });
    } finally {
      if (!mounted) return;
      setState(() {
        _reviewsLoading = false;
      });
    }
  }

  Future<void> _showAddPortfolioSheet() async {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo),
              title: Text(AppLocalizations.of(context)!.addPhoto),
              onTap: () async {
                Navigator.pop(ctx);
                final file = await _picker.pickImage(
                    source: ImageSource.gallery, imageQuality: 85);
                if (file != null) {
                  await _uploadPortfolio(file: file);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.videocam),
              title: Text(AppLocalizations.of(context)!.addVideo),
              onTap: () async {
                Navigator.pop(ctx);
                final file =
                    await _picker.pickVideo(source: ImageSource.gallery);
                if (file != null) {
                  await _uploadPortfolio(file: file);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> _askCaption() async {
    final controller = TextEditingController();

    return showDialog<String?>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.captionOptionalTitle),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.captionHintExample,
          ),
          maxLines: 2,
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, null),
              child: Text(AppLocalizations.of(context)!.skip)),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx,
                controller.text.trim().isEmpty ? null : controller.text.trim()),
            child: Text(AppLocalizations.of(context)!.save),
          ),
        ],
      ),
    );
  }

  // IMPORTANT: backend is 2-step:
  // 1) create post -> post_id
  // 2) upload media to /me/portfolio/<post_id>/media/
  Future<void> _uploadPortfolio({required XFile file}) async {
    final caption = await _askCaption();

    setState(() {
      _portfolioUploading = true;
      _portfolioError = null;
    });

    try {
      final postId = await ApiClient.createPortfolioPost(caption: caption);
      if (postId == null) {
        setState(() => _portfolioError =
            AppLocalizations.of(context)!.failedToCreatePortfolioPost);
        return;
      }

      final ok =
          await ApiClient.uploadPortfolioMedia(postId: postId, file: file);
      if (!ok) {
        setState(() => _portfolioError =
            AppLocalizations.of(context)!.uploadFailedMediaUpload);
        return;
      }

      await _loadPortfolio();
    } catch (e) {
      setState(() {
        _portfolioError =
            AppLocalizations.of(context)!.uploadFailed(e.toString());
      });
    } finally {
      if (!mounted) return;
      setState(() {
        _portfolioUploading = false;
      });
    }
  }

  Future<void> _deletePortfolioPost(int postId) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.deletePostTitle),
        content: Text(AppLocalizations.of(context)!.deletePostBody),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(AppLocalizations.of(context)!.cancel)),
          ElevatedButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(AppLocalizations.of(context)!.delete)),
        ],
      ),
    );

    if (ok != true) return;

    try {
      final deleted = await ApiClient.deletePortfolioPost(postId);
      if (!deleted) {
        setState(
            () => _portfolioError = AppLocalizations.of(context)!.deleteFailed);
        return;
      }
      await _loadPortfolio();
    } catch (e) {
      setState(() {
        _portfolioError =
            AppLocalizations.of(context)!.deleteFailedWithError(e.toString());
      });
    }
  }

  Widget _buildPortfolioSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.portfolioTitle,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                if (_portfolioUploading) ...[
                  const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2)),
                  const SizedBox(width: 12),
                ],
                OutlinedButton.icon(
                  onPressed:
                      _portfolioUploading ? null : _showAddPortfolioSheet,
                  icon: const Icon(Icons.add),
                  label: Text(AppLocalizations.of(context)!.addPost),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (_portfolioError != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(_portfolioError!,
                    style: const TextStyle(color: Colors.red)),
              ),
            if (_portfolioLoading)
              const Padding(
                padding: EdgeInsets.all(12),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (_portfolioPosts.isEmpty)
              Text(
                AppLocalizations.of(context)!.noPortfolioPostsYetHelpText,
                style: TextStyle(color: Colors.grey[700]),
              )
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _portfolioPosts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  final post = _portfolioPosts[index] as Map<String, dynamic>;
                  final postId = post['id'];

                  final caption = (post['caption'] ?? '').toString();
                  final mediaList = (post['media'] is List)
                      ? (post['media'] as List)
                      : const <dynamic>[];
                  final cover = mediaList.isNotEmpty
                      ? (mediaList.first as Map<String, dynamic>)
                      : <String, dynamic>{};

                  final mediaType = (cover['media_type'] ?? 'image').toString();
                  final mediaUrl = _resolveUrl(cover['file_url']?.toString());

                  return InkWell(
                    onTap: () {
                      final flattened = flattenPortfolio(_portfolioPosts);
                      if (flattened.isEmpty) return;

                      final initialIndex = _initialMediaIndexForPost(index);
                      final safeIndex =
                          initialIndex.clamp(0, flattened.length - 1);

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => PortfolioViewerScreen(
                            posts: flattened,
                            initialIndex: safeIndex,
                          ),
                        ),
                      );
                    },
                    onLongPress: (postId is int)
                        ? () => _deletePortfolioPost(postId)
                        : null,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(
                            color: Colors.grey[200],
                            child: mediaUrl.isEmpty
                                ? const Center(child: Icon(Icons.broken_image))
                                : Image.network(
                                    mediaUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => const Center(
                                        child: Icon(Icons.broken_image)),
                                  ),
                          ),
                          if (mediaType == 'video')
                            Container(
                              color: Colors.black.withOpacity(0.25),
                              child: const Center(
                                child: Icon(Icons.play_circle_fill,
                                    color: Colors.white, size: 36),
                              ),
                            ),
                          if (caption.isNotEmpty)
                            Positioned(
                              left: 6,
                              right: 6,
                              bottom: 6,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.45),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  caption,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 11),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewsSection() {
    final l10n = AppLocalizations.of(context)!;

    // Determine how many reviews to show
    final totalReviews = _reviews.length;
    final reviewsToShow = _reviewsExpanded 
        ? _reviews 
        : _reviews.take(_initialReviewsToShow).toList();
    final hasMoreReviews = totalReviews > _initialReviewsToShow;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  l10n.reviewsReceivedTitle,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.refresh, size: 20),
                  onPressed: _reviewsLoading ? null : _loadReviews,
                ),
              ],
            ),
            const SizedBox(height: 8),
            
            // Summary row
            if (_reviewCount > 0) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 28),
                    const SizedBox(width: 8),
                    Text(
                      _averageRating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      l10n.reviewCountLabel(_reviewCount),
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
            
            if (_reviewsError != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  _reviewsError!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              
            if (_reviewsLoading)
              const Padding(
                padding: EdgeInsets.all(12),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (_reviews.isEmpty)
              Text(
                l10n.noReviewsYetHelpText,
                style: TextStyle(color: Colors.grey[700]),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: reviewsToShow.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final review = reviewsToShow[index] as Map<String, dynamic>;
                  final rating = (review['rating'] as int?) ?? 0;
                  final comment = (review['comment'] ?? '').toString();
                  final createdAt = review['created_at']?.toString() ?? '';
                  final user = review['user'] as Map<String, dynamic>?;
                  
                  final firstName = user?['first_name']?.toString() ?? '';
                  final lastName = user?['last_name']?.toString() ?? '';
                  final username = user?['username']?.toString() ?? 'User';
                  final displayName = (firstName.isNotEmpty || lastName.isNotEmpty)
                      ? '$firstName $lastName'.trim()
                      : username;
                  
                  final profilePic = _resolveUrl(user?['profile_picture_url']?.toString());

                  // Format date
                  String dateStr = '';
                  if (createdAt.isNotEmpty) {
                    try {
                      final dt = DateTime.parse(createdAt);
                      dateStr = '${dt.day}/${dt.month}/${dt.year}';
                    } catch (_) {
                      dateStr = createdAt.split('T').first;
                    }
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: profilePic.isNotEmpty
                              ? NetworkImage(profilePic)
                              : null,
                          child: profilePic.isEmpty
                              ? const Icon(Icons.person, size: 20)
                              : null,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      displayName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  if (dateStr.isNotEmpty)
                                    Text(
                                      dateStr,
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: List.generate(
                                  5,
                                  (i) => Icon(
                                    i < rating ? Icons.star : Icons.star_border,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                ),
                              ),
                              if (comment.isNotEmpty) ...[
                                const SizedBox(height: 6),
                                Text(
                                  comment,
                                  style: TextStyle(color: Colors.grey[800]),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              // Show More / Show Less button
              if (hasMoreReviews) ...[
                const SizedBox(height: 8),
                Center(
                  child: TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _reviewsExpanded = !_reviewsExpanded;
                      });
                    },
                    icon: Icon(
                      _reviewsExpanded 
                          ? Icons.keyboard_arrow_up 
                          : Icons.keyboard_arrow_down,
                      size: 20,
                    ),
                    label: Text(
                      _reviewsExpanded
                          ? 'Show less'
                          : 'Show more (${totalReviews - _initialReviewsToShow} more)',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
          ],
        ),
      ),
    );
  }

  // -------------------------
  // UI
  // -------------------------
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(_isCreatingProfile
            ? l10n.setupProviderProfileTitle
            : l10n.providerProfileTitle),
        actions: _isCreatingProfile
            ? []
            : [
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: _loadProfile,
                ),
              ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: SizedBox(
                  width: 450,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_isCreatingProfile) ...[
                        Card(
                          color: Colors.blue[50],
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.info, color: Colors.blue[700]),
                                    const SizedBox(width: 8),
                                    Text(
                                      l10n.welcomeToStyloriaTitle,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue[700],
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  l10n.completeProviderProfileToStartEarning,
                                  style: TextStyle(color: Colors.blue[800]),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                      if (!_isCreatingProfile && _reviewCount > 0) ...[
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                const Icon(Icons.star,
                                    color: Colors.amber, size: 30),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _averageRating.toStringAsFixed(1),
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      l10n.reviewCountLabel(_reviewCount),
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                if (_averageRating >= 4.0)
                                  Chip(
                                    label: Text(l10n.topRatedChip),
                                    backgroundColor: Colors.green,
                                    labelStyle:
                                        const TextStyle(color: Colors.white),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: _bioController,
                              decoration: InputDecoration(
                                labelText: l10n.bioLabel,
                                hintText: l10n.bioHint,
                                border: const OutlineInputBorder(),
                                prefixIcon: const Icon(Icons.description),
                                filled: _isCreatingProfile,
                                fillColor: _isCreatingProfile
                                    ? Colors.yellow[50]
                                    : null,
                              ),
                              maxLines: 4,
                              maxLength: 500,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty)
                                  return l10n.pleaseEnterBio;
                                if (value.trim().length < 20)
                                  return l10n.bioMinLength(20);
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),

                            // Portfolio section
                            if (!_isCreatingProfile) ...[
                              _buildPortfolioSection(),
                              const SizedBox(height: 16),
                              _buildReviewsSection(),
                              const SizedBox(height: 16),
                              // Certifications section
                              CertificationsSection(
                                onCertificationsChanged: () {
                                  // Optionally reload profile to update any trust score display
                                  _loadProfile();
                                },
                              ),
                              const SizedBox(height: 16),
                            ],

                            Text(
                              l10n.yourLocationTitle,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _isCreatingProfile
                                  ? l10n.locationHelpMatchNearbyClients
                                  : l10n.locationHelpUpdateToFindJobs,
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            const SizedBox(height: 12),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: Icon(
                                        Icons.gps_fixed,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      title: Text(
                                        l10n.useMyCurrentLocationTitle,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(l10n.gpsSubtitle),
                                      trailing: _gettingLocation
                                          ? const CircularProgressIndicator()
                                          : IconButton(
                                              icon: const Icon(Icons.refresh),
                                              onPressed: _getCurrentLocation,
                                            ),
                                    ),
                                    if (_currentAddress.isNotEmpty)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 72, right: 8, bottom: 8),
                                        child: Text(
                                          _currentAddress,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.green),
                                        ),
                                      ),
                                    if (_locationError != null)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, right: 16, bottom: 8),
                                        child: Text(
                                          _locationError!,
                                          style: const TextStyle(
                                              fontSize: 12, color: Colors.red),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Center(
                                child: Text(l10n.orLabel,
                                    style:
                                        const TextStyle(color: Colors.grey))),
                            const SizedBox(height: 12),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      l10n.enterYourAddressTitle,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller: _addressController,
                                            decoration: InputDecoration(
                                              labelText: l10n.fullAddressLabel,
                                              hintText: l10n.fullAddressHint,
                                              border:
                                                  const OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        ElevatedButton(
                                          onPressed: _gettingLocation
                                              ? null
                                              : _convertAddressToCoordinates,
                                          child: Text(l10n.find),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      l10n.addressHelpText,
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Card(
                              color: Colors.grey[50],
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      l10n.coordinatesAutoFilledTitle,
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller: _latController,
                                            decoration: InputDecoration(
                                              labelText: l10n.latitudeLabel,
                                              border:
                                                  const OutlineInputBorder(),
                                              filled: true,
                                            ),
                                            readOnly: true,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: TextFormField(
                                            controller: _lngController,
                                            decoration: InputDecoration(
                                              labelText: l10n.longitudeLabel,
                                              border:
                                                  const OutlineInputBorder(),
                                              filled: true,
                                            ),
                                            readOnly: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      l10n.servicePricingTitle,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      l10n.servicePricingHelp,
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                    const SizedBox(height: 16),
                                    Table(
                                      columnWidths: const {
                                        0: FlexColumnWidth(2.5),
                                        1: FlexColumnWidth(2.8),
                                        2: FlexColumnWidth(1),
                                      },
                                      border:
                                          TableBorder.all(color: Colors.grey),
                                      children: [
                                        TableRow(
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade100),
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(l10n.serviceHeader,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(l10n.priceHeader,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(l10n.notOfferedHeader,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ],
                                        ),
                                        ..._serviceTypes.map((service) {
                                          return TableRow(
                                            decoration: BoxDecoration(
                                              color: service['offered']
                                                  ? Colors.transparent
                                                  : Colors.grey.shade50,
                                            ),
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(_serviceLabel(
                                                          service['id'] as String,
                                                          l10n)),
                                                    ),
                                                    if (service['requiresCertification'] == true)
                                                      Tooltip(
                                                        message: l10n.requiresCertificationTooltip,
                                                        child: Icon(
                                                          _certificationStatus[service['id']]?['has_verified_cert'] == true
                                                              ? Icons.verified
                                                              : Icons.shield_outlined,
                                                          size: 16,
                                                          color: _certificationStatus[service['id']]?['has_verified_cert'] == true
                                                              ? Colors.green
                                                              : Colors.orange,
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                  enabled: service['offered'],
                                                  initialValue: service['price']
                                                      .toStringAsFixed(2),
                                                  keyboardType:
                                                      const TextInputType
                                                          .numberWithOptions(
                                                          decimal: true),
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp(
                                                            r'^\d*\.?\d{0,2}')),
                                                  ],
                                                  onChanged: (value) {
                                                    final index = _serviceTypes
                                                        .indexOf(service);
                                                    _updateServicePrice(
                                                        index, value);
                                                  },
                                                  decoration: InputDecoration(
                                                    hintText: '0.00',
                                                    border: const OutlineInputBorder(),
                                                    isDense: true,
                                                    contentPadding: const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 12,
                                                    ),
                                                    prefixIcon: Container(
                                                      width: 32,
                                                      alignment: Alignment.center,
                                                      child: Text(
                                                        _currencySymbol,
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          color: service['offered']
                                                              ? Colors.black87
                                                              : Colors.grey,
                                                        ),
                                                      ),
                                                    ),
                                                    prefixIconConstraints: const BoxConstraints(
                                                      minWidth: 32,
                                                      maxWidth: 32,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Checkbox(
                                                  value: !service['offered'],
                                                  onChanged: (_) {
                                                    final index = _serviceTypes
                                                        .indexOf(service);
                                                    _toggleServiceOffered(
                                                        index);
                                                  },
                                                ),
                                              ),
                                            ],
                                          );
                                        }).toList(),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.shade50,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            l10n.providerHowPricingWorksTitle,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            l10n.providerHowPricingWorksBody,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    Switch(
                                      value: _available,
                                      onChanged: (value) =>
                                          setState(() => _available = value),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            l10n.availableForBookingsTitle,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            _available
                                                ? l10n.availableOnHelp
                                                : l10n.availableOffHelp,
                                            style: TextStyle(
                                              color: _available
                                                  ? Colors.green
                                                  : Colors.orange,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            if (_error != null)
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.red[50],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.red),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.error, color: Colors.red),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(_error!,
                                          style: const TextStyle(
                                              color: Colors.red)),
                                    ),
                                  ],
                                ),
                              ),
                            if (_success != null) ...[
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.green[50],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.green),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.check_circle,
                                        color: Colors.green),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(_success!,
                                          style: const TextStyle(
                                              color: Colors.green)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _loading ? null : _saveProfile,
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  backgroundColor:
                                      _isCreatingProfile ? Colors.blue : null,
                                ),
                                child: _loading
                                    ? const SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white),
                                      )
                                    : Text(
                                        _isCreatingProfile
                                            ? l10n.completeSetupStartEarning
                                            : l10n.updateProfile,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                              ),
                            ),
                            if (_isCreatingProfile) ...[
                              const SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                child: TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text(l10n.skipForNow),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
