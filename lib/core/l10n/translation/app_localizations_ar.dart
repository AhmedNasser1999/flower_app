// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'تظبيق متجر الزهور الالكتروني';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get emailLabel => 'البريد الإلكتروني';

  @override
  String get emailHintText => 'أدخل بريدك الإلكتروني';

  @override
  String get passwordLabel => 'كلمة المرور';

  @override
  String get passwordHintText => 'أدخل كلمة المرور';

  @override
  String get emailIsEmptyErrorMessage => 'البريد الإلكتروني مطلوب';

  @override
  String get emailValidationErrorMsg => 'هذا البريد الإلكتروني غير صالح';

  @override
  String get passwordRequiredErrorMsg => 'كلمة المرور مطلوبة';

  @override
  String get passwordValidationErrorMsg =>
      'يجب أن تكون على الأقل 6 أحرف وتحتوي على M#12m';

  @override
  String get rememberMe => 'تذكرني';

  @override
  String get forgetPasswordTextButton => 'هل نسيت كلمة المرور؟';

  @override
  String get continueAsGuestButton => 'المتابعة كضيف';

  @override
  String get dontHaveAnAccount => 'ليس لديك حساب؟';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get dashboard => 'لوحة التحكم';

  @override
  String get home => 'الرئيسية';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get settings => 'الاعدادات';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get categories => 'التصنيفات';

  @override
  String get cart => 'عربة التسوق';
}
