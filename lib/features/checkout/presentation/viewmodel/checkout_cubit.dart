import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../address/data/models/address.dart';
import '../../data/models/cash_order_request.dart';
import '../../data/models/cash_order_request_DTO.dart';
import '../../data/models/checkout_request.dart';
import '../../data/models/shipping_address_request_DTO.dart';
import '../../domain/use_cases/checkout_session_usecase.dart';
import '../../domain/use_cases/create_cash_order_usecase.dart';
import 'checkout_states.dart';

@injectable
class CheckoutCubit extends Cubit<CheckoutState> {
  final CreateCashOrderUsecase createCashOrderUsecase;
  final CheckoutSessionUsecase checkoutSessionUsecase;

  CheckoutCubit({
    required this.createCashOrderUsecase,
    required this.checkoutSessionUsecase,
  }) : super(CheckoutInitial());

  Future<void> placeOrder({
    required String paymentMethod,
    required Address address,
  }) async {
    emit(CheckoutLoading());
    try {
      final request = CashOrderRequestDTO(
        street: address.street,
        phone: address.phone,
        city: address.city,
        lat: address.lat,
        long: address.long,
      );

      if (paymentMethod == "Cash on delivery") {
        final response = await createCashOrderUsecase.executeCreateCashOrder(
          CashOrderRequest(shippingAddress: request),
        );
        final message = response.message;
        emit(CheckoutCashSuccess(message));
      } else {
        final request = ShippingAddress(
          street: address.street,
          phone: address.phone,
          city: address.city,
          lat: address.lat,
          long: address.long,
        );

        final response = await checkoutSessionUsecase.executeCheckoutSession(
          CheckoutRequest(shippingAddress: request),
        );

        emit(CheckoutCardSuccess(response.url ?? ""));
      }
    } catch (e) {
      emit(CheckoutError(e.toString()));
    }
  }
}
