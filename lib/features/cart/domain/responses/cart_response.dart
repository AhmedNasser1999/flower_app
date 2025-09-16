import 'package:json_annotation/json_annotation.dart';
import '../../data/models/cart_model.dart';

part 'cart_response.g.dart';

@JsonSerializable()
class CartResponse {
  final String message;
  final int numOfCartItems;
  final Cart cart;

  CartResponse({
    required this.message,
    required this.numOfCartItems,
    required this.cart,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) =>
      _$CartResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CartResponseToJson(this);
}

@JsonSerializable()
class AddToCartRequest {
  final String product;
  final int quantity;

  AddToCartRequest({
    required this.product,
    required this.quantity,
  });

  factory AddToCartRequest.fromJson(Map<String, dynamic> json) =>
      _$AddToCartRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddToCartRequestToJson(this);
}
