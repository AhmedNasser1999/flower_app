// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/api/client/auth_api_client.dart' as _i213;
import '../../features/auth/api/datasource_implemenation/auth_remote_datasource_impl.dart'
    as _i434;
import '../../features/auth/data/datasource/auth_remote_datasource.dart'
    as _i175;
import '../../features/auth/data/repositories_implementation/auth_repo_impl.dart'
    as _i303;
import '../../features/auth/domain/repositories/Auth_repo.dart' as _i669;
import '../../features/auth/domain/usecases/forget_password_usecase/forget_password_usecase.dart'
    as _i682;
import '../../features/auth/domain/usecases/login_usecase/login_usecases.dart'
    as _i3;
import '../../features/auth/domain/usecases/logout_usecase/logout_usecase.dart'
    as _i8;
import '../../features/auth/domain/usecases/reset_password_usecase/reset_password_usecase.dart'
    as _i309;
import '../../features/auth/domain/usecases/signup_usecase/signup_usecase.dart'
    as _i93;
import '../../features/auth/domain/usecases/verify_code_usecase/verify_code_usecase.dart'
    as _i719;
import '../../features/auth/forget_password/presentation/viewmodel/forget_password_viewmodel.dart'
    as _i164;
import '../../features/auth/forget_password/presentation/viewmodel/reset_password_viewmodel.dart'
    as _i341;
import '../../features/auth/forget_password/presentation/viewmodel/verify_code_viewmodel.dart'
    as _i215;
import '../../features/auth/login/presentation/viewmodel/login_viewmodel.dart'
    as _i1063;
import '../../features/auth/logout/viewmodel/logout_viewmodel.dart' as _i71;
import '../../features/auth/signup/cubit/signup_cubit.dart' as _i387;
import '../../features/profile/api/client/profile_api_client.dart' as _i418;
import '../../features/profile/api/datasource_impl/profile_remote_datasource_impl.dart'
    as _i121;
import '../../features/profile/change_password/presentation/viewmodel/change_password_viewmodel.dart'
    as _i729;
import '../../features/profile/data/datasource/profile_remote_datasource.dart'
    as _i1031;
import '../../features/profile/data/repositories_impl/profile_repository_impl.dart'
    as _i357;
import '../../features/profile/domain/repositories/profile_repository.dart'
    as _i894;
import '../../features/profile/domain/usecases/change_password_usecase.dart'
    as _i550;
import '../../features/profile/domain/usecases/get_profile_data_usecase.dart'
    as _i68;
import '../../features/profile/presentation/viewmodel/profile_viewmodel.dart'
    as _i351;
import 'dio_module/dio_module.dart' as _i484;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioModule = _$DioModule();
    gh.factory<String>(
      () => dioModule.baseUrl,
      instanceName: 'baseurl',
    );
    gh.lazySingleton<_i361.Dio>(
        () => dioModule.dio(gh<String>(instanceName: 'baseurl')));
    gh.factory<_i213.AuthApiClient>(() => _i213.AuthApiClient(
          gh<_i361.Dio>(),
          baseUrl: gh<String>(instanceName: 'baseurl'),
        ));
    gh.factory<_i418.ProfileApiClient>(() => _i418.ProfileApiClient(
          gh<_i361.Dio>(),
          baseUrl: gh<String>(instanceName: 'baseurl'),
        ));
    gh.lazySingleton<_i175.AuthRemoteDatasource>(
        () => _i434.AuthRemoteDatasourceImpl(gh<_i213.AuthApiClient>()));
    gh.factory<_i341.ResetPasswordCubit>(
        () => _i341.ResetPasswordCubit(gh<_i213.AuthApiClient>()));
    gh.factory<_i669.AuthRepo>(
        () => _i303.AuthRepoImpl(gh<_i175.AuthRemoteDatasource>()));
    gh.lazySingleton<_i1031.ProfileRemoteDatasource>(() =>
        _i121.ProfileRemoteDatasourceImpl(
            apiClient: gh<_i418.ProfileApiClient>()));
    gh.factory<_i3.LoginUseCase>(() => _i3.LoginUseCase(gh<_i669.AuthRepo>()));
    gh.factory<_i8.LogoutUseCase>(
        () => _i8.LogoutUseCase(gh<_i669.AuthRepo>()));
    gh.factory<_i682.ForgetPasswordUseCase>(
        () => _i682.ForgetPasswordUseCase(gh<_i669.AuthRepo>()));
    gh.factory<_i309.ResetPasswordUseCase>(
        () => _i309.ResetPasswordUseCase(gh<_i669.AuthRepo>()));
    gh.factory<_i719.VerifyCodeUseCase>(
        () => _i719.VerifyCodeUseCase(gh<_i669.AuthRepo>()));
    gh.factory<_i215.VerifyCodeCubit>(() => _i215.VerifyCodeCubit(
          gh<_i719.VerifyCodeUseCase>(),
          gh<_i682.ForgetPasswordUseCase>(),
        ));
    gh.lazySingleton<_i894.ProfileRepository>(() =>
        _i357.ProfileRepositoryImpl(gh<_i1031.ProfileRemoteDatasource>()));
    gh.factory<_i164.ForgetPasswordCubit>(
        () => _i164.ForgetPasswordCubit(gh<_i682.ForgetPasswordUseCase>()));
    gh.factory<_i93.SignupUsecase>(
        () => _i93.SignupUsecase(gh<_i669.AuthRepo>()));
    gh.factory<_i71.LogoutViewModel>(
        () => _i71.LogoutViewModel(gh<_i8.LogoutUseCase>()));
    gh.factory<_i1063.LoginViewModel>(
        () => _i1063.LoginViewModel(gh<_i3.LoginUseCase>()));
    gh.factory<_i68.GetProfileDataUseCase>(
        () => _i68.GetProfileDataUseCase(gh<_i894.ProfileRepository>()));
    gh.factory<_i387.SignupCubit>(
        () => _i387.SignupCubit(signupUsecase: gh<_i93.SignupUsecase>()));
    gh.lazySingleton<_i550.ChangePasswordUseCases>(
        () => _i550.ChangePasswordUseCases(gh<_i894.ProfileRepository>()));
    gh.factory<_i729.ChangePasswordViewModel>(() =>
        _i729.ChangePasswordViewModel(gh<_i550.ChangePasswordUseCases>()));
    gh.factory<_i351.ProfileViewModel>(
        () => _i351.ProfileViewModel(gh<_i68.GetProfileDataUseCase>()));
    return this;
  }
}

class _$DioModule extends _i484.DioModule {}
