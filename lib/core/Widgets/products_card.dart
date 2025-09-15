import 'package:flower_app/core/contants/app_icons.dart';
import 'package:flower_app/core/l10n/translation/app_localizations.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_indicator/loading_indicator.dart';

class ProductCard extends StatelessWidget {
  final String productId;
  final String productTitle;
  final String productImg;
  final int productPrice;
  final int productPriceDiscount;
  final int priceDiscount;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.productId,
    required this.productImg,
    required this.productPrice,
    required this.productPriceDiscount,
    required this.priceDiscount,
    required this.productTitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.lightPink,
                ),
                child: Image.network(
                  productImg,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.fitHeight,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image,
                        size: 50, color: Colors.grey);
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
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
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),

              // Title
              Text(
                productTitle,
                style: theme.textTheme.bodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),

              // Price
              productPriceDiscount == 0
                  ? Text(
                      "EGP $productPrice",
                      style: theme.textTheme.bodyMedium,
                    )
                  : Row(
                      children: [
                        Text(
                          "EGP $productPriceDiscount",
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          "EGP $productPrice",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          "$priceDiscount%",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
              const SizedBox(height: 10),

              // Add to Cart Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.pink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 6),
                  ),
                  onPressed: () {
                    context.read<CartCubit>().addToCart(
                          productId,
                          1,
                          context,
                        );
                  },
                  icon: SvgPicture.asset(
                    AppIcons.cartIcon,
                    colorFilter: const ColorFilter.mode(
                      AppColors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: Text(
                    local.addToCartBtn,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
