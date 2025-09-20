import 'package:flower_app/features/home/presentation/view/widgets/product_item.dart';
import 'package:flower_app/features/occasion/domain/entity/occasion_entity.dart';
import 'package:flutter/material.dart';

class OccasionList extends StatelessWidget {
  final List<OccasionEntity> occasionList;
  final Function(OccasionEntity)? onTap;
  const OccasionList({
    super.key,
    required this.occasionList,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final imagesList = [
      "assets/images/wedding.png",
      "assets/images/graduation.png",
      "assets/images/birthday.png",
      "assets/images/anniversay.jpg",
      "assets/images/newyear.jpg",
      "assets/images/valantainesday.jpg",
      "assets/images/mothersday.jpeg",
      "assets/images/fatherday.jpg",
      "assets/images/chrism.jpg",
      "assets/images/esterday.jpg",
    ];
    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final imagePath = index < imagesList.length
              ? imagesList[index]
              : "assets/images/default.png";
          return ProductItem(
            image: imagePath,
            name: occasionList[index].name,
            isOccasion: true,
            price: 0,
            onTap: onTap != null ? () => onTap!(occasionList[index]) : null,
            quantity: occasionList[index].productsCount,
          );
        },
        separatorBuilder: (context, index) => SizedBox(width: 16.0),
        itemCount: occasionList.length,
      ),
    );
  }
}
