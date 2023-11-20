// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:tsc_app/core/exceptions/app_exception.dart';
import 'package:tsc_app/core/usecase/use_case.dart';
import 'package:tsc_app/features/home/domain/entities/offer.dart';

import '../repository/base_home_repo.dart';

@lazySingleton
class GetHomeOffersUseCase extends UseCase<NoParams, List<Offer>> {
  final BaseHomeRepo repo;
  GetHomeOffersUseCase({required this.repo});
  @override
  Future<Either<CustomException, List<Offer>>> call(params) async {
    return await repo.getOffers();
  }
}
