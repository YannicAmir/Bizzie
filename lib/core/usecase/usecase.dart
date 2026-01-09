abstract class UseCase<Result, Params> {
  Future<Result> call(Params params);
}

class NoParams {}

abstract class StreamUseCase<Result, Params> {
  Stream<Result> call(Params params);
}

abstract class SynchronousUseCase<Result, Params> {
  Result call(Params params);
}
