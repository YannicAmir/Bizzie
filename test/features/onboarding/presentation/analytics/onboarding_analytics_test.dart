import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/onboarding/presentation/analytics/onboarding_analytics.dart';
import 'package:bizzie/features/user/domain/enums/investing_experience.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAnalyticsService extends Mock implements IAnalyticsService {}

void main() {
  late OnboardingAnalytics analytics;
  late MockAnalyticsService mockAnalyticsService;

  setUp(() {
    mockAnalyticsService = MockAnalyticsService();
    analytics = OnboardingAnalytics(mockAnalyticsService);

    when(
      () => mockAnalyticsService.logEvent(
        name: any(named: 'name'),
        parameters: any(named: 'parameters'),
      ),
    ).thenAnswer((_) async {});

    when(
      () => mockAnalyticsService.setUserProperty(
        name: any(named: 'name'),
        value: any(named: 'value'),
      ),
    ).thenAnswer((_) async {});
  });

  group('OnboardingAnalytics (Gold Standard Refinement)', () {
    test('logSectorSelected_withEnum_logsCorrectEvent', () async {
      await analytics.logSectorSelected(Sector.energy);

      verify(
        () => mockAnalyticsService.logEvent(
          name: 'onboarding_sector_selected',
          parameters: {'sector_name': 'energy'},
        ),
      ).called(1);
    });

    test('logExperienceSelected_withEnum_logsCorrectEvent', () async {
      await analytics.logExperienceSelected(InvestingExperience.beginner);

      verify(
        () => mockAnalyticsService.logEvent(
          name: 'onboarding_experience_selected',
          parameters: {'experience_level': 'beginner'},
        ),
      ).called(1);
    });

    test('logBrandsSelected_sanitizesAndLimitsBrands', () async {
      final manyBrands = List.generate(15, (i) => 'Brand $i');

      await analytics.logBrandsSelected(brandNames: manyBrands, count: 15);

      verify(
        () => mockAnalyticsService.logEvent(
          name: 'onboarding_brands_selected',
          parameters: {
            'brand_names': manyBrands.take(10).join(','),
            'count': 15,
          },
        ),
      ).called(1);
    });

    test('logComplete_withEnums_logsCorrectEvent', () async {
      await analytics.logComplete(
        sector: Sector.healthCare,
        experience: InvestingExperience.intermediate,
        brandCount: 5,
      );

      verify(
        () => mockAnalyticsService.logEvent(
          name: 'onboarding_complete',
          parameters: {
            'sector': 'healthCare',
            'experience': 'intermediate',
            'brand_count': 5,
          },
        ),
      ).called(1);
    });

    test('setUserProperties_withEnums_setsProperties', () async {
      await analytics.setUserProperties(
        experience: InvestingExperience.expert,
        sector: Sector.financials,
      );

      verify(
        () => mockAnalyticsService.setUserProperty(
          name: 'investing_experience',
          value: 'expert',
        ),
      ).called(1);
      verify(
        () => mockAnalyticsService.setUserProperty(
          name: 'favorite_sector',
          value: 'financials',
        ),
      ).called(1);
    });
  });
}
