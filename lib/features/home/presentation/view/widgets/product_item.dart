import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String image;
  final String name;
  final int price;
  final bool isOccasion;
  final VoidCallback? onTap;
  const ProductItem(
      {super.key,
      required this.image,
      required this.name,
      required this.price,
      this.isOccasion = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
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
              child: Image.network(
                image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 150,
                    color: Colors.grey[300],
                    child: Icon(Icons.error_outline, color: Colors.red),
                  );
                },
              ),
            ),
          SizedBox(height: 8.0),
          Expanded(
            child: Text(
              name,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 4.0),
          isOccasion
              ? Text('')
              : Expanded(
                  child: Text(
                    '$price LE',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
        ],
      ),
    ),
    );
  }
}
