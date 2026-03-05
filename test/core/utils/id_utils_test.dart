import 'package:bizzie/core/utils/id_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('IdUtils', () {
    test('generateSessionId_noArguments_returnsEightCharacterString', () {
      // act
      final id = IdUtils.generateSessionId();

      // assert
      expect(id.length, 8);
      expect(id, isA<String>());
    });

    test('generateSessionId_customLength_returnsStringOfSpecifiedLength', () {
      // arrange
      const customLength = 12;

      // act
      final id = IdUtils.generateSessionId(customLength);

      // assert
      expect(id.length, customLength);
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

    test('generateSessionId_validCharacters_containsOnlyUrlFriendlyChars', () {
      // arrange
      final urlFriendlyRegex = RegExp(r'^[a-zA-Z0-9_-]+$');

      // act
      final id = IdUtils.generateSessionId(100);

      // assert
      expect(urlFriendlyRegex.hasMatch(id), isTrue);
    });
  });
}
