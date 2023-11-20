import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:tsc_app/core/exceptions/app_exception.dart';

import 'package:tsc_app/features/auth/domain/repository/base_auth_repo.dart';

import '../data_source/remote.dart';

@LazySingleton(as: BaseAuthRepository)
class AuthRepoImpl extends BaseAuthRepository {
  final AuthRemoteDataSource remote;
  AuthRepoImpl({required this.remote});
  @override
  Future<Either<CustomException, StreamController<String?>>>
      signInWithPhoneNumber({
    required String phoneNumber,
  }) async {
    try {
      final result =
          await remote.signInWithPhoneNumber(phoneNumber: phoneNumber);
      return right(result);
    } on CustomException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<CustomException, User?>> verifyOtp(
      {required String otp}) async {
    try {
      final result = await remote.verifyOtp(otp: otp);
      return right(result);
    } on CustomException catch (e) {
      return left(e);
    }
  }
}
