import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DefaultTabBarWidget extends StatelessWidget {
  //final List<String> tabs;
  // final TabController? controller;
  // final Function(String)? onTabSelected;

  const DefaultTabBarWidget({
    super.key,
   // required this.tabs,
    // this.controller,
    // this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TabBar(
            //controller: controller,
            isScrollable: true,
            labelColor: AppColors.pink,
            unselectedLabelColor: AppColors.grey,
            indicatorColor: AppColors.pink,
            indicatorWeight: 4.5,
            padding: EdgeInsets.zero,
            tabAlignment: TabAlignment.start,
            // onTap: (index) {
            //   if (onTabSelected != null) {
            //     onTabSelected!(tabs[index]);
            //   }
            //},
            tabs: [
              Tab(text: "All",),
              Tab(text: "All",),
              Tab(text: "All",),
              Tab(text: "All",),
              Tab(text: "All",),
              Tab(text: "All",),
              Tab(text: "All",),
              Tab(text: "All",),
              Tab(text: "All",),
            ],
          ),
        ],
      ),
    );
  }
}
