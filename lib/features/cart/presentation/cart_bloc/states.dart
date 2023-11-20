// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tsc_app/core/exceptions/app_exception.dart';

abstract class CartBlocStates {}

class InitialState extends CartBlocStates {}

class LoadingState extends CartBlocStates {}

class DoneState extends CartBlocStates {}

class FailedState extends CartBlocStates {
  final CustomException exception;
  FailedState({required this.exception});
}

// create Cart
class CreateCartLoadingState extends CartBlocStates {}

// add items states
class AddItemToCartLoadingState extends CartBlocStates {}

class AddItemToCartDoneState extends CartBlocStates {}

// get cart items states
class GetCartItemsLoadingState extends CartBlocStates {}

class GetCartItemsDoneState extends CartBlocStates {}
