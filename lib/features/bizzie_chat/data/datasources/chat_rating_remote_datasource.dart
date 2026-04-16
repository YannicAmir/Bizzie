import 'package:injectable/injectable.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/utils/id_utils.dart';
import 'package:bizzie/features/bizzie_chat/data/dtos/chat_rating_dto.dart';
import 'package:bizzie/features/bizzie_chat/data/interfaces/i_chat_rating_remote_datasource.dart';
import 'package:bizzie/services/firestore_service.dart';

final _logger = BizzieLogger('ChatRatingRemoteDataSource');

const _kChatRatings = 'bizzie_chat_ratings';

@Injectable(as: IChatRatingRemoteDataSource)
class ChatRatingRemoteDataSource implements IChatRatingRemoteDataSource {
  final FirestoreService _firestoreService;

  ChatRatingRemoteDataSource(this._firestoreService);

  @override
  Future<void> submitRating(ChatRatingDto dto) async {
    try {
      _logger.info('submitRating: ${dto.rating}');
      await _firestoreService.setDocument(
        path: '$_kChatRatings/${IdUtils.generateSessionId()}',
        value: dto,
        toJson: (dto) => dto.toJson(),
        merge: false,
      );
    } catch (e, s) {
      _logger.severe('submitRating failed', e, s);
      rethrow;
    }
  }
}
