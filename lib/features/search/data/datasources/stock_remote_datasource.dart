import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

abstract class IStockRemoteDataSource {
  Future<int> getRemoteUpdatedTime();
  Future<void> downloadStockFile(File targetFile);
}

@Injectable(as: IStockRemoteDataSource)
class StockRemoteDataSource implements IStockRemoteDataSource {
  final FirebaseStorage _storage;
  static const String _storagePath = 'system_data/stock_list.json';

  StockRemoteDataSource(this._storage);

  @override
  Future<int> getRemoteUpdatedTime() async {
    final ref = _storage.ref().child(_storagePath);
    final metadata = await ref.getMetadata();
    return metadata.updated?.millisecondsSinceEpoch ?? 0;
  }

  @override
  Future<void> downloadStockFile(File targetFile) async {
    final ref = _storage.ref().child(_storagePath);
    await ref.writeToFile(targetFile);
  }
}
