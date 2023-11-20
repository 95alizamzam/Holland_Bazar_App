// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tsc_app/core/exceptions/app_exception.dart';

abstract class ProductsStates {}

class ProductsInitialState extends ProductsStates {}

class ProductsLoadingState extends ProductsStates {}

class ProductsDoneState extends ProductsStates {}

class ProductsFailedState extends ProductsStates {
  final CustomException exception;
  ProductsFailedState({required this.exception});
}
