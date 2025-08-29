import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

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
      child: Column(
        children: [
          TabBar(
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            labelColor: AppColors.pink,
            unselectedLabelColor: AppColors.grey,
            labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            unselectedLabelStyle: const TextStyle(fontSize: 15),
            dividerColor: Colors.transparent,
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(width: 3.5, color: AppColors.pink),
              insets: EdgeInsets.symmetric(horizontal: 12),
            ),
            onTap: (index) {
              if (onTabSelected != null) {
                onTabSelected!(tabs[index]);
              }
            },
            tabs: tabs.map((t) => Tab(text: t)).toList(),
          ),
        ],
      ),
    );
  }
}
