import 'package:flower_app/features/profile/domain/entity/user_entity.dart';

abstract class ProfileStates {}

class ProfileInitialState extends ProfileStates {}

class ProfileLoadingState extends ProfileStates {}

class ProfileSuccessState extends ProfileStates {
  final UserEntity user;

  ProfileSuccessState(this.user);
}

class ProfileErrorState extends ProfileStates {
  final String message;

  ProfileErrorState(this.message);
}
