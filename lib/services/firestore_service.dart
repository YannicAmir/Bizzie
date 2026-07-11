import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';

final _logger = BizzieLogger('FirestoreService');

@lazySingleton
class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService(this._firestore);

  void _logAndRethrowStreamError(Object e, StackTrace s, String context) {
    if (e is FirebaseException && e.code == 'permission-denied') {
      _logger.warning(
        'Firestore permission denied for $context - likely during logout session clearing',
        e,
      );
    } else {
      _logger.severe('Firestore stream error for $context', e, s);
    }
    throw e;
  }

  CollectionReference<T> _getCollectionRef<T>(
    String path,
    T Function(Map<String, dynamic> json) fromJson,
    Map<String, dynamic> Function(T value) toJson,
  ) {
    return _firestore
        .collection(path)
        .withConverter<T>(
          fromFirestore: (snapshot, _) {
            final data = Map<String, dynamic>.from(snapshot.data() ?? {});
            data['id'] = snapshot.id;
            return fromJson(data);
          },
          toFirestore: (value, _) => toJson(value),
        );
  }

  DocumentReference<T> _getDocRef<T>(
    String path,
    T Function(Map<String, dynamic> json) fromJson,
    Map<String, dynamic> Function(T value) toJson,
  ) {
    return _firestore
        .doc(path)
        .withConverter<T>(
          fromFirestore: (snapshot, _) {
            final data = Map<String, dynamic>.from(snapshot.data() ?? {});
            data['id'] = snapshot.id;
            return fromJson(data);
          },
          toFirestore: (value, _) => toJson(value),
        );
  }

  CollectionReference<T> getConvertedCollectionRef<T>({
    required String path,
    required T Function(Map<String, dynamic> json) fromJson,
    required Map<String, dynamic> Function(T value) toJson,
  }) {
    return _firestore
        .collection(path)
        .withConverter<T>(
          fromFirestore: (snapshot, _) =>
              fromJson(Map<String, dynamic>.from(snapshot.data() ?? {})),
          toFirestore: (value, _) => toJson(value),
        );
  }

  Stream<T?> getDocumentStream<T>({
    required String path,
    required T Function(Map<String, dynamic> json) fromJson,
    required Map<String, dynamic> Function(T value) toJson,
  }) {
    return _getDocRef<T>(
      path,
      fromJson,
      toJson,
    ).snapshots().map((s) => s.data()).handleError((e, s) {
      if (e is FirebaseException && e.code == 'permission-denied') {
        _logger.warning(
          'Firestore permission denied for $path - likely during logout session clearing',
          e,
        );
      }
      throw e;
    });
  }

  Stream<List<T>> getCollectionStream<T>({
    required String path,
    required T Function(Map<String, dynamic> json) fromJson,
    required Map<String, dynamic> Function(T value) toJson,
    Query<T> Function(Query<T> query)? queryBuilder,
  }) {
    Query<T> query = _getCollectionRef<T>(path, fromJson, toJson);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    return query
        .snapshots()
        .map((s) => s.docs.map((d) => d.data()).toList())
        .handleError((e, s) {
          if (e is FirebaseException && e.code == 'permission-denied') {
            _logger.warning(
              'Firestore permission denied for $path - likely during logout session clearing',
              e,
            );
          }
          throw e;
        });
  }

  Future<List<T>> getCollection<T>({
    required String path,
    required T Function(Map<String, dynamic> json) fromJson,
    required Map<String, dynamic> Function(T value) toJson,
    Query<T> Function(Query<T> query)? queryBuilder,
  }) async {
    Query<T> query = _getCollectionRef<T>(path, fromJson, toJson);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final snapshot = await query.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<List<T>> getCollectionFuture<T>({
    required String path,
    required T Function(Map<String, dynamic> json) fromJson,
    required Map<String, dynamic> Function(T value) toJson,
    String? whereInField,
    List<dynamic>? whereInValues,
    Query<T> Function(Query<T> query)? queryBuilder,
  }) async {
    Query<T> query = _getCollectionRef<T>(path, fromJson, toJson);

    if (whereInField != null && whereInValues != null) {
      if (whereInValues.isEmpty) return [];
      query = query.where(whereInField, whereIn: whereInValues);
    }

    if (queryBuilder != null) {
      query = queryBuilder(query);
    }

    final snapshot = await query.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<T?> getDocument<T>({
    required String path,
    required T Function(Map<String, dynamic> json) fromJson,
    required Map<String, dynamic> Function(T value) toJson,
  }) async {
    final snapshot = await _getDocRef<T>(path, fromJson, toJson).get();
    return snapshot.data();
  }

  Future<T?> getLatestDocument<T>({
    required String collectionPath,
    required String orderBy,
    required T Function(Map<String, dynamic> json) fromJson,
    required Map<String, dynamic> Function(T value) toJson,
    bool descending = true,
  }) async {
    final querySnapshot = await _getCollectionRef<T>(
      collectionPath,
      fromJson,
      toJson,
    ).orderBy(orderBy, descending: descending).limit(1).get();

    if (querySnapshot.docs.isEmpty) return null;
    return querySnapshot.docs.first.data();
  }

  Future<void> setDocument<T>({
    required String path,
    required T value,
    required Map<String, dynamic> Function(T value) toJson,
    bool merge = true,
  }) async {
    final data = toJson(value);
    await _firestore.doc(path).set(data, SetOptions(merge: merge));
  }

  Future<void> updateDocument({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    await _firestore.doc(path).update(data);
  }

  Future<void> deleteDocument({required String path}) async {
    await _firestore.doc(path).delete();
  }

  Stream<List<T>> getCollectionGroupStreamChunked<T>({
    required String collectionId,
    required String whereInField,
    required List<dynamic> values,
    required T Function(Map<String, dynamic> json) fromJson,
    int chunkSize = 30,
  }) {
    if (values.isEmpty) return Stream.value([]);

    final chunks = <List<dynamic>>[];
    for (var i = 0; i < values.length; i += chunkSize) {
      chunks.add(
        values.sublist(
          i,
          i + chunkSize > values.length ? values.length : i + chunkSize,
        ),
      );
    }

    final streams = chunks.map((chunk) {
      return _firestore
          .collectionGroup(collectionId)
          .where(whereInField, whereIn: chunk)
          .snapshots()
          .map((s) => s.docs.map((d) {
                final data = Map<String, dynamic>.from(d.data());
                data['id'] = d.id;
                return fromJson(data);
              }).toList());
    }).toList();

    return Rx.combineLatest<List<T>, List<T>>(
      streams,
      (valuesList) => valuesList.expand((x) => x).toList(),
    ).handleError(
      (Object e, StackTrace s) =>
          _logAndRethrowStreamError(e, s, 'collectionGroup $collectionId'),
    );
  }

  Stream<List<T>> getMergedSubcollectionStreams<T>({
    required String rootCollection,
    required List<String> documentIds,
    required String subcollectionId,
    required T Function(Map<String, dynamic> json) fromJson,
    String? injectDocumentIdAs,
  }) {
    if (documentIds.isEmpty) return Stream.value([]);

    final streams = documentIds.map((docId) {
      return _firestore
          .collection(rootCollection)
          .doc(docId)
          .collection(subcollectionId)
          .snapshots()
          .map((s) => s.docs.map((d) {
                final data = Map<String, dynamic>.from(d.data());
                data['id'] = d.id;
                if (injectDocumentIdAs != null) {
                  data.putIfAbsent(injectDocumentIdAs, () => docId);
                }
                return fromJson(data);
              }).toList());
    }).toList();

    return Rx.combineLatest<List<T>, List<T>>(
      streams,
      (valuesList) => valuesList.expand((x) => x).toList(),
    ).handleError(
      (Object e, StackTrace s) => _logAndRethrowStreamError(
        e,
        s,
        '$rootCollection/*/$subcollectionId',
      ),
    );
  }

  Stream<List<T>> getCollectionStreamChunked<T>({
    required String path,
    required String whereInField,
    required List<dynamic> values,
    required T Function(Map<String, dynamic> json) fromJson,
    required Map<String, dynamic> Function(T value) toJson,
    int chunkSize = 30,
    Query<T> Function(Query<T> query)? queryBuilder,
  }) {
    if (values.isEmpty) return Stream.value([]);

    final chunks = <List<dynamic>>[];
    for (var i = 0; i < values.length; i += chunkSize) {
      chunks.add(
        values.sublist(
          i,
          i + chunkSize > values.length ? values.length : i + chunkSize,
        ),
      );
    }

    final streams = chunks.map((chunk) {
      Query<T> query = _getCollectionRef<T>(
        path,
        fromJson,
        toJson,
      ).where(whereInField, whereIn: chunk);
      if (queryBuilder != null) {
        query = queryBuilder(query);
      }
      return query.snapshots().map((s) => s.docs.map((d) => d.data()).toList());
    }).toList();

    return Rx.combineLatest<List<T>, List<T>>(
      streams,
      (valuesList) => valuesList.expand((x) => x).toList(),
    ).handleError(
      (Object e, StackTrace s) => _logAndRethrowStreamError(e, s, path),
    );
  }

  BizzieBatch batch() => BizzieBatch(_firestore.batch(), _firestore);
}

class BizzieBatch {
  final WriteBatch _batch;
  final FirebaseFirestore _firestore;

  BizzieBatch(this._batch, this._firestore);

  void setDocument<T>({
    required String path,
    required T value,
    required Map<String, dynamic> Function(T value) toJson,
    bool merge = true,
  }) {
    final reference = _firestore.doc(path);
    _batch.set(reference, toJson(value), SetOptions(merge: merge));
  }

  void setRaw({
    required String path,
    required Map<String, dynamic> data,
    bool merge = true,
  }) {
    final reference = _firestore.doc(path);
    _batch.set(reference, data, SetOptions(merge: merge));
  }

  void deleteDocument({required String path}) {
    final reference = _firestore.doc(path);
    _batch.delete(reference);
  }

  Future<void> commit() => _batch.commit();
}
