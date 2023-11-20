// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:tsc_app/core/exceptions/app_exception.dart';
import 'package:tsc_app/core/usecase/use_case.dart';

import '../repository/base_cart_repo.dart';

@lazySingleton
class CheckExsistCartUseCase extends UseCase<String, bool> {
  final BaseCartRepository repo;
  CheckExsistCartUseCase({required this.repo});
  @override
  Future<Either<CustomException, bool>> call(params) async {
    return await repo.checkUserCartExist(userId: params);
  }
}
