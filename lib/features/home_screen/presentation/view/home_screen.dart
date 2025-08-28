import 'package:flower_app/core/Widgets/section_header.dart';
import 'package:flower_app/core/contants/app_icons.dart';
import 'package:flower_app/core/extensions/extensions.dart';
import 'package:flower_app/features/home_screen/presentation/widgets/app_logo.dart';
import 'package:flower_app/features/home_screen/presentation/widgets/best_seller_list.dart';
import 'package:flower_app/features/home_screen/presentation/widgets/category_list.dart';
import 'package:flower_app/features/home_screen/presentation/widgets/occasion_list.dart';
import 'package:flower_app/features/home_screen/presentation/widgets/order_info.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppLogo(),
              SizedBox(height: 10.0),
              OrderInfo(),
              SizedBox(height: 10.0),
              SectionHeader(
                title: 'Categories',
                onPressed: () {},
              ),
              SizedBox(height: 10.0),
              CategoryList(
                onTap: () {},
                icon: AppIcons.tulip,
                title: 'Flowers',
              ),
              SizedBox(height: 10.0),
              SectionHeader(
                title: 'Best Seller',
                onPressed: () {},
              ),
              BestSellerList(
                image: 'assets/images/image.png',
                name: 'Flower Name',
                price: '600 EGP',
              ),
              SectionHeader(
                title: 'Occasion',
                onPressed: () {},
              ),
              OccasionList(
                image: 'assets/images/image.png',
                name: 'Flower Name',
                price: '600 EGP',
              ),
            ],
          ).setHorizontalAndVerticalPadding(context, 0.05, 0.02),
        ),
      ),
    );
  }
}
