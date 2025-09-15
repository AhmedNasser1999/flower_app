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
    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => ProductItem(
          image: occasionList[index].image,
          name: occasionList[index].name,
          isOccasion: true,
          price: 0,
          onTap: onTap != null ? () => onTap!(occasionList[index]) : null,
        ),
        separatorBuilder: (context, index) => SizedBox(width: 16.0),
        itemCount: occasionList.length,
      ),
    );
  }
}
