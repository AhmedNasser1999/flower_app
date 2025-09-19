import 'package:flower_app/features/checkout/data/models/checkout_request.dart';
import 'package:flower_app/features/checkout/domain/entities/checkout_entity.dart';
import 'package:injectable/injectable.dart';

import '../repository/checkout_repo.dart';

@injectable
class CheckoutSessionUsecase {
  final CheckoutRepo checkoutRepoImpl;
  CheckoutSessionUsecase(this.checkoutRepoImpl);
  Future<CheckoutEntity> executeCheckoutSession(CheckoutRequest request) async {
    return await checkoutRepoImpl.checkoutSession(request);
  }
}
