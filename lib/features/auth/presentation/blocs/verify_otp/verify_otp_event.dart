// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';

abstract class VerifyOtpEvents {}

class VerifyOtpEvent extends VerifyOtpEvents {
  final String otp;
  VerifyOtpEvent({required this.otp});
}

class UpdateUi extends VerifyOtpEvents {
  final User user;
  UpdateUi({required this.user});
}
