import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/categories_response.dart';
import '../../data/models/categoryResponse_byId_model.dart';
import '../../domain/usecases/get_all_categories_usecase.dart';
import '../../domain/usecases/get_category_byId_usecase.dart';
import 'categories_states.dart';


class CategoriesCubit extends Cubit<CategoriesState> {
  final GetAllCategoriesUseCase getAllCategoriesUseCase;
  final GetCategoryByIdUseCase getCategoryDetailsUseCase;

  CategoriesCubit({
    required this.getAllCategoriesUseCase,
    required this.getCategoryDetailsUseCase,
  }) : super(CategoriesInitial());

  Future<void> getAllCategories() async {
    emit(GetAllCategoriesLoading());
    try {
      final result = await getAllCategoriesUseCase();
      emit(GetAllCategoriesSuccess(result));
    } catch (e) {
      emit(GetAllCategoriesError(e.toString()));
    }
  }

  Future<void> getCategoryDetails(String id) async {
    emit(GetCategoryDetailsLoading());
    try {
      final result = await getCategoryDetailsUseCase(id);
      emit(GetCategoryDetailsSuccess(result));
    } catch (e) {
      emit(GetCategoryDetailsError(e.toString()));
    }
  }
}
