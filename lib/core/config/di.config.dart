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
import '../../features/auth/domain/usecase/signup_usecase/signup_usecase.dart'
    as _i195;
import '../../features/auth/domain/usecases/forget_password_usecase.dart'
    as _i948;
import '../../features/auth/domain/usecases/login_usecases.dart' as _i1037;
import '../../features/auth/domain/usecases/reset_password_usecase.dart'
    as _i474;
import '../../features/auth/domain/usecases/verify_code_usecase.dart' as _i294;
import '../../features/auth/forget_password/presentation/viewmodel/forget_password_viewmodel.dart'
    as _i164;
import '../../features/auth/forget_password/presentation/viewmodel/reset_password_viewmodel.dart'
    as _i341;
import '../../features/auth/forget_password/presentation/viewmodel/verify_code_viewmodel.dart'
    as _i215;
import '../../features/auth/login/presentation/viewmodel/login_viewmodel.dart'
    as _i1063;
import '../../features/auth/signup/cubit/signup_cubit.dart' as _i387;
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
    gh.lazySingleton<_i175.AuthRemoteDatasource>(
        () => _i434.AuthRemoteDatasourceImpl(gh<_i213.AuthApiClient>()));
    gh.factory<_i341.ResetPasswordCubit>(
        () => _i341.ResetPasswordCubit(gh<_i213.AuthApiClient>()));
    gh.factory<_i669.AuthRepo>(
        () => _i303.AuthRepoImpl(gh<_i175.AuthRemoteDatasource>()));
    gh.factory<_i1037.LoginUseCase>(
        () => _i1037.LoginUseCase(gh<_i669.AuthRepo>()));
    gh.factory<_i948.ForgetPasswordUseCase>(
        () => _i948.ForgetPasswordUseCase(gh<_i669.AuthRepo>()));
    gh.factory<_i294.VerifyCodeUseCase>(
        () => _i294.VerifyCodeUseCase(gh<_i669.AuthRepo>()));
    gh.factory<_i474.ResetPasswordUseCase>(
        () => _i474.ResetPasswordUseCase(gh<_i669.AuthRepo>()));
    gh.factory<_i164.ForgetPasswordCubit>(
        () => _i164.ForgetPasswordCubit(gh<_i948.ForgetPasswordUseCase>()));
    gh.factory<_i195.SignupUsecase>(
        () => _i195.SignupUsecase(gh<_i669.AuthRepo>()));
    gh.factory<_i215.VerifyCodeCubit>(() => _i215.VerifyCodeCubit(
          gh<_i294.VerifyCodeUseCase>(),
          gh<_i948.ForgetPasswordUseCase>(),
        ));
    gh.factory<_i1063.LoginViewModel>(
        () => _i1063.LoginViewModel(gh<_i1037.LoginUseCase>()));
    gh.factory<_i387.SignupCubit>(
        () => _i387.SignupCubit(signupUsecase: gh<_i195.SignupUsecase>()));
    return this;
  }
}

class _$DioModule extends _i484.DioModule {}
