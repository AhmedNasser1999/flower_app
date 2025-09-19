import 'package:flower_app/core/extensions/extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class PaymentSection extends StatelessWidget {
  final String selectedPayment;
  final ValueChanged<String> onChanged;

  const PaymentSection(
      {super.key, required this.selectedPayment, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _paymentOption(context, "Cash on delivery"),
        const SizedBox(height: 10),
        _paymentOption(context, "Credit card"),
      ],
    );
  }

  Widget _paymentOption(BuildContext context, String value) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        width: size.width * 0.9,
        height: size.height * 0.07,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)
          ],
          color: AppColors.white,
        ),
        child: Row(
          children: [
            Expanded(child: Text(value)),
            Radio<String>(
              value: value,
              groupValue: selectedPayment,
              activeColor: AppColors.pink,
              onChanged: (val) => onChanged(val!),
            ),
          ],
        ).setHorizontalPadding(context, 0.025),
      ),
    );
  }
}
