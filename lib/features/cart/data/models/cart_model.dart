import 'package:flower_app/features/most_selling_products/data/models/products_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_model.g.dart';

@JsonSerializable()
class Cart {
  @JsonKey(name: '_id')
  final String id;

  final String user;
  final List<CartItem> cartItems;
  final List<dynamic> appliedCoupons;
  final int totalPrice;
  final String createdAt;
  final String updatedAt;

  @JsonKey(name: '__v')
  final int v;

  Cart({
    required this.id,
    required this.user,
    required this.cartItems,
    required this.appliedCoupons,
    required this.totalPrice,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
  Map<String, dynamic> toJson() => _$CartToJson(this);
}

@JsonSerializable()
class CartItem {
  final Products product;
  final int price;
  final int quantity;

  @JsonKey(name: '_id')
  final String id;

  CartItem({
    required this.product,
    required this.price,
    required this.quantity,
    required this.id,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}