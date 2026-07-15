import 'package:bizzie/core/data/models/cache_result.dart' as result;
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/segments/data/dtos/revenue_segmentation_dto.dart';
import 'package:bizzie/features/company_profile/segments/data/interfaces/i_segments_firestore_datasource.dart';
import 'package:bizzie/features/company_profile/segments/data/interfaces/i_segments_remote_datasource.dart';
import 'package:bizzie/features/company_profile/segments/domain/enums/segment_period.dart';
import 'package:bizzie/features/company_profile/segments/domain/interfaces/i_segments_repository.dart';
import 'package:bizzie/features/company_profile/segments/domain/models/revenue_geographic_segments.dart';
import 'package:bizzie/features/company_profile/segments/domain/models/revenue_product_segments.dart';
import 'package:bizzie/features/company_profile/segments/domain/models/revenue_segment.dart';
import 'package:bizzie/features/company_profile/shared/domain/interfaces/i_exchange_rate_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('SegmentsRepositoryImpl');

typedef _SegmentationSync =
    Future<result.CacheResult<List<RevenueSegmentationDto>>> Function(
      SegmentPeriod period,
    );

class _SegmentationData {
  final List<RevenueSegment> annual;
  final List<RevenueSegment> quarterly;
  final String reportedCurrency;
  final CompanyProfileDataOrigin origin;

  const _SegmentationData({
    required this.annual,
    required this.quarterly,
    required this.reportedCurrency,
    required this.origin,
  });
}

@LazySingleton(as: ISegmentsRepository)
class SegmentsRepositoryImpl implements ISegmentsRepository {
  final ISegmentsRemoteDataSource _remoteDataSource;
  final ISegmentsFirestoreDataSource _localDataSource;
  final IExchangeRateRepository _exchangeRateRepository;

  SegmentsRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._exchangeRateRepository,
  );

  @override
  Future<Either<Failure, (RevenueProductSegments, CompanyProfileDataOrigin)>>
  getProductSegments(String ticker) async {
    try {
      final res = await _loadSegmentation(
        ticker,
        (period) => _localDataSource.syncProductSegmentation(
          ticker,
          period: period,
          remoteFetcher: () =>
              _remoteDataSource.getProductSegmentation(ticker, period: period),
        ),
      );

      return res.map(
        (data) => (
          RevenueProductSegments(
            symbol: ticker,
            reportedCurrency: data.reportedCurrency,
            annual: data.annual,
            quarterly: data.quarterly,
          ),
          data.origin,
        ),
      );
    } catch (e) {
      _logger.severe('Failed to load product segmentation for $ticker', e);
      return left(Failure.server(e.toString()));
    }
  }

  @override
  Future<
    Either<Failure, (RevenueGeographicSegments, CompanyProfileDataOrigin)>
  >
  getGeographicSegments(String ticker) async {
    try {
      final res = await _loadSegmentation(
        ticker,
        (period) => _localDataSource.syncGeographicSegmentation(
          ticker,
          period: period,
          remoteFetcher: () => _remoteDataSource.getGeographicSegmentation(
            ticker,
            period: period,
          ),
        ),
      );

      return res.map(
        (data) => (
          RevenueGeographicSegments(
            symbol: ticker,
            reportedCurrency: data.reportedCurrency,
            annual: data.annual,
            quarterly: data.quarterly,
          ),
          data.origin,
        ),
      );
    } catch (e) {
      _logger.severe('Failed to load geographic segmentation for $ticker', e);
      return left(Failure.server(e.toString()));
    }
  }

  Future<Either<Failure, _SegmentationData>> _loadSegmentation(
    String ticker,
    _SegmentationSync sync,
  ) async {
    final annualRes = await sync(SegmentPeriod.annual);
    if (annualRes is result.CacheFailure<List<RevenueSegmentationDto>>) {
      return left(annualRes.failure);
    }

    final quartRes = await sync(SegmentPeriod.quarter);
    if (quartRes is result.CacheFailure<List<RevenueSegmentationDto>>) {
      return left(quartRes.failure);
    }

    final (annualDtos, annualOrigin) = _dataOf(annualRes);
    final (quartDtos, quartOrigin) = _dataOf(quartRes);

    final conversionRes = await _exchangeRateRepository.getMultiplier(
      reportedCurrency:
          annualDtos.firstOrNull?.reportedCurrency ??
          quartDtos.firstOrNull?.reportedCurrency,
      ticker: ticker,
    );

    return conversionRes.fold((f) => left(f), (convData) {
      final (conversion, convOrigin) = convData;

      return right(
        _SegmentationData(
          annual: _toDomainList(annualDtos, conversion),
          quarterly: _toDomainList(quartDtos, conversion),
          reportedCurrency: conversion.targetCurrency,
          origin: _resolveOrigin([annualOrigin, quartOrigin, convOrigin]),
        ),
      );
    });
  }

  (List<RevenueSegmentationDto>, CompanyProfileDataOrigin) _dataOf(
    result.CacheResult<List<RevenueSegmentationDto>> res,
  ) {
    if (res is result.CacheSuccess<List<RevenueSegmentationDto>>) {
      return (res.data, res.origin);
    }
    return (const [], CompanyProfileDataOrigin.cache);
  }

  List<RevenueSegment> _toDomainList(
    List<RevenueSegmentationDto> dtos,
    ({double multiplier, String targetCurrency}) conversion,
  ) {
    final segments = dtos
        .where((d) => d.date?.isNotEmpty == true)
        .map(
          (d) => d.toDomain(
            multiplier: conversion.multiplier,
            targetCurrency: conversion.targetCurrency,
          ),
        )
        .toList();
    segments.sort((a, b) => b.date.compareTo(a.date));
    return segments;
  }

  CompanyProfileDataOrigin _resolveOrigin(
    List<CompanyProfileDataOrigin> origins,
  ) {
    if (origins.contains(CompanyProfileDataOrigin.api)) {
      return CompanyProfileDataOrigin.api;
    }
    if (origins.contains(CompanyProfileDataOrigin.db)) {
      return CompanyProfileDataOrigin.db;
    }
    return CompanyProfileDataOrigin.cache;
  }
}
