// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tsc_app/core/exceptions/app_exception.dart';
import 'package:tsc_app/core/usecase/use_case.dart';

import '../repository/base_auth_repo.dart';

@lazySingleton
class LoginUseCase extends UseCase<String, StreamController<String?>> {
  final BaseAuthRepository repo;
  LoginUseCase({required this.repo});

  @override
  Future<Either<CustomException, StreamController<String?>>> call(params) async {
    return repo.signInWithPhoneNumber(phoneNumber: params);
  }
}
