import 'package:flower_app/features/occasion/domain/usecases/get_occasions_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'occasion_states.dart';

@injectable
class OccasionViewmodel extends Cubit<OccasionState> {
  final GetOccasionsUseCase _getOccasionsUseCase;
  String? _selectedOccasionId;

  String? get selectedOccasionId => _selectedOccasionId;

  OccasionViewmodel(this._getOccasionsUseCase) : super(OccasionInitial());

  Future<void> getOccasions({int? page, int? limit}) async {
    emit(OccasionLoading());

    try {
      final occasions = await _getOccasionsUseCase(page: page, limit: limit);
      emit(OccasionLoaded(occasions));
    } catch (e) {
      emit(OccasionError(e.toString()));
    }
  }

  void selectOccasion(String occasionId) {
    _selectedOccasionId = occasionId;
  }

  Future<void> refreshOccasions() async {
    await getOccasions();
  }
}
