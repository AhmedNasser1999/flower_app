import 'package:flutter/material.dart';

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
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Icon(
          Icons.keyboard_arrow_down_outlined,
          size: 35,
        )
      ],
    );
  }
}
