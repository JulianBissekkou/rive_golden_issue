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

    tearDownAll(() {
      // Restore animation setting after tests
      RiveCanvas.repeatRiveAnimation = true;
    });

    testGoldens('MyApp should match golden file', (tester) async {
      // Build the app
      await tester.pumpWidgetBuilder(
        const MyApp(),
        surfaceSize: const Size(400, 800),
      );

      // Wait for any initial animations to settle
      await tester.pumpAndSettle();

      // Take a screenshot and compare with golden file
      await screenMatchesGolden(tester, 'my_app_home');
    });

    testGoldens('MyApp should render correctly on different screen sizes', (
      tester,
    ) async {
      final builder = DeviceBuilder()
        ..addScenario(widget: const MyApp(), name: 'default');

      await tester.pumpDeviceBuilder(builder);
      await tester.pumpAndSettle();

      await screenMatchesGolden(tester, 'my_app_multi_device');
    });

    testGoldens('MyApp should handle different themes', (tester) async {
      // Test light theme
      await tester.pumpWidgetBuilder(
        const MyApp(),
        surfaceSize: const Size(400, 800),
        wrapper: (child) => Theme(data: ThemeData.light(), child: child),
      );

      await tester.pumpAndSettle();
      await screenMatchesGolden(tester, 'my_app_light_theme');
    });
  });
}
