import 'package:flutter/material.dart';
import '../../../../categories/data/models/category_model.dart';
import 'category_widget.dart';

class CategoryList extends StatelessWidget {
  final List<Categories> categories;
  final Function(Categories) onTap;

  const CategoryList({
    super.key,
    required this.categories,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final category = categories[index];
          return CategoryWidget(
            onTap: () => onTap(category),
            icon: category.image ?? "",
            title: category.name ?? "",
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 16.0),
        itemCount: categories.length,
      ),
    );
  }
}
