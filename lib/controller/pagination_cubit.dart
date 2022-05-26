import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:pagination/controller/pagination_rep.dart';
import 'package:pagination/model/passenger_model.dart';

part 'pagination_state.dart';

class PaginationCubit extends Cubit<PaginationState> {
  PaginationCubit() : super(PaginationInitial());
  
  void getPages({bool isRefresh=true})async{
    
    // emit(PaginationInitial());

    final person = await PaginationRepo.getPassenger(isRefresh: isRefresh);
    print(person.runtimeType);
    print('===================');
    print(person);

    if(person!=null){
      /// Loaded  State
      ///

      emit(PaginationLoadedState(passengerModel: person));

    }else
      {
        /// Error State

        emit(PaginationErrorState(error: ''));

      }

}
}
