import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/use_cases/get_orders_usecase.dart';
import 'order_states.dart';

@injectable
class OrdersCubit extends Cubit<OrdersState> {
  final GetOrdersUseCase _getOrdersUseCase;
  OrdersCubit(this._getOrdersUseCase) : super(OrdersInitialState());

  Future<void> getOrder() async {
    emit(OrdersLoadingState());
    try {
      final orders = await _getOrdersUseCase();

      final active = orders.where((order) => order.state == 'pending'||order.state == 'inProgress').toList();
      final completed =
          orders.where((order) => order.state == 'completed').toList();

      emit(
          OrdersSuccessState(activeOrders: active, completedOrders: completed));
    } catch (e) {
      emit(OrdersErrorState(e.toString()));
    }
  }
}
