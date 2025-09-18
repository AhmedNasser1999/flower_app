import '../../domain/entities/order_entity.dart';

abstract class OrdersState {}

class OrdersInitialState extends OrdersState {}

class OrdersLoadingState extends OrdersState {}

class OrdersSuccessState extends OrdersState {
  final List<OrderEntity> activeOrders;
  final List<OrderEntity> completedOrders;

  OrdersSuccessState({
    required this.activeOrders,
    required this.completedOrders,
  });
}

class OrdersErrorState extends OrdersState {
  final String message;

  OrdersErrorState(this.message);
}
