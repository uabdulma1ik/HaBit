import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit/logic/navigation/navigation_bar_event.dart';
import 'package:habit/logic/navigation/navigation_bar_state.dart';


class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationState(0)) {
    on<ChangeTabEvent>((event, emit) {
      emit(NavigationState(event.newIndex));
    });
  }
}
