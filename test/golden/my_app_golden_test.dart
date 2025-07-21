import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:rive_example/main.dart';
import 'package:rive_example/rive_canvas.dart';

void main() {
  group('MyApp Golden Tests', () {
    setUpAll(() async {
      // Initialize golden toolkit
      await loadAppFonts();

      // Disable Rive animation repetition for consistent golden tests
      RiveCanvas.repeatRiveAnimation = false;
    });

    testGoldens('MyApp should match golden file', (tester) async {
      // Build the app
      await tester.pumpWidgetBuilder(
        const MyApp(),
        surfaceSize: const Size(400, 800),
      );

      // Wait for any initial animations to settle
      await tester.pumpAndSettle();
      await tester.pump();

      // Take a screenshot and compare with golden file
      await screenMatchesGolden(tester, 'my_app_home');
    });
  });
}
