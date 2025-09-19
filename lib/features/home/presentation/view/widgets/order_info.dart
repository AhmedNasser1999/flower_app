import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/contants/app_icons.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../core/routes/route_names.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../address/presentation/view_model/address_cubit.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo({super.key});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;

    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, state) {
        String displayAddress = local.noAddresses;

        if (state is AddressLoaded) {
          final cubit = context.read<AddressCubit>();
          final selected = cubit.selectedAddress;

          if (selected != null) {
            displayAddress = '${selected.street}, ${selected.city}';
          } else if (state.response.addresses.isNotEmpty) {
            final first = state.response.addresses.first;
            displayAddress = '${first.street}, ${first.city}';
          }
        } else if (state is AddressLoading) {
          displayAddress = local.loading;
        } else if (state is AddressError) {
          displayAddress = local.errorLoadingAddress;
        }

        return Row(
          children: [
            SvgPicture.asset(AppIcons.locationMarkerIcon, color: AppColors.grey),
            const SizedBox(width: 8),
            Text(
              local.deliverTo,
              style: const TextStyle(
                  color: AppColors.grey, fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                displayAddress,
                maxLines: 1,
                style: const TextStyle(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () async {
                final result = await Navigator.pushNamed(
                  context,
                  AppRoutes.savedAddressScreen,
                );

                if (result == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(local.addressChanged),
                      backgroundColor: AppColors.pink,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: SvgPicture.asset(AppIcons.arrowDownIcon,
                  color: AppColors.pink),
            ),
          ],
        );
      },
    );
  }
}
