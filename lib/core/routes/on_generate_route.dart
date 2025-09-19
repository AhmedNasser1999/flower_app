import 'package:flower_app/core/config/di.dart';
import 'package:flower_app/core/Widgets/product_details.dart';
import 'package:flower_app/core/routes/route_names.dart';
import 'package:flower_app/features/address/presentation/views/add_address_screen.dart';
import 'package:flower_app/features/address/presentation/views/saved_address_screen.dart';
import 'package:flower_app/features/auth/signup/cubit/signup_cubit.dart';
import 'package:flower_app/features/auth/signup/view/signup_screen.dart';
import 'package:flower_app/features/categories/presentation/view/categories_screen.dart';
import 'package:flower_app/features/dashboard/presentation/views/dashboard_screen.dart';
import 'package:flower_app/features/home/presentation/view/home_screen.dart';
import 'package:flower_app/features/most_selling_products/presentation/view/most_selling_products.dart';
import 'package:flower_app/features/most_selling_products/presentation/viewmodel/most_selling_products_viewmodel.dart';
import 'package:flower_app/features/order/presentation/view/orders_screen.dart';
import 'package:flower_app/features/order/presentation/viewmodel/orders_cubit.dart';
import 'package:flower_app/features/notifications/presentation/view/notifications_screen.dart';
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
import '../../features/auth/logout/viewmodel/logout_viewmodel.dart';
import '../../features/auth/logout/views/logout_widget.dart';
import '../../features/checkout/presentation/view/checkout_screen.dart';
import '../../features/checkout/presentation/viewmodel/checkout_cubit.dart';
import '../../features/profile/change_password/presentation/viewmodel/change_password_viewmodel.dart';
import '../../features/profile/domain/entity/user_entity.dart';
import '../../features/most_selling_products/domain/entity/products_entity.dart';
import '../../features/profile/presentation/view/edit_profile_screen.dart';
import '../../features/profile/presentation/view/widgets/about_us.dart';
import '../../features/cart/presentation/view_model/cart_cubit.dart';
import '../../features/cart/presentation/views/cart_screen.dart';
import '../../features/profile/change_password/presentation/views/screens/change_password_screen.dart';
import '../../features/categories/presentation/viewmodel/categories_viewmodel.dart';
import '../../features/occasion/presentation/view/occasion_screen.dart';
import '../../features/splash/view/splash_view.dart';

class Routes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.initial:
        {
          return MaterialPageRoute(
            builder: (context) => const SplashView(),
            settings: settings,
          );
        }
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<LoginViewModel>(),
            child: const LoginScreen(),
          ),
        );

      case AppRoutes.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      case AppRoutes.signUp:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => getIt<SignupCubit>(),
                  child: const SignupScreen(),
                ));

      case AppRoutes.dashboard:
        return MaterialPageRoute(builder: (_) => DashboardScreen());

      case AppRoutes.forgetPassword:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => getIt<ForgetPasswordCubit>(),
            child: const ForgetPasswordScreen(),
          ),
        );

      case AppRoutes.emailVerification:
        final email = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
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
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LogoutViewModel>(),
            child: const LogoutDialogWidget(),
          ),
        );

      case AppRoutes.resetPassword:
        final email = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => getIt<ResetPasswordCubit>(),
            child: ResetPasswordScreen(email: email),
          ),
        );
      case AppRoutes.cart:
        final bool isFromNavBar = settings.arguments as bool? ?? false;
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => getIt<CartCubit>(),
                  child: CartScreen(isFromNavBar: isFromNavBar),
                ));

      case AppRoutes.mostSellingProducts:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) =>
                getIt<MostSellingProductsViewmodel>()..getMostSellingProducts(),
            child: MostSellingProducts(),
          ),
        );

      case AppRoutes.productDetails:
        final product = settings.arguments as ProductsEntity;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<CartCubit>(),
            child: ProductDetails(product: product),
          ),
        );
      case AppRoutes.occasions:
        final String initialOccasionId = settings.arguments as String? ?? "";
        return MaterialPageRoute(
          builder: (context) =>
              OccasionScreen(initialOccasionId: initialOccasionId),
        );
      case AppRoutes.categoriesScreen:
        final args = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<MostSellingProductsViewmodel>(),
              ),
              BlocProvider(
                create: (context) =>
                    getIt<CategoriesCubit>()..getAllCategories(),
              ),
            ],
            child: CategoriesScreen(
              initialCategoryId: args,
            ),
          ),
        );

      case AppRoutes.termsAndConditions:
        return MaterialPageRoute(builder: (_) => TermsAndConditions());

      case AppRoutes.aboutUs:
        return MaterialPageRoute(builder: (_) => AboutUs());

      case AppRoutes.editProfile:
        final user = settings.arguments as UserEntity;
        return MaterialPageRoute(
            builder: (_) => EditProfileScreen(
                  user: user,
                ));

      case AppRoutes.orders:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<OrdersCubit>()..getOrder(),
            child: const OrdersScreen(),
          ),
        );

      case AppRoutes.notification:
        return MaterialPageRoute(builder: (_) => NotificationsScreen());

      case AppRoutes.addressScreen:
        return MaterialPageRoute(builder: (_) => AddAddressScreen());
      case AppRoutes.savedAddressScreen:
        return MaterialPageRoute(builder: (_) => SavedAddressesScreen());
      case AppRoutes.checkout:
        final args = settings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (_) => getIt<CheckoutCubit>(),
                child: CheckoutScreen(subTotal: args)));
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('404 - Page Not Found')),
          ),
        );
    }
  }
}
