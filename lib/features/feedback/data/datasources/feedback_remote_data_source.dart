import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/feedback/data/dtos/feedback_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('FeedbackRemoteDataSource');

abstract class IFeedbackRemoteDataSource {
  Future<void> submitFeedback(FeedbackDto feedback);
}

@LazySingleton(as: IFeedbackRemoteDataSource)
class FeedbackRemoteDataSource implements IFeedbackRemoteDataSource {
  final FirebaseFirestore _firestore;

  FeedbackRemoteDataSource(this._firestore);

  @override
  Future<void> submitFeedback(FeedbackDto feedback) async {
    try {
      final data = feedback.toJson();
      data['timestamp'] = FieldValue.serverTimestamp();

      await _firestore.collection('feedback').add(data);
      _logger.info(
        'Feedback submitted successfully for user: ${feedback.userId}',
      );
    } catch (e, stack) {
      _logger.severe('Error writing feedback to Firestore', e, stack);
      rethrow;
    }
  }
}
