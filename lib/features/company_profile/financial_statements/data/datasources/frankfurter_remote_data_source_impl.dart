import 'package:bizzie/core/utils/retry_util.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/i_exchange_rate_remote_data_source.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/frankfurter_response_dto.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IExchangeRateRemoteDataSource)
class FrankfurterRemoteDataSourceImpl implements IExchangeRateRemoteDataSource {
  final Dio _frankfurterDio;

  FrankfurterRemoteDataSourceImpl(
    @Named('FrankfurterDio') this._frankfurterDio,
  );

  @override
  Future<List<FrankfurterResponseDto>> getExchangeRate({
    required String base,
    required String target,
    required String date,
  }) async {
    return RetryUtil.retry<List<FrankfurterResponseDto>>(
      task: () async {
        final response = await _frankfurterDio.get<List<dynamic>>(
          '/rates',
          queryParameters: {'date': date, 'base': base, 'quotes': target},
        );
        return response.data!
            .map(
              (json) =>
                  FrankfurterResponseDto.fromJson(json as Map<String, dynamic>),
            )
            .toList();
      },
      maxRetries: 3,
      initialDelay: const Duration(seconds: 1),
      maxDelay: const Duration(seconds: 5),
    );
  }
}
