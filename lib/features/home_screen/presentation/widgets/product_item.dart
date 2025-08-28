import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  const ProductItem({super.key, required this.image, required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 131,
          height: 151,
          child: Image.asset(
            image,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[300],
                child: Icon(Icons.error_outline, color: Colors.red),
              );
            },
          ),
        ),
        SizedBox(height: 8.0),
        Text(
         name,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          price,
          style: TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
