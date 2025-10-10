import 'dart:developer';
import 'package:flower_app/core/extensions/extensions.dart';
import 'package:flower_app/features/address/presentation/view_model/address_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_app/core/Widgets/Custom_Elevated_Button.dart';
import 'package:flower_app/core/contants/app_icons.dart';
import 'package:flower_app/features/cart/presentation/widgets/product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../../../../core/common/widgets/custom_snackbar_widget.dart';
import '../../../../core/l10n/translation/app_localizations.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AddressCubit>().getAddresses();
    });
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return WillPopScope(
      onWillPop: () async => !widget.isFromNavBar,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: !widget.isFromNavBar
              ? Text(local.cart)
              : Padding(
                  padding: const EdgeInsetsDirectional.only(start: 18),
                  child: Text(local.cart),
                ),
          backgroundColor: Colors.white,
          centerTitle: false,
          automaticallyImplyLeading: !widget.isFromNavBar,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
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
                    child: Text(
                      local.clear,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.pink,
                        fontWeight: FontWeight.bold,
                      ),
                    ).setHorizontalPadding(context, 0.02),
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
              log(state.message);
            }
          },
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(
                child: SizedBox(
                  height: 80,
                  width: 80,
                  child: LoadingIndicator(
                    indicatorType: Indicator.lineScalePulseOut,
                    colors: [AppColors.pink],
                    strokeWidth: 2,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              );
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
                              .removeFromCart(item.product.Id, context),
                          onUpdateQuantity: (quantity) {
                            if (quantity > 0) {
                              context
                                  .read<CartCubit>()
                                  .updateCartItem(item.product.Id, quantity);
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
    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, state) {
        String addressText = local.selectAnAddress;

        if (state is AddressLoaded) {
          final cubit = context.read<AddressCubit>();
          final selected = cubit.selectedAddress;

          if (selected != null) {
            addressText = '${selected.street}, ${selected.city}';
          } else if (state.response.addresses.isNotEmpty) {
            final address = state.response.addresses.first;
            addressText = '${address.street}, ${address.city}';
          } else {
            addressText = local.noAddresses;
          }
        } else if (state is AddressError) {
          addressText = local.errorLoadingAddress;
        } else if (state is AddressLoading) {
          addressText = local.loading;
        }

        return Row(
          children: [
            SvgPicture.asset(AppIcons.locationMarkerIcon,
                color: AppColors.grey),
            const SizedBox(width: 8),
            Text(
              local.deliverTo,
              style: const TextStyle(
                color: AppColors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                addressText,
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
                  setState(() {});
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
          const SizedBox(height: 20),
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
        Navigator.pushNamed(context, AppRoutes.checkout,
            arguments: state.cartResponse.cart.totalPrice);
      }
    }
  }

  void _showClearCartDialog(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.white,
        title: Text(local.clearCartTitle),
        content: Text(local.clearCartMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(local.cancel,
                style: const TextStyle(color: AppColors.black)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<CartCubit>().clearCart(context).then((value) {
                showCustomSnackBar(context, local.cartClearedSuccessfully,
                    isError: false);
              });
            },
            child: Text(
              local.clear,
              style: const TextStyle(color: AppColors.pink),
            ),
          ),
        ],
      ),
    );
  }
}
