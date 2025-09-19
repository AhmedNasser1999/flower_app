import 'package:flower_app/features/checkout/data/models/cash_order_request.dart';
import 'package:flower_app/features/checkout/data/repository/checkout_repo_impl.dart';
import 'package:flower_app/features/checkout/domain/entities/cash_order_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class CreateCashOrderUsecase {
  CheckoutRepoImpl checkoutRepoImpl;
  CreateCashOrderUsecase(this.checkoutRepoImpl);
  Future<CashOrderEntity> executeCreateCashOrder(
      CashOrderRequest request) async {
    return await checkoutRepoImpl.createCashOrder(request);
  }
}
