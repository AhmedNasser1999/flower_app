import 'package:flower_app/core/extensions/extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/Widgets/Custom_Elevated_Button.dart';
import '../../../../core/theme/app_colors.dart';

class OrderCard extends StatelessWidget {
  final String title;
  final String price;
  final String subtitle;
  final String buttonText;
  final VoidCallback onPressed;

  const OrderCard({
    super.key,
    this.title = "Red Roses",
    this.price = "EGP 600",
    this.subtitle = "Order number# 123456",
    this.buttonText = "Track Order",
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.grey.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              "assets/images/Image1.png",
              width: 130,
              height: 130,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14, color: AppColors.grey),
                ),
                const SizedBox(height: 8),
                CustomElevatedButton(
                  text: buttonText,
                  onPressed: onPressed,
                  textColor: AppColors.white,
                  height: 50,
                  width: double.infinity, // fills remaining width
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

