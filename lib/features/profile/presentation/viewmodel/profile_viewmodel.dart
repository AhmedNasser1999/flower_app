import 'package:flower_app/features/profile/domain/entity/user_entity.dart';
import 'package:flower_app/features/profile/presentation/viewmodel/states/profile_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/api_result.dart';
import '../../domain/usecases/get_profile_data_usecase.dart';

@injectable
class ProfileViewModel extends Cubit<ProfileStates> {
  final GetProfileDataUseCase _getProfileDataUseCase;

  ProfileViewModel(this._getProfileDataUseCase) : super(ProfileInitialState());

  UserEntity? user;

  Future<void> getProfile() async {
    emit(ProfileLoadingState());
    final result = await _getProfileDataUseCase();

    switch (result) {
      case ApiSuccessResult(:final data):
        emit(ProfileSuccessState(data));
      case ApiErrorResult(:final errorMessage):
        emit(ProfileErrorState(errorMessage));
    }
  }
}