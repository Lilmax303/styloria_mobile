// lib/profile_picture_screen.dart

import 'dart:io';
import 'dart:typed_data';

import 'profile_picture_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';

import 'api_client.dart';

class ProfilePictureScreen extends StatefulWidget {
  const ProfilePictureScreen({super.key});

  @override
  State<ProfilePictureScreen> createState() => _ProfilePictureScreenState();
}

class _ProfilePictureScreenState extends State<ProfilePictureScreen> {
  bool _uploading = false;
  bool _deleting = false;
  String? _error;
  String? _success;

  Uint8List? _previewBytes;
  File? _selectedFile;
  String? _currentProfilePictureUrl;

  @override
  void initState() {
    super.initState();
    _loadCurrentProfilePicture();
  }

  Future<void> _loadCurrentProfilePicture() async {
    final userData = await ApiClient.getCurrentUser();
    if (mounted && userData != null) {
      setState(() {
        _currentProfilePictureUrl = userData['profile_picture_url']?.toString();
      });
    }
  }

  Future<void> _pickImage() async {
    setState(() {
      _error = null;
      _success = null;
    });

    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );

    if (!mounted) return;

    if (result == null || result.files.isEmpty) return;

    final file = result.files.first;

    setState(() {
      _previewBytes = file.bytes;
      _selectedFile = (file.path != null && !kIsWeb) ? File(file.path!) : null;
    });
  }

  Future<void> _upload() async {
    setState(() {
      _uploading = true;
      _error = null;
      _success = null;
    });

    try {
      Map<String, dynamic>? updated;

      if (kIsWeb) {
        if (_previewBytes == null) {
          setState(() {
            _error = AppLocalizations.of(context).noImageBytesFoundWeb;
            _uploading = false;
          });
          return;
        }

        updated = await ApiClient.uploadProfilePictureBytes(
          bytes: _previewBytes!,
          filename: 'profile.jpg',
        );
      } else {
        if (_selectedFile == null) {
          setState(() {
            _error = AppLocalizations.of(context).pleasePickAnImageFirst;
            _uploading = false;
          });
          return;
        }

        updated = await ApiClient.uploadProfilePicture(_selectedFile!);
      }

      if (!mounted) return;

      setState(() {
        _uploading = false;
      });

      if (updated == null) {
        setState(() {
          _error = AppLocalizations.of(context).uploadFailedCheckServerLogs;
        });
        return;
      }

      final newUrl = updated?['profile_picture_url']?.toString();

      // Update global state immediately
      profilePictureState.updateProfilePicture(newUrl);

      setState(() {
        _success = AppLocalizations.of(context).profilePictureUploadedSuccessfully;
        _currentProfilePictureUrl = newUrl;
        _previewBytes = null;
        _selectedFile = null;
      });

      // Return to previous screen and let it refresh
      Future.delayed(const Duration(milliseconds: 700), () {
        if (mounted) Navigator.of(context).pop(true);
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _uploading = false;
        _error = AppLocalizations.of(context).errorWithValue(e.toString());
      });
    }
  }

  Future<void> _deleteProfilePicture() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppLocalizations.of(context).deleteProfilePictureTitle),
        content: Text(AppLocalizations.of(context).deleteProfilePictureConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(AppLocalizations.of(context).cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text(AppLocalizations.of(context).delete),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() {
      _deleting = true;
      _error = null;
      _success = null;
    });

    try {
      final deleted = await ApiClient.deleteProfilePicture();

      if (!mounted) return;

      setState(() {
        _deleting = false;
      });

      if (deleted) {
        // Update global state immediately
        profilePictureState.updateProfilePicture(null);

        setState(() {
          _success = AppLocalizations.of(context).profilePictureDeletedSuccessfully;
          _currentProfilePictureUrl = null;
          _previewBytes = null;
          _selectedFile = null;
        });

        Future.delayed(const Duration(milliseconds: 700), () {
          if (mounted) Navigator.of(context).pop(true);
        });
      } else {
        setState(() {
          _error = AppLocalizations.of(context).failedToDeleteProfilePicture;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _deleting = false;
        _error = AppLocalizations.of(context).errorWithValue(e.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final preview = _previewBytes;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.uploadProfilePicture),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.currentProfilePicture,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_currentProfilePictureUrl != null && _currentProfilePictureUrl!.isNotEmpty)
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(_currentProfilePictureUrl!),
                  )
                else
                  const CircleAvatar(
                    radius: 50,
                    child: Icon(Icons.person, size: 40),
                  ),
                if (_currentProfilePictureUrl != null && _currentProfilePictureUrl!.isNotEmpty) ...[
                  const SizedBox(width: 16),
                  IconButton(
                    onPressed: (_deleting || _uploading) ? null : _deleteProfilePicture,
                    icon: _deleting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.delete, color: Colors.red),
                    tooltip: l10n.deleteProfilePicture,
                  ),
                ],
              ],
            ),
            const SizedBox(height: 20),

            Text(
              l10n.newPicturePreview,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            if (preview != null)
              CircleAvatar(
                radius: 60,
                backgroundImage: MemoryImage(preview),
              )
            else
              const CircleAvatar(
                radius: 60,
                child: Icon(Icons.image, size: 40),
              ),

            const SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: (_uploading || _deleting) ? null : _pickImage,
              icon: const Icon(Icons.photo_library),
              label: Text(l10n.chooseImage),
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: (_uploading || _deleting) ? null : _upload,
              child: _uploading
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(l10n.upload),
            ),

            const SizedBox(height: 16),

            if (_error != null)
              Text(
                _error!,
                style: const TextStyle(color: Colors.red),
              ),

            if (_success != null)
              Text(
                _success!,
                style: const TextStyle(color: Colors.green),
              ),
          ],
        ),
      ),
    );
  }
}