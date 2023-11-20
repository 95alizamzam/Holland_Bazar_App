import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
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
    required Function() onVerificationCompleted,
    required Function(FirebaseAuthException) onVerificationFailed,
    required Function(String) onCodeAutoRetrievalTimeout,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: formatNumber(phoneNumber),
      verificationCompleted: (PhoneAuthCredential credential) async {
        /*
           When the SMS code is delivered to the device, only for android devices
           android devices can automatically verify sms code and provide credential
        */
        await hiveHelper.storeData(
            key: HiveKeys.authSmsCode, value: credential.smsCode);
        onVerificationCompleted();
      },
      codeSent: (String verificationId, int? resendToken) async {
        // code sent to user device , redirect user to otp page
        // after go to otp page we can use verificationId and smscode to create credential and
        // use it for signIn process
        // we can save this id in storage - like HIVE
        await hiveHelper.storeData(
            key: HiveKeys.authVerificationId, value: verificationId);
      },
      verificationFailed: (FirebaseAuthException e) async {
        await hiveHelper.storeData(
            key: HiveKeys.authErrorMessage, value: e.message);

        onVerificationFailed(e);
      },
      codeAutoRetrievalTimeout: (String verificationId) async {
        await hiveHelper.storeData(
          key: HiveKeys.authErrorMessage,
          value: "Time Out to get sms Verification Code",
        );
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
