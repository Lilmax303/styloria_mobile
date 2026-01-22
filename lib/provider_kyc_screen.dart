// lib/provider_kyc_screen.dart

import 'dart:typed_data';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';

import 'main.dart';

import 'api_client.dart';

class ProviderKycScreen extends StatefulWidget {
  final String? verificationStatus;
  final String? reviewNotes;

  const ProviderKycScreen({super.key, this.verificationStatus, this.reviewNotes});

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

  Future<void> _pickIdFront() async {
    final x = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (x == null) return;
    final bytes = await x.readAsBytes();
    if (!mounted) return;
    setState(() => _idFrontBytes = bytes);
  }

  Future<void> _pickIdBack() async {
    final x = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (x == null) return;
    final bytes = await x.readAsBytes();
    if (!mounted) return;
    setState(() => _idBackBytes = bytes);
  }

  Future<void> _pickSelfie() async {
    // Camera preferred for selfie; fallback to gallery if needed
    final x = await _picker.pickImage(
      source: kIsWeb ? ImageSource.gallery : ImageSource.camera,
      imageQuality: 85,
    );    
    if (x == null) return;
    final bytes = await x.readAsBytes();
    if (!mounted) return;
    setState(() => _selfieBytes = bytes);
  }

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

    // Re-check status
    final profile = await ApiClient.getMyProviderProfileAnyStatus();

    if (!mounted) return;

    final verificationStatus = profile?['verification_status']?.toString();

    setState(() {
      _submitting = false;
      _status = l10n.submittedCurrentStatus(
        verificationStatus ?? l10n.unknownStatus,
      );
    });

    // If instantly approved (unlikely), allow leaving this screen
    if (verificationStatus == 'approved') {
      if (!mounted) return;
      Navigator.of(context).pop(true);
    }
  }

  Widget _previewBox(Uint8List? bytes, String label) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: bytes == null
          ? Center(child: Text(label))
          : ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.memory(bytes, fit: BoxFit.cover),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final initial = widget.verificationStatus;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.providerKycTitle),
        automaticallyImplyLeading: false, // force gating
        actions: [
          IconButton(
            tooltip: l10n.logoutTooltip,
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ApiClient.logout();
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
            if (initial != null)
              Text(
                l10n.statusLabel(initial),
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            const SizedBox(height: 12),

            // ✅ PASTE REJECTION BOX HERE
            if (widget.verificationStatus == 'rejected' &&
                (widget.reviewNotes ?? '').trim().isNotEmpty)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red),
                ),
                child: Text(
                  l10n.rejectedWithNotes(widget.reviewNotes!),
                  style: const TextStyle(color: Colors.red),
                ),
              ),

            const SizedBox(height: 12),

            Text(l10n.kycInstructions),
            const SizedBox(height: 16),

            _previewBox(_idFrontBytes, l10n.idFrontRequired),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _submitting ? null : _pickIdFront,
              child: Text(l10n.selectIdFront),
            ),

            const SizedBox(height: 12),

            _previewBox(_idBackBytes, l10n.idBackRequired),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: _submitting ? null : _pickIdBack,
              child: Text(l10n.selectIdBackRequired),
            ),

            const SizedBox(height: 12),

            _previewBox(_selfieBytes, l10n.selfieRequired),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _submitting ? null : _pickSelfie,
              child: Text(kIsWeb ? l10n.selectSelfie : l10n.takeSelfie),
            ),

            const SizedBox(height: 16),

            if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),
            if (_status != null) Text(_status!, style: const TextStyle(color: Colors.green)),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: _submitting ? null : _submit,
              child: _submitting
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(l10n.submitKyc),
            ),

            const SizedBox(height: 12),

            Text(
              l10n.verificationMayTakeTimeNote,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}