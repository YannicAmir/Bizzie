import 'package:bizzie/core/constants/firestore_constants.dart';
import 'package:bizzie/core/error/exceptions.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/security/data/dtos/security_quote_dto.dart';
import 'package:bizzie/features/company_profile/security/data/interfaces/i_security_quote_remote_datasource.dart';
import 'package:bizzie/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('SecurityQuoteRemoteDataSource');

@Injectable(as: ISecurityQuoteRemoteDataSource)
class SecurityQuoteRemoteDataSource implements ISecurityQuoteRemoteDataSource {
  final FirestoreService _firestoreService;

  SecurityQuoteRemoteDataSource(this._firestoreService);

  @override
  Stream<SecurityQuoteDto?> getSecurityQuoteStream(String ticker) {
    _logger.info('Requesting security quote stream for $ticker');

    return _firestoreService
        .getDocumentStream<SecurityQuoteDto>(
          path: '${FirestoreConstants.stockPrices}/$ticker',
          fromJson: SecurityQuoteDto.fromJson,
          toJson: (dto) => dto.toJson(),
        )
        .handleError((Object e, StackTrace s) {
          if (e is FirebaseException && e.code == 'permission-denied') {
            _logger.warning(
              'Security quote stream permission denied for $ticker (expected on logout)',
            );
            Error.throwWithStackTrace(PermissionDeniedException(), s);
          }
          _logger.severe('Error in security quote stream for $ticker', e, s);
          Error.throwWithStackTrace(e, s);
        });
  }
}
