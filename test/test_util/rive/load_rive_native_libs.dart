import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

// Remove this workaround once
// https://github.com/rive-app/rive-flutter/issues/354 is resolved.
Future<void> loadRiveNativeLibs() async {
  final rootPath = _getRootPath();
  final targetPath = "${rootPath}librive_native.dylib";
  if (File(targetPath).existsSync()) {
    return;
  }

  final riveLib = File(
    "${Directory.current.path}/test/test_util/rive/librive_native.dylib",
  );
  assert(riveLib.existsSync(), "File does not exist: ${riveLib.path}");
  Directory(rootPath).createSync(recursive: true);
  riveLib.copySync(targetPath);
}

// Copies the native compiled binary to the path where the rive native library.
// The binary can be downloaded using the following steps:
// dart run rive_native:setup --verbose --clean --platform macos
String _getRootPath() {
  if (Platform.isMacOS) {
    return "${Directory.current.path}/native/build/macosx/bin/debug_shared/";
  }

  throw UnsupportedError("Unknown platform: ${Platform.operatingSystem}");
}
