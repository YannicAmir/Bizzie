import 'package:bizzie/features/company_profile/shared/domain/enums/market_cap_category.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/ratio_category.dart';
import 'package:bizzie/features/company_profile/news/domain/models/news_article.dart';
import 'package:bizzie/features/company_profile/presentation/utils/market_cap_category_extensions.dart';
import 'package:bizzie/features/company_profile/presentation/utils/mascot_utils.dart';
import 'package:bizzie/features/company_profile/news/presentation/utils/news_article_extensions.dart';
import 'package:bizzie/features/company_profile/presentation/utils/ratio_category_extensions.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:bizzie/features/onboarding/domain/models/user_model.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/shared/widgets/app_badge.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MarketCapCategoryX', () {
    test('label_returnsCorrectStrings', () {
      expect(MarketCapCategory.mega.label, 'Mega-Cap');
      expect(MarketCapCategory.nano.label, 'Nano-Cap');
    });
  });

  group('MascotUtils', () {
    test('getMascotAsset_returnsMascotForSector_onLoaded', () {
      final tUser = UserModel(
        uid: '123',
        name: 'Tester',
        favoriteSector: 'Technology',
        watchlist: [],
        investingExperience: InvestingExperience.intermediate,
        createdAt: DateTime.now(),
        isSubscribed: false,
        fcmTokens: {},
      );
      final state = UserState.loaded(tUser);

      final asset = MascotUtils.getMascotAsset(state);
      expect(asset.contains('it'), true); // Technology -> bizzie_mascot_it.png
    });

    test('getMascotAsset_returnsDefaultMascot_onOtherStates', () {
      const state = UserState.initial();
      final asset = MascotUtils.getMascotAsset(state);
      expect(asset.contains('default'), true);
    });
  });

  group('NewsArticlePresentationX', () {
    test('timeAgo_returnsFormattedString', () {
      final now = DateTime.now();
      final article = NewsArticle(
        title: 'Test',
        url: '',
        publishedDate: now.subtract(const Duration(hours: 2)).toIso8601String(),
        site: '',
      );

      expect(article.timeAgo.contains('hours ago'), true);
    });

    test('timeAgo_handlesFutureDatesByUsingNow', () {
      final future = DateTime.now().add(const Duration(days: 1));
      final article = NewsArticle(
        title: 'Test',
        url: '',
        publishedDate: future.toIso8601String(),
        site: '',
      );

      expect(article.timeAgo, 'a moment ago');
    });
  });

  group('RatioCategoryX', () {
    test('label_returnsCorrectStrings', () {
      expect(RatioCategory.average.label, 'Average');
      expect(RatioCategory.veryHigh.label, 'Very High');
      expect(RatioCategory.none.label, '-');
    });

    test('badgeStyle_returnsCorrectSemanticStyles', () {
      expect(RatioCategory.veryHigh.badgeStyle, AppBadgeStyle.critical);
      expect(RatioCategory.veryLow.badgeStyle, AppBadgeStyle.good);
      expect(RatioCategory.average.badgeStyle, AppBadgeStyle.neutral);
    });
  });
}
