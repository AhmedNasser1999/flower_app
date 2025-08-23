import 'package:flower_app/core/config/di.dart';
import 'package:flower_app/core/contants/secure_storage.dart';
import 'package:flutter/material.dart';
import 'core/l10n/translation/app_localizations.dart';
import 'core/routes/on_generate_route.dart';
import 'core/routes/route_names.dart';
import 'features/auth/domain/services/auth_service.dart';
import 'features/auth/domain/services/guest_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SecureStorage.initialize();

  final initialRoute = await _getInitialRoute();
  await configureDependencies();
  await Future.delayed(Duration(milliseconds: 100)); // Add a small delay
  runApp(MyApp());
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
//  final String initialRoute;

//  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.signUp,
      onGenerateRoute: Routes.onGenerateRoute,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale("en"),
    );
  }
}
