import '../../domain/entities/order.dart';

abstract class TrackOrderState {}

class TrackOrderInitial extends TrackOrderState {}

class TrackOrderLoading extends TrackOrderState {}

class TrackOrderLoaded extends TrackOrderState {
  final Order order;
  TrackOrderLoaded(this.order);
}

class TrackOrderError extends TrackOrderState {
  final String message;
  TrackOrderError(this.message);
}
