// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tsc_app/core/exceptions/app_exception.dart';

abstract class LoginEvents {}

class LoginEvent extends LoginEvents {
  final String phoneNumber;
  LoginEvent({required this.phoneNumber});
}

class UpdateUiSuccess extends LoginEvents {}

class UpdateUiFailed extends LoginEvents {
  final CustomException exception;
  UpdateUiFailed({required this.exception});
}
