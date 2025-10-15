import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import '../../domain/entities/order.dart';

class OrderModel {
  final String id;
  final bool arrivedAtPickup;
  final int createdAt;
  final String driverId;
  final List<OrderItemModel> items;
  final int lastUpdated;
  final String orderNumber;
  final String paymentMethod;
  final PickupAddressModel pickupAddress;
  final String state;
  final int total;
  final String updateOrderButton;
  final UserAddressModel userAddress;

  OrderModel({
    required this.id,
    required this.arrivedAtPickup,
    required this.createdAt,
    required this.driverId,
    required this.items,
    required this.lastUpdated,
    required this.orderNumber,
    required this.paymentMethod,
    required this.pickupAddress,
    required this.state,
    required this.total,
    required this.updateOrderButton,
    required this.userAddress,
  });

  factory OrderModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    int parseInt(dynamic value) {
      if (value is int) return value;
      if (value is double) return value.toInt();
      return 0;
    }
    return OrderModel(
      id: data['id'] ?? '',
      arrivedAtPickup: data['arrivedAtPickup'] ?? false,
      createdAt: parseInt(data['createdAt']),
      driverId: data['driverId'] ?? '',
      items: (data['items'] as List<dynamic>?)?.map((item) => OrderItemModel.fromMap(item)).toList() ?? [],
      lastUpdated: data['lastUpdated'] is Timestamp
        ? (data['lastUpdated'] as Timestamp).millisecondsSinceEpoch
        : parseInt(data['lastUpdated']),
      orderNumber: data['orderNumber'] ?? '',
      paymentMethod: data['paymentMethod'] ?? '',
      pickupAddress: PickupAddressModel.fromMap(data['pickupAddress'] ?? {}),
      state: data['state'] ?? '',
      total: parseInt(data['total']),
      updateOrderButton: data['update_order_button'] ?? '',
      userAddress: UserAddressModel.fromMap(data['userAddress'] ?? {}),
    );
  }
}

class OrderItemModel {
  final String name;
  final int price;
  final String productId;
  final int quantity;

  OrderItemModel({
    required this.name,
    required this.price,
    required this.productId,
    required this.quantity,
  });

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    int parseInt(dynamic value) {
      if (value is int) return value;
      if (value is double) return value.toInt();
      return 0;
    }
    return OrderItemModel(
      name: map['name'] ?? '',
      price: parseInt(map['price']),
      productId: map['productId'] ?? '',
      quantity: parseInt(map['quantity']),
    );
  }
}

class PickupAddressModel {
  final String address;
  final String name;
  final String phoneNumber;

  PickupAddressModel({
    required this.address,
    required this.name,
    required this.phoneNumber,
  });

  factory PickupAddressModel.fromMap(Map<String, dynamic> map) {
    return PickupAddressModel(
      address: map['address'] ?? '',
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
    );
  }
}

class UserAddressModel {
  final String address;
  final String name;
  final String phoneNumber;

  UserAddressModel({
    required this.address,
    required this.name,
    required this.phoneNumber,
  });

  factory UserAddressModel.fromMap(Map<String, dynamic> map) {
    return UserAddressModel(
      address: map['address'] ?? '',
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
    );
  }
}

extension OrderModelMapper on OrderModel {
  Order toEntity() {
    return Order(
      id: id,
      arrivedAtPickup: arrivedAtPickup,
      createdAt: createdAt,
      driverId: driverId,
      items: items.map((item) => item.toEntity()).toList(),
      lastUpdated: lastUpdated,
      orderNumber: orderNumber,
      paymentMethod: paymentMethod,
      pickupAddress: pickupAddress.toEntity(),
      state: state,
      total: total,
      updateOrderButton: updateOrderButton,
      userAddress: userAddress.toEntity(),
    );
  }
}

extension OrderItemModelMapper on OrderItemModel {
  OrderItem toEntity() {
    return OrderItem(
      name: name,
      price: price,
      productId: productId,
      quantity: quantity,
    );
  }
}

extension PickupAddressModelMapper on PickupAddressModel {
  PickupAddress toEntity() {
    return PickupAddress(
      address: address,
      name: name,
      phoneNumber: phoneNumber,
    );
  }
}

extension UserAddressModelMapper on UserAddressModel {
  UserAddress toEntity() {
    return UserAddress(
      address: address,
      name: name,
      phoneNumber: phoneNumber,
    );
  }
}
