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

  @override
  State<BrightnessAwareLogoTile> createState() =>
      _BrightnessAwareLogoTileState();
}

class _BrightnessAwareLogoTileState extends State<BrightnessAwareLogoTile> {
  ImageStream? _imageStream;
  ImageStreamListener? _imageStreamListener;
  bool _isNearWhiteLogo = false;

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
    final imageStream = _imageStream;
    final imageStreamListener = _imageStreamListener;
    if (imageStream != null && imageStreamListener != null) {
      imageStream.removeListener(imageStreamListener);
    }
  }

  void _resolveLogoBrightness() {
    final imageStream = widget.imageProvider.resolve(
      const ImageConfiguration(),
    );
    late final ImageStreamListener imageStreamListener;
    imageStreamListener = ImageStreamListener(
      (info, _) async {
        final byteData = await info.image.toByteData(
          format: ui.ImageByteFormat.rawStraightRgba,
        );
        imageStream.removeListener(imageStreamListener);
        if (byteData == null || !mounted) return;
        final averageLuminance = _averageOpaqueLuminance(byteData);
        if (averageLuminance != null &&
            averageLuminance >=
                BrightnessAwareLogoTile._nearWhiteLuminanceThreshold) {
          setState(() => _isNearWhiteLogo = true);
        }
      },
      onError: (_, __) {
        imageStream.removeListener(imageStreamListener);
      },
    );
    imageStream.addListener(imageStreamListener);
    _imageStream = imageStream;
    _imageStreamListener = imageStreamListener;
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
