import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tsc_app/core/di/setup.dart';
import 'package:tsc_app/core/services/hive_config.dart';
import 'package:tsc_app/features/cart/domain/entities/cart_item.dart';
import 'package:tsc_app/features/cart/domain/usecases/add_item_to_cart.dart';
import 'package:tsc_app/features/cart/domain/usecases/create_user_cart.dart';
import 'package:tsc_app/features/cart/domain/usecases/get_user_cart_items.dart';
import 'package:tsc_app/features/cart/domain/usecases/remove_item_from_cart.dart';
import 'package:tsc_app/features/cart/presentation/cart_bloc/events.dart';
import 'package:tsc_app/features/cart/presentation/cart_bloc/states.dart';

import '../../domain/usecases/change_item_quantity.dart';
import '../../domain/usecases/check_exsist_cart.dart';

@injectable
class CartBloc extends Bloc<CartBlocEvents, CartBlocStates> {
  final CheckExsistCartUseCase checkExsistCartUseCase;
  final CreateUserCartUseCase createUserCartUseCase;
  final GetUserCartItemsUseCase getUserCartItemsUseCase;
  final AddItemToCartUseCase addItemToCartUseCase;
  final ChangeItemQuantityUseCase changeItemQuantityUseCase;
  final RemoveItemFromCartUseCase removeItemFromCartUseCase;

  List<CartItem> items = [];
  bool isCartExist = false;
  final userId = getIt<HiveConfig>().getData(key: HiveKeys.userId);
  CartBloc({
    required this.checkExsistCartUseCase,
    required this.createUserCartUseCase,
    required this.getUserCartItemsUseCase,
    required this.addItemToCartUseCase,
    required this.changeItemQuantityUseCase,
    required this.removeItemFromCartUseCase,
  }) : super(InitialState()) {
    on<CheckExistCartEvent>((event, emit) async {
      emit(LoadingState());
      final response = await checkExsistCartUseCase(userId);
      response.fold(
        (l) => emit(FailedState(exception: l)),
        (r) {
          if (r) {
            isCartExist = true;
            add(GetCartItemsEvent(userId: userId));
          } else {
            isCartExist = false;
            emit(DoneState());
          }
        },
      );
    });

    on<CreateCartEvent>((event, emit) async {
      emit(CreateCartLoadingState());
      final response = await createUserCartUseCase(userId);
      response.fold(
        (l) {
          isCartExist = false;
          emit(FailedState(exception: l));
        },
        (r) {
          isCartExist = true;
          add(GetCartItemsEvent(userId: userId));
        },
      );
    });

    on<GetCartItemsEvent>((event, emit) async {
      emit(GetCartItemsLoadingState());
      final respnse = await getUserCartItemsUseCase(userId);
      respnse.fold(
        (l) {
          items.clear();
          emit(FailedState(exception: l));
        },
        (r) {
          items = r;
          emit(GetCartItemsDoneState());
        },
      );
    });

    on<AddItemToCart>((event, emit) async {
      emit(AddItemToCartLoadingState());

      final AddItemToCartParams params = AddItemToCartParams(
        cartId: userId,
        item: event.item,
      );

      final response = await addItemToCartUseCase(params);
      response.fold(
        (l) => emit(FailedState(exception: l)),
        (r) => emit(AddItemToCartDoneState()),
      );
    });

    on<ChangeItemQuantity>((event, emit) async {
      final ChangeQuantityParams params = ChangeQuantityParams(
        userId: userId,
        docId: event.documentId,
        quantity: event.quantity,
      );
      final response = await changeItemQuantityUseCase(params);

      response.fold(
        (l) {
          emit(FailedState(exception: l));
        },
        (r) => emit(DoneState()),
      );
    });

    on<RemoveItemFromCart>((event, emit) async {
      final RemoveItemToCartParams params = RemoveItemToCartParams(
        cartId: userId,
        docId: event.docId,
      );
      final response = await removeItemFromCartUseCase(params);
      response.fold(
        (l) {
          emit(FailedState(exception: l));
        },
        (r) {
          items.removeWhere((element) => element.id == event.itemId);
          emit(DoneState());
        },
      );
    });
  }
}
