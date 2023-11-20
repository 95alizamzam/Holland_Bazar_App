import 'package:dartz/dartz.dart';
import 'package:tsc_app/core/exceptions/app_exception.dart';

abstract class UseCase<Params, Data> {
  Future<Either<CustomException, Data>> call(Params params);
}

class NoParams {}
