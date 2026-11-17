import 'package:bizzie/features/onboarding/domain/models/onboarding_step.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/onboarding_skip_button.dart';
import 'package:material_ui/material_ui.dart';

const double _skipButtonTopInset = 0;
const double _skipButtonEndInset = 12;

class OnboardingSkipOverlay extends StatelessWidget {
  final OnboardingStep step;
  final Widget child;

  const OnboardingSkipOverlay({
    super.key,
    required this.step,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        child,
        PositionedDirectional(
          top: _skipButtonTopInset,
          end: _skipButtonEndInset,
          child: OnboardingSkipButton(step: step),
        ),
      ],
    );
  }
}
