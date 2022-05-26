part of 'pagination_cubit.dart';

@immutable
abstract class PaginationState {}

class PaginationInitial extends PaginationState {}

class PaginationLoadingState extends PaginationState {}

class PaginationLoadedState extends PaginationState {

  PassengerModel passengerModel;

 PaginationLoadedState({required this.passengerModel});

}

class PaginationErrorState extends PaginationState {

  String error;
  PaginationErrorState({required this.error});

}