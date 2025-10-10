import 'package:flower_app/features/order/presentation/viewmodel/order_states.dart';
import 'package:flower_app/features/order/presentation/viewmodel/orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../core/contants/app_images.dart';
import '../../../../core/l10n/translation/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/order_card.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
            icon: Image.asset(AppImages.arrowBack),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            local.myOrders,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          bottom: TabBar(
            isScrollable: false,
            indicatorWeight: 3,
            labelColor: AppColors.pink,
            unselectedLabelColor: AppColors.grey,
            indicatorColor: AppColors.pink,
            tabs: [
              Tab(text: local.active),
              Tab(text: local.completed),
            ],
          ),
        ),
        body: BlocBuilder<OrdersCubit, OrdersState>(builder: (context, state) {
          if (state is OrdersLoadingState) {
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
          } else if (state is OrdersSuccessState) {
            return TabBarView(
              children: [
                ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: state.activeOrders.length,
                  itemBuilder: (context, index) {
                    final order = state.activeOrders[index];
                    final firstItem = order.orderItems.isNotEmpty
                        ? order.orderItems.first
                        : null;
                    return OrderCard(
                      title: firstItem?.title ?? '-',
                      price: 'EGP ${order.totalPrice.toStringAsFixed(0)}',
                      subtitle: 'Order number# ${order.orderNumber}',
                      buttonText: local.trackOrder,
                      onPressed: () {},
                    );
                  },
                ),
                ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: 1,
                  //itemCount: state.completedOrders.length,
                  itemBuilder: (context, index) {
                    return OrderCard(
                        buttonText: local.recorder,
                        title: "Test with dummy data",
                        onPressed: () {});
                    // final order = state.completedOrders[index];
                    // final firstItem = order.orderItems.isNotEmpty ? order.orderItems.first : null;
                    // return OrderCard(
                    //   title: firstItem?.title ?? '-',
                    //   price: 'EGP ${order.totalPrice.toStringAsFixed(0)}',
                    //   subtitle: 'Order number# ${order.orderNumber}',
                    //   buttonText: local.recorder,
                    //   onPressed: () {},
                    // );
                  },
                ),
              ],
            );
          } else if (state is OrdersErrorState) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox.shrink();
          }
        }),
      ),
    );
  }
}
