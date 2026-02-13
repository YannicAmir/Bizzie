import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/shared/utils/url_launcher_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('LaunchUrlUseCase');

@lazySingleton
class LaunchUrlUseCase implements UseCase<Either<Failure, void>, String> {
  LaunchUrlUseCase();

  @override
  Future<Either<Failure, void>> call(String url) async {
    _logger.info('Executing LaunchUrlUseCase: Requesting to launch URL: $url');

    if (url.isEmpty) {
      _logger.warning('LaunchUrlUseCase failed: URL is empty');
      return Left(Failure.server('URL cannot be empty'));
    }

    return _performLaunch(url);
  }

  Future<Either<Failure, void>> _performLaunch(String url) async {
    try {
      await UrlLauncherUtils.launch(url);
      _logger.info('Successfully launched URL');
      return const Right(null);
    } catch (e) {
      _logger.severe('Failed to launch URL: $url', e);
      return Left(
        Failure.server(
          'Could not launch the requested link. Please try again later.',
        ),
      );
    }
  }
}
