import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bizzie/features/reports/data/dtos/weekly_report_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WeeklyReportDto', () {
    group('fromJson', () {
      test('fromJson_allCamelCaseFields_deserializesCorrectly', () {
        // arrange
        final json = <String, dynamic>{
          'id': '2026-05-27',
          'ticker': 'AAPL',
          'companyName': 'Apple Inc.',
          'messageTitle': 'Weekly Recap',
          'messageShortSummary': 'Short summary',
          'messageLongSummary': 'Long summary',
          'newsLinks': ['https://news1.com', 'https://news2.com'],
          'eightKLinks': ['https://8k1.com'],
          'priceMovement': {
            'startPrice': 150.0,
            'endPrice': 155.0,
            'priceChange': 5.0,
            'priceChangePercent': 3.33,
          },
          'createdAt': '2026-05-27T10:00:00.000Z',
        };

        // act
        final dto = WeeklyReportDto.fromJson(json);

        // assert
        expect(dto.id, '2026-05-27');
        expect(dto.ticker, 'AAPL');
        expect(dto.companyName, 'Apple Inc.');
        expect(dto.messageTitle, 'Weekly Recap');
        expect(dto.messageShortSummary, 'Short summary');
        expect(dto.messageLongSummary, 'Long summary');
        expect(dto.newsLinks, ['https://news1.com', 'https://news2.com']);
        expect(dto.eightKLinks, ['https://8k1.com']);
        expect(dto.priceMovement, isNotNull);
        expect(dto.createdAt, DateTime.parse('2026-05-27T10:00:00.000Z'));
      });

      test('fromJson_nullOptionalFields_allFieldsNull', () {
        // arrange
        final json = <String, dynamic>{
          'createdAt': '2026-05-27T10:00:00.000Z',
        };

        // act
        final dto = WeeklyReportDto.fromJson(json);

        // assert
        expect(dto.id, isNull);
        expect(dto.ticker, isNull);
        expect(dto.companyName, isNull);
        expect(dto.messageTitle, isNull);
        expect(dto.messageShortSummary, isNull);
        expect(dto.messageLongSummary, isNull);
        expect(dto.newsLinks, isNull);
        expect(dto.eightKLinks, isNull);
        expect(dto.priceMovement, isNull);
      });

      test('fromJson_isoStringCreatedAt_parsesDateCorrectly', () {
        // arrange
        final json = <String, dynamic>{
          'createdAt': '2026-05-27T10:00:00.000Z',
        };

        // act
        final dto = WeeklyReportDto.fromJson(json);

        // assert
        expect(dto.createdAt, DateTime.utc(2026, 5, 27, 10, 0, 0));
      });
    });

    group('toDomain', () {
      test('toDomain_allFields_mapsToWeeklyReportCorrectly', () {
        // arrange
        final createdAt = DateTime.parse('2026-05-27T10:00:00.000Z');
        final dto = WeeklyReportDto(
          id: '2026-05-27',
          ticker: 'AAPL',
          companyName: 'Apple Inc.',
          messageTitle: 'Weekly Recap',
          messageShortSummary: 'Short summary',
          messageLongSummary: 'Long summary',
          newsLinks: const ['https://news1.com'],
          eightKLinks: const ['https://8k1.com'],
          priceMovement: {
            'startPrice': 150.0,
            'endPrice': 155.0,
            'priceChange': 5.0,
            'priceChangePercent': 3.33,
          },
          createdAt: createdAt,
        );

        // act
        final domain = dto.toDomain();

        // assert
        expect(domain.id, '2026-05-27');
        expect(domain.ticker, 'AAPL');
        expect(domain.companyName, 'Apple Inc.');
        expect(domain.messageTitle, 'Weekly Recap');
        expect(domain.messageShortSummary, 'Short summary');
        expect(domain.messageLongSummary, 'Long summary');
        expect(domain.newsLinks, ['https://news1.com']);
        expect(domain.eightKLinks, ['https://8k1.com']);
        expect(domain.createdAt, createdAt);
        expect(domain.priceMovement?.startPrice, 150.0);
        expect(domain.priceMovement?.endPrice, 155.0);
        expect(domain.priceMovement?.priceChange, 5.0);
        expect(domain.priceMovement?.priceChangePercent, 3.33);
      });

      test('toDomain_nullFields_priceMovementIsNull', () {
        // arrange
        final dto = WeeklyReportDto(
          createdAt: DateTime.parse('2026-05-27T10:00:00.000Z'),
        );

        // act
        final domain = dto.toDomain();

        // assert
        expect(domain.id, isNull);
        expect(domain.ticker, isNull);
        expect(domain.companyName, isNull);
        expect(domain.priceMovement, isNull);
      });

      test('toDomain_priceMovementWithIntValues_convertsToDouble', () {
        // arrange
        final dto = WeeklyReportDto(
          createdAt: DateTime.parse('2026-05-27T10:00:00.000Z'),
          priceMovement: {
            'startPrice': 150,
            'endPrice': 155,
            'priceChange': 5,
            'priceChangePercent': 3,
          },
        );

        // act
        final domain = dto.toDomain();

        // assert
        expect(domain.priceMovement?.startPrice, 150.0);
        expect(domain.priceMovement?.endPrice, 155.0);
        expect(domain.priceMovement?.priceChange, 5.0);
        expect(domain.priceMovement?.priceChangePercent, 3.0);
      });

      test('toDomain_priceMovementWithStringValues_convertsToDouble', () {
        // arrange
        final dto = WeeklyReportDto(
          createdAt: DateTime.parse('2026-05-27T10:00:00.000Z'),
          priceMovement: {
            'startPrice': '150.5',
            'endPrice': '155.5',
            'priceChange': '5.0',
            'priceChangePercent': '3.33',
          },
        );

        // act
        final domain = dto.toDomain();

        // assert
        expect(domain.priceMovement?.startPrice, 150.5);
        expect(domain.priceMovement?.endPrice, 155.5);
        expect(domain.priceMovement?.priceChange, 5.0);
        expect(domain.priceMovement?.priceChangePercent, 3.33);
      });

      test('toDomain_priceMovementWithNullValues_nullDoubles', () {
        // arrange
        final dto = WeeklyReportDto(
          createdAt: DateTime.parse('2026-05-27T10:00:00.000Z'),
          priceMovement: {
            'startPrice': null,
            'endPrice': null,
            'priceChange': null,
            'priceChangePercent': null,
          },
        );

        // act
        final domain = dto.toDomain();

        // assert
        expect(domain.priceMovement?.startPrice, isNull);
        expect(domain.priceMovement?.endPrice, isNull);
        expect(domain.priceMovement?.priceChange, isNull);
        expect(domain.priceMovement?.priceChangePercent, isNull);
      });
    });

    group('toJson', () {
      test('toJson_withId_excludesIdFromOutput', () {
        // arrange
        final dto = WeeklyReportDto(
          id: '2026-05-27',
          ticker: 'AAPL',
          companyName: 'Apple Inc.',
        );

        // act
        final json = dto.toJson();

        // assert
        expect(json.containsKey('id'), isFalse);
        expect(json['ticker'], 'AAPL');
        expect(json['companyName'], 'Apple Inc.');
      });

      test('toJson_nullCreatedAt_outputsNullWithoutError', () {
        // arrange
        const dto = WeeklyReportDto(ticker: 'AAPL');

        // act
        final json = dto.toJson();

        // assert
        expect(json['ticker'], 'AAPL');
        expect(json['createdAt'], isNull);
      });

      test('toJson_withCreatedAt_outputsFirestoreTimestamp', () {
        // arrange
        final dto = WeeklyReportDto(
          createdAt: DateTime.parse('2026-05-27T10:00:00.000Z'),
        );

        // act
        final json = dto.toJson();

        // assert
        expect(json['createdAt'], isA<Timestamp>());
      });
    });
  });
}
