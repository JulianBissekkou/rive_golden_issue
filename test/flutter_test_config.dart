import 'dart:async';

import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:rive_example/rive_canvas.dart';
import 'test_util/rive/load_rive_native_libs.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  return GoldenToolkit.runWithConfiguration(
    () async {
      await loadAppFonts();

      await loadRiveNativeLibs();
      await RiveCanvas.init();
      await testMain();
    },
    config: GoldenToolkitConfiguration(
      skipGoldenAssertion: () => false,
      defaultDevices: const [Device.phone, Device.iphone11],
    ),
  );
}
