import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:tsc_app/core/di/setup.dart';
import 'package:tsc_app/core/services/firebase/auth_services.dart';

abstract class AuthRemoteDataSource {
  Future<StreamController<String?>> signInWithPhoneNumber({
    required String phoneNumber,
  });
  Future<User?> verifyOtp({required String otp});
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final authService = getIt<FirebaseAuthServices>();

  @override
  Future<StreamController<String?>> signInWithPhoneNumber({
    required String phoneNumber,
  }) async {
    StreamController<String?> sc = StreamController<String?>();

    await authService.signInWithPhoneNumber(
      phoneNumber: phoneNumber,
      onVerificationCompleted: () => sc.sink.add(null),
      onCodeAutoRetrievalTimeout: (p0) => sc.sink.add(p0),
      onVerificationFailed: (p0) => sc.sink.add(p0.message),
    );
    sc.sink.add(null);

    return sc;
  }

  @override
  Future<User?> verifyOtp({required String otp}) async {
    return await authService.verifyOtp(otp);
  }
}
