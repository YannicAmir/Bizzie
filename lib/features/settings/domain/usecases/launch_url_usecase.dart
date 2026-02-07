import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/shared/utils/url_launcher_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LaunchUrlUseCase implements UseCase<Either<Failure, void>, String> {
  LaunchUrlUseCase();

  @override
  Future<Either<Failure, void>> call(String url) async {
    try {
      await UrlLauncherUtils.launch(url);
      return const Right(null);
    } catch (e) {
      return Left(Failure.server(e.toString()));
    }
  }
}
