import 'package:flower_app/features/checkout/data/models/checkout_request.dart';
import 'package:flower_app/features/checkout/data/repository/checkout_repo_impl.dart';
import 'package:flower_app/features/checkout/domain/entities/checkout_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class CheckoutSessionUsecase {
  CheckoutRepoImpl checkoutRepoImpl;
  CheckoutSessionUsecase(this.checkoutRepoImpl);
  Future<CheckoutEntity> executeCheckoutSession(CheckoutRequest request) async {
    return await checkoutRepoImpl.checkoutSession(request);
  }
}
