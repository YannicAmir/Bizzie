import 'package:bizzie/core/constants/storage_constants.dart';
import 'package:bizzie/features/app_ratings/data/datasources/app_ratings_local_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late AppRatingsLocalDataSource dataSource;

  const interactionKey = StorageConstants.appRatingsInteractionCount;
  const attemptsKey = StorageConstants.appRatingsPromptAttempts;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = AppRatingsLocalDataSource(mockSharedPreferences);
  });

  group('AppRatingsLocalDataSource', () {
    group('interactionCount', () {
      test('getInteractionCount_noValue_returnsZero', () {
        // arrange
        when(
          () => mockSharedPreferences.getInt(interactionKey),
        ).thenReturn(null);

        // act
        final result = dataSource.getInteractionCount();

        // assert
        expect(result, 0);
        verify(() => mockSharedPreferences.getInt(interactionKey)).called(1);
      });

      test('getInteractionCount_hasValue_returnsValue', () {
        // arrange
        const expectedCount = 5;
        when(
          () => mockSharedPreferences.getInt(interactionKey),
        ).thenReturn(expectedCount);

        // act
        final result = dataSource.getInteractionCount();

        // assert
        expect(result, expectedCount);
        verify(() => mockSharedPreferences.getInt(interactionKey)).called(1);
      });

      test('setInteractionCount_callsSetInt', () async {
        // arrange
        const countToSet = 10;
        when(
          () => mockSharedPreferences.setInt(interactionKey, countToSet),
        ).thenAnswer((_) async => true);

        // act
        await dataSource.setInteractionCount(countToSet);

        // assert
        verify(
          () => mockSharedPreferences.setInt(interactionKey, countToSet),
        ).called(1);
      });
    });

    group('promptAttempts', () {
      test('getPromptAttempts_noValue_returnsZero', () {
        // arrange
        when(() => mockSharedPreferences.getInt(attemptsKey)).thenReturn(null);

        // act
        final result = dataSource.getPromptAttempts();

        // assert
        expect(result, 0);
        verify(() => mockSharedPreferences.getInt(attemptsKey)).called(1);
      });

      test('getPromptAttempts_hasValue_returnsValue', () {
        // arrange
        const expectedAttempts = 1;
        when(
          () => mockSharedPreferences.getInt(attemptsKey),
        ).thenReturn(expectedAttempts);

        // act
        final result = dataSource.getPromptAttempts();

        // assert
        expect(result, expectedAttempts);
        verify(() => mockSharedPreferences.getInt(attemptsKey)).called(1);
      });

      test('setPromptAttempts_callsSetInt', () async {
        // arrange
        const attemptsToSet = 2;
        when(
          () => mockSharedPreferences.setInt(attemptsKey, attemptsToSet),
        ).thenAnswer((_) async => true);

        // act
        await dataSource.setPromptAttempts(attemptsToSet);

        // assert
        verify(
          () => mockSharedPreferences.setInt(attemptsKey, attemptsToSet),
        ).called(1);
      });
    });
  });
}
