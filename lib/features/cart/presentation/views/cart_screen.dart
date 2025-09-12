import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_app/core/Widgets/Custom_Elevated_Button.dart';
import 'package:flower_app/core/contants/app_icons.dart';
import 'package:flower_app/core/contants/app_images.dart';
import 'package:flower_app/core/l10n/translation/app_localizations.dart';
import 'package:flower_app/features/cart/presentation/widgets/product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/routes/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/cart_model.dart';
import '../view_model/cart_cubit.dart';
import '../view_model/cart_state.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, this.isFromNavBar = false});

  final bool isFromNavBar;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final int deliveryFee = 22;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartCubit>().getCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !widget.isFromNavBar,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: !widget.isFromNavBar
              ? const Text("Cart")
              : const Padding(
                  padding: EdgeInsetsDirectional.only(start: 18),
                  child: Text("Cart"),
                ),
          backgroundColor: Colors.white,
          centerTitle: false,
          automaticallyImplyLeading: !widget.isFromNavBar,
          leading: !widget.isFromNavBar
              ? IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_sharp),
                  onPressed: () => Navigator.pop(context),
                )
              : null,
          actions: [
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                if (state is CartLoaded &&
                    state.cartResponse.cart.cartItems.isNotEmpty) {
                  return TextButton(
                    onPressed: () {
                      _showClearCartDialog(context);
                    },
                    child: const Text(
                      "Clear",
                      style: TextStyle(
                        color: AppColors.pink,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
        body: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            if (state is CartError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is CartLoaded) {
              final cart = state.cartResponse.cart;
              return _buildCartContent(context, cart);
            }

            return _buildEmptyCart(context);
          },
        ),
      ),
    );
  }

  Widget _buildCartContent(BuildContext context, Cart cart) {
    var local = AppLocalizations.of(context)!;
    final subtotal = _calculateSubtotalValue(cart);
    final total = subtotal + deliveryFee;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          _buildAddressSection(local),
          const SizedBox(height: 24),
          Expanded(
            child: cart.cartItems.isEmpty
                ? _buildEmptyCart(context)
                : ListView.builder(
                    itemCount: cart.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cart.cartItems[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: ProductCartWidget(
                          cartItem: item,
                          onRemove: () => context
                              .read<CartCubit>()
                              .removeFromCart(item.product.id),
                          onUpdateQuantity: (quantity) {
                            if (quantity > 0) {
                              context
                                  .read<CartCubit>()
                                  .updateCartItem(item.product.id, quantity);
                            }
                          },
                        ),
                      );
                    },
                  ),
          ),
          if (cart.cartItems.isNotEmpty)
            _buildCheckoutSection(local, subtotal, total),
        ],
      ),
    );
  }

  Widget _buildAddressSection(AppLocalizations local) {
    return Row(
      children: [
        SvgPicture.asset(AppIcons.locationMarkerIcon),
        const SizedBox(width: 8),
        Text(local.deliverTo),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            "Addressssssssssssssssssssssssssssss",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.savedAddressScreen);
          },
          child: SvgPicture.asset(AppIcons.arrowDownIcon),
        ),
      ],
    );
  }

  Widget _buildCheckoutSection(
      AppLocalizations local, int subtotal, int total) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const SizedBox(height: 24),
        _buildPriceRow(label: local.subTotal, price: "${local.egp} $subtotal"),
        const SizedBox(height: 8),
        _buildPriceRow(
            label: local.deliveryFee, price: "${local.egp} $deliveryFee"),
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
          price: "${local.egp} $total",
        ),
        const SizedBox(height: 24),
        CustomElevatedButton(
          onPressed: () {
            _handleCheckout(context);
          },
          text: local.checkout,
          color: AppColors.pink,
          textColor: Colors.white,
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /*    Image.asset(
            AppImages.emptyCart,
            width: 350,
            height: 350,
            fit: BoxFit.cover,
          ),*/
          const SizedBox(height: 20),
          Text(
            local?.yourCartIsEmpty ?? "Your cart is empty",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            local?.addItemsToGetStarted ?? "Add items to get started",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 42),
          CustomElevatedButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.dashboard, (route) => false);
            },
            text: local?.continueShopping ?? "Continue Shopping",
            color: AppColors.pink,
            textColor: Colors.white,
          ),
        ],
      ),
    );
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

  int _calculateSubtotalValue(Cart cart) {
    return cart.cartItems
        .fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  void _handleCheckout(BuildContext context) {
    final state = context.read<CartCubit>().state;
    if (state is CartLoaded) {
      final cart = state.cartResponse.cart;
      if (cart.cartItems.isNotEmpty) {
        log('Proceeding to checkout with ${cart.cartItems.length} items');
      }
    }
  }

  void _showClearCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Clear Cart"),
        content: const Text("Are you sure you want to clear all items?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<CartCubit>().clearCart(context);
            },
            child: const Text(
              "Clear",
              style: TextStyle(color: AppColors.pink),
            ),
          ),
        ],
      ),
    );
  }
}
