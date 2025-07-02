import 'package:equatable/equatable.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class ChangeTabEvent extends NavigationEvent {
  final int newIndex;

  const ChangeTabEvent(this.newIndex);

  @override
  List<Object> get props => [newIndex];
}
