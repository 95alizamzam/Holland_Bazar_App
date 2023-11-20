// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tsc_app/core/exceptions/app_exception.dart';

abstract class OffersStates {}

class OffersInitialState extends OffersStates {}

class OffersLoadingState extends OffersStates {}

class OffersDoneState extends OffersStates {}

class OffersFailedState extends OffersStates {
  final CustomException exception;
  OffersFailedState({required this.exception});
}
