import 'package:bizzie/app/themes/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const double _closeIconSize = 24;

class BizzieCloseIcon extends StatelessWidget {
  final Color? color;

  const BizzieCloseIcon({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    final iconColor = color;
    return SvgPicture.asset(
      AppAssets.modalCloseIcon,
      width: _closeIconSize,
      height: _closeIconSize,
      colorFilter: iconColor == null
          ? null
          : ColorFilter.mode(iconColor, BlendMode.srcIn),
    );
  }
}
