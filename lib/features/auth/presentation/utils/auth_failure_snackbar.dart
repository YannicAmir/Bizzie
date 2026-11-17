import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/shared/widgets/modals/bizzie_snackbar.dart';
import 'package:material_ui/material_ui.dart';

class AuthFailureSnackBar {
  AuthFailureSnackBar._();

  static void show(BuildContext context, Failure failure) {
    if (failure is CancelFailure) return;
    BizzieSnackBar.show(
      context,
      message: failure.errorMessage,
      type: BizzieSnackBarType.error,
    );
  }
}
