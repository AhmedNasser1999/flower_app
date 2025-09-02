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
              context.read<LocalizationCubit>().changeLanguage();
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
