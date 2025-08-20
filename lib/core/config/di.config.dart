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
    gh.lazySingleton<_i361.Dio>(
        () => dioModule.dio(gh<String>(instanceName: 'baseurl')));
    gh.factory<_i213.AuthApiClient>(() => _i213.AuthApiClient(
          gh<_i361.Dio>(),
          baseUrl: gh<String>(instanceName: 'baseurl'),
        ));
    gh.lazySingleton<_i175.AuthRemoteDatasource>(
        () => _i434.AuthRemoteDatasourceImpl(gh<_i213.AuthApiClient>()));
    gh.factory<_i669.AuthRepo>(
        () => _i303.AuthRepoImpl(gh<_i175.AuthRemoteDatasource>()));
    return this;
  }
}

class _$DioModule extends _i484.DioModule {}
