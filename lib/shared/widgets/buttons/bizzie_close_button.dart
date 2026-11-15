import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_close_icon.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BizzieCloseButton extends StatelessWidget {
  const BizzieCloseButton({super.key});

  void _onPressed(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Close',
      style: IconButton.styleFrom(minimumSize: AppConstants.minTouchTargetSize),
      onPressed: () => _onPressed(context),
      icon: const BizzieCloseIcon(),
    );
  }
}
