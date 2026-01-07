import 'dart:async';
import 'dart:io';

import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/search/data/datasources/stock_local_datasource.dart';
import 'package:bizzie/features/search/data/repositories/stock_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseStorage extends Mock implements FirebaseStorage {}

class MockReference extends Mock implements Reference {}

class MockFullMetadata extends Mock implements FullMetadata {}

class MockIStockLocalDataSource extends Mock implements IStockLocalDataSource {}

class MockTaskSnapshot extends Mock implements TaskSnapshot {}

class FakeDownloadTask extends Fake implements DownloadTask {
  @override
  Future<S> then<S>(
    FutureOr<S> Function(TaskSnapshot) onValue, {
    Function? onError,
  }) {
    // Return a dummy snapshot
    return Future.value(MockTaskSnapshot()).then(onValue, onError: onError);
  }
}

class MockFile extends Mock implements File {}

class FakeFile extends Mock implements File {}

void main() {
  late StockRepository repository;
  late MockFirebaseStorage mockStorage;
  late MockIStockLocalDataSource mockLocalDataSource;
  late MockReference mockReference;
  late MockFullMetadata mockMetadata;
  late MockFile mockFile;

  setUpAll(() {
    registerFallbackValue(FakeFile());
  });

  setUp(() {
    mockStorage = MockFirebaseStorage();
    mockLocalDataSource = MockIStockLocalDataSource();
    mockReference = MockReference();
    mockMetadata = MockFullMetadata();
    mockFile = MockFile();

    repository = StockRepository(mockStorage, mockLocalDataSource);

    // Default mocks
    when(() => mockStorage.ref()).thenReturn(mockReference);
    when(() => mockReference.child(any())).thenReturn(mockReference);
  });

  group('StockRepository', () {
    group('getLocalStockListFile', () {
      test('getLocalStockListFile_fileExists_returnsFile', () async {
        // arrange
        when(
          () => mockLocalDataSource.getLocalStockFile(),
        ).thenAnswer((_) async => mockFile);
        when(() => mockFile.exists()).thenAnswer((_) async => true);

        // act
        final result = await repository.getLocalStockListFile();

        // assert
        expect(result, Right(mockFile));
        verify(() => mockLocalDataSource.getLocalStockFile()).called(1);
      });

      test(
        'getLocalStockListFile_fileDoesNotExist_returnsCacheFailure',
        () async {
          // arrange
          when(
            () => mockLocalDataSource.getLocalStockFile(),
          ).thenAnswer((_) async => mockFile);
          when(() => mockFile.exists()).thenAnswer((_) async => false);

          // act
          final result = await repository.getLocalStockListFile();

          // assert
          expect(result, isA<Left<Failure, File>>());
          result.fold(
            (failure) => expect(failure, isA<CacheFailure>()),
            (_) => fail('Should return Left'),
          );
        },
      );

      test(
        'getLocalStockListFile_exceptionOccurs_returnsCacheFailure',
        () async {
          // arrange
          when(
            () => mockLocalDataSource.getLocalStockFile(),
          ).thenThrow(Exception('Error'));

          // act
          final result = await repository.getLocalStockListFile();

          // assert
          expect(result, isA<Left<Failure, File>>());
        },
      );
    });

    group('hasLocalFile', () {
      test('hasLocalFile_dataSourceReturnsTrue_returnsTrue', () async {
        // arrange
        when(
          () => mockLocalDataSource.hasLocalFile(),
        ).thenAnswer((_) async => true);

        // act
        final result = await repository.hasLocalFile();

        // assert
        expect(result, true);
      });
    });

    group('syncStockList', () {
      test('syncStockList_noLocalFile_downloadsFile', () async {
        // arrange
        when(
          () => mockReference.getMetadata(),
        ).thenAnswer((_) async => mockMetadata);
        when(() => mockMetadata.updated).thenReturn(DateTime.now());

        when(() => mockLocalDataSource.getLastUpdatedTime()).thenReturn(0);

        when(
          () => mockLocalDataSource.hasLocalFile(),
        ).thenAnswer((_) async => false);

        when(
          () => mockLocalDataSource.getLocalStockFile(),
        ).thenAnswer((_) async => mockFile);

        final fakeDownloadTask = FakeDownloadTask();
        when(
          () => mockReference.writeToFile(any()),
        ).thenAnswer((_) => fakeDownloadTask);

        when(
          () => mockLocalDataSource.setLastUpdatedTime(any()),
        ).thenAnswer((_) async {});

        // act
        final result = await repository.syncStockList();

        // assert
        expect(result, const Right(null));
        verify(() => mockReference.writeToFile(mockFile)).called(1);
        verify(() => mockLocalDataSource.setLastUpdatedTime(any())).called(1);
      });

      test('syncStockList_localFileUpToDate_doesNotDownload', () async {
        // arrange
        final now = DateTime.now();
        final remoteTime = now.millisecondsSinceEpoch;

        when(
          () => mockReference.getMetadata(),
        ).thenAnswer((_) async => mockMetadata);
        when(() => mockMetadata.updated).thenReturn(now);

        when(
          () => mockLocalDataSource.getLastUpdatedTime(),
        ).thenReturn(remoteTime);
        when(
          () => mockLocalDataSource.hasLocalFile(),
        ).thenAnswer((_) async => true);

        // act
        final result = await repository.syncStockList();

        // assert
        expect(result, const Right(null));
        verifyNever(() => mockReference.writeToFile(any()));
        verifyNever(() => mockLocalDataSource.setLastUpdatedTime(any()));
      });

      test('syncStockList_exceptionOccurs_returnsServerFailure', () async {
        // arrange
        when(
          () => mockReference.getMetadata(),
        ).thenThrow(Exception('Firebase Error'));

        // act
        final result = await repository.syncStockList();

        // assert
        expect(result, isA<Left<Failure, void>>());
        result.fold(
          (failure) => expect(failure, isA<ServerFailure>()),
          (_) => fail('Should return Left'),
        );
      });
    });
  });
}
