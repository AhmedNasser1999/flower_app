import 'package:flower_app/core/config/di.dart';
import 'package:flower_app/core/routes/route_names.dart';
import 'package:flower_app/features/auth/signup/cubit/signup_cubit.dart';
import 'package:flower_app/features/auth/signup/view/signup_screen.dart';
import 'package:flower_app/features/dashboard/presentation/views/dashboard_screen.dart';
import 'package:flower_app/features/profile/presentation/view/widgets/terms_and_conditions.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/forget_password/presentation/viewmodel/forget_password_viewmodel.dart';
import '../../features/auth/forget_password/presentation/viewmodel/reset_password_viewmodel.dart';
import '../../features/auth/forget_password/presentation/viewmodel/verify_code_viewmodel.dart';
import '../../features/auth/forget_password/presentation/views/screens/ResetPasswordScreen.dart';
import '../../features/auth/forget_password/presentation/views/screens/email_verificationScreen.dart';
import '../../features/auth/forget_password/presentation/views/screens/forgertPasswordScreen.dart';
import '../../features/auth/login/presentation/viewmodel/login_viewmodel.dart';
import '../../features/auth/login/presentation/view/login_screen.dart';
import '../../features/profile/change_password/presentation/viewmodel/change_password_viewmodel.dart';
import '../../features/profile/presentation/view/edit_profile_screen.dart';
import '../../features/profile/presentation/view/widgets/about_us.dart';
import '../../features/profile/change_password/presentation/views/screens/change_password_screen.dart';
import '../../features/profile/logout/views/logout_widget.dart';

class Routes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<LoginViewModel>(),
            child: const LoginScreen(),
          ),
        );

      case AppRoutes.signUp:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => getIt<SignupCubit>(),
              child: const SignupScreen(),
            ));

      case AppRoutes.dashboard:
        return MaterialPageRoute(builder: (_) =>  DashboardScreen());

      case AppRoutes.forgetPassword:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
            create: (_) => getIt<ForgetPasswordCubit>(),
            child: const ForgetPasswordScreen(),
          ),
        );

      case AppRoutes.emailVerification:
        final email = settings.arguments as String;
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
            create: (_) => getIt<VerifyCodeCubit>(),
            child: EmailVerificationScreen(email: email),

          ),
        );
      case AppRoutes.changePasswordScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<ChangePasswordViewModel>(),
            child: const ChangePasswordScreen(),
          ),
        );

      case AppRoutes.logoutWidget:
        return MaterialPageRoute(builder: (_) =>  LogoutDialogWidget());


      case AppRoutes.resetPassword:
        final email = settings.arguments as String;
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
            create: (_) => getIt<ResetPasswordCubit>(),
            child: ResetPasswordScreen(email: email),
          ),
        );

      case AppRoutes.termsAndConditions:
        return MaterialPageRoute(builder: (_) =>  TermsAndConditions());

      case AppRoutes.aboutUs:
        return MaterialPageRoute(builder: (_) =>  AboutUs());

      case AppRoutes.editProfile:
        return MaterialPageRoute(builder: (_) =>  EditProfileScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('404 - Page Not Found')),
          ),
        );
    }
  }
}
