import 'package:flutter/material.dart';

import '../../../../categories/domain/entity/category_entity.dart';
import 'category_widget.dart';

class CategoryList extends StatelessWidget {
  final List<Category> categories;
  final VoidCallback onTap;
  const CategoryList(
      {super.key, required this.categories, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => CategoryWidget(
          onTap: onTap,
          icon: categories[index].image!,
          title: categories[index].name,
        ),
        separatorBuilder: (context, index) => SizedBox(width: 16.0),
        itemCount: categories.length,
      ),
    );
    
  }
}
