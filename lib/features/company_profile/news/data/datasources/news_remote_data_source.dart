import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/services/config_service.dart';
import 'package:bizzie/features/company_profile/news/data/dtos/news_dto.dart';

abstract class NewsRemoteDataSource {
  Future<List<NewsDto>> getStockNews(String ticker);
}

@LazySingleton(as: NewsRemoteDataSource)
class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  static const int _newsLimit = 100;

  final Dio _dio;
  final ConfigService _configService;

  NewsRemoteDataSourceImpl(@Named('FmpDio') this._dio, this._configService);

  String _sanitize(String ticker) => ticker.replaceAll('.', '-');

  String _removeTrailingSlash(String url) =>
      url.endsWith('/') ? url.substring(0, url.length - 1) : url;

  String get _baseUrl => _removeTrailingSlash(_configService.fmpConfig.baseUrl);

  @override
  Future<List<NewsDto>> getStockNews(String ticker) async {
    final response = await _dio.get(
      '$_baseUrl/news/stock',
      queryParameters: {'symbols': _sanitize(ticker), 'limit': _newsLimit},
    );
    return (response.data as List).map((e) => NewsDto.fromJson(e)).toList();
  }
}
