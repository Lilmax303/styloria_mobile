// lib/provider_kyc_screen.dart
// Enhanced version with full localization support

import 'dart:typed_data';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';

import 'main.dart';
import 'api_client.dart';
import 'onboarding_screen.dart';       // ✅ ADD THIS IMPORT
import 'app_tab_state.dart';   // ✅ for clearProfilePictureState

class ProviderKycScreen extends StatefulWidget {
  final String? verificationStatus;
  final String? reviewNotes;

  const ProviderKycScreen({
    super.key,
    this.verificationStatus,
    this.reviewNotes,
  });

  @override
  State<ProviderKycScreen> createState() => _ProviderKycScreenState();
}

class _ProviderKycScreenState extends State<ProviderKycScreen> {
  final _picker = ImagePicker();

  Uint8List? _idFrontBytes;
  Uint8List? _idBackBytes;
  Uint8List? _selfieBytes;

  bool _submitting = false;
  String? _error;
  String? _status;

  bool _isLocked = false;

  @override
  void initState() {
    super.initState();
    _checkIfLocked();
  }

  void _checkIfLocked() {
    if (widget.verificationStatus == 'pending') {
      setState(() {
        _isLocked = true;
      });
    }
  }

  // ═══════════════════════════════════════════════════════════════════
  // ID FRONT - Camera or Gallery
  // ═══════════════════════════════════════════════════════════════════
  Future<void> _pickIdFront() async {
    if (_isLocked) {
      _showLockedMessage();
      return;
    }

    final l10n = AppLocalizations.of(context)!;

    try {
      final source = await _showImageSourceDialog(
        title: l10n.kycIdFrontPhoto,
        message: l10n.kycIdFrontMessage,
      );

      if (source == null) return;

      final x = await _picker.pickImage(
        source: source,
        imageQuality: 85,
        preferredCameraDevice: CameraDevice.rear,
      );

      if (x == null) return;

      final bytes = await x.readAsBytes();
      if (!mounted) return;

      setState(() {
        _idFrontBytes = bytes;
        _error = null;
      });
    } catch (e) {
      debugPrint('Error picking ID front: $e');
      if (!mounted) return;
      setState(() => _error = l10n.kycFailedCaptureImage);
    }
  }

  // ═══════════════════════════════════════════════════════════════════
  // ID BACK - Camera or Gallery
  // ═══════════════════════════════════════════════════════════════════
  Future<void> _pickIdBack() async {
    if (_isLocked) {
      _showLockedMessage();
      return;
    }

    final l10n = AppLocalizations.of(context)!;

    try {
      final source = await _showImageSourceDialog(
        title: l10n.kycIdBackPhoto,
        message: l10n.kycIdBackMessage,
      );

      if (source == null) return;

      final x = await _picker.pickImage(
        source: source,
        imageQuality: 85,
        preferredCameraDevice: CameraDevice.rear,
      );

      if (x == null) return;

      final bytes = await x.readAsBytes();
      if (!mounted) return;

      setState(() {
        _idBackBytes = bytes;
        _error = null;
      });
    } catch (e) {
      debugPrint('Error picking ID back: $e');
      if (!mounted) return;
      setState(() => _error = l10n.kycFailedCaptureImage);
    }
  }

