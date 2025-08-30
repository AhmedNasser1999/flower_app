import 'package:flower_app/features/categories/domain/entities/category_entity.dart';
import 'package:flower_app/features/home_screen/presentation/widgets/category_widget.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  final List<CategoryEntity> categories;
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
          icon: categories[index].catImage!,
          title: categories[index].catName,
        ),
        separatorBuilder: (context, index) => SizedBox(width: 16.0),
        itemCount: categories.length,
      ),
    );
    
  }
}
