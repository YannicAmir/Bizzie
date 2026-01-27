import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/shared/data/datasources/company_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/shared/data/datasources/company_remote_data_source.dart';
import 'package:bizzie/features/company_profile/shared/data/dtos/company_profile_dto.dart';
import 'package:bizzie/features/company_profile/shared/data/dtos/quote_dto.dart';
import 'package:bizzie/features/company_profile/shared/domain/interfaces/i_company_repository.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/company_profile.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/stock_quote.dart';

@LazySingleton(as: ICompanyRepository)
class CompanyRepositoryImpl implements ICompanyRepository {
  final CompanyRemoteDataSource _remoteDataSource;
  final CompanyFirestoreDataSource _localDataSource;

  CompanyRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, CompanyProfile>> getProfile(String ticker) async {
    try {
      final local = await _localDataSource.getCachedProfile(ticker);
      if (local != null) return right(_toCompanyProfile(local));

      final remote = await _remoteDataSource.getProfile(ticker);
      if (remote.isEmpty) {
        return left(const ServerFailure('Profile not found'));
      }
      final profile = remote.first;
      await _localDataSource.cacheProfile(ticker, profile);
      return right(_toCompanyProfile(profile));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, StockQuote>> getQuote(String ticker) async {
    try {
      final local = await _localDataSource.getCachedQuote(ticker);
      if (local != null) return right(_toStockQuote(local));

      final remote = await _remoteDataSource.getQuote(ticker);
      if (remote.isEmpty) {
        return left(const ServerFailure('Quote not found'));
      }
      final quote = remote.first;
      await _localDataSource.cacheQuote(ticker, quote);
      return right(_toStockQuote(quote));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  CompanyProfile _toCompanyProfile(ProfileDto dto) {
    return CompanyProfile(
      symbol: dto.symbol ?? '',
      price: dto.price,
      changesPercentage: dto.changesPercentage,
      change: dto.change,
      marketCap: dto.marketCap,
      beta: dto.beta,
      description: dto.description,
      sector: dto.sector,
      industry: dto.industry,
      exchange: dto.exchange,
      exchangeShortName: dto.exchangeShortName,
      currency: dto.currency,
      isEtf: dto.isEtf,
      isFund: dto.isFund,
      isActivelyTrading: dto.isActivelyTrading,
      companyName: dto.companyName,
      image: dto.image,
      ceo: dto.ceo,
      website: dto.website,
      address: dto.address,
      city: dto.city,
      state: dto.state,
      zip: dto.zip,
      phone: dto.phone,
      fullTimeEmployees: dto.fullTimeEmployees,
      ipoDate: dto.ipoDate,
      country: dto.country,
    );
  }

  StockQuote _toStockQuote(QuoteDto dto) {
    return StockQuote(
      symbol: dto.symbol,
      name: dto.name,
      price: dto.price,
      change: dto.change,
      changesPercentage: dto.changesPercentage,
      marketCap: dto.marketCap,
      pe: dto.pe,
      eps: dto.eps,
      volume: dto.volume,
      sharesOutstanding: dto.sharesOutstanding,
    );
  }
}
