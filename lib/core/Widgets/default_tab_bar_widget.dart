import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DefaultTabBarWidget extends StatefulWidget {
  final List<String> tabs;
  final Function(String)? onTabSelected;
  final int initialIndex;

  const DefaultTabBarWidget({
    super.key,
    required this.tabs,
    this.onTabSelected,
    required this.initialIndex,
  });

  @override
  State<DefaultTabBarWidget> createState() => _DefaultTabBarWidgetState();
}

class _DefaultTabBarWidgetState extends State<DefaultTabBarWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  void _setupController({int? initialIndex}) {
    _tabController = TabController(
      length: widget.tabs.length,
      vsync: this,
      initialIndex: initialIndex ?? widget.initialIndex,
    );

    _tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) return;
    widget.onTabSelected?.call(widget.tabs[_tabController.index]);
  }

  @override
  void initState() {
    super.initState();
    _setupController();
  }

  @override
  void didUpdateWidget(covariant DefaultTabBarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.tabs.length != widget.tabs.length ||
        oldWidget.initialIndex != widget.initialIndex) {
      _tabController.removeListener(_handleTabChange);
      _tabController.dispose();

      final safeIndex =
          widget.initialIndex < widget.tabs.length ? widget.initialIndex : 0;

      _setupController(initialIndex: safeIndex);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: _tabController,
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
      tabs: widget.tabs.map((t) => Tab(text: t)).toList(),
    );
  }
}
