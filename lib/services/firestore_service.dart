import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@singleton
class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService(this._firestore);

  FirebaseFirestore get instance => _firestore;

  @factoryMethod
  static FirestoreService init() {
    return FirestoreService(FirebaseFirestore.instance);
  }

  Future<void> setDocument({
    required String path,
    required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    final reference = _firestore.doc(path);
    await reference.set(data, SetOptions(merge: merge));
  }

  Future<void> updateDocument({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = _firestore.doc(path);
    await reference.update(data);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDocument({
    required String path,
  }) async {
    final reference = _firestore.doc(path);
    return await reference.get();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getDocumentStream({
    required String path,
  }) {
    final reference = _firestore.doc(path);
    return reference.snapshots();
  }

  Future<DocumentReference<Map<String, dynamic>>> addDocument({
    required String collectionPath,
    required Map<String, dynamic> data,
  }) async {
    final collection = _firestore.collection(collectionPath);
    return await collection.add(data);
  }
}
