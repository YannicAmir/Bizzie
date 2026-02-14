import 'package:bizzie/core/error/exceptions.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/feedback/data/datasources/feedback_remote_data_source.dart';
import 'package:bizzie/features/feedback/data/dtos/feedback_dto.dart';
import 'package:bizzie/features/feedback/domain/interfaces/i_feedback_repository.dart';
import 'package:bizzie/features/feedback/domain/models/feedback_model.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IFeedbackRepository)
class FeedbackRepositoryImpl implements IFeedbackRepository {
  final IFeedbackRemoteDataSource _remoteDataSource;

  FeedbackRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, void>> submitFeedback(FeedbackModel feedback) async {
    try {
      final dto = FeedbackDto.fromDomain(feedback);
      await _remoteDataSource.submitFeedback(dto);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(Failure.server(e.message));
    } catch (e) {
      return const Left(Failure.server('An unexpected error occurred'));
    }
  }
}
