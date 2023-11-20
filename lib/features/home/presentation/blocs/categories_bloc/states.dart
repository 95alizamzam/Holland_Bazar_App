// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tsc_app/core/exceptions/app_exception.dart';

abstract class CategoriessStates {}

class CategoriesInitialState extends CategoriessStates {}

class CategoriesLoadingState extends CategoriessStates {}

class CategoriesDoneState extends CategoriessStates {}

class CategoriesFailedState extends CategoriessStates {
  final CustomException exception;
  CategoriesFailedState({required this.exception});
}
