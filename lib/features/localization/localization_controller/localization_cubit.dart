import 'package:flower_app/features/localization/data/localization_preference.dart';
import 'package:flower_app/features/localization/localization_controller/localization_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  String language;
  String selectedLanguage;

  LocalizationCubit({required this.language, this.selectedLanguage = "English"})
      : super(LanguageInitialState());

  void selectLanguage(String lang) {
    selectedLanguage = lang;

    if (lang == "English") {
      language = "en";
      LocalizationPreference.saveLanguage(language);
      emit(EnglishLanguage());
    } else if (lang == "Arabic") {
      language = "ar";
      LocalizationPreference.saveLanguage(language);
      emit(ArabicLanguage());
    }
  }

  bool isSelected(String lang) => selectedLanguage == lang;
}
