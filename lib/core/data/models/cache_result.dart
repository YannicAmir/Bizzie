import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';

sealed class CacheResult<T> {
  const CacheResult();

  bool get isSuccess => this is CacheSuccess<T>;
  bool get isFailure => this is CacheFailure<T>;
  bool get isNotFound => this is CacheNotFound<T>;

  R map<R>({
    required R Function(CacheSuccess<T>) success,
    required R Function(CacheFailure<T>) failure,
    required R Function(CacheNotFound<T>) notFound,
  }) {
    if (this is CacheSuccess<T>) {
      return success(this as CacheSuccess<T>);
    }
    if (this is CacheFailure<T>) {
      return failure(this as CacheFailure<T>);
    }
    if (this is CacheNotFound<T>) {
      return notFound(this as CacheNotFound<T>);
    }
    throw Exception('Unknown CacheResult type: $runtimeType');
  }

  R maybeMap<R>({
    R Function(CacheSuccess<T>)? success,
    R Function(CacheFailure<T>)? failure,
    R Function(CacheNotFound<T>)? notFound,
    required R Function() orElse,
  }) {
    if (this is CacheSuccess<T> && success != null) {
      return success(this as CacheSuccess<T>);
    }
    if (this is CacheFailure<T> && failure != null) {
      return failure(this as CacheFailure<T>);
    }
    if (this is CacheNotFound<T> && notFound != null) {
      return notFound(this as CacheNotFound<T>);
    }
    return orElse();
  }
}

class CacheSuccess<T> extends CacheResult<T> {
  final T data;
  final CompanyProfileDataOrigin origin;

  const CacheSuccess(this.data, this.origin);
}

class CacheFailure<T> extends CacheResult<T> {
  final Failure failure;

  const CacheFailure(this.failure);
}

class CacheNotFound<T> extends CacheResult<T> {
  const CacheNotFound();
}
