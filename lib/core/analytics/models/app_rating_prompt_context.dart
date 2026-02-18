import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_rating_prompt_context.freezed.dart';

@freezed
abstract class AppRatingPromptContext with _$AppRatingPromptContext {
  const factory AppRatingPromptContext({
    // Company Information
    required String ticker,
    required String companyName,
    required String sector,
    required String industry,

    // User Profile
    required String experienceLevel,
    required String favoriteSector,
    required bool isPremium,
    required int watchlistCount,

    // Engagement & Status
    required bool notificationsEnabled,
    required int interactionCount,
    required int promptAttempts,
    required String currentTab,
    // Represents the specific value fetched from Remote Config (review_prompt_event_count)
    required int thresholdCount,
  }) = _AppRatingPromptContext;

  const AppRatingPromptContext._();

  Map<String, Object> toMap(String screenName) {
    return {
      'screen_name': screenName,
      'ticker': ticker,
      'company_name': companyName,
      'sector': sector,
      'industry': industry,
      'experience_level': experienceLevel,
      'favorite_sector': favoriteSector,
      'is_premium': isPremium,
      'watchlist_count': watchlistCount,
      'notifications_enabled': notificationsEnabled,
      'interaction_count': interactionCount,
      'prompt_attempts': promptAttempts,
      'current_tab': currentTab,
      'threshold_count': thresholdCount,
    };
  }
}
