import 'package:injectable/injectable.dart';

import '../entities/order_entity.dart';
import '../repositories/order_repo.dart';

@injectable
class GetOrdersUseCase {
  final OrderRepo _orderRepo;

  GetOrdersUseCase(this._orderRepo);

  Future<List<OrderEntity>> call() async {
    return _orderRepo.getOrders();
  }
}
