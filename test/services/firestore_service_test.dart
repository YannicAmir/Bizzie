import 'package:bizzie/services/firestore_service.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeFirebaseFirestore fakeFirestore;
  late FirestoreService firestoreService;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    firestoreService = FirestoreService(fakeFirestore);
  });

  group('FirestoreService', () {
    test('setDocument_validData_savesToFirestore', () async {
      // arrange
      final data = {'name': 'Test'};
      final path = 'users/123';

      // act
      await firestoreService.setDocument(path: path, data: data);

      // assert
      final snapshot = await fakeFirestore.doc(path).get();
      expect(snapshot.exists, isTrue);
      expect(snapshot.data(), equals(data));
    });

    test('updateDocument_existingDocument_updatesData', () async {
      // arrange
      final path = 'users/123';
      await fakeFirestore.doc(path).set({'name': 'Original', 'age': 25});
      final updateData = {'name': 'Updated'};

      // act
      await firestoreService.updateDocument(path: path, data: updateData);

      // assert
      final snapshot = await fakeFirestore.doc(path).get();
      expect(snapshot.data(), equals({'name': 'Updated', 'age': 25}));
    });

    test('getDocument_existingDocument_returnsSnapshot', () async {
      // arrange
      final path = 'users/123';
      final data = {'name': 'Test'};
      await fakeFirestore.doc(path).set(data);

      // act
      final result = await firestoreService.getDocument(path: path);

      // assert
      expect(result.exists, isTrue);
      expect(result.data(), equals(data));
    });

    test('addDocument_validData_addsToCollection', () async {
      // arrange
      final collectionPath = 'items';
      final data = {'name': 'New Item'};

      // act
      final docRef = await firestoreService.addDocument(
        collectionPath: collectionPath,
        data: data,
      );

      // assert
      final snapshot = await docRef.get();
      expect(snapshot.exists, isTrue);
      expect(snapshot.data(), equals(data));
    });

    test('deleteDocument_existingDocument_removesFromFirestore', () async {
      // arrange
      final path = 'users/123';
      await fakeFirestore.doc(path).set({'name': 'To Delete'});

      // act
      await firestoreService.deleteDocument(path: path);

      // assert
      final snapshot = await fakeFirestore.doc(path).get();
      expect(snapshot.exists, isFalse);
    });

    group('getLatestDocument', () {
      test('getLatestDocument_emptyCollection_returnsNull', () async {
        // arrange
        const collectionPath = 'empty_collection';

        // act
        final result = await firestoreService.getLatestDocument(
          collectionPath: collectionPath,
          orderBy: 'date',
        );

        // assert
        expect(result, isNull);
      });

      test('getLatestDocument_multipleDocuments_returnsLatest', () async {
        // arrange
        final collectionPath = 'items';
        await fakeFirestore.collection(collectionPath).add({
          'id': 1,
          'date': DateTime(2026, 1, 1).toIso8601String(),
        });
        await fakeFirestore.collection(collectionPath).add({
          'id': 2,
          'date': DateTime(2026, 1, 3).toIso8601String(),
        });
        await fakeFirestore.collection(collectionPath).add({
          'id': 3,
          'date': DateTime(2026, 1, 2).toIso8601String(),
        });

        // act
        final result = await firestoreService.getLatestDocument(
          collectionPath: collectionPath,
          orderBy: 'date',
          descending: true,
        );

        // assert
        expect(result?['id'], equals(2));
      });

      test('getLatestDocument_ascendingOrder_returnsEarliest', () async {
        // arrange
        final collectionPath = 'items_asc';
        await fakeFirestore.collection(collectionPath).add({
          'id': 1,
          'date': 'A',
        });
        await fakeFirestore.collection(collectionPath).add({
          'id': 2,
          'date': 'C',
        });
        await fakeFirestore.collection(collectionPath).add({
          'id': 3,
          'date': 'B',
        });

        // act
        final result = await firestoreService.getLatestDocument(
          collectionPath: collectionPath,
          orderBy: 'date',
          descending: false,
        );

        // assert
        expect(result?['id'], equals(1));
      });
    });
  });
}
