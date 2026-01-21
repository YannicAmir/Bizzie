import 'package:bizzie/app/themes/app_assets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BizzieNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final ColorFilter? colorFilter;
  final double placeholderScale;

  const BizzieNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.colorFilter,
    this.placeholderScale = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return _PlaceholderImage(scale: placeholderScale);
    }

    final isSvg = imageUrl!.toLowerCase().endsWith('.svg');

    if (isSvg) {
      return SvgPicture.network(
        imageUrl!,
        width: width,
        height: height,
        fit: fit,
        colorFilter: colorFilter,
        placeholderBuilder: (context) =>
            _PlaceholderImage(scale: placeholderScale),
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl!,
      width: width,
      height: height,
      fit: fit,
      imageBuilder: colorFilter != null
          ? (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: fit,
                  colorFilter: colorFilter,
                ),
              ),
            )
          : null,
      placeholder: (context, url) => _PlaceholderImage(scale: placeholderScale),
      errorWidget: (context, url, error) =>
          _PlaceholderImage(scale: placeholderScale),
    );
  }
}

class _PlaceholderImage extends StatelessWidget {
  final double scale;

  const _PlaceholderImage({this.scale = 1.0});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AppAssets.splashLogo,
        fit: BoxFit.contain,
        width: 48 * scale,
        height: 48 * scale,
      ),
    );
  }
}
