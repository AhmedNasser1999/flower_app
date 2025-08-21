import 'package:flower_app/core/Widgets/Custom_Elevated_Button.dart';
import 'package:flower_app/core/routes/route_names.dart';
import 'package:flower_app/features/auth/domain/services/auth_service.dart';
import 'package:flower_app/features/dashboard/presentation/cubits/nav_bar_cubit.dart';
import 'package:flower_app/features/dashboard/presentation/widgets/custom_nav_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatelessWidget {
   DashboardScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens =  [
      Center( child: Text("home")),
      Center(child: Text("categories")),
      Center(child: Text("cart")),
      Center(child: CustomElevatedButton(text: "Logout", onPressed: ()async{
        await AuthService.logout();
        Navigator.pushNamed(context, AppRoutes.login);

      })),
    ];

    return BlocProvider(
      create: (context) => NavBarCubit()..changeTab(0),
      child: Builder(
        builder: (context) {
          return BlocBuilder<NavBarCubit, NavBarState>(
            builder: (context, state) {
              return Scaffold(
                backgroundColor: Colors.white,
                body: _screens[state.selectedIndex],
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
