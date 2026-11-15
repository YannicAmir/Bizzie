import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/shared/widgets/modals/bizzie_snackbar.dart';
import 'package:flutter/material.dart';

class AuthFailureSnackBar {
  AuthFailureSnackBar._();

  static void show(BuildContext context, Failure failure) {
    BizzieSnackBar.show(
      context,
      message: failure.errorMessage,
      type: BizzieSnackBarType.error,
    );
  }
}
