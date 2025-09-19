import 'dart:developer';

import 'package:flower_app/core/config/di.dart';
import 'package:flower_app/core/l10n/translation/app_localizations.dart';
import 'package:flower_app/features/address/presentation/view_model/address_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_app/core/Widgets/custom_text_field.dart';
import 'package:flower_app/features/address/domain/requests/address_request.dart';
import 'package:flower_app/features/address/data/models/address.dart';
import '../../../../core/contants/app_images.dart';
import '../../../../core/theme/app_colors.dart';
import 'map_view.dart';
import 'package:latlong2/latlong.dart';

class AddAddressScreen extends StatefulWidget {
  final Address? addressToEdit;

  const AddAddressScreen({super.key, this.addressToEdit});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final TextEditingController streetController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController recipientController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController latController = TextEditingController();
  final TextEditingController longController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  LatLng? _selectedLocation;

  bool get _isEditMode => widget.addressToEdit != null;

  @override
  void initState() {
    super.initState();
    _populateFormIfEditing();
  }

  void _populateFormIfEditing() {
    if (_isEditMode) {
      final address = widget.addressToEdit!;
      streetController.text = address.street;
      phoneController.text = address.phone;
      recipientController.text = address.recipientName ?? '';
      cityController.text = address.city;
      areaController.text = address.area ?? '';
      latController.text = address.lat;
      longController.text = address.long;

      if (address.lat.isNotEmpty && address.long.isNotEmpty) {
        _selectedLocation = LatLng(
          double.parse(address.lat),
          double.parse(address.long),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    return BlocProvider(
      create: (context) => getIt<AddressCubit>(),
      child: Scaffold(
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
            _isEditMode ? local!.editAddress : local!.addAddress,
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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(local.error),
                  duration: const Duration(seconds: 2),
                  backgroundColor: AppColors.red,
                  behavior: SnackBarBehavior.fixed,
                ),
              );
            } else if (state is AddressLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.response.message),
                  duration: const Duration(seconds: 2),
                  backgroundColor: AppColors.green,
                  padding: EdgeInsets.all(16),
                ),
              );
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    MapView(
                      onLocationSelected: (LatLng latLng) {
                        setState(() {
                          _selectedLocation = latLng;
                          latController.text = latLng.latitude.toString();
                          longController.text = latLng.longitude.toString();
                        });
                      },
                      onAddressFetched: (String address) {
                        streetController.text = address;
                      },
                      initialLocation: _isEditMode && _selectedLocation != null
                          ? _selectedLocation
                          : null,
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      controller: streetController,
                      label: local.address,
                      hint: local.addressHint,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return local.addressRequired;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      controller: phoneController,
                      label: local.phoneNumber,
                      hint: local.phoneHint,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return local.phoneRequired;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      controller: recipientController,
                      label: local.recipientName,
                      hint: local.recipientHint,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return local.recipientRequired;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            controller: cityController,
                            label: local.city,
                            hint: local.cityHint,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return local.cityRequired;
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomTextFormField(
                            controller: areaController,
                            label: local.area,
                            hint: local.areaHint,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    state is AddressLoading
                        ? Center(
                            child: const CircularProgressIndicator(
                            color: AppColors.pink,
                            strokeWidth: 2,
                          ))
                        : ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (_selectedLocation == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(local.selectLocation),
                                    ),
                                  );
                                  return;
                                }

                                final addressRequest = AddressRequest(
                                  id: _isEditMode
                                      ? widget.addressToEdit!.id
                                      : null,
                                  street: streetController.text,
                                  phone: phoneController.text,
                                  city: cityController.text,
                                  lat: latController.text,
                                  long: longController.text,
                                  recipientName: recipientController.text,
                                );

                                if (_isEditMode) {
                                  context.read<AddressCubit>().updateAddress(
                                        widget.addressToEdit!.id,
                                        addressRequest,
                                      );
                                } else {
                                  context
                                      .read<AddressCubit>()
                                      .addAddress(addressRequest);
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.pink,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: Text(_isEditMode
                                ? local.updateAddress
                                : local.saveAddress),
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    streetController.dispose();
    phoneController.dispose();
    recipientController.dispose();
    cityController.dispose();
    areaController.dispose();
    latController.dispose();
    longController.dispose();
    super.dispose();
  }
}
