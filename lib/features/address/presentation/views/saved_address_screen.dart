import 'dart:developer';
import 'package:flower_app/core/Widgets/Custom_Elevated_Button.dart';
import 'package:flower_app/features/address/presentation/view_model/address_cubit.dart';
import 'package:flower_app/features/address/presentation/views/add_address_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../../../../core/contants/app_images.dart';
import '../../../../core/l10n/translation/app_localizations.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/address_widget.dart';

class SavedAddressesScreen extends StatefulWidget {
  const SavedAddressesScreen({super.key});

  @override
  State<SavedAddressesScreen> createState() => _SavedAddressesScreenState();
}

class _SavedAddressesScreenState extends State<SavedAddressesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AddressCubit>().getAddresses();
    });
}

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(AppImages.arrowBack),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        title: Text(
          local!.savedAddress,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
      ),
      body: BlocConsumer<AddressCubit, AddressState>(
        listener: (context, state) {
          if (state is AddressError) {
            log(state.message);
            Center(
              child: Text(local.errorText),
            );
          }
        },
        builder: (context, state) {
          if (state is AddressLoading) {
            return const Center(
              child: SizedBox(
                height: 80,
                width: 80,
                child: LoadingIndicator(
                  indicatorType: Indicator.lineScalePulseOut,
                  colors: [AppColors.pink],
                  strokeWidth: 2,
                  backgroundColor: Colors.transparent,
                ),
              ),
            );
          } else if (state is AddressLoaded) {
            final addresses = state.response.addresses;

            if (addresses.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_off,
                      size: 64,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      local.noAddresses,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 180,
                      height: 50,
                      child: CustomElevatedButton(
                        text: local.addAddress,
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.addressScreen);
                        },
                      ),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async =>
                  context.read<AddressCubit>().getAddresses(),
              backgroundColor: Colors.white,
              color: AppColors.pink,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: addresses.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final address = addresses[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: GestureDetector(
                            onTap: () {
                              context
                                  .read<AddressCubit>()
                                  .selectAddress(address.id);
                            },
                            child: AddressWidget(
                              city: address.city,
                              street: address.street,
                              onDelete: () {
                                _deleteAddress(context, address.id);
                              },
                              onEdit: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider.value(
                                        value: context.read<AddressCubit>(),
                                        child: AddAddressScreen(addressToEdit: address),
                                      ),
                                    ),
                                  );
                                }

                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  CustomElevatedButton(
                    text: local.addAddress,
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.addressScreen);
                    },
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            );
          } else if (state is AddressError) {
            log(local.errorLoading);
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(local.swipeDownToRefresh),
                ],
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.pink,
              strokeWidth: 2,
            ),
          );
        },
      ),
    );
  }

  void _deleteAddress(BuildContext context, String addressId) {
    final local = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(local!.deleteAddress),
        backgroundColor: Colors.white,
        content: Text(local.deleteConfirmation),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: AppColors.pink,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(
                    color: AppColors.pink,
                    width: 1,
                  )),
            ),
            onPressed: () => Navigator.pop(context),
            child: Text(
              local.cancel,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(
                    color: AppColors.pink,
                    width: 1,
                  )),
            ),
            onPressed: () {
              Navigator.pop(context);
              context.read<AddressCubit>().deleteAddress(addressId);
              Future.delayed(const Duration(milliseconds: 500), () {
                if(!mounted){
                context.read<AddressCubit>().getAddresses();}
              });
            },
            child: Text(local.delete,
                style: TextStyle(
                  color: AppColors.pink,
                )),
          ),
        ],
      ),
    );
  }
}
