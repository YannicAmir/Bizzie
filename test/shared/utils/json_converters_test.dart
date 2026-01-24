import 'package:bizzie/shared/utils/json_converters.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TimestampConverter', () {
    const converter = TimestampConverter();

    test('fromJson_handlesTimestamp', () {
      final now = DateTime.now();
      final timestamp = Timestamp.fromDate(now);
      expect(converter.fromJson(timestamp), now);
    });

    test('fromJson_handlesString', () {
      const dateStr = '2023-01-15T12:00:00Z';
      final expected = DateTime.parse(dateStr);
      expect(converter.fromJson(dateStr), expected);
    });

    test('fromJson_throwsOnInvalidType', () {
      expect(() => converter.fromJson(123), throwsFormatException);
    });

    test('toJson_returnsTimestamp', () {
      final now = DateTime.now();
      final result = converter.toJson(now);
      expect(result, isA<Timestamp>());
      expect((result as Timestamp).toDate(), now);
    });
  });
}
