import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/contants/app_icons.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../core/routes/route_names.dart';
import '../../../../../core/theme/app_colors.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo({super.key, required this.address});

  final String address;

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return Row(
      children: [
        SvgPicture.asset(AppIcons.locationMarkerIcon, color: AppColors.grey),
        const SizedBox(width: 8),
        Text(
          local.deliverTo,
          style: TextStyle(color: AppColors.grey, fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            address,
            maxLines: 1,
            style: TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.savedAddressScreen);
          },
          child:
              SvgPicture.asset(AppIcons.arrowDownIcon, color: AppColors.pink),
        ),
      ],
    );
  }
}
