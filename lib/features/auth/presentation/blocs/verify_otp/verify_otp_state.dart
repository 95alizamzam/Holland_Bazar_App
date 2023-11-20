// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tsc_app/core/exceptions/app_exception.dart';

abstract class VerifyOtpStates {}

class InitialState extends VerifyOtpStates {}

class VerifyLoading extends VerifyOtpStates {}

class VerifyDone extends VerifyOtpStates {}

class VerifyFailed extends VerifyOtpStates {
  final CustomException exception;
  VerifyFailed({required this.exception});
}
