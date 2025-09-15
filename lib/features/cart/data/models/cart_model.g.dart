// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      id: json['_id'] as String,
      user: json['user'] as String,
      cartItems: (json['cartItems'] as List<dynamic>)
          .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      appliedCoupons: json['appliedCoupons'] as List<dynamic>,
      totalPrice: (json['totalPrice'] as num).toInt(),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      v: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'cartItems': instance.cartItems,
      'appliedCoupons': instance.appliedCoupons,
      'totalPrice': instance.totalPrice,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
    };

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
      product: Products.fromJson(json['product'] as Map<String, dynamic>),
      price: (json['price'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
      id: json['_id'] as String,
    );

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      'product': instance.product,
      'price': instance.price,
      'quantity': instance.quantity,
      '_id': instance.id,
    };
