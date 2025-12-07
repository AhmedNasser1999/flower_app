import 'package:flower_app/core/contants/app_icons.dart';
import 'package:flower_app/core/l10n/translation/app_localizations.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../features/auth/domain/services/guest_service.dart';
import '../../features/dashboard/presentation/widgets/login_dialog.dart';

class ProductCard extends StatelessWidget {
  final String productId;
  final String productTitle;
  final String productImg;
  final int productPrice;
  final int productPriceDiscount;
  final int priceDiscount;
  final VoidCallback? onTap;
  final int quantity;
  final bool isFromProductDetails;

  const ProductCard({
    super.key,
    required this.productId,
    required this.productImg,
    required this.productPrice,
    required this.productPriceDiscount,
    required this.priceDiscount,
    required this.productTitle,
    this.onTap,
    required this.quantity,
    required this.isFromProductDetails,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context)!;
    final isOutOfStock = quantity <= 0;

    return GestureDetector(
      onTap: isOutOfStock ? null : onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.lightPink,
                    ),
                    child: Stack(
                      children: [
                        Image.network(
                          productImg,
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.fitHeight,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.grey.withValues(alpha: 0.3),
                              ),
                              child: const Icon(Icons.broken_image,
                                  size: 50, color: Colors.grey),
                            );
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
                        if (isOutOfStock)
                          Container(
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.black.withValues(alpha: 0.6),
                            ),
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.red.withValues(alpha: 0.9),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  local.outOfStock,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Title
                  Text(
                    productTitle,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isOutOfStock ? Colors.grey : null,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // Price
                  productPriceDiscount == 0
                      ? Text(
                          "EGP $productPrice",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: isOutOfStock ? Colors.grey : null,
                          ),
                        )
                      : Row(
                          children: [
                            Text(
                              "EGP $productPriceDiscount",
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: isOutOfStock ? Colors.grey : null,
                              ),
                            ),
                            const SizedBox(width: 2),
                            Text(
                              "EGP$productPrice",
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.grey,
                                fontSize: 11,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            const SizedBox(width: 2),
                            Text(
                              "$priceDiscount%",
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color:
                                    isOutOfStock ? Colors.grey : Colors.green,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                  const SizedBox(height: 10),

                  _buildBottomSection(context, local, isOutOfStock),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSection(
      BuildContext context, AppLocalizations local, bool isOutOfStock) {
    if (isOutOfStock) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(
          child: Text(
            local.outOfStock,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.pink,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8),
          elevation: 2,
        ),
        onPressed: isOutOfStock
            ? null
            : () async {
                final isGuest = await GuestService.isGuest();

                if (isGuest) {
                  showDialog(
                    context: context,
                    builder: (_) => const LoginRequiredDialog(),
                  );
                  return;
                } else {
                  context
                      .read<CartCubit>()
                      .addToCart(productId, 1, context, isFromProductDetails);
                }
              },
        icon: SvgPicture.asset(
          AppIcons.cartIcon,
          colorFilter: const ColorFilter.mode(
            AppColors.white,
            BlendMode.srcIn,
          ),
          height: 18,
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
    );
  }
}
