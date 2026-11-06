import 'package:bizzie/core/domain/interfaces/i_company_filings_repository.dart';
import 'package:bizzie/core/domain/models/company_filings.dart';
import 'package:bizzie/core/error/exceptions.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/reports/data/dtos/financial_report_dto.dart';
import 'package:bizzie/features/reports/data/dtos/sec_filing_dto.dart';
import 'package:bizzie/features/reports/data/interfaces/i_reports_remote_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

final _logger = BizzieLogger('CompanyFilingsRepositoryImpl');

@LazySingleton(as: ICompanyFilingsRepository)
class CompanyFilingsRepositoryImpl implements ICompanyFilingsRepository {
  final IReportsRemoteDataSource _remoteDataSource;

  CompanyFilingsRepositoryImpl(this._remoteDataSource);

  @override
  Stream<Either<Failure, CompanyFilings>> getCompanyFilings(String ticker) {
    _logger.info('Requesting company filings for $ticker');
    return Rx.combineLatest2<
          List<FinancialReportDto>,
          List<SecFilingDto>,
          Either<Failure, CompanyFilings>
        >(
          _remoteDataSource.getFinancialReportsStream([ticker]),
          _remoteDataSource.getSecFilingsStream([ticker]),
          (reports, filings) => Right(
            CompanyFilings(
              reports: reports.map((dto) => dto.toDomain()).toList(),
              filings: filings.map((dto) => dto.toDomain()).toList(),
            ),
          ),
        )
        .onErrorReturnWith((error, stackTrace) {
          if (error is ServerException) {
            return Left(Failure.server(error.message));
          }
          _logger.severe(
            'Unexpected error fetching company filings for $ticker',
            error,
            stackTrace,
          );
          return Left(Failure.server('Unexpected error: $error'));
        });
  }
}
