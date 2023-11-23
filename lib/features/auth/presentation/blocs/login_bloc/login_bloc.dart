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
        (l) => emit(LoginFailed(exception: l)),
        (r) {
          r.stream.listen(
            (error) {
              if (error == null) {
                add(UpdateUiSuccess());
              } else {
                debugPrint("-----------------------------\n");
                debugPrint("The Error Message ---> $error");
                debugPrint("-----------------------------\n");

                add(UpdateUiFailed(exception: CustomException(message: error)));
              }
            },
            cancelOnError: true,
            onError: (e, s) => add(UpdateUiFailed(
                exception: CustomException(message: e.toString()))),
            onDone: () => add(UpdateUiSuccess()),
          );
        },
      );
    });

    on<UpdateUiSuccess>((event, emit) {
      emit(LoginDone());
    });

    on<UpdateUiFailed>((event, emit) {
      emit(LoginFailed(exception: event.exception));
    });
  }
}
