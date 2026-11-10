import 'package:bizzie/core/constants/firestore_constants.dart';
import 'package:bizzie/core/error/exceptions.dart';
import 'package:bizzie/features/company_profile/security/data/datasources/security_quote_remote_datasource.dart';
import 'package:bizzie/features/company_profile/security/data/dtos/security_quote_dto.dart';
import 'package:bizzie/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirestoreService extends Mock implements FirestoreService {}

const tTicker = 'AAPL';
const tPath = '${FirestoreConstants.stockPrices}/$tTicker';
const tSecurityQuoteDto = SecurityQuoteDto(
  ticker: tTicker,
  price: 189.5,
  change: 1.25,
  changePercent: 0.66,
  sessionDate: '2026-11-06',
);
const tUpdatedSecurityQuoteDto = SecurityQuoteDto(
  ticker: tTicker,
  price: 190.1,
  change: 1.85,
  changePercent: 0.98,
  sessionDate: '2026-11-06',
);
final tException = Exception('firestore failed');
final tPermissionDenied = FirebaseException(
  plugin: 'cloud_firestore',
  code: 'permission-denied',
);

void main() {
  late MockFirestoreService mockFirestoreService;
  late SecurityQuoteRemoteDataSource sut;

  void stubGetDocumentStream(Stream<SecurityQuoteDto?> stream) {
    when(
      () => mockFirestoreService.getDocumentStream<SecurityQuoteDto>(
        path: any(named: 'path'),
        fromJson: any(named: 'fromJson'),
        toJson: any(named: 'toJson'),
      ),
    ).thenAnswer((_) => stream);
  }

  setUp(() {
    mockFirestoreService = MockFirestoreService();
    sut = SecurityQuoteRemoteDataSource(mockFirestoreService);
  });

  group('SecurityQuoteRemoteDataSource', () {
    group('getSecurityQuoteStream', () {
      test('getSecurityQuoteStream_documentExists_emitsDto', () async {
        // arrange
        stubGetDocumentStream(Stream.value(tSecurityQuoteDto));

        // act
        final stream = sut.getSecurityQuoteStream(tTicker);

        // assert
        await expectLater(stream, emitsInOrder([tSecurityQuoteDto, emitsDone]));
      });

      test(
        'getSecurityQuoteStream_documentUpdates_emitsEachSnapshot',
        () async {
          // arrange
          stubGetDocumentStream(
            Stream.fromIterable([tSecurityQuoteDto, tUpdatedSecurityQuoteDto]),
          );

          // act
          final stream = sut.getSecurityQuoteStream(tTicker);

          // assert
          await expectLater(
            stream,
            emitsInOrder([
              tSecurityQuoteDto,
              tUpdatedSecurityQuoteDto,
              emitsDone,
            ]),
          );
        },
      );

      test('getSecurityQuoteStream_called_requestsStockPricesTickerPath', () {
        // arrange
        stubGetDocumentStream(Stream.value(tSecurityQuoteDto));

        // act
        sut.getSecurityQuoteStream(tTicker);

        // assert
        verify(
          () => mockFirestoreService.getDocumentStream<SecurityQuoteDto>(
            path: tPath,
            fromJson: any(named: 'fromJson'),
            toJson: any(named: 'toJson'),
          ),
        ).called(1);
      });

      test('getSecurityQuoteStream_called_passesDtoJsonConverters', () {
        // arrange
        stubGetDocumentStream(Stream.value(tSecurityQuoteDto));

        // act
        sut.getSecurityQuoteStream(tTicker);

        // assert
        final captured = verify(
          () => mockFirestoreService.getDocumentStream<SecurityQuoteDto>(
            path: any(named: 'path'),
            fromJson: captureAny(named: 'fromJson'),
            toJson: captureAny(named: 'toJson'),
          ),
        ).captured;
        final fromJson =
            captured[0] as SecurityQuoteDto Function(Map<String, dynamic>);
        final toJson =
            captured[1] as Map<String, dynamic> Function(SecurityQuoteDto);
        expect(toJson(tSecurityQuoteDto), tSecurityQuoteDto.toJson());
        expect(fromJson(tSecurityQuoteDto.toJson()), tSecurityQuoteDto);
      });

      test('getSecurityQuoteStream_documentMissing_emitsNull', () async {
        // arrange
        stubGetDocumentStream(Stream.value(null));

        // act
        final stream = sut.getSecurityQuoteStream(tTicker);

        // assert
        await expectLater(stream, emitsInOrder([isNull, emitsDone]));
      });

      test('getSecurityQuoteStream_streamErrors_rethrowsError', () async {
        // arrange
        stubGetDocumentStream(Stream.error(tException));

        // act
        final stream = sut.getSecurityQuoteStream(tTicker);

        // assert
        await expectLater(stream, emitsError(tException));
      });

      test(
        'getSecurityQuoteStream_permissionDenied_throwsPermissionDeniedException',
        () async {
          // arrange
          stubGetDocumentStream(Stream.error(tPermissionDenied));

          // act
          final stream = sut.getSecurityQuoteStream(tTicker);

          // assert
          await expectLater(
            stream,
            emitsError(isA<PermissionDeniedException>()),
          );
        },
      );
    });
  });
}
