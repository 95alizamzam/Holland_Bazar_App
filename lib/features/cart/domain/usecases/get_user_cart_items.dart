// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:tsc_app/core/exceptions/app_exception.dart';
import 'package:tsc_app/core/usecase/use_case.dart';
import 'package:tsc_app/features/cart/domain/entities/cart_item.dart';

import '../repository/base_cart_repo.dart';

@lazySingleton
class GetUserCartItemsUseCase extends UseCase<String, List<CartItem>> {
  final BaseCartRepository repo;
  GetUserCartItemsUseCase({required this.repo});
  @override
  Future<Either<CustomException, List<CartItem>>> call(params) async {
    return await repo.getUserCartItems(cartId: params);
  }
}
