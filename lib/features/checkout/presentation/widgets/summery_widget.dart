import 'package:flower_app/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/Widgets/Custom_Elevated_Button.dart';
import '../../../../core/l10n/translation/app_localizations.dart';
import '../../../address/presentation/view_model/address_cubit.dart';
import '../viewmodel/checkout_cubit.dart';
import '../viewmodel/checkout_states.dart';

class SummarySection extends StatelessWidget {
  final int subTotal;
  final CheckoutState checkoutState;
  final String selectedPayment;

  const SummarySection(
      {super.key,
      required this.checkoutState,
      required this.selectedPayment,
      required this.subTotal});

  @override
  Widget build(BuildContext context) {
    final int deliveryFee = 22;
    final local = AppLocalizations.of(context)!;
    return Column(
      children: [
        _row(local.subTotal, "${local.egp}  $subTotal"),
        const SizedBox(height: 10),
        _row(local.deliveryFee, "${local.egp} $deliveryFee"),
        const Divider(thickness: 1),
        _row(local.total, "${local.egp}  ${subTotal + deliveryFee}",
            isTotal: true),
        const SizedBox(height: 40),
        BlocBuilder<AddressCubit, AddressState>(
          builder: (context, addressState) {
            return CustomElevatedButton(
              text: checkoutState is CheckoutLoading
                  ? "Placing..."
                  : "Place order",
              onPressed: checkoutState is CheckoutLoading
                  ? null
                  : () {
                      final addressCubit = context.read<AddressCubit>();
                      final checkoutCubit = context.read<CheckoutCubit>();
                      final selected = addressCubit.selectedAddress;

                      if (selected == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Please select address")),
                        );
                        return;
                      }
                      checkoutCubit.placeOrder(
                          paymentMethod: selectedPayment, address: selected);
                    },
            );
          },
        ),
      ],
    ).setHorizontalPadding(context, 0.045);
  }

  Widget _row(String label, String value, {bool isTotal = false}) {
    return Row(
      children: [
        Text(label,
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: isTotal ? 20 : 16)),
        const Spacer(),
        Text(value,
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: isTotal ? 20 : 16)),
      ],
    );
  }
}
