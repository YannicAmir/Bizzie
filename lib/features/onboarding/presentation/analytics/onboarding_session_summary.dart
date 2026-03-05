import 'package:bizzie/core/enums/day_of_week.dart';

class OnboardingSessionSummary {
  final String sessionId;
  final String exitStep;
  final int totalDurationSeconds;
  final String? sector;
  final String? experience;
  final int addedBrandsCount;
  final bool notificationsEnabled;
  final bool highlightsSkipped;
  final bool didSignup;
  final DayOfWeek dayOfWeek;

  const OnboardingSessionSummary({
    required this.sessionId,
    required this.exitStep,
    required this.totalDurationSeconds,
    this.sector,
    this.experience,
    required this.addedBrandsCount,
    required this.notificationsEnabled,
    required this.highlightsSkipped,
    required this.didSignup,
    required this.dayOfWeek,
  });

  Map<String, dynamic> toJson() => {
    'sessionId': sessionId,
    'exitStep': exitStep,
    'totalDurationSeconds': totalDurationSeconds,
    'sector': sector,
    'experience': experience,
    'addedBrandsCount': addedBrandsCount,
    'notificationsEnabled': notificationsEnabled,
    'highlightsSkipped': highlightsSkipped,
    'didSignup': didSignup,
    'dayOfWeek': dayOfWeek.name,
  };

  factory OnboardingSessionSummary.fromJson(Map<String, dynamic> json) =>
      OnboardingSessionSummary(
        sessionId: json['sessionId'] as String,
        exitStep: json['exitStep'] as String,
        totalDurationSeconds: (json['totalDurationSeconds'] as num).toInt(),
        sector: json['sector'] as String?,
        experience: json['experience'] as String?,
        addedBrandsCount: (json['addedBrandsCount'] as num?)?.toInt() ?? 0,
        notificationsEnabled: json['notificationsEnabled'] as bool,
        highlightsSkipped: json['highlightsSkipped'] as bool,
        didSignup: json['didSignup'] as bool,
        dayOfWeek: DayOfWeek.values.firstWhere(
          (e) => e.name == json['dayOfWeek'],
          orElse: () => DayOfWeek.monday,
        ),
      );
}
