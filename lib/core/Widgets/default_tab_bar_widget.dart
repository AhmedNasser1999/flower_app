import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class DefaultTabBarWidget extends StatelessWidget {
  final List<String> tabs;
  final Function(String)? onTabSelected;

  const DefaultTabBarWidget({
    super.key,
    required this.tabs,
    this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: TabBar(
        isScrollable: true,
        labelColor: AppColors.pink,
        unselectedLabelColor: AppColors.grey,
        indicatorColor: AppColors.pink,
        indicatorWeight: 4.5,
        onTap: (index) {
          if (onTabSelected != null) {
            onTabSelected!(tabs[index]);
          }
        },
        tabs: tabs.map((name) => Tab(text: name)).toList(),
      ),
    );
  }
}
