// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:tsc_app/core/exceptions/app_exception.dart';
import 'package:tsc_app/core/usecase/use_case.dart';

import '../entities/product.dart';
import '../repository/base_home_repo.dart';

@lazySingleton
class GetHomeProductsUseCase extends UseCase<NoParams, List<Product>> {
  final BaseHomeRepo repo;
  GetHomeProductsUseCase({required this.repo});
  @override
  Future<Either<CustomException, List<Product>>> call(params) async {
    return await repo.getProducts();
  }
}
