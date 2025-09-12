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
  String get passwordValidationErrorMsg =>
      'must be at least 6 characters and have M#12m';

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

  @override
  String get password => 'Password';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get resetPasswordUnderMsg =>
      'Password must not be empty and must contain 6 characters with upper case letter and one number at least';

  @override
  String get emailVerificationScreen => 'Email verification';

  @override
  String get emailVerificationScreenUnderMsg =>
      'Please enter your code that was sent to your\nemail address';

  @override
  String get codeReceiveMsgError => 'Didn\'t receive code?';

  @override
  String get forgetPasswordUnderText =>
      'Please enter your email associated to\nyour account';

  @override
  String get forgetPassword => 'Forget Password';

  @override
  String get validationEmailErrorMessage => 'This Email is not valid';

  @override
  String get requiredEmailErrorMessage => 'Email is required';

  @override
  String get continueButton => 'Continue';

  @override
  String get confirmPasswordLabel => 'Confirm Password';

  @override
  String get newPasswordLabel => 'New Password';

  @override
  String get newPasswordHint => 'Enter new password';

  @override
  String get wrongPasswordErrorMsg => 'Wrong password, Try Again';

  @override
  String get addToCartBtn => 'Add to cart';

  @override
  String get mostSellingTitle => 'Best Seller';

  @override
  String get mostSellingSubTitle => 'Bloom with our exquisite best sellers';

  @override
  String get explore => 'Explore';
}
