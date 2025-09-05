import 'package:flower_app/core/config/di.dart';
import 'package:flower_app/core/contants/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/config/di.dart';
import 'core/l10n/translation/app_localizations.dart';
import 'core/routes/on_generate_route.dart';
import 'core/routes/route_names.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/domain/services/auth_service.dart';
import 'features/auth/domain/services/guest_service.dart';
import 'features/localization/data/localization_preference.dart';
import 'features/localization/localization_controller/localization_cubit.dart';
import 'features/localization/localization_controller/localization_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  String languageValue = await LocalizationPreference.getLanguage();
  await SecureStorage.initialize();

  final initialRoute = await _getInitialRoute();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<LocalizationCubit>(
        create: (BuildContext context) =>
            LocalizationCubit(language: languageValue),
      ),
    ],
    child: MyApp(
      initialRoute: initialRoute,
    ),
  ));
}

Future<String> _getInitialRoute() async {
  final isLoggedIn = await AuthService.isLoggedIn();
  final isGuest = await GuestService.isGuest();

  if (isLoggedIn) {
    return AppRoutes.dashboard;
  }
  else if (isGuest) {
    return AppRoutes.dashboard;
  }
  else {
    return AppRoutes.login;
  }
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
      builder: (context, state) {
        final cubit = context.read<LocalizationCubit>();

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: initialRoute,
          onGenerateRoute: Routes.onGenerateRoute,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: cubit.language == "en" ? const Locale("en") : const Locale("ar"),
        );
      },
    );
  }
}