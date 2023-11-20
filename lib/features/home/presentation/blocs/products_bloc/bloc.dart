import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tsc_app/core/usecase/use_case.dart';

import 'package:tsc_app/features/home/presentation/blocs/products_bloc/events.dart';
import 'package:tsc_app/features/home/presentation/blocs/products_bloc/states.dart';

import '../../../domain/entities/product.dart';
import '../../../domain/usecases/get_home_product.dart';

@injectable
class ProductsBloc extends Bloc<ProductsEvents, ProductsStates> {
  final GetHomeProductsUseCase getHomeProductsUseCase;

  List<Product> products = [];

  ProductsBloc({
    required this.getHomeProductsUseCase,
  }) : super(ProductsInitialState()) {
    on<GetHomeProductsEvent>((event, emit) async {
      emit(ProductsLoadingState());
      final response = await getHomeProductsUseCase(NoParams());
      response.fold(
        (l) => emit(ProductsFailedState(exception: l)),
        (r) {
          products = r;
          emit(ProductsDoneState());
        },
      );
    });
  }
}
