// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tsc_app/core/exceptions/app_exception.dart';

abstract class LoginStates {}

class LoginInitail extends LoginStates {}

class LoginLoading extends LoginStates {}

class LoginDone extends LoginStates {}

class LoginFailed extends LoginStates {
  final CustomException exception;
  LoginFailed({required this.exception});
}
