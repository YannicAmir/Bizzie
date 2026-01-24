import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreCacheEntry<T> {
  final T data;
  final DateTime lastUpdated;

  FirestoreCacheEntry({required this.data, required this.lastUpdated});

  factory FirestoreCacheEntry.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) {
    return FirestoreCacheEntry(
      data: fromJsonT(json['data']),
      lastUpdated: (json['lastUpdated'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return {
      'data': toJsonT(data),
      'lastUpdated': Timestamp.fromDate(lastUpdated),
    };
  }
}
