import 'package:flower_app/core/Widgets/delivery_address_card.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 30,
                      ),
                    ),
                    Text(
                      'Checkout',
                      style: Theme.of(context).textTheme.headlineMedium,
                    )
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Delivery time',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      'Schedule',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.pink),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                const Row(
                  spacing: 5,
                  children: [
                    Icon(Icons.alarm),
                    Text('Instant'),
                    Text(
                      'Arrive by 03 Sep 2024, 11:00 AM',
                      style: TextStyle(color: Color(0xff51B063)),
                    ),
                  ],
                ),
                const SizedBox(height: 25.0),
                const Divider(
                  thickness: 24,
                  color: Color(0xffEAEAEA),
                ),
                const SizedBox(height: 25.0),
                Row(
                  children: [
                    Text(
                      'Delivery address',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
                DeliveryAddressCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
