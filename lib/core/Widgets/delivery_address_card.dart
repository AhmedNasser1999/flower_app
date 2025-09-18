import 'package:flutter/material.dart';

class DeliveryAddressCard extends StatelessWidget {
  const DeliveryAddressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      height: 83.0,
      child: Card(
        child: Row(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Radio<String>(
                      value: 'home',
                    ),
                    Text('Home'),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
