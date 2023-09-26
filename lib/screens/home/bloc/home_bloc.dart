import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:notebloc/repositories/api/api_functions.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FormNavigationEvent>(formNavigation);
    on<FetchSuccessEvent>(fetchDatas);
    on<ShowDialogEvent>(showDialogEvent);
    on<DeleteNoteEvent>(deleteNoteEvent);
  }

  FutureOr<void> formNavigation(
      FormNavigationEvent event, Emitter<HomeState> emit) {
    emit(FormNavigationState());
  }

  FutureOr<void> fetchDatas(
      FetchSuccessEvent event, Emitter<HomeState> emit) async {
    emit(LoadingState());
    final notes = await Api.fetchNotes();
    if (notes!.isNotEmpty) {
      emit(SuccessState(notesList: notes));
    } else {
      emit(ErrorState());
    }
  }

  FutureOr<void> deleteNoteEvent(
      DeleteNoteEvent event, Emitter<HomeState> emit) {
    Api.deleteById(event.id);
    emit(DeleteNoteMessageState());
  }

  FutureOr<void> showDialogEvent(
      ShowDialogEvent event, Emitter<HomeState> emit) {
    emit(ShowPopupMessageState());
  }
}
