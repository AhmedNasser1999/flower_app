import 'package:flower_app/features/occasion/domain/entity/occasion_entity.dart';

abstract class OccasionState {}

class OccasionInitial extends OccasionState {}

class OccasionLoading extends OccasionState {}

class OccasionLoaded extends OccasionState {
  final List<OccasionEntity> occasions;

  OccasionLoaded(this.occasions);
}

class OccasionError extends OccasionState {
  final String message;

  OccasionError(this.message);
}