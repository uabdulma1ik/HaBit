import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:habit/logic/my_profile/my_profile_event.dart';
import 'package:habit/logic/my_profile/my_profile_state.dart';
import 'package:habit/services/auth_service/auth_service.dart';

class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileState> {
  MyProfileBloc() : super(const MyProfileState(isLoading: true)) {
    on<LoadProfile>((event, emit) async {
      emit(const MyProfileState(isLoading: true));

      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final userData = await AuthService().getUserData(user.uid);

        emit(
          MyProfileState(
            displayName: userData['displayName'],
            email: userData['email'],
            isLoading: false,
          ),
        );
      } else {
        emit(const MyProfileState(isLoading: false));
      }
    });
  }
}
