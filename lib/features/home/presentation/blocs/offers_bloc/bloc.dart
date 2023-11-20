import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tsc_app/core/usecase/use_case.dart';
import 'package:tsc_app/features/home/domain/entities/offer.dart';
import 'package:tsc_app/features/home/domain/usecases/get_home_offers.dart';
import 'package:tsc_app/features/home/presentation/blocs/offers_bloc/states.dart';

import 'events.dart';

@injectable
class OffersBloc extends Bloc<OffersEvents, OffersStates> {
  final GetHomeOffersUseCase getHomeOffersUseCase;
  List<Offer> offers = [];

  OffersBloc({
    required this.getHomeOffersUseCase,
  }) : super(OffersInitialState()) {
    on<GetHomeOffersEvent>((event, emit) async {
      emit(OffersLoadingState());
      final response = await getHomeOffersUseCase(NoParams());
      response.fold(
        (l) => emit(OffersFailedState(exception: l)),
        (r) {
          offers = r;
          emit(OffersDoneState());
        },
      );
    });
  }
}
