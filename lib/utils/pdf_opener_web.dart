// lib/utils/pdf_opener_web.dart

// This file is only used on Flutter Web via conditional import.
// ignore_for_file: deprecated_member_use, avoid_web_libraries_in_flutter

import 'dart:typed_data';
import 'dart:html' as html;

Future<void> openPdfBytes(
  Uint8List bytes, {
  required String filename,
}) async {
  final blob = html.Blob(<dynamic>[bytes], 'application/pdf');
  final url = html.Url.createObjectUrlFromBlob(blob);

  html.window.open(url, '_blank');
}