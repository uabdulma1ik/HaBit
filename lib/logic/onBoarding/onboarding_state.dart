import 'package:equatable/equatable.dart';

class OnboardingState extends Equatable {
  final int currentIndex;

  const OnboardingState(this.currentIndex);

  @override
  List<Object> get props => [currentIndex];
}
