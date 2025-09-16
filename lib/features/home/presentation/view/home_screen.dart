import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/address/presentation/views/map_view.dart';
import 'package:flower_app/features/home/presentation/view/widgets/occison_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_app/core/config/di.dart';
import 'package:flower_app/core/extensions/extensions.dart';
import 'package:flower_app/core/routes/route_names.dart';
import 'package:flower_app/core/Widgets/section_header.dart';
import 'package:flower_app/core/l10n/translation/app_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flower_app/features/address/presentation/view_model/address_cubit.dart';
import 'package:flower_app/features/address/data/models/address.dart';

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
  String _currentAddress = 'Loading address...';
  Address? _selectedAddress;

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
    _requestLocationPermission();
    _loadAddresses();
  }

  Future<void> _loadAddresses() async {
    final addressCubit = getIt<AddressCubit>();
    await addressCubit.getAddresses();
    addressCubit.stream.listen((state) {
      if (state is AddressLoaded && state.response.addresses.isNotEmpty) {
        setState(() {
          _selectedAddress = state.response.addresses.first;
          _currentAddress = '${_selectedAddress?.street}, ${_selectedAddress?.city}';
        });
      } else if (state is AddressLoaded && state.response.addresses.isEmpty) {
        setState(() {
          _currentAddress = 'No address saved. Tap to add one.';
        });
      }
    });
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
    var local = AppLocalizations.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<HomeCubit>()..initializeHomeData(),
        ),
        BlocProvider(
          create: (_) => getIt<AddressCubit>()..getAddresses(),
        ),
      ],
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
                  BlocBuilder<AddressCubit, AddressState>(
                    builder: (context, addressState) {
                      if (addressState is AddressLoaded) {
                        final addresses = addressState.response.addresses;
                        if (addresses.isNotEmpty) {
                          _selectedAddress = addresses.first;
                          _currentAddress = '${_selectedAddress?.street}, ${_selectedAddress?.city}';
                        } else {
                          _currentAddress = local!.noAddresses;
                        }
                      } else if (addressState is AddressError) {
                        _currentAddress = 'something went wrong....';
                      }

                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, AppRoutes.savedAddressScreen),
                        child: OrderInfo(
                          address: _currentAddress,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10.0),
                  SectionHeader(
                    title: local!.categories,
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.categoriesScreen);
                    },
                  ),
                  const SizedBox(height: 10.0),
                  CategoriesSection(state: state),
                  const SizedBox(height: 10.0),
                  SectionHeader(
                    title: local.bestSeller,
                    onPressed: () {
                      Navigator.pushNamed(
                          context, AppRoutes.mostSellingProducts);
                    },
                  ),
                  const SizedBox(height: 10.0),
                  ProductsSection(state: state),
                  const SizedBox(height: 7.0),
                  SectionHeader(
                    title: local.occasion,
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.occasions);
                    },
                  ),
                  const SizedBox(height: 5.0),
                  OccasionsSection(state: state),
                ],
              ).setHorizontalAndVerticalPadding(context, 0.0364, 0.0131),
            ),
          ),
        ),
      ),
    );
  }
}