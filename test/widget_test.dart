// test/widget_test.dart
//
// This project doesn't use Flutter's default "counter app" UI,
// so we replace the default counter test with a simple smoke test
// that just verifies the app builds.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:styloria_mobile/main.dart';

void main() {
  testWidgets('StyloriaApp builds (smoke test)', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const StyloriaApp());

    // Let the first frame render
    await tester.pump();

    // StyloriaApp returns a MaterialApp, so this is a safe basic check.
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}