class Order {
  final String id;
  final bool arrivedAtPickup;
  final int createdAt;
  final String driverId;
  final List<OrderItem> items;
  final int lastUpdated;
  final String orderNumber;
  final String paymentMethod;
  final PickupAddress pickupAddress;
  final String state;
  final int total;
  final String updateOrderButton;
  final UserAddress userAddress;

  Order({
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
}

class OrderItem {
  final String name;
  final int price;
  final String productId;
  final int quantity;

  OrderItem({
    required this.name,
    required this.price,
    required this.productId,
    required this.quantity,
  });
}

class PickupAddress {
  final String address;
  final String name;
  final String phoneNumber;

  PickupAddress({
    required this.address,
    required this.name,
    required this.phoneNumber,
  });
}

class UserAddress {
  final String address;
  final String name;
  final String phoneNumber;

  UserAddress({
    required this.address,
    required this.name,
    required this.phoneNumber,
  });
}
