import 'package:flutter/material.dart';
import 'package:flower_app/core/l10n/translation/app_localizations.dart';

class ProductItem extends StatelessWidget {
  final String image;
  final String name;
  final int price;
  final bool isOccasion;
  final VoidCallback? onTap;
  final int quantity;

  const ProductItem({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    this.isOccasion = false,
    this.onTap,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    final isAsset = image.startsWith("assets/");
    final isOutOfStock = quantity <= 0 && !isOccasion;
    final local = AppLocalizations.of(context);

    return GestureDetector(
      onTap: isOutOfStock ? null : onTap,
      child: SizedBox(
        height: 200,
        width: 150,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 150,
                  child: Stack(
                    children: [
                      isAsset
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
                      if (isOutOfStock)
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                local?.outOfStock ?? 'Out of Stock',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                Expanded(
                  child: Text(
                    name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Inter",
                      color: isOutOfStock ? Colors.grey[600] : Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 4.0),

                // Price
                isOccasion
                    ? const SizedBox.shrink()
                    : Expanded(
                        child: Text(
                          '$price EGP',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Inter",
                            color:
                                isOutOfStock ? Colors.grey[600] : Colors.black,
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
