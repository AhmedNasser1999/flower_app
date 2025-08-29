import 'package:flower_app/core/Widgets/Custom_Elevated_Button.dart';
import 'package:flower_app/core/config/di.dart';
import 'package:flower_app/core/routes/route_names.dart';
import 'package:flower_app/features/auth/domain/services/auth_service.dart';
import 'package:flower_app/features/auth/domain/services/guest_service.dart';
import 'package:flower_app/features/categories/presentation/viewmodel/categories_viewmodel.dart';
import 'package:flower_app/features/dashboard/presentation/cubits/nav_bar_cubit.dart';
import 'package:flower_app/features/dashboard/presentation/widgets/custom_nav_bar_widget.dart';
import 'package:flower_app/features/most_selling_products/presentation/viewmodel/most_selling_products_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/di.dart';
import '../../../categories/presentation/view/categories_screen.dart';
import '../../../most_selling_products/presentation/viewmodel/most_selling_products_viewmodel.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      Center(child: Text("home")),
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
            getIt<MostSellingProductsViewmodel>()..getMostSellingProducts(),
          ),
          BlocProvider(
            create: (context) =>
            getIt<CategoriesCubit>()..getAllCategories(),
          ),
        ],
        child: const CategoriesScreen(),
      ),
      Center(child: Text("cart")),
      Center(
          child: CustomElevatedButton(
              text: "Logout",
              onPressed: () async {
                await AuthService.logout();
                await GuestService.endGuestSession();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.login,
                  (route) => false,
                );
              })),
    ];

    return BlocProvider(
      create: (context) => NavBarCubit()..changeTab(0),
      child: Builder(
        builder: (context) {
          return BlocBuilder<NavBarCubit, NavBarState>(
            builder: (context, state) {
              return Scaffold(
                floatingActionButton: FloatingActionButton(onPressed: (){
                  Navigator.pushNamed(context, AppRoutes.occasions);
                }),
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
