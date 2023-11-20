// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:tsc_app/core/exceptions/app_exception.dart';
import 'package:tsc_app/core/usecase/use_case.dart';

import '../repository/base_cart_repo.dart';

@lazySingleton
class RemoveItemFromCartUseCase extends UseCase<RemoveItemToCartParams, Unit> {
  final BaseCartRepository repo;
  RemoveItemFromCartUseCase({required this.repo});
  @override
  Future<Either<CustomException, Unit>> call(params) async {
    return await repo.removeItemFromCard(
      cartId: params.cartId,
      docId: params.docId,
    );
  }
}

class RemoveItemToCartParams {
  final String cartId;
  final String docId;
  RemoveItemToCartParams({required this.cartId, required this.docId});
}
