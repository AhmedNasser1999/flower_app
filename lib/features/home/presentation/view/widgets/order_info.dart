import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo({super.key, required this.address});

  final String address;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5.0,
      children: [
        Icon(
          Icons.location_on_outlined,
        ),
        Expanded(
          child: Text(
            address,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
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
