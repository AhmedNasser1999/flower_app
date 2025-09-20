import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flower_app/core/contants/app_constants.dart';
import 'package:flower_app/core/contants/api_constants.dart';
import 'package:flower_app/features/address/domain/requests/address_request.dart';
import 'package:flower_app/features/address/domain/responses/address_response.dart';
import 'package:flower_app/features/auth/data/models/forget_password_models/forget_password_request.dart';
import 'package:flower_app/features/auth/data/models/forget_password_models/reset_password_request_model.dart';
import 'package:flower_app/features/auth/data/models/forget_password_models/verify_code_request_model.dart';
import 'package:flower_app/features/auth/data/models/login_models/login_request_model.dart';
import 'package:flower_app/features/auth/data/models/login_models/login_response_model.dart';
import 'package:flower_app/features/auth/data/models/signup_model/signup_request_model.dart';
import 'package:flower_app/features/auth/data/models/signup_model/signup_response_model.dart';
import 'package:flower_app/features/cart/domain/responses/cart_response.dart';
import 'package:flower_app/features/categories/data/models/categories_response.dart';
import 'package:flower_app/features/categories/data/models/categoryResponse_byId_model.dart';
import 'package:flower_app/features/checkout/data/models/cash_order_request.dart';
import 'package:flower_app/features/checkout/data/models/cash_order_response.dart';
import 'package:flower_app/features/checkout/data/models/chechout_response.dart';
import 'package:flower_app/features/checkout/data/models/checkout_request.dart';
import 'package:flower_app/features/most_selling_products/data/models/products_reponse_model.dart';
import 'package:flower_app/features/occasion/data/models/occasion_response_model.dart';
import 'package:flower_app/features/order/data/models/order_response.dart';
import 'package:flower_app/features/profile/data/models/change_password_request_model.dart';
import 'package:flower_app/features/profile/data/models/change_password_response_model.dart';
import 'package:flower_app/features/profile/data/models/edit_profile_request_model.dart';
import 'package:flower_app/features/profile/data/models/edit_profile_response_model.dart';
import 'package:flower_app/features/profile/data/models/profile_response.dart';
import 'package:flower_app/features/profile/data/models/upload_photo_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@injectable
@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio, {@Named('baseurl') String? baseUrl}) = _ApiClient;

  /// AUTH ENDPOINTS ///
  @POST(AppConstants.signIn)
  Future<LoginResponse> login(@Body() LoginRequest loginRequest);

  @POST(AppConstants.signup)
  Future<RegisterResponse> signUp(@Body() RegisterRequest registerRequest);

  @GET(AppConstants.logout)
  @Extra({'auth': true})
  Future<String> logout();

  @POST(AppConstants.forgetPassword)
  Future<String> forgetPassword(
      @Body() ForgetPasswordRequestModel forgetPasswordRequestModel);

  @POST(AppConstants.verifyResetCode)
  Future<String> verifyResetCode(
      @Body() VerifyCodeRequestModel verifyResetCode);

  @PUT(AppConstants.restPassword)
  Future<String> resetPassword(
      @Body() ResetPasswordRequestModel resetPasswordRequestModel);

  /// PROFILE ENDPOINTS ///
  @GET(AppConstants.profile)
  @Extra({'auth': true})
  Future<ProfileResponse> getProfile();

  @PATCH(AppConstants.changePassword)
  @Extra({'auth': true})
  Future<ChangePasswordResponseModel> changePassword(
      @Body() ChangePasswordRequestModel changePasswordRequestModel);

  @PUT(AppConstants.editProfile)
  @Extra({'auth': true})
  Future<EditProfileResponseModel> editProfile(
      @Body() EditProfileRequestModel model);

  @PUT(AppConstants.uploadPhoto)
  @MultiPart()
  @Extra({'auth': true})
  Future<UploadPhotoResponse> uploadPhoto(@Part(name: "photo") File photo);

  /// CATEGORIES ENDPOINTS ///
  @GET(AppConstants.categories)
  Future<CategoriesResponse> getAllCategories();

  @GET("${AppConstants.categories}/{id}")
  Future<CategoryDetailsResponse> getCategoryById(@Path("id") String id);

  /// PRODUCTS ENDPOINTS ///
  @GET('/products')
  Future<ProductsResponseModel> getAllProducts(
      @Query('sort') String? sort,
      @Query('search') String? search,
      @Query('category') String? category);

  /// CART ENDPOINTS ///
  @POST(AppConstants.addToCart)
  @Extra({'auth': true})
  Future<CartResponse> addToCart(@Body() AddToCartRequest request);

  @GET(AppConstants.getCart)
  @Extra({'auth': true})
  Future<CartResponse> getCart();

  @DELETE("${AppConstants.removeFromCart}/{id}")
  @Extra({'auth': true})
  Future<CartResponse> removeFromCart(@Path('id') String itemId);

  @PUT("${AppConstants.updateCartItem}/{id}")
  @Extra({'auth': true})
  Future<CartResponse> updateCartItem(
      @Path('id') String itemId,
      @Body() Map<String, dynamic> data,
      );

  @DELETE(AppConstants.deleteUserCart)
  @Extra({'auth': true})
  Future<CartResponse> clearCart();

  /// ADDRESS ENDPOINTS ///
  @PATCH(AppConstants.addresses)
  @Extra({'auth': true})
  Future<AddressResponse> addAddress(@Body() AddressRequest request);

  @GET(AppConstants.addresses)
  @Extra({'auth': true})
  Future<AddressResponse> getAddresses();

  @PATCH('${AppConstants.addresses}/{id}')
  @Extra({'auth': true})
  Future<AddressResponse> updateAddress(
      @Path('id') String id, @Body() AddressRequest request);

  @DELETE('${AppConstants.addresses}/{id}')
  @Extra({'auth': true})
  Future<AddressResponse> deleteAddress(@Path('id') String id);

  /// ORDER ENDPOINTS ///
  @GET("orders")
  @Extra({'auth': true})
  Future<OrderResponse> getOrders();

  /// CHECKOUT ENDPOINTS ///
  @POST(ApiConstant.cashOrder)
  @Extra({'auth': true})
  Future<CashOrderResponse> createCashOrder(
      @Body() CashOrderRequest cashOrderRequest);

  @POST(ApiConstant.checkout)
  @Extra({'auth': true})
  Future<CheckoutResponse> checkoutSession(
      @Body() CheckoutRequest checkoutRequest);

  /// OCCASION ENDPOINTS ///
  @GET("/occasions")
  Future<OccasionsResponse> getOccasions({
    @Query("page") int? page,
    @Query("limit") int? limit,
  });
}