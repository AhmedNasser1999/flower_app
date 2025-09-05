import 'package:flower_app/core/Widgets/Custom_Elevated_Button.dart';
import 'package:flower_app/core/routes/route_names.dart';
import 'package:flower_app/features/auth/domain/services/auth_service.dart';
import 'package:flower_app/features/auth/domain/services/guest_service.dart';
import 'package:flower_app/features/dashboard/presentation/cubits/nav_bar_cubit.dart';
import 'package:flower_app/features/dashboard/presentation/widgets/custom_nav_bar_widget.dart';
import 'package:flower_app/features/home/presentation/view/home_screen.dart';
import 'package:flower_app/features/most_selling_products/presentation/viewmodel/most_selling_products_viewmodel.dart';
import 'package:flower_app/features/profile/presentation/view/profile_screen.dart';
import 'package:flower_app/features/profile/presentation/viewmodel/profile_viewmodel.dart';

import '../../../../core/config/di.dart';
import '../../../categories/presentation/view/categories_screen.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const HomeScreen(),

      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
            getIt<MostSellingProductsViewmodel>()..getMostSellingProducts(),
          ),
          BlocProvider(
            create: (context) => getIt<CategoriesCubit>()..getAllCategories(),
          ),
        ],
        child: const CategoriesScreen(),
      ),

      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomElevatedButton(
              text: "Change Password",
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.changePasswordScreen);
              },
            ),
            const SizedBox(height: 20),
            CustomElevatedButton(
              text: "Logout",
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
          ],
        ),
      ),

      BlocProvider(
        create: (_) => getIt<ProfileViewModel>()..getProfile(),
        child: const ProfileScreen(),
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
