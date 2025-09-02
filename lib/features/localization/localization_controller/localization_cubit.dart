import 'package:flower_app/features/localization/data/localization_preference.dart';
import 'package:flower_app/features/localization/localization_controller/localization_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  String language;
  LocalizationCubit({required this.language}) : super(LanguageInitialState());

  Future<void> changeLanguage() async {
    final String newlanguage = language == "en" ? "ar" : "en";
    language = newlanguage;
    LocalizationPreference.saveLanguage(language);
    emit(ChangeLanguage());
  }
}
