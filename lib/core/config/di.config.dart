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

import '../../features/address/api/client/address_api_client.dart' as _i932;
import '../../features/address/api/data_source_impl/address_remote_data_source_impl.dart'
    as _i670;
import '../../features/address/data/data_source/address_remote_data_source.dart'
    as _i747;
import '../../features/address/data/repo_impl/address_repo_impl.dart' as _i778;
import '../../features/address/domain/repositories/address_repository.dart'
    as _i463;
import '../../features/address/domain/use_cases/address_use_cases.dart'
    as _i1005;
import '../../features/address/presentation/view_model/address_cubit.dart'
    as _i554;
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
import '../../features/cart/api/client/cart_api_client.dart' as _i131;
import '../../features/cart/api/data_source_impl/cart_remote_data_source_impl.dart'
    as _i948;
import '../../features/cart/data/data_source/cart_remote_data_source.dart'
    as _i1026;
import '../../features/cart/data/repo_impl/cart_repo_impl.dart' as _i966;
import '../../features/cart/domain/repositories/cart_repository.dart' as _i322;
import '../../features/cart/domain/use_cases/add_to_cart_use_case.dart'
    as _i252;
import '../../features/cart/domain/use_cases/clear_cart_use_case.dart' as _i493;
import '../../features/cart/domain/use_cases/get_cart_use_case.dart' as _i176;
import '../../features/cart/domain/use_cases/remove_from_cart_use_case.dart'
    as _i30;
import '../../features/cart/domain/use_cases/update_cart_use_case.dart'
    as _i147;
import '../../features/cart/presentation/view_model/cart_cubit.dart' as _i818;
import '../../features/categories/api/client/categories_api_client.dart'
    as _i361;
import '../../features/categories/api/datasource_impl/catogries_remote_datasource_impl.dart'
    as _i315;
import '../../features/categories/data/datasource/categories_remote_datasource.dart'
    as _i904;
import '../../features/categories/data/repositories_impl/categories_repo_impl.dart'
    as _i738;
import '../../features/categories/domain/repositories/categories_repo.dart'
    as _i594;
import '../../features/categories/domain/usecases/get_all_categories_usecase.dart'
    as _i943;
import '../../features/categories/domain/usecases/get_category_byId_usecase.dart'
    as _i557;
import '../../features/categories/presentation/viewmodel/categories_viewmodel.dart'
    as _i820;
import '../../features/home/presentation/viewmodel/home_cubit.dart' as _i925;
import '../../features/most_selling_products/api/client/product_api_client.dart'
    as _i67;
import '../../features/most_selling_products/api/datasource_impl/product_remote_datasource_impl.dart'
    as _i313;
import '../../features/most_selling_products/data/datasource/product_remote_datasource.dart'
    as _i955;
import '../../features/most_selling_products/data/repositories_impl/product_repo_impl.dart'
    as _i680;
import '../../features/most_selling_products/domain/repositories/product_repo.dart'
    as _i1026;
import '../../features/most_selling_products/domain/usecases/get_all_products_usecase.dart'
    as _i144;
import '../../features/most_selling_products/presentation/viewmodel/most_selling_products_viewmodel.dart'
    as _i72;
import '../../features/occasion/api/client/occasion_api_client.dart' as _i1040;
import '../../features/occasion/api/datasource_impl/occasion_remote_data_source_impl.dart'
    as _i633;
import '../../features/occasion/data/datasource/occasion_remote_data_source.dart'
    as _i168;
import '../../features/occasion/data/repositories_impl/occasion_repo_impl.dart'
    as _i740;
import '../../features/occasion/domain/repositories/occasion_repository.dart'
    as _i682;
import '../../features/occasion/domain/usecases/get_occasions_use_case.dart'
    as _i202;
import '../../features/occasion/presentation/viewmodel/occasion_view_model.dart'
    as _i473;
import '../../features/order/api/client/order_api_client.dart' as _i81;
import '../../features/order/api/data_source_impl/order_remote_data_source_impl.dart'
    as _i841;
