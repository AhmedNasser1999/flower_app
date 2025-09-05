import 'package:flower_app/core/Widgets/Custom_Elevated_Button.dart';
import 'package:flower_app/core/l10n/translation/app_localizations.dart';
import 'package:flower_app/core/routes/route_names.dart';
import 'package:flower_app/features/auth/domain/services/auth_service.dart';
import 'package:flower_app/features/auth/domain/services/guest_service.dart';
import 'package:flower_app/features/dashboard/presentation/cubits/nav_bar_cubit.dart';
import 'package:flower_app/features/dashboard/presentation/widgets/custom_nav_bar_widget.dart';
import 'package:flower_app/features/localization/localization_controller/localization_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      Center(child: Text("home")),
      Center(child: Text("categories")),
      Center(child: Text("cart")),
      Column(
        spacing: 20.0,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: CustomElevatedButton(
              text: AppLocalizations.of(context)!.logout,
              onPressed: () async {
                await AuthService.logout();
                await GuestService.endGuestSession();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.login,
                  (route) => false,
                );
              },
            ),
          ),
          CustomElevatedButton(
            text: 'Change language',
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        spacing: 16.0,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Change Language',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pink,
                                ),
                          ),
                          Card(
                            child: SizedBox(
                              height: 60,
                              width: double.infinity,
                              child: InkWell(
                                onTap: () {
                                  context
                                      .read<LocalizationCubit>()
                                      .selectLanguage(
                                        "Arabic",
                                      );
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  children: [
                                    const SizedBox(width: 16),
                                    Icon(
                                      context
                                              .read<LocalizationCubit>()
                                              .isSelected("Arabic")
                                          ? Icons.radio_button_checked
                                          : Icons.radio_button_unchecked,
                                      color: Colors.pink,
                                    ),
                                    const Spacer(),
                                    Text(
                                      'Arabic',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    const SizedBox(width: 16),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            child: SizedBox(
                              height: 60,
                              width: double.infinity,
                              child: InkWell(
                                onTap: () {
                                  context
                                      .read<LocalizationCubit>()
                                      .selectLanguage(
                                        "English",
                                      );
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  children: [
                                    const SizedBox(width: 16),
                                    Icon(
                                      context
                                              .read<LocalizationCubit>()
                                              .isSelected("English")
                                          ? Icons.radio_button_checked
                                          : Icons.radio_button_unchecked,
                                      color: Colors.pink,
                                    ),
                                    const Spacer(),
                                    Text(
                                      'English',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    const SizedBox(width: 16),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    ];

    return BlocProvider(
      create: (context) => NavBarCubit()..changeTab(0),
      child: Builder(
        builder: (context) {
          return BlocBuilder<NavBarCubit, NavBarState>(
            builder: (context, state) {
              return Scaffold(
                backgroundColor: Colors.white,
                body: screens[state.selectedIndex],
                bottomNavigationBar: SizedBox(
                  height: 80,
                  child: CustomBottomNavBarWidget(
                    currentIndex: state.selectedIndex,
                    onTap: (index) {
                      context.read<NavBarCubit>().changeTab(index);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
