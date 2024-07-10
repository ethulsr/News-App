part of 'navigation_bloc.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object> get props => [];
}

class NavigationInitial extends NavigationState {}

class NavigationSelected extends NavigationState {
  final int selectedIndex;

  const NavigationSelected(this.selectedIndex);

  @override
  List<Object> get props => [selectedIndex];
}
