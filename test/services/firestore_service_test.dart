import 'package:bizzie/services/firestore_service.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

class TestDto {
  final String id;
  final String name;

  TestDto({this.id = '', required this.name});

  factory TestDto.fromJson(Map<String, dynamic> json) {
    return TestDto(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'name': name};
}

void main() {
  late FakeFirebaseFirestore fakeFirestore;
  late FirestoreService firestoreService;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    firestoreService = FirestoreService(fakeFirestore);
  });

  group('FirestoreService (Generic API)', () {
    test('setDocument saves typed data to Firestore', () async {
      final dto = TestDto(name: 'TestItem');
      const path = 'items/123';

      await firestoreService.setDocument<TestDto>(
        path: path,
        value: dto,
        toJson: (d) => d.toJson(),
      );

      final snapshot = await fakeFirestore.doc(path).get();
      expect(snapshot.exists, isTrue);
      expect(snapshot.data()?['name'], 'TestItem');
    });

    test('getDocument returns typed data and injects ID', () async {
      const path = 'items/123';
      await fakeFirestore.doc(path).set({'name': 'Existing'});

      final result = await firestoreService.getDocument<TestDto>(
        path: path,
        fromJson: TestDto.fromJson,
        toJson: (d) => d.toJson(),
      );

      expect(result, isNotNull);
      expect(result?.name, 'Existing');
      expect(result?.id, '123'); // Verify ID injection
    });

    test('getCollection returns list of typed data', () async {
      const collectionPath = 'items';
      await fakeFirestore.collection(collectionPath).doc('1').set({
        'name': 'A',
      });
      await fakeFirestore.collection(collectionPath).doc('2').set({
        'name': 'B',
      });

      final results = await firestoreService.getCollection<TestDto>(
        path: collectionPath,
        fromJson: TestDto.fromJson,
        toJson: (d) => d.toJson(),
      );

      expect(results.length, 2);
      expect(results.any((e) => e.name == 'A' && e.id == '1'), isTrue);
      expect(results.any((e) => e.name == 'B' && e.id == '2'), isTrue);
    });

    test('getLatestDocument returns the single latest matching doc', () async {
      const path = 'logs';
      await fakeFirestore.collection(path).add({'name': 'old', 'ts': 1});
      await fakeFirestore.collection(path).add({'name': 'new', 'ts': 100});
      await fakeFirestore.collection(path).add({'name': 'mid', 'ts': 50});

      final latest = await firestoreService.getLatestDocument<TestDto>(
        collectionPath: path,
        orderBy: 'ts',
        fromJson: TestDto.fromJson,
        toJson: (d) => d.toJson(),
      );

      expect(latest?.name, 'new');
    });

    test('batch performs atomic multiple sets', () async {
      final batch = firestoreService.batch();

      batch.setDocument<TestDto>(
        path: 'items/b1',
        value: TestDto(name: 'Batch1'),
        toJson: (d) => d.toJson(),
      );

      batch.setRaw(path: 'items/b2', data: {'name': 'BatchRaw'});

      await batch.commit();

      final s1 = await fakeFirestore.doc('items/b1').get();
      final s2 = await fakeFirestore.doc('items/b2').get();

      expect(s1.data()?['name'], 'Batch1');
      expect(s2.data()?['name'], 'BatchRaw');
    });
  });
}
