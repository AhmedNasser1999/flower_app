import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String icon;
  final String title;

  const CategoryWidget({
    super.key,
    required this.onTap,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10.0,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            width: 68.0,
            height: 68.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: AppColors.lightPink,
            ),
            child: (icon.isNotEmpty)
                ? Image.network(
                    icon,
                    width: 25,
                    height: 28,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.broken_image,
                        size: 26,
                        color: Colors.grey),
                  )
                : const Icon(Icons.image_not_supported,
                    size: 22, color: Colors.grey),
          ),
        ),
        SizedBox(
          width: 68.0,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: "Inter",
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
