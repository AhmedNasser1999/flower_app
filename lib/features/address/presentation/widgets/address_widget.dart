import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/contants/app_icons.dart';

class AddressWidget extends StatelessWidget {
  const AddressWidget({
    super.key,
    required this.city,
    required this.street,
    required this.onDelete,
    required this.onEdit,
  });

  final String city;
  final String street;
  final void Function()? onDelete;
  final void Function()? onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.2),
          width: 2,
          style: BorderStyle.solid,
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.location_on_outlined),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  city,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              InkWell(
                onTap: onDelete,
                child: SvgPicture.asset(
                  AppIcons.deleteIcon,
                  width: 28,
                  height: 28,
                ),
              ),
              const SizedBox(width: 12),
              InkWell(
                onTap: onEdit,
                child: const Icon(Icons.mode_edit_outline_outlined, size: 26),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            street,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
