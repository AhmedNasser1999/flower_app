import 'package:flower_app/features/checkout/data/models/cash_order_request.dart';
import 'package:flower_app/features/checkout/domain/entities/cash_order_entity.dart';
import 'package:injectable/injectable.dart';
import '../repository/checkout_repo.dart';

@injectable
class CreateCashOrderUsecase {
  final CheckoutRepo checkoutRepoImpl;
  CreateCashOrderUsecase(this.checkoutRepoImpl);
  Future<CashOrderEntity> executeCreateCashOrder(
      CashOrderRequest request) async {
    return await checkoutRepoImpl.createCashOrder(request);
  }
}
