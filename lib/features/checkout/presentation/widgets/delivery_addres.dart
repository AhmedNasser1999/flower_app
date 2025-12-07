import 'package:flower_app/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../core/l10n/translation/app_localizations.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../address/presentation/view_model/address_cubit.dart';
import 'delivery_address_card.dart';

class DeliveryAddressSection extends StatelessWidget {
  const DeliveryAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          local.deliveryAddress,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ).setHorizontalPadding(context, 0.05),
        const SizedBox(height: 10),
        BlocBuilder<AddressCubit, AddressState>(
          builder: (context, state) {
            final cubit = context.read<AddressCubit>();
            if (state is AddressLoaded) {
              return Column(
                children: state.response.addresses.map((address) {
                  return DeliveryAddressCard(
                    address: address,
                    isSelected: cubit.selectedAddressId == address.id,
                    onSelect: () => cubit.selectAddress(address.id),
                  ).setHorizontalPadding(context, 0.05);
                }).toList(),
              );
            }
            if (state is AddressLoading) {
              return const Center(
                  child: SizedBox(
                height: 50,
                width: 50,
                child: LoadingIndicator(
                  indicatorType: Indicator.lineScalePulseOut,
                  colors: [AppColors.pink],
                  strokeWidth: 2,
                  backgroundColor: Colors.transparent,
                ),
              ));
            }
            return const SizedBox.shrink();
          },
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () async {
            await Navigator.pushNamed(context, AppRoutes.addressScreen);
            context.read<AddressCubit>().getAddresses();
          },
          child: Center(
            child: Container(
              width: size.width * 0.9,
              height: size.height * 0.05,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.grey.withOpacity(0.4)),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add, color: AppColors.pink),
                    const SizedBox(width: 10),
                    Text(local.addNew,
                        style: const TextStyle(
                            color: AppColors.pink,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
