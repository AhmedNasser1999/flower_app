
import 'package:flower_app/core/config/di.dart';
import 'package:flower_app/core/contants/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/l10n/translation/app_localizations.dart';
import 'core/routes/on_generate_route.dart';
import 'core/routes/route_names.dart';
import 'features/address/presentation/view_model/address_cubit.dart';
import 'features/localization/data/localization_preference.dart';
import 'features/localization/localization_controller/localization_cubit.dart';
import 'features/localization/localization_controller/localization_state.dart';
import 'features/cart/presentation/view_model/cart_cubit.dart';
import 'features/profile/presentation/viewmodel/profile_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  String languageValue = await LocalizationPreference.getLanguage();
  await SecureStorage.initialize();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ProfileViewModel>(
          create: (_) => getIt<ProfileViewModel>()..getProfile(),
        ),
        BlocProvider<LocalizationCubit>(
          create: (BuildContext context) =>
              LocalizationCubit(language: languageValue),
        ),
        BlocProvider<CartCubit>(
          create: (_) => getIt<CartCubit>()..getCart(),
        ),
        BlocProvider<AddressCubit>(
          create: (_) => getIt<AddressCubit>(),
        ),
      ],
      child: MyApp(
        initialRoute: AppRoutes.initial,
      ),
    ),
  );
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
          locale:
          cubit.language == "en" ? const Locale("en") : const Locale("ar"),
        );
      },
    );
  }
}