  // ═══════════════════════════════════════════════════════════════════
  // SELFIE - Camera or Gallery
  // ═══════════════════════════════════════════════════════════════════
  Future<void> _pickSelfie() async {
    if (_isLocked) {
      _showLockedMessage();
      return;
    }

    final l10n = AppLocalizations.of(context)!;

    try {
      XFile? x;

      if (!kIsWeb) {
        try {
          x = await _picker.pickImage(
            source: ImageSource.camera,
            preferredCameraDevice: CameraDevice.front,
            imageQuality: 85,
          );
        } catch (cameraError) {
          debugPrint('Camera not available: $cameraError');
          if (!mounted) return;

          final useGallery = await _showCameraFallbackDialog();
          if (useGallery == true) {
            x = await _picker.pickImage(
              source: ImageSource.gallery,
              imageQuality: 85,
            );
          } else {
            return;
          }
        }
      } else {
        x = await _picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 85,
        );
      }

      if (x == null) return;

      final bytes = await x.readAsBytes();
      if (!mounted) return;

      setState(() {
        _selfieBytes = bytes;
        _error = null;
      });
    } catch (e) {
      debugPrint('Error picking selfie: $e');
      if (!mounted) return;
      setState(() => _error = l10n.kycFailedCaptureSelfie);
    }
  }

  // ═══════════════════════════════════════════════════════════════════
  // IMAGE SOURCE DIALOG
  // ═══════════════════════════════════════════════════════════════════
  Future<ImageSource?> _showImageSourceDialog({
    required String title,
    required String message,
  }) async {
    if (kIsWeb) {
      return ImageSource.gallery;
    }

    final l10n = AppLocalizations.of(context)!;

    return showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message),
            const SizedBox(height: 16),
            Text(
              l10n.kycChooseSource,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: () => Navigator.of(context).pop(ImageSource.gallery),
            icon: const Icon(Icons.photo_library),
            label: Text(l10n.kycGallery),
          ),
          ElevatedButton.icon(
            onPressed: () => Navigator.of(context).pop(ImageSource.camera),
            icon: const Icon(Icons.camera_alt),
            label: Text(l10n.kycCamera),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════
  // CAMERA FALLBACK DIALOG
  // ═══════════════════════════════════════════════════════════════════
  Future<bool?> _showCameraFallbackDialog() async {
    final l10n = AppLocalizations.of(context)!;

    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.kycCameraNotAvailable),
        content: Text(l10n.kycCameraNotAvailableMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.kycUseGallery),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════
  // LOCKED DOCUMENTS MESSAGE
  // ═══════════════════════════════════════════════════════════════════
  void _showLockedMessage() {
    final l10n = AppLocalizations.of(context)!;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.kycDocumentsLocked),
        backgroundColor: Colors.orange.shade700,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════
  // SUBMIT VERIFICATION
  // ═══════════════════════════════════════════════════════════════════
  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context)!;

    if (_idFrontBytes == null || _idBackBytes == null || _selfieBytes == null) {
      setState(() => _error = l10n.errorUploadAllRequired);
      return;
    }

    setState(() {
      _submitting = true;
      _error = null;
      _status = null;
    });

    try {
      final res = await ApiClient.submitProviderVerificationBytes(
        idDocumentFrontBytes: _idFrontBytes!,
        idDocumentBackBytes: _idBackBytes!,
        verificationSelfieBytes: _selfieBytes!,
        idDocumentFrontFilename: 'id_front.jpg',
        idDocumentBackFilename: 'id_back.jpg',
        verificationSelfieFilename: 'selfie.jpg',
      );

      if (!mounted) return;

      if (res['ok'] != true) {
        final data = res['data'];
        final msg = (data is Map && data['detail'] != null)
            ? data['detail'].toString()
            : l10n.failedSubmitKycCode(res['status_code'].toString());
        setState(() {
          _submitting = false;
          _error = msg;
        });
        return;
      }

      final profile = await ApiClient.getMyProviderProfileAnyStatus();

      if (!mounted) return;

      final verificationStatus = profile?['verification_status']?.toString();

      setState(() {
        _submitting = false;
        _isLocked = true;
        _status = l10n.kycVerificationSubmittedSuccessfully;
      });

      if (verificationStatus == 'pending') {
        _showSuccessNotice();
      }

      if (verificationStatus == 'approved') {
        if (!mounted) return;
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      debugPrint('Error submitting KYC: $e');
      if (!mounted) return;
      setState(() {
        _submitting = false;
        _error = l10n.kycFailedSubmitVerification;
      });
    }
  }

  // ═══════════════════════════════════════════════════════════════════
  // SUCCESS NOTICE WITH SIGN OUT PROMPT
  // ═══════════════════════════════════════════════════════════════════
  void _showSuccessNotice() {
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green.shade600,
              size: 28,
            ),
            const SizedBox(width: 12),
            Text(l10n.kycVerificationSubmitted),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.kycThankYouSubmitting,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline,
                        size: 20,
                        color: Colors.blue.shade700,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          l10n.kycWhatHappensNext,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildNoticeStep('1', l10n.kycReviewTime),
                  const SizedBox(height: 8),
                  _buildNoticeStep('2', l10n.kycEmailNotification),
                  const SizedBox(height: 8),
                  _buildNoticeStep('3', l10n.kycCheckEmail),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.orange.shade200),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.lock_outline,
                          size: 18,
                          color: Colors.orange.shade700,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            l10n.kycLocked,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.orange.shade900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.kycRecommendSignOut,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.kycStaySignedIn),
          ),
          // ✅ FIX #1: Preserve onboarding flag during sign-out from success dialog
          ElevatedButton.icon(
            onPressed: () async {
              Navigator.of(context).pop(); // Close dialog
              await OnboardingScreen.logoutPreservingOnboarding(() async {
                await ApiClient.logout();
                clearProfilePictureState();
              });
              if (!context.mounted) return;
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
            label: Text(l10n.signOut),
          ),
        ],
      ),
    );
  }

  Widget _buildNoticeStep(String number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════
  // PREVIEW BOX
  // ═══════════════════════════════════════════════════════════════════
  Widget _previewBox(Uint8List? bytes, String label, IconData icon) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: bytes != null ? cs.primary : Colors.grey.shade300,
          width: bytes != null ? 2 : 1,
        ),
      ),
      child: bytes == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 40, color: Colors.grey.shade400),
                  const SizedBox(height: 8),
                  Text(
                    label,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            )
          : Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.memory(
                    bytes,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                if (_isLocked)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.lock,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════
  // STATUS BANNER
  // ═══════════════════════════════════════════════════════════════════
  Widget _buildStatusBanner() {
    final l10n = AppLocalizations.of(context)!;
    final status = widget.verificationStatus;

    if (status == null) return const SizedBox.shrink();

    Color bgColor;
    Color textColor;
    IconData icon;
    String title;
    String subtitle;

    switch (status) {
      case 'pending':
        bgColor = Colors.blue.shade50;
        textColor = Colors.blue.shade900;
        icon = Icons.pending_actions;
        title = l10n.kycVerificationPending;
        subtitle = l10n.kycVerificationPendingSubtitle;
        break;
      case 'approved':
        bgColor = Colors.green.shade50;
        textColor = Colors.green.shade900;
        icon = Icons.check_circle;
        title = l10n.kycVerificationApproved;
        subtitle = l10n.kycVerificationApprovedSubtitle;
        break;
      case 'rejected':
        bgColor = Colors.red.shade50;
        textColor = Colors.red.shade900;
        icon = Icons.cancel;
        title = l10n.kycVerificationRejected;
        subtitle = l10n.kycVerificationRejectedSubtitle;
        break;
      default:
        bgColor = Colors.grey.shade50;
        textColor = Colors.grey.shade900;
        icon = Icons.info;
        title = l10n.kycVerificationRequired;
        subtitle = l10n.kycVerificationRequiredSubtitle;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: textColor.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: textColor, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: textColor.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════
  // BUILD UI
  // ═══════════════════════════════════════════════════════════════════
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.providerKycTitle),
        automaticallyImplyLeading: false,
        actions: [
          // ✅ FIX #2: Preserve onboarding flag during AppBar logout
          IconButton(
            tooltip: l10n.logoutTooltip,
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await OnboardingScreen.logoutPreservingOnboarding(() async {
                await ApiClient.logout();
                clearProfilePictureState();
              });
              if (!context.mounted) return;
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildStatusBanner(),
            const SizedBox(height: 20),

            if (widget.verificationStatus == 'rejected' &&
                (widget.reviewNotes ?? '').trim().isNotEmpty)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.warning, color: Colors.red, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          l10n.kycReviewNotes,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.reviewNotes!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),

            if (widget.verificationStatus == 'rejected')
              const SizedBox(height: 20),

            Text(
              l10n.kycInstructions,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),

            // ID FRONT
            Text(
              l10n.kycIdCardFront,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: cs.primary,
              ),
            ),
            const SizedBox(height: 8),
            _previewBox(_idFrontBytes, l10n.idFrontRequired, Icons.credit_card),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _isLocked ? null : _pickIdFront,
              icon: Icon(_isLocked ? Icons.lock : Icons.camera_alt),
              label: Text(_isLocked ? l10n.kycButtonLocked : l10n.kycCaptureIdFront),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),

            const SizedBox(height: 20),

            // ID BACK
            Text(
              l10n.kycIdCardBack,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: cs.primary,
              ),
            ),
            const SizedBox(height: 8),
            _previewBox(_idBackBytes, l10n.idBackRequired, Icons.credit_card),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: _isLocked ? null : _pickIdBack,
              icon: Icon(_isLocked ? Icons.lock : Icons.camera_alt),
              label: Text(_isLocked ? l10n.kycButtonLocked : l10n.kycCaptureIdBack),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),

            const SizedBox(height: 20),

            // SELFIE
            Text(
              l10n.kycVerificationSelfie,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: cs.primary,
              ),
            ),
            const SizedBox(height: 8),
            _previewBox(_selfieBytes, l10n.selfieRequired, Icons.person),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _isLocked ? null : _pickSelfie,
              icon: Icon(_isLocked ? Icons.lock : Icons.photo_camera),
              label: Text(
                _isLocked
                    ? l10n.kycButtonLocked
                    : (kIsWeb ? l10n.selectSelfie : l10n.takeSelfie),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),

            const SizedBox(height: 20),

            if (_error != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error, color: Colors.red, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),

            if (_status != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _status!,
                        style: const TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: (_submitting || _isLocked) ? null : _submit,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: _submitting
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(
                      _isLocked ? l10n.kycDocumentsLockedButton : l10n.submitKyc,
                      style: const TextStyle(fontSize: 16),
                    ),
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lightbulb_outline,
                        size: 18,
                        color: Colors.amber.shade700,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        l10n.kycTipsTitle,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: cs.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildTip(l10n.kycTipGoodLighting),
                  _buildTip(l10n.kycTipFlatCard),
                  _buildTip(l10n.kycTipReadableText),
                  _buildTip(l10n.kycTipFaceCamera),
                  _buildTip(l10n.kycTipAvoidGlare),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTip(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 4),
      child: Text(
        text,
        style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
      ),
    );
  }
}