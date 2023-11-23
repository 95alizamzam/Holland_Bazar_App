// ignore_for_file: public_member_api_docs, sort_constructors_first

abstract class LoginStates {}

class LoginInitail extends LoginStates {}

class LoginLoading extends LoginStates {}

class LoginDone extends LoginStates {}

class LoginFailed extends LoginStates {
  final String errorMsg;
  LoginFailed({required this.errorMsg});
}
