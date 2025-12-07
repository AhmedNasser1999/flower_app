import 'package:flower_app/core/extensions/extensions.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../address/data/models/address.dart';
import '../../../address/presentation/views/add_address_screen.dart';

class DeliveryAddressCard extends StatelessWidget {
  final Address address;
  final bool isSelected;
  final VoidCallback onSelect;

  const DeliveryAddressCard({
    super.key,
    required this.isSelected,
    required this.onSelect,
    required this.address,
  });

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
                  Radio<String>(
                    value: address.id,
                    groupValue: isSelected ? address.id : null,
                    activeColor: AppColors.pink,
                    onChanged: (_) => onSelect(),
                  ),
                  Text(
                    "${address.recipientName}",
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
                "${address.lat} - ${address.city}",
                style: const TextStyle(
                  color: AppColors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Janna",
                ),
              ).setHorizontalPadding(context, 0.035)
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AddAddressScreen(addressToEdit: address),
                ),
              );
            },
            child: const Icon(
              Icons.mode_edit_outline_outlined,
              color: AppColors.grey,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}
