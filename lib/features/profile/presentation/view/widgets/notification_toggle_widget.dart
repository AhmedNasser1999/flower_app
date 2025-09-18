import 'package:flutter/material.dart';

import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../core/routes/route_names.dart';

class NotificationToggleWidget extends StatefulWidget {
  const NotificationToggleWidget({super.key});

  @override
  State<NotificationToggleWidget> createState() =>
      _NotificationToggleWidgetState();
}

class _NotificationToggleWidgetState extends State<NotificationToggleWidget> {
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context)!;
    return ListTile(
      leading: Switch(
        value: _enabled,
        onChanged: (val) {
          setState(() {
            _enabled = val;
          });
        },
        thumbColor: MaterialStateProperty.all(Colors.white),
        activeTrackColor: Colors.pink,
        inactiveThumbColor: Colors.white,
        inactiveTrackColor: Colors.grey.shade400,
      ),
      title: Text(
        local.notification,
        style: theme.textTheme.bodyMedium,
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 20),
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.notification);
      },
    );
  }
}
