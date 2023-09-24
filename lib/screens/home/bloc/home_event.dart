part of 'home_bloc.dart';

abstract class HomeEvent {}

abstract class HomeActionEvent extends HomeEvent {}

final class FetchSuccessEvent extends HomeEvent {}

final class FormNavigationEvent extends HomeActionEvent {}
