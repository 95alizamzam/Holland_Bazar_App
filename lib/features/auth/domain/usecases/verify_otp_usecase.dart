// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:tsc_app/core/exceptions/app_exception.dart';
import 'package:tsc_app/core/usecase/use_case.dart';

import '../repository/base_auth_repo.dart';

@lazySingleton
class VerifyOtpUseCase extends UseCase<String, User?> {
  final BaseAuthRepository repo;
  VerifyOtpUseCase({required this.repo});

  @override
  Future<Either<CustomException, User?>> call(params) async {
    return repo.verifyOtp(otp: params);
  }
}
