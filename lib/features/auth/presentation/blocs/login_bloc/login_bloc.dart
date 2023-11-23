import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:tsc_app/core/exceptions/app_exception.dart';

import '../../../domain/usecases/login_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  final LoginUseCase loginUseCase;

  LoginBloc({
    required this.loginUseCase,
  }) : super(LoginInitail()) {
    on<LoginEvent>((event, emit) async {
      emit(LoginLoading());
      final response = await loginUseCase(event.phoneNumber);
      response.fold(
        (l) => emit(LoginFailed(errorMsg: l.message)),
        (r) {
          r.stream.listen((event) {
            if (event == null) {
              add(UpdateUiSuccess());
            } else {
              debugPrint("-----------------------------\n");
              debugPrint("The Error Message ---> $event");
              debugPrint("-----------------------------\n");
              add(UpdateUiFailed(exception: CustomException(message: event)));
            }
          });
        },
      );
    });

    on<UpdateUiSuccess>((event, emit) {
      emit(LoginDone());
    });

    on<UpdateUiFailed>((event, emit) {
      emit(LoginFailed(errorMsg: event.exception.message));
    });
  }
}
