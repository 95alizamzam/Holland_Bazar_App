import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:tsc_app/core/di/setup.dart';
import 'package:tsc_app/core/exceptions/app_exception.dart';
import 'package:tsc_app/core/services/hive_config.dart';
import 'package:tsc_app/features/auth/data/models/user_model.dart';
import 'package:tsc_app/features/auth/presentation/blocs/verify_otp/verify_otp_event.dart';
import 'package:tsc_app/features/auth/presentation/blocs/verify_otp/verify_otp_state.dart';

import '../../../domain/usecases/verify_otp_usecase.dart';

@injectable
class VerifyOtpBloc extends Bloc<VerifyOtpEvents, VerifyOtpStates> {
  final VerifyOtpUseCase verifyOtpUseCase;

  VerifyOtpBloc({
    required this.verifyOtpUseCase,
  }) : super(InitialState()) {
    on<VerifyOtpEvent>((event, emit) async {
      emit(VerifyLoading());
      final response = await verifyOtpUseCase(event.otp);
      response.fold(
        (l) => emit(VerifyFailed(exception: l)),
        (user) {
          if (user != null) {
            add(UpdateUi(user: user));
          } else {
            emit(
              VerifyFailed(
                exception: CustomException(message: "Something went wrong"),
              ),
            );
          }
        },
      );
    });

    on<UpdateUi>((event, emit) async {
      await saveUserData(event.user);
      emit(VerifyDone());
    });
  }

  Future<void> saveUserData(User user) async {
    final hiveHelper = getIt<HiveConfig>();
    final UserDataModel model = UserDataModel(
      userId: user.uid,
      displayName: user.displayName,
      phoneNumber: user.phoneNumber,
      refreshToken: user.refreshToken,
    );
    hiveHelper.storeData(key: HiveKeys.userData, value: model);
  }
}
