part of 'home_bloc.dart';

abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}
final class LoadingState extends HomeState {}
final class SuccessState extends HomeState {
  List notesList = [];
  SuccessState({required this.notesList});
}
final class ErrorState extends HomeState {} 


final class FormNavigationState extends HomeActionState{}
