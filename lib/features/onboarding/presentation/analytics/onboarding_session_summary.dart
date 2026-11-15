import 'package:bizzie/core/enums/day_of_week.dart';

class OnboardingSessionSummary {
  final String sessionId;
  final String exitStep;
  final int totalDurationSeconds;
  final String? sector;
  final String? experience;
  final int addedBrandsCount;
  final bool notificationsEnabled;
  final bool didSignup;
  final bool didSkip;
  final DayOfWeek dayOfWeek;

  const OnboardingSessionSummary({
    required this.sessionId,
    required this.exitStep,
    required this.totalDurationSeconds,
    this.sector,
    this.experience,
    required this.addedBrandsCount,
    required this.notificationsEnabled,
    required this.didSignup,
    this.didSkip = false,
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
    'didSignup': didSignup,
    'didSkip': didSkip,
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
        didSignup: json['didSignup'] as bool,
        didSkip: json['didSkip'] as bool? ?? false,
        dayOfWeek: DayOfWeek.values.firstWhere(
          (e) => e.name == json['dayOfWeek'],
          orElse: () => DayOfWeek.monday,
        ),
      );
}
