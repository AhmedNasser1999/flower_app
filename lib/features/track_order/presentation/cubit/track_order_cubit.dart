import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart' hide Order;
import '../../domain/entities/order.dart';
import '../../domain/usecases/get_order_by_id_usecase.dart';
import '../../domain/usecases/watch_order_updates_usecase.dart';
import 'track_order_state.dart';
import 'package:url_launcher/url_launcher.dart';

@injectable
class TrackOrderCubit extends Cubit<TrackOrderState> {
  final GetOrderByIdUseCase getOrderByIdUseCase;
  final WatchOrderUpdatesUseCase watchOrderUpdatesUseCase;

  Stream<Order?>? _orderStream;

  TrackOrderCubit({
    required this.getOrderByIdUseCase,
    required this.watchOrderUpdatesUseCase,
  }) : super(TrackOrderInitial());

  void getOrder({required String userId, required String orderId}) async {
    emit(TrackOrderLoading());
    try {
      final order = await getOrderByIdUseCase(userId: userId, orderId: orderId);
      if (order != null) {
        emit(TrackOrderLoaded(order));
      } else {
        emit(TrackOrderError('Order not found'));
      }
    } catch (e) {
      emit(TrackOrderError(e.toString()));
    }
  }

  void watchOrder({required String userId, required String orderId}) {
    emit(TrackOrderLoading());
    _orderStream = watchOrderUpdatesUseCase(userId: userId, orderId: orderId);
    _orderStream!.listen((order) {
      if (order != null) {
        emit(TrackOrderLoaded(order));
      } else {
        emit(TrackOrderError('Order not found'));
      }
    }, onError: (e) {
      emit(TrackOrderError(e.toString()));
    });
  }

  void call(String phoneNumber) async {
    final url = Uri.parse("tel:$phoneNumber");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      log("Phone is not installed");
    }
  }

  void shareViaWhatsApp(String phoneNumber) async {
    final cleanedPhone = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    final phone =
    cleanedPhone.startsWith('+') ? cleanedPhone : '+$cleanedPhone';
    final url = Uri.parse("https://wa.me/$phone");

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      final phoneUrl = Uri.parse("tel:$phone");
      if (await canLaunchUrl(phoneUrl)) {
        await launchUrl(phoneUrl);
      }
    }
  }

}
