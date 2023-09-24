import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:notebloc/screens/repositories/api/api_functions.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FormNavigationEvent>(formNavigation);
    on<FetchSuccessEvent>(fetchDatas);
  }

  FutureOr<void> formNavigation(FormNavigationEvent event, Emitter<HomeState> emit) {
    emit(FormNavigationState());
  }

  FutureOr<void> fetchDatas(FetchSuccessEvent event, Emitter<HomeState> emit) async{
    emit(LoadingState());
    final notes= await Api.fetchNotes();
    if (notes!.isNotEmpty) { 
      emit(SuccessState(notesList: notes));
    } else {
       emit(ErrorState());
    }
  }
}
