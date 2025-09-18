import 'package:dio/dio.dart';
import 'package:flower_app/core/contants/app_constants.dart';
import 'package:flower_app/features/cart/domain/responses/cart_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'cart_api_client.g.dart';

@injectable
@RestApi()
abstract class CartApiClient {
  @factoryMethod
  factory CartApiClient(Dio dio, {@Named('baseurl') String? baseUrl}) =
      _CartApiClient;

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
}
