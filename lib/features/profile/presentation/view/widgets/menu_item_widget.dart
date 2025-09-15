import 'package:flutter/material.dart';

class MenuItemWidget extends StatelessWidget {
  final Widget? leading;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  const MenuItemWidget({
    super.key,
    this.leading,
    required this.title,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: leading,
      title: Text(
        title,
        style: theme.textTheme.bodyMedium,
      ),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 20),
      onTap: onTap,
    );
  }
}
