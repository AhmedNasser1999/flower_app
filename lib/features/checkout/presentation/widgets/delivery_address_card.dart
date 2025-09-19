import 'package:flower_app/core/extensions/extensions.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DeliveryAddressCard extends StatefulWidget {
  final String title;
  const DeliveryAddressCard({super.key, required this.title});

  @override
  State<DeliveryAddressCard> createState() => _DeliveryAddressCardState();
}

class _DeliveryAddressCardState extends State<DeliveryAddressCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      height: size.height * 0.1,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Radio<bool>(
                    value: true,
                    groupValue: isSelected,
                    activeColor: AppColors.pink,
                    onChanged: (value) {
                      setState(() {
                        isSelected = value!;
                      });
                    },
                  ),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.black,
                      fontFamily: "Janna",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Text(
                "2XVP+XC - Sheikh Zayed",
                style: const TextStyle(
                  color: AppColors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Janna",
                ),
              ).setHorizontalPadding(context, 0.035)
            ],
          ),
          const SizedBox(width: 130,),
          GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.edit,
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
