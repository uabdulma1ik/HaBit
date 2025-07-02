import 'package:equatable/equatable.dart';

class MyProfileState extends Equatable {
  final String? displayName;
  final String? email;
  final bool isLoading;

  const MyProfileState({this.displayName, this.email, this.isLoading = false});

  @override
  List<Object?> get props => [displayName, email, isLoading];
}
