import 'package:flower_app/features/occasion/domain/usecases/get_occasions_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'occasion_states.dart';

@injectable
class OccasionViewmodel extends Cubit<OccasionState> {
  final GetOccasionProductsUseCase _getOccasionProductsUseCase;
  String? _selectedOccasionId;
  String? get selectedOccasionId => _selectedOccasionId;

  OccasionViewmodel(this._getOccasionProductsUseCase) : super(OccasionInitial());

  Future<void> getOccasionProducts(String occasionId) async {
    emit(OccasionLoading());
    _selectedOccasionId = occasionId;

    try {
      final products = await _getOccasionProductsUseCase(occasionId);
      emit(OccasionLoaded(products));
    } catch (e) {
      emit(OccasionError(e.toString()));
    }
  }

  Future<void> refreshOccasionProducts() async {
    if (_selectedOccasionId != null) {
      await getOccasionProducts(_selectedOccasionId!);
    }
  }
}