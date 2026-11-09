import 'dart:async';

import 'package:bizzie/core/error/exceptions.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/security/data/dtos/security_quote_dto.dart';
import 'package:bizzie/features/company_profile/security/data/interfaces/i_security_quote_remote_datasource.dart';
import 'package:bizzie/features/company_profile/security/domain/interfaces/i_security_quote_repository.dart';
import 'package:bizzie/features/company_profile/security/domain/models/security_quote.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('SecurityQuoteRepositoryImpl');

@LazySingleton(as: ISecurityQuoteRepository)
class SecurityQuoteRepositoryImpl implements ISecurityQuoteRepository {
  final ISecurityQuoteRemoteDataSource _remoteDataSource;

  SecurityQuoteRepositoryImpl(this._remoteDataSource);

  @override
  Stream<Either<Failure, SecurityQuote?>> watchSecurityQuote(String ticker) {
    return _remoteDataSource
        .getSecurityQuoteStream(ticker)
        .transform(
          StreamTransformer<
            SecurityQuoteDto?,
            Either<Failure, SecurityQuote?>
          >.fromHandlers(
            handleData: (dto, sink) {
              try {
                sink.add(Right(dto?.toDomain()));
              } catch (e, stack) {
                _logger.severe('Failed to map security quote stream', e, stack);
                sink.add(Left(Failure.server(e.toString())));
              }
            },
            handleError: (error, stack, sink) {
              sink.add(
                Left(
                  error is PermissionDeniedException
                      ? const Failure.permission()
                      : Failure.server(error.toString()),
                ),
              );
            },
          ),
        );
  }
}
