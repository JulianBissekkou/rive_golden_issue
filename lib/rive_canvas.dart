import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:rive/rive.dart' as rive;

class RiveCanvas extends StatefulWidget {
  final String asset;
  final double? width;
  final double? height;

  @visibleForTesting
  static bool repeatRiveAnimation = true;

  static Future<void> init() {
    return rive.RiveNative.init();
  }

  RiveCanvas(this.asset, {this.width, this.height})
    : super(key: ValueKey(asset));

  @override
  State<RiveCanvas> createState() => _RiveCanvasState();
}

class _RiveCanvasState extends State<RiveCanvas> {
  rive.RiveWidgetController? _riveWidgetController;

  @override
  void initState() {
    super.initState();
    _loadRiveImage();
  }

  @override
  void dispose() {
    _riveWidgetController?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant RiveCanvas oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.asset != oldWidget.asset) {
      _loadRiveImage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = _riveWidgetController;

    return ClipRect(
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child:
            controller == null
                ? const CircularProgressIndicator()
                : Container(
                  color: Colors.red,
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.all(16),
                  child: rive.RiveWidget(
                    key: ValueKey(controller),
                    controller: controller,
                  ),
                ),
      ),
    );
  }

  Future<void> _loadRiveImage() async {
    final asset = widget.asset;
    final riveFile = await _loadAsset(asset);
    if (!mounted || widget.asset != asset) return;

    _riveWidgetController?.dispose();

    final controller = rive.RiveWidgetController(riveFile)
      ..active = RiveCanvas.repeatRiveAnimation;

    setState(() => _riveWidgetController = controller);
  }

  Future<rive.File> _loadAsset(String path) async {
    return (await rive.File.asset(path, riveFactory: rive.Factory.flutter))!;
  }
}
