import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tsc_app/core/usecase/use_case.dart';

import 'package:tsc_app/features/home/domain/usecases/get_categories.dart';

import 'package:tsc_app/features/home/presentation/blocs/categories_bloc/states.dart';

import '../../../domain/entities/category.dart';
import 'events.dart';

@injectable
class CategoriesBloc extends Bloc<CategoriesEvents, CategoriessStates> {
  final GetHomeCategoriesUseCase getHomeCategoriesUseCase;
  List<Category> categories = [];

  CategoriesBloc({
    required this.getHomeCategoriesUseCase,
  }) : super(CategoriesInitialState()) {
    on<GetHomeCategoriesEvent>((event, emit) async {
      emit(CategoriesLoadingState());
      final response = await getHomeCategoriesUseCase(NoParams());
      response.fold(
        (l) => emit(CategoriesFailedState(exception: l)),
        (r) {
          categories = r;
          emit(CategoriesDoneState());
        },
      );
    });
  }
}
