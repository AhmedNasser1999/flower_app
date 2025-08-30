import 'package:flower_app/features/home_screen/presentation/widgets/product_item.dart';
import 'package:flower_app/features/most_selling_products/domain/entity/products_entity.dart';
import 'package:flutter/material.dart';

class BestSellerList extends StatelessWidget {
  final List<ProductsEntity> productList;
  const BestSellerList({super.key, required this.productList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => ProductItem(
          image: productList[index].imgCover,
          name: productList[index].title,
          price: productList[index].price,
        ),
        separatorBuilder: (context, index) => SizedBox(width: 16.0),
        itemCount: productList.length,
      ),
    );
  }
}
