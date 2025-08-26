import 'package:flower_app/core/extensions/extensions.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/Widgets/custom_text_field.dart';
import '../../../../core/Widgets/products_card.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 78),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (_) => null,
                )

              ),
              const SizedBox(width: 8),
              Container(
                width: 64,
                height: 59,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent,
                  border: Border.all(color: AppColors.grey, width: 0.9),
                ),
                child: GestureDetector(
                  child: Image.asset("assets/icons/filter-Icon.png"),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return ProductCard(
                  productImg: '',
                  productPrice: 100,
                  productPriceDiscount: 50,
                  priceDiscount: 50,
                  productTitle: 'title $index',
                );
              },
            ),
          ),
        ],
      ).setHorizontalPadding(context, 0.04),
    );
  }
}
