import 'dart:io';

import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/search/data/datasources/stock_local_datasource.dart';
import 'package:bizzie/features/search/data/datasources/stock_remote_datasource.dart';
import 'package:bizzie/features/search/data/repositories/stock_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIStockRemoteDataSource extends Mock
    implements IStockRemoteDataSource {}

class MockIStockLocalDataSource extends Mock implements IStockLocalDataSource {}

class MockFile extends Mock implements File {}

class FakeFile extends Mock implements File {}

void main() {
  late StockRepository repository;
  late MockIStockRemoteDataSource mockRemoteDataSource;
  late MockIStockLocalDataSource mockLocalDataSource;
  late MockFile mockFile;

  setUpAll(() {
    registerFallbackValue(FakeFile());
  });

  setUp(() {
    mockRemoteDataSource = MockIStockRemoteDataSource();
    mockLocalDataSource = MockIStockLocalDataSource();
    mockFile = MockFile();

    repository = StockRepository(mockRemoteDataSource, mockLocalDataSource);
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
        final remoteTime = DateTime.now().millisecondsSinceEpoch;

        when(
          () => mockRemoteDataSource.getRemoteUpdatedTime(),
        ).thenAnswer((_) async => remoteTime);

        when(() => mockLocalDataSource.getLastUpdatedTime()).thenReturn(0);

        when(
          () => mockLocalDataSource.hasLocalFile(),
        ).thenAnswer((_) async => false);

        when(
          () => mockLocalDataSource.getLocalStockFile(),
        ).thenAnswer((_) async => mockFile);

        when(
          () => mockRemoteDataSource.downloadStockFile(any()),
        ).thenAnswer((_) async {});

        when(
          () => mockLocalDataSource.setLastUpdatedTime(any()),
        ).thenAnswer((_) async {});

        // act
        final result = await repository.syncStockList();

        // assert
        expect(result, const Right(null));
        verify(
          () => mockRemoteDataSource.downloadStockFile(mockFile),
        ).called(1);
        verify(
          () => mockLocalDataSource.setLastUpdatedTime(remoteTime),
        ).called(1);
      });

      test('syncStockList_localFileUpToDate_doesNotDownload', () async {
        // arrange
        final remoteTime = DateTime.now().millisecondsSinceEpoch;

        when(
          () => mockRemoteDataSource.getRemoteUpdatedTime(),
        ).thenAnswer((_) async => remoteTime);

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
        verifyNever(() => mockRemoteDataSource.downloadStockFile(any()));
        verifyNever(() => mockLocalDataSource.setLastUpdatedTime(any()));
      });

      test('syncStockList_exceptionOccurs_returnsServerFailure', () async {
        // arrange
        when(
          () => mockRemoteDataSource.getRemoteUpdatedTime(),
        ).thenThrow(Exception('Server Error'));

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