import '../../features/order/data/data_sources/order_remote_data_source.dart'
    as _i701;
import '../../features/order/data/repositories/order_repo_impl.dart' as _i1004;
import '../../features/order/domain/repositories/order_repo.dart' as _i713;
import '../../features/order/domain/use_cases/get_orders_usecase.dart' as _i796;
import '../../features/order/presentation/viewmodel/orders_cubit.dart' as _i561;
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
import '../../features/profile/domain/usecases/edit_profile_data_usecase.dart'
    as _i691;
import '../../features/profile/domain/usecases/get_profile_data_usecase.dart'
    as _i68;
import '../../features/profile/domain/usecases/upload_photo_usecase.dart'
    as _i971;
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
    gh.factory<_i81.OrderApiClient>(() => _i81.OrderApiClient(
          gh<_i361.Dio>(),
          baseUrl: gh<String>(instanceName: 'baseurl'),
        ));
    gh.factory<_i213.AuthApiClient>(() => _i213.AuthApiClient(
          gh<_i361.Dio>(),
          baseUrl: gh<String>(instanceName: 'baseurl'),
        ));
    gh.factory<_i418.ProfileApiClient>(() => _i418.ProfileApiClient(
          gh<_i361.Dio>(),
          baseUrl: gh<String>(instanceName: 'baseurl'),
        ));
    gh.factory<_i932.AddressApiClient>(() => _i932.AddressApiClient(
          gh<_i361.Dio>(),
          baseUrl: gh<String>(instanceName: 'baseurl'),
        ));
    gh.factory<_i131.CartApiClient>(() => _i131.CartApiClient(
          gh<_i361.Dio>(),
          baseUrl: gh<String>(instanceName: 'baseurl'),
        ));
    gh.factory<_i361.CategoryApiClient>(() => _i361.CategoryApiClient(
          gh<_i361.Dio>(),
          baseUrl: gh<String>(instanceName: 'baseurl'),
        ));
    gh.factory<_i1040.OccasionApiClient>(() => _i1040.OccasionApiClient(
          gh<_i361.Dio>(),
          baseUrl: gh<String>(instanceName: 'baseurl'),
        ));
    gh.factory<_i67.ProductApiClient>(() => _i67.ProductApiClient(
          gh<_i361.Dio>(),
          baseUrl: gh<String>(instanceName: 'baseurl'),
        ));
    gh.lazySingleton<_i175.AuthRemoteDatasource>(
        () => _i434.AuthRemoteDatasourceImpl(gh<_i213.AuthApiClient>()));
    gh.lazySingleton<_i1026.CartRemoteDataSource>(
        () => _i948.CartRemoteDataSourceImpl(gh<_i131.CartApiClient>()));
    gh.lazySingleton<_i701.OrderRemoteDataSource>(
        () => _i841.OrderRemoteDataSourceImpl(gh<_i81.OrderApiClient>()));
    gh.lazySingleton<_i904.GetCategoriesRemoteDataSource>(() =>
        _i315.GetCategoriesRemoteDataSourceImpl(gh<_i361.CategoryApiClient>()));
    gh.factory<_i341.ResetPasswordCubit>(
        () => _i341.ResetPasswordCubit(gh<_i213.AuthApiClient>()));
    gh.lazySingleton<_i713.OrderRepo>(
        () => _i1004.OrderRepoImpl(gh<_i701.OrderRemoteDataSource>()));
    gh.factory<_i747.AddressRemoteDataSource>(() =>
        _i670.AddressRemoteDataSourceImpl(
            addressApiClient: gh<_i932.AddressApiClient>()));
    gh.factory<_i669.AuthRepo>(
        () => _i303.AuthRepoImpl(gh<_i175.AuthRemoteDatasource>()));
    gh.factory<_i168.OccasionRemoteDataSource>(() =>
        _i633.OccasionRemoteDataSourceImpl(gh<_i1040.OccasionApiClient>()));
    gh.factory<_i682.OccasionRepository>(() =>
        _i740.OccasionRepositoryImpl(gh<_i168.OccasionRemoteDataSource>()));
    gh.lazySingleton<_i955.ProductRemoteDataSource>(
        () => _i313.ProductRemoteDataSourceImpl(gh<_i67.ProductApiClient>()));
    gh.lazySingleton<_i1031.ProfileRemoteDatasource>(() =>
        _i121.ProfileRemoteDatasourceImpl(
            apiClient: gh<_i418.ProfileApiClient>()));
    gh.lazySingleton<_i322.CartRepository>(
        () => _i966.CartRepositoryImpl(gh<_i1026.CartRemoteDataSource>()));
    gh.factory<_i796.GetOrdersUseCase>(
        () => _i796.GetOrdersUseCase(gh<_i713.OrderRepo>()));
    gh.factory<_i147.UpdateCartItemUseCase>(
        () => _i147.UpdateCartItemUseCase(gh<_i322.CartRepository>()));
    gh.factory<_i176.GetCartUseCase>(
        () => _i176.GetCartUseCase(gh<_i322.CartRepository>()));
    gh.factory<_i252.AddToCartUseCase>(
        () => _i252.AddToCartUseCase(gh<_i322.CartRepository>()));
    gh.factory<_i30.RemoveFromCartUseCase>(
        () => _i30.RemoveFromCartUseCase(gh<_i322.CartRepository>()));
    gh.factory<_i493.ClearCartUseCase>(
        () => _i493.ClearCartUseCase(gh<_i322.CartRepository>()));
    gh.factory<_i93.SignupUsecase>(
        () => _i93.SignupUsecase(gh<_i669.AuthRepo>()));
    gh.factory<_i3.LoginUseCase>(() => _i3.LoginUseCase(gh<_i669.AuthRepo>()));
    gh.factory<_i8.LogoutUseCase>(
        () => _i8.LogoutUseCase(gh<_i669.AuthRepo>()));
    gh.factory<_i719.VerifyCodeUseCase>(
        () => _i719.VerifyCodeUseCase(gh<_i669.AuthRepo>()));
    gh.factory<_i682.ForgetPasswordUseCase>(
        () => _i682.ForgetPasswordUseCase(gh<_i669.AuthRepo>()));
    gh.factory<_i309.ResetPasswordUseCase>(
        () => _i309.ResetPasswordUseCase(gh<_i669.AuthRepo>()));
    gh.lazySingleton<_i1026.ProductRepo>(
        () => _i680.ProductRepoImpl(gh<_i955.ProductRemoteDataSource>()));
    gh.factory<_i215.VerifyCodeCubit>(() => _i215.VerifyCodeCubit(
          gh<_i719.VerifyCodeUseCase>(),
          gh<_i682.ForgetPasswordUseCase>(),
        ));
    gh.factory<_i463.AddressRepository>(() => _i778.AddressRepositoryImpl(
        remoteDataSource: gh<_i747.AddressRemoteDataSource>()));
    gh.lazySingleton<_i894.ProfileRepository>(() =>
        _i357.ProfileRepositoryImpl(gh<_i1031.ProfileRemoteDatasource>()));
    gh.factory<_i594.CategoriesRepo>(() =>
        _i738.CategoriesRepoImpl(gh<_i904.GetCategoriesRemoteDataSource>()));
    gh.factory<_i691.EditProfileDataUseCase>(
        () => _i691.EditProfileDataUseCase(gh<_i894.ProfileRepository>()));
    gh.factory<_i68.GetProfileDataUseCase>(
        () => _i68.GetProfileDataUseCase(gh<_i894.ProfileRepository>()));
    gh.factory<_i387.SignupCubit>(
        () => _i387.SignupCubit(signupUsecase: gh<_i93.SignupUsecase>()));
    gh.lazySingleton<_i550.ChangePasswordUseCases>(
        () => _i550.ChangePasswordUseCases(gh<_i894.ProfileRepository>()));
    gh.factory<_i202.GetOccasionsUseCase>(
        () => _i202.GetOccasionsUseCase(gh<_i682.OccasionRepository>()));
    gh.factory<_i729.ChangePasswordViewModel>(() =>
        _i729.ChangePasswordViewModel(gh<_i550.ChangePasswordUseCases>()));
    gh.factory<_i164.ForgetPasswordCubit>(
        () => _i164.ForgetPasswordCubit(gh<_i682.ForgetPasswordUseCase>()));
    gh.lazySingleton<_i557.GetCategoryByIdUseCase>(
        () => _i557.GetCategoryByIdUseCase(gh<_i594.CategoriesRepo>()));
    gh.lazySingleton<_i943.GetAllCategoriesUseCase>(
        () => _i943.GetAllCategoriesUseCase(gh<_i594.CategoriesRepo>()));
    gh.factory<_i1005.AddAddressUseCase>(() =>
        _i1005.AddAddressUseCase(repository: gh<_i463.AddressRepository>()));
    gh.factory<_i1005.GetAddressesUseCase>(() =>
        _i1005.GetAddressesUseCase(repository: gh<_i463.AddressRepository>()));
    gh.factory<_i1005.UpdateAddressUseCase>(() =>
        _i1005.UpdateAddressUseCase(repository: gh<_i463.AddressRepository>()));
    gh.factory<_i1005.DeleteAddressUseCase>(() =>
        _i1005.DeleteAddressUseCase(repository: gh<_i463.AddressRepository>()));
    gh.factory<_i144.GetAllProductsUseCase>(
        () => _i144.GetAllProductsUseCase(gh<_i1026.ProductRepo>()));
    gh.factory<_i971.UploadPhotoUseCase>(
        () => _i971.UploadPhotoUseCase(gh<_i894.ProfileRepository>()));
    gh.factory<_i818.CartCubit>(() => _i818.CartCubit(
          gh<_i252.AddToCartUseCase>(),
          gh<_i176.GetCartUseCase>(),
          gh<_i30.RemoveFromCartUseCase>(),
          gh<_i147.UpdateCartItemUseCase>(),
          gh<_i493.ClearCartUseCase>(),
        ));
    gh.factory<_i561.OrdersCubit>(
        () => _i561.OrdersCubit(gh<_i796.GetOrdersUseCase>()));
    gh.factory<_i71.LogoutViewModel>(
        () => _i71.LogoutViewModel(gh<_i8.LogoutUseCase>()));
    gh.factory<_i72.MostSellingProductsViewmodel>(() =>
        _i72.MostSellingProductsViewmodel(gh<_i144.GetAllProductsUseCase>()));
    gh.factory<_i1063.LoginViewModel>(
        () => _i1063.LoginViewModel(gh<_i3.LoginUseCase>()));
    gh.factory<_i554.AddressCubit>(() => _i554.AddressCubit(
          addAddressUseCase: gh<_i1005.AddAddressUseCase>(),
          getAddressesUseCase: gh<_i1005.GetAddressesUseCase>(),
          updateAddressUseCase: gh<_i1005.UpdateAddressUseCase>(),
          deleteAddressUseCase: gh<_i1005.DeleteAddressUseCase>(),
        ));
    gh.factory<_i473.OccasionViewmodel>(
        () => _i473.OccasionViewmodel(gh<_i202.GetOccasionsUseCase>()));
    gh.factory<_i925.HomeCubit>(() => _i925.HomeCubit(
          gh<_i144.GetAllProductsUseCase>(),
          gh<_i943.GetAllCategoriesUseCase>(),
          gh<_i202.GetOccasionsUseCase>(),
        ));
    gh.factory<_i351.ProfileViewModel>(
        () => _i351.ProfileViewModel(gh<_i68.GetProfileDataUseCase>()));
    gh.factory<_i820.CategoriesCubit>(() => _i820.CategoriesCubit(
          getAllCategoriesUseCase: gh<_i943.GetAllCategoriesUseCase>(),
          getCategoryDetailsUseCase: gh<_i557.GetCategoryByIdUseCase>(),
        ));
    return this;
  }
}

class _$DioModule extends _i484.DioModule {}
