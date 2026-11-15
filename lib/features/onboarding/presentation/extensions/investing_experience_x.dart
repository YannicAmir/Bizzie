import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/core/enums/investing_experience.dart';

extension InvestingExperienceX on InvestingExperience {
  String get title => switch (this) {
    InvestingExperience.expert => 'Expert',
    InvestingExperience.intermediate => 'Intermediate',
    InvestingExperience.beginner => 'Beginner',
  };

  String get description => switch (this) {
    InvestingExperience.expert => "I'm an experienced investor",
    InvestingExperience.intermediate => 'I have some experience',
    InvestingExperience.beginner => "I'm new to investing",
  };

  String get iconPath => switch (this) {
    InvestingExperience.expert => AppAssets.arrowUpIcon,
    InvestingExperience.intermediate => AppAssets.barChartIcon,
    InvestingExperience.beginner => AppAssets.sparkleIcon,
  };
}
