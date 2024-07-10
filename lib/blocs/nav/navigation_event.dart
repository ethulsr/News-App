part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class SelectTab extends NavigationEvent {
  final int index;

  const SelectTab(this.index);

  @override
  List<Object> get props => [index];
}
