import 'package:bizzie/shared/utils/analytics_utils.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AnalyticsUtils', () {
    group('extractPageName', () {
      test('extractPageName_nullName_returnsNull', () {
        // arrange
        const settings = RouteSettings(name: null);

        // act
        final result = AnalyticsUtils.extractPageName(settings);

        // assert
        expect(result, isNull);
      });

      test('extractPageName_emptyName_returnsNull', () {
        // arrange
        const settings = RouteSettings(name: '');

        // act
        final result = AnalyticsUtils.extractPageName(settings);

        // assert
        expect(result, isNull);
      });

      test('extractPageName_companyProfileCamelCase_returnsNormalizedName', () {
        // arrange
        const settings = RouteSettings(name: 'companyProfileTabs');

        // act
        final result = AnalyticsUtils.extractPageName(settings);

        // assert
        expect(result, equals('company_profile'));
      });

      test('extractPageName_companyProfilePrefix_returnsNormalizedName', () {
        // arrange
        const settings = RouteSettings(name: 'cp_security');

        // act
        final result = AnalyticsUtils.extractPageName(settings);

        // assert
        expect(result, equals('company_profile'));
      });

      test('extractPageName_regularRoute_returnsOriginalName', () {
        // arrange
        const settings = RouteSettings(name: 'home_screen');

        // act
        final result = AnalyticsUtils.extractPageName(settings);

        // assert
        expect(result, equals('home_screen'));
      });
    });
  });
}
