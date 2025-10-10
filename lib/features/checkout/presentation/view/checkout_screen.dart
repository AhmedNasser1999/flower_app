import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../../../../core/common/widgets/custom_snackbar_widget.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../address/presentation/view_model/address_cubit.dart';
import '../viewmodel/checkout_cubit.dart';
import '../viewmodel/checkout_states.dart';
import '../widgets/checkout_header.dart';
import '../widgets/delivery_addres.dart';
import '../widgets/delivery_time.dart';
import '../widgets/gift_widget.dart';
import '../widgets/payment_web_view.dart';
import '../widgets/payment_widget.dart';
import '../widgets/summery_widget.dart';

class CheckoutScreen extends StatefulWidget {
  final int subTotal;
  const CheckoutScreen({super.key, required this.subTotal});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedPayment = "Cash on delivery";
  bool _enabledGift = true;

  final TextEditingController giftNameController = TextEditingController();
  final TextEditingController giftPhoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AddressCubit>().getAddresses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: BlocConsumer<CheckoutCubit, CheckoutState>(
          listener: (context, state) {
            if (state is CheckoutLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => const Center(
                    child: SizedBox(
                  height: 50,
                  width: 50,
                  child: LoadingIndicator(
                    indicatorType: Indicator.lineScalePulseOut,
                    colors: [AppColors.pink],
                    strokeWidth: 2,
                    backgroundColor: Colors.transparent,
                  ),
                )),
              );
            } else if (state is CheckoutCashSuccess) {
              Navigator.pop(context);
              showCustomSnackBar(context, "Order placed ${state.message}fully",
                  isError: false);
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.dashboard, (route) => false);
            } else if (state is CheckoutCardSuccess) {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PaymentWebViewScreen(url: state.url),
                ),
              );
              showCustomSnackBar(context, "Credit card session created",
                  isError: false);
            } else if (state is CheckoutError) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
              showCustomSnackBar(context, state.message, isError: true);
            }
          },
          builder: (context, checkoutState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const CheckoutHeader(),
                  const SizedBox(height: 16),
                  const DeliveryTimeSection(),
                  const SizedBox(height: 25),
                  const Divider(thickness: 24, color: Color(0xffEAEAEA)),
                  const SizedBox(height: 25),
                  const DeliveryAddressSection(),
                  const SizedBox(height: 30),
                  const Divider(thickness: 24, color: Color(0xffEAEAEA)),
                  const SizedBox(height: 20),
                  PaymentSection(
                    selectedPayment: selectedPayment,
                    onChanged: (val) => setState(() => selectedPayment = val),
                  ),
                  if (selectedPayment == "Credit card")
                    GiftSection(
                      enabled: _enabledGift,
                      onChanged: (val) => setState(() => _enabledGift = val),
                      giftNameController: giftNameController,
                      giftPhoneController: giftPhoneController,
                    ),
                  const SizedBox(height: 30),
                  const Divider(thickness: 24, color: Color(0xffEAEAEA)),
                  const SizedBox(height: 30),
                  SummarySection(
                    checkoutState: checkoutState,
                    selectedPayment: selectedPayment,
                    subTotal: widget.subTotal,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
