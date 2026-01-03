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
    test('setDocument saves data to Firestore', () async {
      final data = {'name': 'Test'};
      final path = 'users/123';

      await firestoreService.setDocument(path: path, data: data);

      final snapshot = await fakeFirestore.doc(path).get();
      expect(snapshot.exists, isTrue);
      expect(snapshot.data(), equals(data));
    });

    test('updateDocument updates data in Firestore', () async {
      final path = 'users/123';
      await fakeFirestore.doc(path).set({'name': 'Original', 'age': 25});

      final updateData = {'name': 'Updated'};
      await firestoreService.updateDocument(path: path, data: updateData);

      final snapshot = await fakeFirestore.doc(path).get();
      expect(snapshot.data(), equals({'name': 'Updated', 'age': 25}));
    });
  });
}
