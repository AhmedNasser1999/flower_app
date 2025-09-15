import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String image;
  final String name;
  final int price;
  final bool isOccasion;
  final VoidCallback? onTap;

  const ProductItem({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    this.isOccasion = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isAsset = image.startsWith("assets/");

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 200,
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 150,
              child: isAsset
                  ? Image.asset(
                image,
                fit: BoxFit.cover,
                width: 150,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 150,
                    color: Colors.grey[300],
                    child: const Icon(Icons.error_outline,
                        color: Colors.red),
                  );
                },
              )
                  : Image.network(
                image,
                fit: BoxFit.cover,
                width: 150,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 150,
                    color: Colors.grey[300],
                    child: const Icon(Icons.error_outline,
                        color: Colors.red),
                  );
                },
              ),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: Text(
                name,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: "Inter",
                ),
              ),
            ),
            const SizedBox(height: 4.0),
            isOccasion
                ? const SizedBox.shrink()
                : Expanded(
              child: Text(
                '$price EGP',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Inter",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
