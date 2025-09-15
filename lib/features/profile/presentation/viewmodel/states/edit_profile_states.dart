sealed class EditProfileStates {}

class EditProfileInitialState extends EditProfileStates {}

class EditProfileLoadingState extends EditProfileStates {}

class EditProfileSuccessState extends EditProfileStates {
  final String message;
  EditProfileSuccessState({required this.message});
}

class EditProfileErrorState extends EditProfileStates {
  final String message;
  EditProfileErrorState({required this.message});
}

class ProfilePhotoLoadingState extends EditProfileStates {}

class ProfilePhotoUpdatedState extends EditProfileStates {
  final String message;
  ProfilePhotoUpdatedState(this.message);
}

class ProfilePhotoErrorState extends EditProfileStates {
  final String message;
  ProfilePhotoErrorState({required this.message});
}
