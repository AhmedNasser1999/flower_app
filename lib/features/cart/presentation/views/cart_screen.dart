import 'package:flower_app/core/Widgets/Custom_Elevated_Button.dart';
import 'package:flower_app/core/contants/app_icons.dart';
import 'package:flower_app/core/contants/app_images.dart';
import 'package:flower_app/core/l10n/translation/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/app_colors.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Cart"),
          backgroundColor: Colors.white,
          centerTitle: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_sharp),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(AppIcons.locationMarkerIcon),
                  const SizedBox(width: 8),
                  Text(local!.deliverTo),
                  SizedBox(
                    width: 8,
                  ),
                  Flexible(
                    child: Text(
                      "Addressssssssssssssssssssssssssssss",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(AppIcons.arrowDownIcon)),
                ],
              ),
              const SizedBox(height: 24),
              ProductCartWidget(
                image: AppImages.flowerImage,
                title: AppImages.arrowBack,
                description:
                    "oncqckoamsdolkamsdoasmdokasmdosakmdoaskmdiqspcxsmc",
                price: "444",
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 24),
                  _buildPriceRow(label: local.subTotal, price: "EGP 444"),
                  const SizedBox(height: 8),
                  _buildPriceRow(label: local.deliveryFee, price: "EGP 22"),
                  const SizedBox(height: 24),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                    height: 1,
                  ),
                  const SizedBox(height: 12),
                  _buildPriceRow(
                      label: local.total,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      price: "EGP 466"),
                  const SizedBox(height: 24),
                  CustomElevatedButton(
                    onPressed: () {},
                    text: local.checkout,
                    color: AppColors.pink,
                    textColor: Colors.white,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
              
            ],
          ),
        ));
  }

  Widget _buildPriceRow({
    required String label,
    Color? color,
    FontWeight? fontWeight,
    required String price,
  }) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color: color ?? Colors.grey[800],
            fontWeight: fontWeight,
          ),
        ),
        const Spacer(),
        Text(
          price,
          style: TextStyle(
            color: color ?? Colors.grey[800],
            fontWeight: fontWeight,
          ),
        ),
      ],
    );
  }
}

class ProductCartWidget extends StatelessWidget {
  const ProductCartWidget({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.description,
  });

  final String image;
  final String title;
  final String description;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: SizedBox(
              height: 140,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  AppIcons.deleteIcon,
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Flexible(
                          child: Padding(
                            padding:
                                const EdgeInsetsDirectional.only(end: 32.0),
                            child: Text(
                              description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          'EGP $price',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.remove),
                            padding: const EdgeInsets.all(4),
                          ),
                          const Text(
                            "1",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.add),
                            padding: const EdgeInsets.all(4),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
