import 'package:flower_app/features/home/presentation/view/widgets/product_item.dart';
import 'package:flutter/material.dart';

class OccasionList extends StatelessWidget {
  final String image;
  final String name;
  final int price;
  const OccasionList(
      {super.key,
      required this.image,
      required this.name,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => ProductItem(
          image: image,
          name: name,
          price: price,
        ),
        separatorBuilder: (context, index) => SizedBox(width: 16.0),
        itemCount: 20,
      ),
    );
  }
}
