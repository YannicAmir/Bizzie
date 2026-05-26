import 'package:bizzie/core/utils/id_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('IdUtils', () {
    test('generateSessionId_noArguments_returns36CharacterString', () {
      // act
      final id = IdUtils.generateSessionId();

      // assert
      expect(id, isA<String>());
      expect(id.length, 36);
    });

    test('generateSessionId_validFormat_matchesUuidV4Pattern', () {
      // arrange
      final uuidV4Regex = RegExp(
        r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
      );

      // act
      final id = IdUtils.generateSessionId();

      // assert
      expect(uuidV4Regex.hasMatch(id), isTrue);
    });

    test('generateSessionId_multipleCalls_returnsUniqueStrings', () {
      // arrange
      final ids = <String>{};
      const count = 100;

      // act
      for (var i = 0; i < count; i++) {
        ids.add(IdUtils.generateSessionId());
      }

      // assert
      expect(ids.length, count);
    });
  });
}
