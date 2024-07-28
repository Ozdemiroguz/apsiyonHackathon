import 'package:fpdart/fpdart.dart';

import '../failure/failure.dart';

abstract interface class UseCase<T, K> {
  Future<Either<Failure, T>> call(K params);
}
