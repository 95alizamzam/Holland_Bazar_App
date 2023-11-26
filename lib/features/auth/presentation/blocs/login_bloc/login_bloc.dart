import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tsc_app/core/exceptions/app_exception.dart';

import '../../../domain/usecases/login_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  final LoginUseCase loginUseCase;
  StreamSubscription<String?>? streamSubscription;
  LoginBloc({
    required this.loginUseCase,
  }) : super(LoginInitail()) {
    on<LoginEvent>((event, emit) async {
      emit(LoginLoading());
      final response = await loginUseCase(event.phoneNumber);
      response.fold(
        (l) => emit(LoginFailed(errorMsg: l.message)),
        (r) {
          try {
            streamSubscription = r.stream.listen(
              (event) {
                if (event == null) {
                  add(UpdateUiSuccess());
                } else {
                  add(UpdateUiFailed(
                      exception: CustomException(message: event)));
                }
              },
              cancelOnError: false,
              onError: (e, s) {
                emit(LoginFailed(
                    errorMsg: "Something went wrong ,Please try again"));
              },
              onDone: () async {
                await r.close();
              },
            );
          } catch (e) {
            emit(
              LoginFailed(errorMsg: "Something went wrong ,Please try again"),
            );
          }
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
