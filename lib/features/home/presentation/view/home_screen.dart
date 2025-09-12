import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/home/presentation/view/widgets/occison_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_app/core/config/di.dart';
import 'package:flower_app/core/extensions/extensions.dart';
import 'package:flower_app/core/routes/route_names.dart';
import 'package:flower_app/core/Widgets/section_header.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../address/presentation/views/map_view.dart';
import '../viewmodel/home_cubit.dart';
import '../viewmodel/home_state.dart';
import 'widgets/app_logo.dart';
import 'widgets/order_info.dart';
import 'widgets/categories_section.dart';
import 'widgets/products_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LocationPermissionStatus permissionStatus = LocationPermissionStatus.checking;

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
    _requestLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(
            () => permissionStatus = LocationPermissionStatus.serviceDisabled);
        return;
      }

      final geoPerm = await Geolocator.checkPermission();
      if (geoPerm == LocationPermission.always ||
          geoPerm == LocationPermission.whileInUse) {
        setState(() => permissionStatus = LocationPermissionStatus.granted);
        // await _getCurrentLocation();
      } else if (geoPerm == LocationPermission.denied) {
        setState(() => permissionStatus = LocationPermissionStatus.denied);
      } else if (geoPerm == LocationPermission.deniedForever) {
        setState(
            () => permissionStatus = LocationPermissionStatus.deniedForever);
      }
    } catch (e, st) {
      debugPrint('Error checking permission: $e\n$st');
      setState(() => permissionStatus = LocationPermissionStatus.error);
    }
  }

  Future<void> _requestLocationPermission() async {
    try {
      LocationPermission gp = await Geolocator.requestPermission();
      if (gp == LocationPermission.always ||
          gp == LocationPermission.whileInUse) {
        setState(() => permissionStatus = LocationPermissionStatus.granted);
        // await _getCurrentLocation();
      } else if (gp == LocationPermission.deniedForever) {
        setState(
            () => permissionStatus = LocationPermissionStatus.deniedForever);
        await openAppSettings();
      } else {
        setState(() => permissionStatus = LocationPermissionStatus.denied);
      }
    } catch (e) {
      debugPrint('Error requesting permission: $e');
      setState(() => permissionStatus = LocationPermissionStatus.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeCubit>()..initializeHomeData(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) => Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppLogo(),
                  const SizedBox(height: 10.0),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, AppRoutes.savedAddressScreen),
                    child: const OrderInfo(
                      address: 'Deliver to 2XVP+XC - Sheikh Zayed',
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  SectionHeader(
                    title: 'Categories',
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.categoriesScreen);
                    },
                  ),
                  const SizedBox(height: 10.0),
                  CategoriesSection(state: state),
                  const SizedBox(height: 10.0),
                  SectionHeader(
                    title: 'Best Seller',
                    onPressed: () {
                      Navigator.pushNamed(
                          context, AppRoutes.mostSellingProducts);
                    },
                  ),
                  ProductsSection(state: state),
                  SectionHeader(
                    title: 'Occasion',
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.occasions);
                    },
                  ),
                  OccasionsSection(state: state),
                ],
              ).setHorizontalAndVerticalPadding(context, 0.05, 0.02),
            ),
          ),
        ),
      ),
    );
  }
}
