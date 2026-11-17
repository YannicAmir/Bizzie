import 'package:bizzie/shared/widgets/buttons/bizzie_close_button.dart';
import 'package:material_ui/material_ui.dart';

const double _closeButtonEndInset = 12;

class AuthCloseButton extends StatelessWidget {
  const AuthCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsetsDirectional.only(end: _closeButtonEndInset),
      child: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: BizzieCloseButton(),
      ),
    );
  }
}
