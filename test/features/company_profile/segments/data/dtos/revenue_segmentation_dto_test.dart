import 'package:bizzie/features/company_profile/segments/data/dtos/revenue_segmentation_dto.dart';
import 'package:bizzie/features/company_profile/segments/domain/models/revenue_segment.dart';
import 'package:flutter_test/flutter_test.dart';

const tJson = {
  'symbol': 'AAPL',
  'fiscalYear': 2025,
  'period': 'FY',
  'reportedCurrency': 'USD',
  'date': '2025-09-27',
  'data': {'iPhone': 209586000000, 'Mac': 33708000000},
};

const tDto = RevenueSegmentationDto(
  symbol: 'AAPL',
  fiscalYear: 2025,
  period: 'FY',
  reportedCurrency: 'USD',
  date: '2025-09-27',
  data: {'iPhone': 209586000000.0, 'Mac': 33708000000.0},
);

void main() {
  group('RevenueSegmentationDto', () {
    group('fromJson', () {
      test('fromJson_fullPayloadWithIntegerValues_parsesDoubleDataMap', () {
        // arrange - tJson with integer segment values as returned by FMP

        // act
        final dto = RevenueSegmentationDto.fromJson(tJson);

        // assert
        expect(dto, tDto);
        expect(dto.data?['iPhone'], isA<double>());
      });

      test('fromJson_missingFields_parsesWithNulls', () {
        // arrange
        const json = <String, dynamic>{'symbol': 'AAPL'};

        // act
        final dto = RevenueSegmentationDto.fromJson(json);

        // assert
        expect(dto.symbol, 'AAPL');
        expect(dto.fiscalYear, isNull);
        expect(dto.period, isNull);
        expect(dto.reportedCurrency, isNull);
        expect(dto.date, isNull);
        expect(dto.data, isNull);
      });
    });

    group('toJson', () {
      test('toJson_fullDto_roundTripsThroughFromJson', () {
        // arrange - tDto

        // act
        final json = tDto.toJson();
        final restored = RevenueSegmentationDto.fromJson(json);

        // assert
        expect(restored, tDto);
      });
    });

    group('toDomain', () {
      test('toDomain_defaultMultiplier_mapsFieldsUnchanged', () {
        // arrange - tDto

        // act
        final segment = tDto.toDomain();

        // assert
        expect(
          segment,
          const RevenueSegment(
            date: '2025-09-27',
            fiscalYear: 2025,
            period: 'FY',
            reportedCurrency: 'USD',
            data: {'iPhone': 209586000000.0, 'Mac': 33708000000.0},
          ),
        );
      });

      test(
        'toDomain_multiplierAndTargetCurrency_convertsValuesAndCurrency',
        () {
          // arrange
          const dto = RevenueSegmentationDto(
            symbol: 'SAP',
            fiscalYear: 2025,
            period: 'Q1',
            reportedCurrency: 'EUR',
            date: '2025-03-31',
            data: {'Cloud': 100.0, 'Licences': 50.0},
          );

          // act
          final segment = dto.toDomain(multiplier: 1.1, targetCurrency: 'USD');

          // assert
          expect(segment.reportedCurrency, 'USD');
          expect(segment.data['Cloud'], closeTo(110.0, 0.0001));
          expect(segment.data['Licences'], closeTo(55.0, 0.0001));
        },
      );

      test('toDomain_nullFields_fallsBackToDefaults', () {
        // arrange
        const dto = RevenueSegmentationDto();

        // act
        final segment = dto.toDomain();

        // assert
        expect(
          segment,
          const RevenueSegment(
            date: '',
            fiscalYear: 0,
            period: '',
            reportedCurrency: '',
            data: {},
          ),
        );
      });
    });
  });
}
