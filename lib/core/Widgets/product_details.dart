import 'package:flower_app/core/Widgets/custom_Elevated_Button.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/most_selling_products/domain/entity/products_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../features/cart/presentation/view_model/cart_cubit.dart';
import '../routes/route_names.dart';

class ProductDetails extends StatefulWidget {
  final ProductsEntity product;

  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final PageController pageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  height: 350,
                  width: double.infinity,
                  child: PageView.builder(
                    controller: pageViewController,
                    itemCount: widget.product.images.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        widget.product.images[index].trim(),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Text(
                              'Image not found',
                              style: TextStyle(
                                color: AppColors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: SmoothPageIndicator(
                    controller: pageViewController,
                    count: widget.product.images.length,
                    effect: ScrollingDotsEffect(
                      dotColor: AppColors.white,
                      activeDotColor: AppColors.pink,
                      dotHeight: 10.0,
                      dotWidth: 10.0,
                      strokeWidth: 1.5,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "EGP ${widget.product.price}",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        'Status: In Stock',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'All prices include tax',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: AppColors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.product.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.product.description,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey,
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Bouquet includes",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Pink roses: 15",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey,
                    ),
                  ),
                  Text(
                    "White wraps: 10",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomElevatedButton(
                    onPressed: () {
                      context.read<CartCubit>().addToCart(
                          widget.product.id, 1, context, onSuccess: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.cart, arguments: false);
                      });
                    },
                    color: AppColors.pink,
                    text: 'Add to cart',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}