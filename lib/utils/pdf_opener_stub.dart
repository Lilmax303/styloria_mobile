// lib/utils/pdf_opener_stub.dart

import 'dart:typed_data';
import 'dart:io';

import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

Future<void> openPdfBytes(
  Uint8List bytes, {
  required String filename,
}) async {
  final dir = await getTemporaryDirectory();
  final file = File('${dir.path}/$filename');
  await file.writeAsBytes(bytes, flush: true);

  await OpenFilex.open(file.path);
}