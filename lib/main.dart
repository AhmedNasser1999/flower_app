import 'package:flower_app/core/contants/secure_storage.dart';
import 'package:flutter/material.dart';
import 'core/config/di.dart';
import 'core/l10n/translation/app_localizations.dart';
import 'core/routes/on_generate_route.dart';
import 'core/routes/route_names.dart';
import 'features/auth/domain/services/auth_service.dart';
import 'features/auth/domain/services/guest_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await SecureStorage.initialize();

  final initialRoute = await _getInitialRoute();

  runApp(MyApp(initialRoute: initialRoute));
}

Future<String> _getInitialRoute() async {
  final isLoggedIn = await AuthService.isLoggedIn();
  final isGuest = await GuestService.isGuest();

  if (isLoggedIn) {
    return AppRoutes.dashboard;
  } else if (isGuest) {
    return AppRoutes.dashboard;
  } else {
    return AppRoutes.login;
  }
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      onGenerateRoute: Routes.onGenerateRoute,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale("en"),
    );
  }
}