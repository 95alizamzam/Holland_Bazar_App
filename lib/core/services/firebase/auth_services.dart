import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:tsc_app/core/di/setup.dart';
import 'package:tsc_app/core/exceptions/app_exception.dart';
import 'package:tsc_app/core/services/hive_config.dart';

@lazySingleton
class FirebaseAuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseAuth get auth => _auth;
  final hiveHelper = getIt<HiveConfig>();

  Future<void> signInWithPhoneNumber({
    required String phoneNumber,
    required VoidCallback onCodeSent,
    required Function(FirebaseAuthException) onVerificationFailed,
    required Function(String) onCodeAutoRetrievalTimeout,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: formatNumber(phoneNumber),
      verificationCompleted: (PhoneAuthCredential credential) async {
        // work only for android decices - devices which support automatic SMS code resolution.
      },
      codeSent: (String verificationId, int? resendToken) async {
        await hiveHelper.storeData(
          key: HiveKeys.authVerificationId,
          value: verificationId,
        );
        onCodeSent();
      },
      verificationFailed: (FirebaseAuthException e) async {
        onVerificationFailed(e);
      },
      codeAutoRetrievalTimeout: (String verificationId) async {
        onCodeAutoRetrievalTimeout("Time Out to get SMS Verification Code");
      },
    );
  }

  Future<User?> verifyOtp(String otp) async {
    try {
      final verificationId =
          hiveHelper.getData(key: HiveKeys.authVerificationId);

      final UserCredential credential = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: otp,
        ),
      );

      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message!);
    }
  }

  String formatNumber(String phoneNumber) {
    return "+964${phoneNumber.startsWith("0") ? phoneNumber.substring(1) : phoneNumber}";
  }
}
