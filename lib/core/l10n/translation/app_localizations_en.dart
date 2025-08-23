import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Flower E-Commerce App';

  @override
  String get login => 'Login';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailHintText => 'Enter you email';

  @override
  String get passwordLabel => 'password';

  @override
  String get passwordHintText => 'Enter you password';

  @override
  String get emailIsEmptyErrorMessage => 'Email is required';

  @override
  String get emailValidationErrorMsg => 'This Email is not valid';

  @override
  String get passwordRequiredErrorMsg => 'Password is required';

  @override
  String get passwordValidationErrorMsg => 'must be at least 6 characters and have M#12m';

  @override
  String get rememberMe => 'Remember me';

  @override
  String get forgetPasswordTextButton => 'Forget password?';

  @override
  String get continueAsGuestButton => 'Continue as guest';

  @override
  String get dontHaveAnAccount => 'Don\'t have an account?';

  @override
  String get signUp => 'Sign up';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get home => 'Home';

  @override
  String get profile => 'Profile';

  @override
  String get settings => 'Settings';

  @override
  String get logout => 'Logout';

  @override
  String get categories => 'Categories';

  @override
  String get cart => 'Cart';
}
