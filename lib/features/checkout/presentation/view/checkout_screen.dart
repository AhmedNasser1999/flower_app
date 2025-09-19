import 'package:flower_app/core/Widgets/delivery_address_card.dart';
import 'package:flower_app/core/extensions/extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
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
                      size: 25,
                    ),
                  ),
                  Text(
                    'Checkout',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        fontFamily: "Janna",
                        color: AppColors.black),
                  )
                ],
              ).setHorizontalPadding(context, 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Delivery time',
                    style: TextStyle(color: AppColors.black, fontSize: 18, fontFamily: "Janna", fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Schedule',
                    style: TextStyle(color: AppColors.pink, fontSize: 18, fontFamily: "Janna", fontWeight: FontWeight.w500),

                  )
                ],
              ).setHorizontalPadding(context, 0.04),
              const SizedBox(height: 16),
              const Row(
                spacing: 5,
                children: [
                  Icon(Icons.access_time),
                  Text('Instant,', style: TextStyle(fontFamily: "Janna", fontWeight: FontWeight.w400, fontSize: 16),),
                  Text("Arrive by 03 Sep 2024, 11:00 AM",
                    style: TextStyle(color: Color(0xff51B063), fontFamily: "Janna", fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ],
              ).setHorizontalPadding(context, 0.04),
              const SizedBox(height: 25.0),
              const Divider(
                thickness: 24,
                color: Color(0xffEAEAEA),
              ),
              const SizedBox(height: 25.0),
              Row(
                children: [
                  Text(
                    textAlign: TextAlign.left,
                    'Delivery address',
                    style: TextStyle(color: AppColors.black, fontSize: 18, fontFamily: "Janna", fontWeight: FontWeight.w500),
                  ),
                ],
              ).setHorizontalPadding(context, 0.04),
              const SizedBox(height: 10.0),
              DeliveryAddressCard(),setHorizontalPadding(context, 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
