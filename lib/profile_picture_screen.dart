// lib/profile_picture_screen.dart

import 'dart:io';
import 'dart:typed_data';

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
  String? _error;
  String? _success;

  Uint8List? _previewBytes;
  File? _selectedFile;

  @override
  void initState() {
    super.initState();
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

      setState(() {
        _success = AppLocalizations.of(context).profilePictureUploadedSuccessfully;
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
            FutureBuilder<Map<String, dynamic>?>(
              future: ApiClient.getCurrentUser(),
              builder: (context, snapshot) {
                final url = snapshot.data?['profile_picture_url']?.toString();
                if (url != null && url.isNotEmpty) {
                  return CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(url),
                  );
                }
                return const CircleAvatar(
                  radius: 50,
                  child: Icon(Icons.person, size: 40),
                );
              },
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
              onPressed: _uploading ? null : _pickImage,
              icon: const Icon(Icons.photo_library),
              label: Text(l10n.chooseImage),
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: _uploading ? null : _upload,
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