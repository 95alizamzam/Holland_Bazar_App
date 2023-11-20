// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:tsc_app/core/exceptions/app_exception.dart';
import 'package:tsc_app/core/usecase/use_case.dart';

import '../repository/base_cart_repo.dart';

@lazySingleton
class ChangeItemQuantityUseCase extends UseCase<ChangeQuantityParams, Unit> {
  final BaseCartRepository repo;
  ChangeItemQuantityUseCase({required this.repo});
  @override
  Future<Either<CustomException, Unit>> call(params) async {
    return await repo.changeItemQuantity(
      cartId: params.userId,
      docId: params.docId,
      quantity: params.quantity,
    );
  }
}

class ChangeQuantityParams {
  final String userId;
  final String docId;
  final int quantity;
  ChangeQuantityParams({
    required this.userId,
    required this.docId,
    required this.quantity,
  });
}
