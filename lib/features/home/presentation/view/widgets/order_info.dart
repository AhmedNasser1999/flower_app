import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5.0,
      children: [
        Icon(
          Icons.location_on_outlined,
        ),
        Text(
          'Deliver to 2XVP+XC - Sheikh Zayed',
          style: TextStyle(fontFamily: "Inter" ,fontSize: 14, fontWeight: FontWeight.w500)
        ),
        Icon(
          Icons.keyboard_arrow_down_outlined,
          size: 35,
          color: AppColors.pink,
        )
      ],
    );
  }
}
