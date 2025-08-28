import 'package:flower_app/features/home_screen/presentation/widgets/category_widget.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  final VoidCallback onTap;
  final String icon;
  final String title;
  const CategoryList(
      {super.key,
      required this.onTap,
      required this.icon,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => CategoryWidget(
          onTap: onTap,
          icon: icon,
          title: title,
        ),
        separatorBuilder: (context, index) => SizedBox(width: 16.0),
        itemCount: 20,
      ),
    );
  }
}
