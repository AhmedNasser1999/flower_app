import 'dart:async';
import 'package:flower_app/core/contants/app_images.dart';
import 'package:flutter/material.dart';
import '../../../core/routes/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../auth/domain/services/auth_service.dart';
import '../../auth/domain/services/guest_service.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigateToInitial();
  }

  Future<void> _navigateToInitial() async {
    await Future.delayed(const Duration(seconds: 2));

    final route = await _getInitialRoute();

    if (!mounted) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      route,
          (r) => false,
    );
  }

  Future<String> _getInitialRoute() async {
    final isLoggedIn = await AuthService.isLoggedIn();
    final isUserIdSaved = await AuthService.getUserId();
    final isGuest = await GuestService.isGuest();

    if (isLoggedIn && isUserIdSaved != null) {
      return AppRoutes.dashboard;
    } else if (isGuest) {
      return AppRoutes.dashboard;
    } else {
      return AppRoutes.login;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPink,
      body: Center(
        child: SizedBox(
          height: 350,
          width: 350,
          child: Image.asset(AppImages.splashLogo),
        ),
      ),
    );
  }
}