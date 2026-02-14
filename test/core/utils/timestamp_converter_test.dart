import 'package:bizzie/core/utils/timestamp_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TimestampConverter', () {
    const converter = TimestampConverter();

    test('fromJson_handlesTimestamp_returnsDateTime', () {
      // arrange
      final now = DateTime.now();
      final timestamp = Timestamp.fromDate(now);

      // act
      final result = converter.fromJson(timestamp);

      // assert
      expect(result.millisecondsSinceEpoch, now.millisecondsSinceEpoch);
    });

    test('fromJson_handlesString_returnsDateTime', () {
      // arrange
      const dateStr = '2023-01-15T12:00:00Z';
      final expected = DateTime.parse(dateStr);

      // act
      final result = converter.fromJson(dateStr);

      // assert
      expect(result, expected);
    });

    test('fromJson_handlesNull_returnsDateTimeNow', () {
      // act
      final result = converter.fromJson(null);

      // assert
      expect(result, isA<DateTime>());
      final now = DateTime.now();
      expect(result.difference(now).inSeconds.abs() < 5, true);
    });

    test('fromJson_invalidType_throwsFormatException', () {
      // act & assert
      expect(() => converter.fromJson(123), throwsFormatException);
    });

    test('toJson_dateTime_returnsTimestamp', () {
      // arrange
      final now = DateTime.now();

      // act
      final result = converter.toJson(now);

      // assert
      expect(result, isA<Timestamp>());
      expect(
        (result as Timestamp).toDate().millisecondsSinceEpoch,
        now.millisecondsSinceEpoch,
      );
    });
  });
}
