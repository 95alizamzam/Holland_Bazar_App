import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tsc_app/core/exceptions/app_exception.dart';

abstract class BaseAuthRepository {
  Future<Either<CustomException, StreamController<String?>>>
      signInWithPhoneNumber({
    required String phoneNumber,
  });

  Future<Either<CustomException, User?>> verifyOtp({required String otp});
}
