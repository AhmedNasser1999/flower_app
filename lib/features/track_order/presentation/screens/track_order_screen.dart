import 'package:flower_app/core/Widgets/Custom_Elevated_Button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_app/core/config/di.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../../../../core/contants/app_icons.dart';
import '../../../../core/contants/app_images.dart';
import '../../../../core/l10n/translation/app_localizations.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/track_order_cubit.dart';
import '../cubit/track_order_state.dart';

class TrackOrderScreen extends StatelessWidget {
  final String userId;
  final String orderId;

  const TrackOrderScreen(
      {super.key, required this.userId, required this.orderId});

  int getActiveStageIndex(String value) {
    switch (value.toLowerCase()) {
      case 'received':
      case 'received your order':
        return 0;
      case 'preparing':
      case 'preparing your order':
        return 1;
      case 'out for delivery':
        return 2;
      case 'delivered':
        return 3;
      default:
        return 0;
    }
  }
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => getIt<TrackOrderCubit>()
        ..watchOrder(userId: userId, orderId: orderId),
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
            local.trackOrder,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: BlocBuilder<TrackOrderCubit, TrackOrderState>(
          builder: (context, state) {
            if (state is TrackOrderLoading || state is TrackOrderInitial) {
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
            } else if (state is TrackOrderLoaded) {
              final order = state.order;
              final stages = [
                local.receivedYourOrder,
                local.preparingYourOrder,
                local.outForDelivery,
                local.delivered
              ];
              final currentStage = getActiveStageIndex(order.updateOrderButton);

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              local.estimatedArrival,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(fontSize: 16),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              _formatArrival(order.createdAt),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 20),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.pink.shade50,
                            child: SvgPicture.asset(AppIcons.deliveryBoyIcon),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Omar',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text(local.deliveryHeroToday),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: SvgPicture.asset(AppIcons.phoneIcon, color: AppColors.pink),
                            onPressed: () {
                              context.read<TrackOrderCubit>().call(state.order.pickupAddress.phoneNumber);
                            },
                          ),
                          IconButton(
                            icon: SvgPicture.asset(AppIcons.whatsappIcon, width: 25, height: 25),
                            onPressed: () {
                              context.read<TrackOrderCubit>().shareViaWhatsApp(state.order.pickupAddress.phoneNumber);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Image.asset(
                        AppImages.carImage,
                        height: 120,
                      ),
                      const SizedBox(height: 60),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 8),
                        child: Column(
                          children: List.generate(stages.length, (index) {
                            final isCompleted = index < currentStage;
                            final isActive = index == currentStage;
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: isActive
                                            ? Colors.pink
                                            : (isCompleted
                                            ? Colors.pink.shade200
                                            : Colors.white),
                                        border: Border.all(
                                          color: isActive ? Colors.pink : Colors.grey,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: (isCompleted || isActive)
                                          ? const Icon(Icons.check, color: Colors.white, size: 16)
                                          : null,
                                    ),
                                    if (index < stages.length - 1)
                                      Container(
                                        width: 2,
                                        height: 80,
                                        color: Colors.black38,
                                      ),
                                  ],
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      stages[index],
                                      style: TextStyle(
                                        fontWeight: isActive
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        color: isActive
                                            ? Colors.pink
                                            : (isCompleted
                                            ? Colors.pink.shade200
                                            : Colors.black),
                                      ),
                                    ),
                                    Text(
                                      _formatArrival(order.createdAt),
                                      style: Theme.of(context).textTheme.displayMedium,
                                    ),
                                  ],
                                )
                              ],
                            );
                          }),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomElevatedButton(
                        text: local.showMap,
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.orderMapView);
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is TrackOrderError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }


  static String _formatArrival(int ts) {
    if (ts <= 0) return '--';
    final dt = DateTime.fromMillisecondsSinceEpoch(ts);
    return '${dt.day.toString().padLeft(2, '0')} ${_month(dt.month)} ${dt.year}, ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  static String _month(int month) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return months[(month - 1).clamp(0, 11)];
  }
}
