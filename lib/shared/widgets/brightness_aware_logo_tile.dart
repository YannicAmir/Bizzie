import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class BrightnessAwareLogoTile extends StatefulWidget {
  const BrightnessAwareLogoTile({
    super.key,
    required this.imageProvider,
    required this.size,
    required this.borderRadius,
    this.padding = _defaultPadding,
  });

  final ImageProvider imageProvider;
  final double size;
  final double borderRadius;
  final double padding;

  static const double _defaultPadding = 8;
  static const double _nearWhiteLuminanceThreshold = 0.9;
  static const int _luminanceSampleExtent = 32;

  @override
  State<BrightnessAwareLogoTile> createState() =>
      _BrightnessAwareLogoTileState();
}

class _BrightnessAwareLogoTileState extends State<BrightnessAwareLogoTile> {
  VoidCallback? _detachCurrentListener;
  bool _isNearWhiteLogo = false;
  int _resolveGeneration = 0;

  @override
  void initState() {
    super.initState();
    _resolveLogoBrightness();
  }

  @override
  void didUpdateWidget(covariant BrightnessAwareLogoTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.imageProvider != oldWidget.imageProvider) {
      _detachListener();
      _isNearWhiteLogo = false;
      _resolveLogoBrightness();
    }
  }

  @override
  void dispose() {
    _detachListener();
    super.dispose();
  }

  void _detachListener() {
    _detachCurrentListener?.call();
    _detachCurrentListener = null;
  }

  void _resolveLogoBrightness() {
    final generation = ++_resolveGeneration;
    final imageStream = ResizeImage(
      widget.imageProvider,
      width: BrightnessAwareLogoTile._luminanceSampleExtent,
      height: BrightnessAwareLogoTile._luminanceSampleExtent,
      allowUpscaling: false,
    ).resolve(const ImageConfiguration());
    late final ImageStreamListener imageStreamListener;
    var isRemoved = false;
    void removeListenerOnce() {
      if (isRemoved) return;
      isRemoved = true;
      imageStream.removeListener(imageStreamListener);
    }

    imageStreamListener = ImageStreamListener(
      (info, _) async {
        try {
          final byteData = await info.image.toByteData(
            format: ui.ImageByteFormat.rawStraightRgba,
          );
          if (byteData == null ||
              !mounted ||
              generation != _resolveGeneration) {
            return;
          }
          final averageLuminance = _averageOpaqueLuminance(byteData);
          if (averageLuminance != null &&
              averageLuminance >=
                  BrightnessAwareLogoTile._nearWhiteLuminanceThreshold) {
            setState(() => _isNearWhiteLogo = true);
          }
        } catch (error, stackTrace) {
          FlutterError.reportError(
            FlutterErrorDetails(
              exception: error,
              stack: stackTrace,
              library: 'BrightnessAwareLogoTile',
              context: ErrorDescription('resolving logo brightness'),
            ),
          );
        } finally {
          removeListenerOnce();
          info.dispose();
        }
      },
      onError: (_, __) {
        removeListenerOnce();
      },
    );
    imageStream.addListener(imageStreamListener);
    _detachCurrentListener = removeListenerOnce;
  }

  double? _averageOpaqueLuminance(ByteData byteData) {
    final pixels = byteData.buffer.asUint8List();
    var totalLuminance = 0.0;
    var opaquePixelCount = 0;
    for (var i = 0; i + 3 < pixels.length; i += 4) {
      final alpha = pixels[i + 3];
      if (alpha == 0) continue;
      final color = Color.fromARGB(
        alpha,
        pixels[i],
        pixels[i + 1],
        pixels[i + 2],
      );
      totalLuminance += color.computeLuminance();
      opaquePixelCount++;
    }
    return opaquePixelCount == 0 ? null : totalLuminance / opaquePixelCount;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: widget.size,
      height: widget.size,
      padding: EdgeInsets.all(widget.padding),
      decoration: BoxDecoration(
        color: _isNearWhiteLogo ? colorScheme.tertiary : colorScheme.surface,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: Image(
        image: widget.imageProvider,
        fit: BoxFit.contain,
        excludeFromSemantics: true,
      ),
    );
  }
}
