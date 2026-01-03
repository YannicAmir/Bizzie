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

  /// Sets data on the document at [path].
  /// If [merge] is true, the data is merged into the existing document.
  Future<void> setDocument({
    required String path,
    required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    final reference = _firestore.doc(path);
    await reference.set(data, SetOptions(merge: merge));
  }

  /// Updates data on the document at [path].
  Future<void> updateDocument({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = _firestore.doc(path);
    await reference.update(data);
  }

  /// Gets a snapshot of the document at [path].
  Future<DocumentSnapshot<Map<String, dynamic>>> getDocument({
    required String path,
  }) async {
    final reference = _firestore.doc(path);
    return await reference.get();
  }

  /// Gets a stream of the document at [path].
  Stream<DocumentSnapshot<Map<String, dynamic>>> getDocumentStream({
    required String path,
  }) {
    final reference = _firestore.doc(path);
    return reference.snapshots();
  }

  /// Adds a document to the collection at [path] with an auto-generated ID.
  Future<DocumentReference<Map<String, dynamic>>> addDocument({
    required String collectionPath,
    required Map<String, dynamic> data,
  }) async {
    final collection = _firestore.collection(collectionPath);
    return await collection.add(data);
  }
}
