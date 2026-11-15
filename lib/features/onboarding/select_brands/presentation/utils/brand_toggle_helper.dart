import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/models/brand.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrandToggleHelper {
  static void toggle(BuildContext context, Brand brand) {
    context.read<OnboardingBloc>().add(OnboardingEvent.brandToggled(brand));
  }
}
