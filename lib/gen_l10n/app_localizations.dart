import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_af.dart';
import 'app_localizations_ak.dart';
import 'app_localizations_am.dart';
import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ha.dart';
import 'app_localizations_he.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_sw.dart';
import 'app_localizations_ur.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('af'),
    Locale('ak'),
    Locale('am'),
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('fr'),
    Locale('ha'),
    Locale('he'),
    Locale('hi'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('ru'),
    Locale('sw'),
    Locale('ur'),
    Locale('zh')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Styloria'**
  String get appTitle;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @myBookings.
  ///
  /// In en, this message translates to:
  /// **'My Bookings'**
  String get myBookings;

  /// No description provided for @openJobs.
  ///
  /// In en, this message translates to:
  /// **'Open Jobs'**
  String get openJobs;

  /// No description provided for @earnings.
  ///
  /// In en, this message translates to:
  /// **'Earnings'**
  String get earnings;

  /// No description provided for @paymentMethods.
  ///
  /// In en, this message translates to:
  /// **'Payment methods'**
  String get paymentMethods;

  /// No description provided for @referFriends.
  ///
  /// In en, this message translates to:
  /// **'Refer friends'**
  String get referFriends;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get darkMode;

  /// No description provided for @systemDefault.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get systemDefault;

  /// No description provided for @languageUpdated.
  ///
  /// In en, this message translates to:
  /// **'Language updated'**
  String get languageUpdated;

  /// No description provided for @languageSetToSystemDefault.
  ///
  /// In en, this message translates to:
  /// **'Language set to system default'**
  String get languageSetToSystemDefault;

  /// No description provided for @helpAndSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpAndSupport;

  /// No description provided for @chatWithCustomerService.
  ///
  /// In en, this message translates to:
  /// **'Chat with customer service'**
  String get chatWithCustomerService;

  /// No description provided for @aboutAndPolicies.
  ///
  /// In en, this message translates to:
  /// **'About & Policies'**
  String get aboutAndPolicies;

  /// No description provided for @viewUserPoliciesAndAgreements.
  ///
  /// In en, this message translates to:
  /// **'View user policies and agreements'**
  String get viewUserPoliciesAndAgreements;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logOut;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get deleteAccount;

  /// No description provided for @deleteAccountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone'**
  String get deleteAccountSubtitle;

  /// No description provided for @deleteAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get deleteAccountTitle;

  /// No description provided for @deleteAccountConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account?\n\nThis action will sign you out and you may lose access permanently.'**
  String get deleteAccountConfirmBody;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @yesDelete.
  ///
  /// In en, this message translates to:
  /// **'Yes, delete'**
  String get yesDelete;

  /// No description provided for @deleteAccountSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'We’re sorry to see you go.'**
  String get deleteAccountSheetTitle;

  /// No description provided for @deleteAccountSheetPrompt.
  ///
  /// In en, this message translates to:
  /// **'Can you tell us why? (Select all that apply)'**
  String get deleteAccountSheetPrompt;

  /// No description provided for @deleteAccountSelectAtLeastOneReason.
  ///
  /// In en, this message translates to:
  /// **'Please select at least one reason.'**
  String get deleteAccountSelectAtLeastOneReason;

  /// No description provided for @tellUsMoreOptional.
  ///
  /// In en, this message translates to:
  /// **'Tell us more (optional)'**
  String get tellUsMoreOptional;

  /// No description provided for @suggestionsToImproveOptional.
  ///
  /// In en, this message translates to:
  /// **'Suggestions to improve (optional)'**
  String get suggestionsToImproveOptional;

  /// No description provided for @deleteMyAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete my account'**
  String get deleteMyAccount;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @failedToDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete account. Please try again.'**
  String get failedToDeleteAccount;

  /// No description provided for @choosePreferredLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred language'**
  String get choosePreferredLanguage;

  /// No description provided for @noteSomeTextMayStillAppearInEnglish.
  ///
  /// In en, this message translates to:
  /// **'Note: This changes the app language. Some text may still appear in English until translations are added.'**
  String get noteSomeTextMayStillAppearInEnglish;

  /// No description provided for @languageSetToName.
  ///
  /// In en, this message translates to:
  /// **'Language set to {name}'**
  String languageSetToName(Object name);

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset Your Password'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address and we\'ll send you a code to reset your password.'**
  String get forgotPasswordSubtitle;

  /// No description provided for @resetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Create New Password'**
  String get resetPasswordTitle;

  /// No description provided for @resetPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the code sent to your email and choose a new password.'**
  String get resetPasswordSubtitle;

  /// No description provided for @sendResetCode.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Code'**
  String get sendResetCode;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @verificationCode.
  ///
  /// In en, this message translates to:
  /// **'Verification Code'**
  String get verificationCode;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get invalidEmail;

  /// No description provided for @invalidCode.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid code'**
  String get invalidCode;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordTooShort;

  /// No description provided for @changeEmail.
  ///
  /// In en, this message translates to:
  /// **'Use a different email'**
  String get changeEmail;

  /// No description provided for @backToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to Login'**
  String get backToLogin;

  /// No description provided for @deletionReason1.
  ///
  /// In en, this message translates to:
  /// **'I no longer need Styloria'**
  String get deletionReason1;

  /// No description provided for @deletionReason2.
  ///
  /// In en, this message translates to:
  /// **'I had trouble verifying my account (email/KYC)'**
  String get deletionReason2;

  /// No description provided for @deletionReason3.
  ///
  /// In en, this message translates to:
  /// **'I couldn’t find services/providers near me'**
  String get deletionReason3;

  /// No description provided for @deletionReason4.
  ///
  /// In en, this message translates to:
  /// **'Prices or fees were too high / unclear'**
  String get deletionReason4;

  /// No description provided for @deletionReason5.
  ///
  /// In en, this message translates to:
  /// **'The app was confusing / hard to use'**
  String get deletionReason5;

  /// No description provided for @deletionReason6.
  ///
  /// In en, this message translates to:
  /// **'Bugs or performance issues'**
  String get deletionReason6;

  /// No description provided for @deletionReason7.
  ///
  /// In en, this message translates to:
  /// **'Payment/refund issues'**
  String get deletionReason7;

  /// No description provided for @deletionReason8.
  ///
  /// In en, this message translates to:
  /// **'Bad experience with a provider/user'**
  String get deletionReason8;

  /// No description provided for @deletionReason9.
  ///
  /// In en, this message translates to:
  /// **'Privacy or security concerns'**
  String get deletionReason9;

  /// No description provided for @deletionReason10.
  ///
  /// In en, this message translates to:
  /// **'I created this account by mistake'**
  String get deletionReason10;

  /// No description provided for @deletionReason11.
  ///
  /// In en, this message translates to:
  /// **'I’m switching to another platform'**
  String get deletionReason11;

  /// No description provided for @deletionReason12.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get deletionReason12;

  /// No description provided for @loginWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Styloria'**
  String get loginWelcomeTitle;

  /// No description provided for @loginWelcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to manage your bookings and services.'**
  String get loginWelcomeSubtitle;

  /// No description provided for @loginFailedToLoadUserInfo.
  ///
  /// In en, this message translates to:
  /// **'Login succeeded but failed to load user info.'**
  String get loginFailedToLoadUserInfo;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @createNewAccount.
  ///
  /// In en, this message translates to:
  /// **'Create a new account'**
  String get createNewAccount;

  /// No description provided for @requestEmailVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Request email verification code'**
  String get requestEmailVerificationCode;

  /// No description provided for @createAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccountTitle;

  /// No description provided for @joinStyloria.
  ///
  /// In en, this message translates to:
  /// **'Join Styloria'**
  String get joinStyloria;

  /// No description provided for @registerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create an account to book services or become a provider'**
  String get registerSubtitle;

  /// No description provided for @iWantTo.
  ///
  /// In en, this message translates to:
  /// **'I want to:'**
  String get iWantTo;

  /// No description provided for @bookServices.
  ///
  /// In en, this message translates to:
  /// **'Book Services'**
  String get bookServices;

  /// No description provided for @provideServices.
  ///
  /// In en, this message translates to:
  /// **'Provide Services'**
  String get provideServices;

  /// No description provided for @personalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get lastName;

  /// No description provided for @selectDateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Select Date of Birth'**
  String get selectDateOfBirth;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// No description provided for @pleaseEnterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a phone number'**
  String get pleaseEnterPhoneNumber;

  /// No description provided for @accountInformation.
  ///
  /// In en, this message translates to:
  /// **'Account Information'**
  String get accountInformation;

  /// No description provided for @chooseUniqueUsernameHint.
  ///
  /// In en, this message translates to:
  /// **'Choose a unique username'**
  String get chooseUniqueUsernameHint;

  /// No description provided for @youAreCurrentlyUnavailable.
  ///
  /// In en, this message translates to:
  /// **'You\'re Currently Unavailable'**
  String get youAreCurrentlyUnavailable;

  /// No description provided for @toBrowseAndAcceptJobsEnableAvailability.
  ///
  /// In en, this message translates to:
  /// **'To browse and accept nearby job requests, you need to set yourself as available for bookings.'**
  String get toBrowseAndAcceptJobsEnableAvailability;

  /// No description provided for @goToProfileSettings.
  ///
  /// In en, this message translates to:
  /// **'Go to Profile Settings'**
  String get goToProfileSettings;

  /// No description provided for @tipToggleAvailableForBookings.
  ///
  /// In en, this message translates to:
  /// **'Tip: Toggle \"Available for Bookings\" ON in your Provider Profile to start receiving job requests.'**
  String get tipToggleAvailableForBookings;

  /// No description provided for @requestedBy.
  ///
  /// In en, this message translates to:
  /// **'Requested by: {name}'**
  String requestedBy(String name);

  /// No description provided for @locationLabel.
  ///
  /// In en, this message translates to:
  /// **'Location: {address}'**
  String locationLabel(String address);

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'your@email.com'**
  String get emailHint;

  /// No description provided for @enterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get enterValidEmail;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @passwordHintAtLeast10.
  ///
  /// In en, this message translates to:
  /// **'At least 10 characters'**
  String get passwordHintAtLeast10;

  /// No description provided for @passwordMin10.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 10 characters'**
  String get passwordMin10;

  /// No description provided for @iAgreeTo.
  ///
  /// In en, this message translates to:
  /// **'I agree to the '**
  String get iAgreeTo;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @passwordIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordIsRequired;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @pleaseSelectDob.
  ///
  /// In en, this message translates to:
  /// **'Please select your date of birth.'**
  String get pleaseSelectDob;

  /// No description provided for @pleaseSelectCountry.
  ///
  /// In en, this message translates to:
  /// **'Please select your country.'**
  String get pleaseSelectCountry;

  /// No description provided for @pleaseSelectCity.
  ///
  /// In en, this message translates to:
  /// **'Please select your city.'**
  String get pleaseSelectCity;

  /// No description provided for @pleaseEnterValidPhone.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number.'**
  String get pleaseEnterValidPhone;

  /// No description provided for @mustAcceptTerms.
  ///
  /// In en, this message translates to:
  /// **'You must accept the terms and conditions.'**
  String get mustAcceptTerms;

  /// No description provided for @mustBeAtLeast18.
  ///
  /// In en, this message translates to:
  /// **'You must be at least 18 years old to register.'**
  String get mustBeAtLeast18;

  /// No description provided for @agreeToTerms.
  ///
  /// In en, this message translates to:
  /// **'I agree to the Terms of Service and Privacy Policy'**
  String get agreeToTerms;

  /// No description provided for @createAccountButton.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccountButton;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @emailVerifiedSuccessPleaseLogin.
  ///
  /// In en, this message translates to:
  /// **'Email verified successfully. Please login.'**
  String get emailVerifiedSuccessPleaseLogin;

  /// No description provided for @pleaseVerifyEmailToContinue.
  ///
  /// In en, this message translates to:
  /// **'Please verify your email to continue.'**
  String get pleaseVerifyEmailToContinue;

  /// No description provided for @requestVerificationCodeTitle.
  ///
  /// In en, this message translates to:
  /// **'Request verification code'**
  String get requestVerificationCodeTitle;

  /// No description provided for @requestVerificationInstructions.
  ///
  /// In en, this message translates to:
  /// **'Enter your email or username.\nWe’ll send a new verification code to the email on that account.'**
  String get requestVerificationInstructions;

  /// No description provided for @emailOrUsername.
  ///
  /// In en, this message translates to:
  /// **'Email or Username'**
  String get emailOrUsername;

  /// No description provided for @sendCode.
  ///
  /// In en, this message translates to:
  /// **'Send code'**
  String get sendCode;

  /// No description provided for @ifAccountExistsCodeSent.
  ///
  /// In en, this message translates to:
  /// **'If that account exists, a code was sent.'**
  String get ifAccountExistsCodeSent;

  /// No description provided for @failedToSendVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Failed to send verification code.'**
  String get failedToSendVerificationCode;

  /// No description provided for @verifyYourEmailTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify your email'**
  String get verifyYourEmailTitle;

  /// No description provided for @verificationCodeSentInfo.
  ///
  /// In en, this message translates to:
  /// **'A verification code was sent to the email on this account.'**
  String get verificationCodeSentInfo;

  /// No description provided for @emailVerificationInstructions.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code sent to the email on this account:\n{identifier}'**
  String emailVerificationInstructions(Object identifier);

  /// No description provided for @verificationCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Verification code'**
  String get verificationCodeLabel;

  /// No description provided for @sendingEllipsis.
  ///
  /// In en, this message translates to:
  /// **'Sending...'**
  String get sendingEllipsis;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get resendCode;

  /// No description provided for @enter6DigitCodeError.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code.'**
  String get enter6DigitCodeError;

  /// No description provided for @verifyingEllipsis.
  ///
  /// In en, this message translates to:
  /// **'Verifying...'**
  String get verifyingEllipsis;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @invalidOrExpiredCodeTryResending.
  ///
  /// In en, this message translates to:
  /// **'Invalid or expired code. Try resending.'**
  String get invalidOrExpiredCodeTryResending;

  /// No description provided for @bookingTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking #{id}'**
  String bookingTitle(Object id);

  /// No description provided for @invalidBookingIdForChat.
  ///
  /// In en, this message translates to:
  /// **'Invalid booking ID for chat.'**
  String get invalidBookingIdForChat;

  /// No description provided for @invalidBookingIdForCall.
  ///
  /// In en, this message translates to:
  /// **'Invalid booking ID for call.'**
  String get invalidBookingIdForCall;

  /// No description provided for @unableToLoadContactInfo.
  ///
  /// In en, this message translates to:
  /// **'Unable to load contact info. Make sure the booking is active.'**
  String get unableToLoadContactInfo;

  /// No description provided for @noPhoneNumberAvailableForName.
  ///
  /// In en, this message translates to:
  /// **'No phone number available for {name}.'**
  String noPhoneNumberAvailableForName(Object name);

  /// No description provided for @deviceCannotPlaceCalls.
  ///
  /// In en, this message translates to:
  /// **'This device cannot place phone calls.'**
  String get deviceCannotPlaceCalls;

  /// No description provided for @cancelBookingDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel booking'**
  String get cancelBookingDialogTitle;

  /// No description provided for @cancelBookingDialogBody.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to cancel this booking?\n\nNote: If the provider has already accepted and more than 7 minutes have passed (but less than about 40 minutes), a penalty may be applied according to the rules.'**
  String get cancelBookingDialogBody;

  /// No description provided for @yesCancel.
  ///
  /// In en, this message translates to:
  /// **'Yes, cancel'**
  String get yesCancel;

  /// No description provided for @failedToCancelBooking.
  ///
  /// In en, this message translates to:
  /// **'Failed to cancel booking.'**
  String get failedToCancelBooking;

  /// No description provided for @bookingCancelledPenaltyApplied.
  ///
  /// In en, this message translates to:
  /// **'Booking cancelled. A penalty of {amount} has been applied.'**
  String bookingCancelledPenaltyApplied(Object amount);

  /// No description provided for @bookingCancelledSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Booking cancelled successfully.'**
  String get bookingCancelledSuccessfully;

  /// No description provided for @failedToConfirmCompletion.
  ///
  /// In en, this message translates to:
  /// **'Failed to confirm completion. Please try again.'**
  String get failedToConfirmCompletion;

  /// No description provided for @bothSidesConfirmedCompletedPayoutReleased.
  ///
  /// In en, this message translates to:
  /// **'Both sides confirmed. Booking marked as completed and payout released.'**
  String get bothSidesConfirmedCompletedPayoutReleased;

  /// No description provided for @youConfirmedCompletionWaitingForProvider.
  ///
  /// In en, this message translates to:
  /// **'You confirmed completion. Waiting for provider to confirm.'**
  String get youConfirmedCompletionWaitingForProvider;

  /// No description provided for @youConfirmedCompletionWaitingForUser.
  ///
  /// In en, this message translates to:
  /// **'You confirmed completion. Waiting for user to confirm.'**
  String get youConfirmedCompletionWaitingForUser;

  /// No description provided for @statusUnknown.
  ///
  /// In en, this message translates to:
  /// **'unknown'**
  String get statusUnknown;

  /// No description provided for @statusAccepted.
  ///
  /// In en, this message translates to:
  /// **'accepted'**
  String get statusAccepted;

  /// No description provided for @statusInProgress.
  ///
  /// In en, this message translates to:
  /// **'in progress'**
  String get statusInProgress;

  /// No description provided for @statusCompleted.
  ///
  /// In en, this message translates to:
  /// **'completed'**
  String get statusCompleted;

  /// No description provided for @statusCancelled.
  ///
  /// In en, this message translates to:
  /// **'cancelled'**
  String get statusCancelled;

  /// No description provided for @paymentPaid.
  ///
  /// In en, this message translates to:
  /// **'paid'**
  String get paymentPaid;

  /// No description provided for @paymentPending.
  ///
  /// In en, this message translates to:
  /// **'pending'**
  String get paymentPending;

  /// No description provided for @paymentFailed.
  ///
  /// In en, this message translates to:
  /// **'failed'**
  String get paymentFailed;

  /// No description provided for @bookingAcceptedBy.
  ///
  /// In en, this message translates to:
  /// **'Booking accepted by {name}'**
  String bookingAcceptedBy(Object name);

  /// No description provided for @whenLabel.
  ///
  /// In en, this message translates to:
  /// **'When'**
  String get whenLabel;

  /// No description provided for @atTime.
  ///
  /// In en, this message translates to:
  /// **'at {time}'**
  String atTime(Object time);

  /// No description provided for @userLabel.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get userLabel;

  /// No description provided for @providerLabel.
  ///
  /// In en, this message translates to:
  /// **'Provider'**
  String get providerLabel;

  /// No description provided for @estimatedPriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Estimated price'**
  String get estimatedPriceLabel;

  /// No description provided for @offeredPaidLabel.
  ///
  /// In en, this message translates to:
  /// **'Offered / paid'**
  String get offeredPaidLabel;

  /// No description provided for @distanceLabel.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get distanceLabel;

  /// No description provided for @distanceMiles.
  ///
  /// In en, this message translates to:
  /// **'{miles} miles'**
  String distanceMiles(Object miles);

  /// No description provided for @acceptedAtLabel.
  ///
  /// In en, this message translates to:
  /// **'Accepted at'**
  String get acceptedAtLabel;

  /// No description provided for @cancelledAtLabel.
  ///
  /// In en, this message translates to:
  /// **'Cancelled at'**
  String get cancelledAtLabel;

  /// No description provided for @cancelledByLabel.
  ///
  /// In en, this message translates to:
  /// **'Cancelled by'**
  String get cancelledByLabel;

  /// No description provided for @penaltyAppliedLabel.
  ///
  /// In en, this message translates to:
  /// **'Penalty applied: {amount}'**
  String penaltyAppliedLabel(Object amount);

  /// No description provided for @userConfirmedLabel.
  ///
  /// In en, this message translates to:
  /// **'User confirmed'**
  String get userConfirmedLabel;

  /// No description provided for @providerConfirmedLabel.
  ///
  /// In en, this message translates to:
  /// **'Provider confirmed'**
  String get providerConfirmedLabel;

  /// No description provided for @payoutReleasedLabel.
  ///
  /// In en, this message translates to:
  /// **'Payout released'**
  String get payoutReleasedLabel;

  /// No description provided for @yesLower.
  ///
  /// In en, this message translates to:
  /// **'yes'**
  String get yesLower;

  /// No description provided for @noLower.
  ///
  /// In en, this message translates to:
  /// **'no'**
  String get noLower;

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// No description provided for @call.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get call;

  /// No description provided for @actions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get actions;

  /// No description provided for @confirmCompletion.
  ///
  /// In en, this message translates to:
  /// **'Confirm completion'**
  String get confirmCompletion;

  /// No description provided for @noFurtherActionsForBooking.
  ///
  /// In en, this message translates to:
  /// **'No further actions available for this booking.'**
  String get noFurtherActionsForBooking;

  /// No description provided for @freeCancellationEndsIn.
  ///
  /// In en, this message translates to:
  /// **'Free cancellation ends in {time}'**
  String freeCancellationEndsIn(Object time);

  /// No description provided for @earlyFreeCancellationEndedWarning.
  ///
  /// In en, this message translates to:
  /// **'Early free cancellation has ended. Until about 40 minutes after acceptance, late cancellations may incur a penalty.'**
  String get earlyFreeCancellationEndedWarning;

  /// No description provided for @cancelBooking.
  ///
  /// In en, this message translates to:
  /// **'Cancel booking'**
  String get cancelBooking;

  /// No description provided for @cancelBookingNoPenalty.
  ///
  /// In en, this message translates to:
  /// **'Cancel booking (no penalty)'**
  String get cancelBookingNoPenalty;

  /// No description provided for @cancelBookingPenaltyMayApply.
  ///
  /// In en, this message translates to:
  /// **'Cancel booking (penalty may apply)'**
  String get cancelBookingPenaltyMayApply;

  /// No description provided for @cancellationPolicyInfo.
  ///
  /// In en, this message translates to:
  /// **'You can cancel without penalty in the first 7 minutes after provider acceptance, and again after about 40 minutes if needed. Between those times, a penalty may be applied according to the rules.'**
  String get cancellationPolicyInfo;

  /// No description provided for @ratingLine.
  ///
  /// In en, this message translates to:
  /// **'Rating: {rating} ({reviewCount, plural, =1{1 review} other{{reviewCount} reviews}})'**
  String ratingLine(Object rating, int reviewCount);

  /// No description provided for @proofOfSkillsPortfolio.
  ///
  /// In en, this message translates to:
  /// **'Proof of skills (Portfolio)'**
  String get proofOfSkillsPortfolio;

  /// No description provided for @noPortfolioPostsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No portfolio posts available.'**
  String get noPortfolioPostsAvailable;

  /// No description provided for @bookingLocation.
  ///
  /// In en, this message translates to:
  /// **'Booking location'**
  String get bookingLocation;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @latitude.
  ///
  /// In en, this message translates to:
  /// **'Latitude'**
  String get latitude;

  /// No description provided for @longitude.
  ///
  /// In en, this message translates to:
  /// **'Longitude'**
  String get longitude;

  /// No description provided for @mapWillAppearWhenCoordinatesValid.
  ///
  /// In en, this message translates to:
  /// **'Map will appear here when coordinates are valid.'**
  String get mapWillAppearWhenCoordinatesValid;

  /// No description provided for @chatForBookingTitle.
  ///
  /// In en, this message translates to:
  /// **'Chat for booking #{id}'**
  String chatForBookingTitle(Object id);

  /// No description provided for @unableToStartChat.
  ///
  /// In en, this message translates to:
  /// **'Unable to start chat. Chat is only available when the booking is accepted, in progress, or completed within the last day.'**
  String get unableToStartChat;

  /// No description provided for @invalidChatThreadFromServer.
  ///
  /// In en, this message translates to:
  /// **'Invalid chat thread returned from server.'**
  String get invalidChatThreadFromServer;

  /// No description provided for @messageNotSentPolicy.
  ///
  /// In en, this message translates to:
  /// **'Message not sent. Note: sharing phone numbers or emails is not allowed in chat.'**
  String get messageNotSentPolicy;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @typeMessageHint.
  ///
  /// In en, this message translates to:
  /// **'Type a message to support...'**
  String get typeMessageHint;

  /// No description provided for @uploadProfilePicture.
  ///
  /// In en, this message translates to:
  /// **'Upload Profile Picture'**
  String get uploadProfilePicture;

  /// No description provided for @currentProfilePicture.
  ///
  /// In en, this message translates to:
  /// **'Current Profile Picture'**
  String get currentProfilePicture;

  /// No description provided for @newPicturePreview.
  ///
  /// In en, this message translates to:
  /// **'New Picture Preview'**
  String get newPicturePreview;

  /// No description provided for @chooseImage.
  ///
  /// In en, this message translates to:
  /// **'Choose Image'**
  String get chooseImage;

  /// No description provided for @upload.
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get upload;

  /// No description provided for @noImageBytesFoundWeb.
  ///
  /// In en, this message translates to:
  /// **'No image bytes found (web).'**
  String get noImageBytesFoundWeb;

  /// No description provided for @pleasePickAnImageFirst.
  ///
  /// In en, this message translates to:
  /// **'Please pick an image first.'**
  String get pleasePickAnImageFirst;

  /// No description provided for @uploadFailedCheckServerLogs.
  ///
  /// In en, this message translates to:
  /// **'Upload failed. Check server logs / token.'**
  String get uploadFailedCheckServerLogs;

  /// No description provided for @profilePictureUploadedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Profile picture uploaded successfully!'**
  String get profilePictureUploadedSuccessfully;

  /// No description provided for @errorWithValue.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String errorWithValue(Object error);

  /// No description provided for @tapToChangeProfilePicture.
  ///
  /// In en, this message translates to:
  /// **'Tap to change profile picture'**
  String get tapToChangeProfilePicture;

  /// No description provided for @usernameValue.
  ///
  /// In en, this message translates to:
  /// **'Username: {username}'**
  String usernameValue(Object username);

  /// No description provided for @roleValue.
  ///
  /// In en, this message translates to:
  /// **'Role: {role}'**
  String roleValue(Object role);

  /// No description provided for @dateOfBirthYyyyMmDd.
  ///
  /// In en, this message translates to:
  /// **'Date of birth (YYYY-MM-DD)'**
  String get dateOfBirthYyyyMmDd;

  /// No description provided for @saveProfile.
  ///
  /// In en, this message translates to:
  /// **'Save Profile'**
  String get saveProfile;

  /// No description provided for @failedToSaveProfile.
  ///
  /// In en, this message translates to:
  /// **'Failed to save profile. Please try again.'**
  String get failedToSaveProfile;

  /// No description provided for @profileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated.'**
  String get profileUpdated;

  /// No description provided for @completeYourProviderProfile.
  ///
  /// In en, this message translates to:
  /// **'Complete Your Provider Profile'**
  String get completeYourProviderProfile;

  /// No description provided for @completeProviderProfileBody.
  ///
  /// In en, this message translates to:
  /// **'To start accepting jobs and earning money, complete your provider profile.'**
  String get completeProviderProfileBody;

  /// No description provided for @setupProfileNow.
  ///
  /// In en, this message translates to:
  /// **'Setup Profile Now'**
  String get setupProfileNow;

  /// No description provided for @doItLater.
  ///
  /// In en, this message translates to:
  /// **'Do It Later'**
  String get doItLater;

  /// No description provided for @bookingTimerPenaltyPeriodActive.
  ///
  /// In en, this message translates to:
  /// **'Penalty period active'**
  String get bookingTimerPenaltyPeriodActive;

  /// No description provided for @bookingTimerFreeCancellationPeriod.
  ///
  /// In en, this message translates to:
  /// **'Free cancellation period'**
  String get bookingTimerFreeCancellationPeriod;

  /// No description provided for @bookingTimerTimeRemaining.
  ///
  /// In en, this message translates to:
  /// **'Time remaining: {time}'**
  String bookingTimerTimeRemaining(Object time);

  /// No description provided for @bookingTimerCancellingNowPenalty.
  ///
  /// In en, this message translates to:
  /// **'Cancelling now will incur a 10% penalty.'**
  String get bookingTimerCancellingNowPenalty;

  /// No description provided for @bookingTimerCancelNoPenalty.
  ///
  /// In en, this message translates to:
  /// **'You can cancel without penalty.'**
  String get bookingTimerCancelNoPenalty;

  /// No description provided for @myReviewsTitle.
  ///
  /// In en, this message translates to:
  /// **'My Reviews'**
  String get myReviewsTitle;

  /// No description provided for @failedToLoadReviews.
  ///
  /// In en, this message translates to:
  /// **'Failed to load reviews.'**
  String get failedToLoadReviews;

  /// No description provided for @noReviewsYet.
  ///
  /// In en, this message translates to:
  /// **'You have not left any reviews yet.'**
  String get noReviewsYet;

  /// No description provided for @providerWithName.
  ///
  /// In en, this message translates to:
  /// **'Provider: {name}'**
  String providerWithName(Object name);

  /// No description provided for @providerGeneric.
  ///
  /// In en, this message translates to:
  /// **'Provider'**
  String get providerGeneric;

  /// No description provided for @ratingWithValue.
  ///
  /// In en, this message translates to:
  /// **'Rating: {rating}'**
  String ratingWithValue(Object rating);

  /// No description provided for @nearbyOpenJobsTitle.
  ///
  /// In en, this message translates to:
  /// **'Nearby Open Jobs'**
  String get nearbyOpenJobsTitle;

  /// No description provided for @failedToLoadOpenJobsHint.
  ///
  /// In en, this message translates to:
  /// **'Failed to load open jobs.\nMake sure you have a provider profile with location set and available=true.'**
  String get failedToLoadOpenJobsHint;

  /// No description provided for @errorLoadingJobsWithValue.
  ///
  /// In en, this message translates to:
  /// **'Error loading jobs: {error}'**
  String errorLoadingJobsWithValue(Object error);

  /// No description provided for @noOpenJobsFoundNearbyTitle.
  ///
  /// In en, this message translates to:
  /// **'No open jobs found nearby'**
  String get noOpenJobsFoundNearbyTitle;

  /// No description provided for @noOpenJobsFoundNearbyBody.
  ///
  /// In en, this message translates to:
  /// **'Make sure:\n- You have set your provider location\n- You are marked as available\n- Users have created and paid for bookings'**
  String get noOpenJobsFoundNearbyBody;

  /// No description provided for @currencyLabel.
  ///
  /// In en, this message translates to:
  /// **'Currency: {symbol}'**
  String currencyLabel(Object symbol);

  /// No description provided for @pricesShownInCurrency.
  ///
  /// In en, this message translates to:
  /// **'Prices shown in {symbol} ({country})'**
  String pricesShownInCurrency(Object symbol, Object country);

  /// No description provided for @jobTitleWithId.
  ///
  /// In en, this message translates to:
  /// **'Job #{id}'**
  String jobTitleWithId(Object id);

  /// No description provided for @serviceLine.
  ///
  /// In en, this message translates to:
  /// **'Service: {service}'**
  String serviceLine(Object service);

  /// No description provided for @whenLine.
  ///
  /// In en, this message translates to:
  /// **'When: {date} {time}'**
  String whenLine(Object date, Object time);

  /// No description provided for @priceLine.
  ///
  /// In en, this message translates to:
  /// **'Price: {price}'**
  String priceLine(Object price);

  /// No description provided for @acceptJob.
  ///
  /// In en, this message translates to:
  /// **'Accept Job'**
  String get acceptJob;

  /// No description provided for @failedToAcceptJob.
  ///
  /// In en, this message translates to:
  /// **'Failed to accept job.'**
  String get failedToAcceptJob;

  /// No description provided for @jobAcceptedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Job accepted successfully.'**
  String get jobAcceptedSuccessfully;

  /// No description provided for @newServiceRequestTitle.
  ///
  /// In en, this message translates to:
  /// **'New Service Request'**
  String get newServiceRequestTitle;

  /// No description provided for @reviewAlreadySubmitted.
  ///
  /// In en, this message translates to:
  /// **'Review submitted ✓'**
  String get reviewAlreadySubmitted;

  /// No description provided for @offeredPriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Offered price'**
  String get offeredPriceLabel;

  /// No description provided for @offeredPriceHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 25.00'**
  String get offeredPriceHint;

  /// No description provided for @enterValidPrice.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid price'**
  String get enterValidPrice;

  /// No description provided for @bookAndPay.
  ///
  /// In en, this message translates to:
  /// **'Book & Pay'**
  String get bookAndPay;

  /// No description provided for @bookAndPayAmount.
  ///
  /// In en, this message translates to:
  /// **'Book & Pay {amount}'**
  String bookAndPayAmount(Object amount);

  /// No description provided for @haircutService.
  ///
  /// In en, this message translates to:
  /// **'Haircut'**
  String get haircutService;

  /// No description provided for @stylingService.
  ///
  /// In en, this message translates to:
  /// **'Styling'**
  String get stylingService;

  /// No description provided for @timeLabel.
  ///
  /// In en, this message translates to:
  /// **'Time:'**
  String get timeLabel;

  /// No description provided for @notesLabel.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notesLabel;

  /// No description provided for @requestCreatedAndPaidBroadcast.
  ///
  /// In en, this message translates to:
  /// **'Request created & paid! Broadcast to providers.'**
  String get requestCreatedAndPaidBroadcast;

  /// No description provided for @locationLatLng.
  ///
  /// In en, this message translates to:
  /// **'Location: {lat}, {lng}'**
  String locationLatLng(Object lat, Object lng);

  /// No description provided for @paymentMethodsTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment methods'**
  String get paymentMethodsTitle;

  /// No description provided for @paymentPreferencesInfo.
  ///
  /// In en, this message translates to:
  /// **'These preferences are stored locally on your device. Actual payments are processed securely via Stripe/other gateways.'**
  String get paymentPreferencesInfo;

  /// No description provided for @preferredMethodLabel.
  ///
  /// In en, this message translates to:
  /// **'Preferred method (local gateway selected by country)'**
  String get preferredMethodLabel;

  /// No description provided for @methodVisaMastercard.
  ///
  /// In en, this message translates to:
  /// **'Visa/Mastercard'**
  String get methodVisaMastercard;

  /// No description provided for @methodMobileMoney.
  ///
  /// In en, this message translates to:
  /// **'Mobile Money (Momo/Paystack/Africa)'**
  String get methodMobileMoney;

  /// No description provided for @methodPaypal.
  ///
  /// In en, this message translates to:
  /// **'PayPal'**
  String get methodPaypal;

  /// No description provided for @methodApplePayGooglePay.
  ///
  /// In en, this message translates to:
  /// **'Apple Pay/Google Pay'**
  String get methodApplePayGooglePay;

  /// No description provided for @methodWeChatPay.
  ///
  /// In en, this message translates to:
  /// **'WeChat Pay (China)'**
  String get methodWeChatPay;

  /// No description provided for @methodAlipay.
  ///
  /// In en, this message translates to:
  /// **'Alipay (China)'**
  String get methodAlipay;

  /// No description provided for @methodUnionPay.
  ///
  /// In en, this message translates to:
  /// **'UnionPay Card (China)'**
  String get methodUnionPay;

  /// No description provided for @mobileMoneyNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Mobile Money Number'**
  String get mobileMoneyNumberLabel;

  /// No description provided for @wechatAlipayIdLabel.
  ///
  /// In en, this message translates to:
  /// **'WeChat/Alipay ID'**
  String get wechatAlipayIdLabel;

  /// No description provided for @cardLast4DigitsLabel.
  ///
  /// In en, this message translates to:
  /// **'Card last 4 digits'**
  String get cardLast4DigitsLabel;

  /// No description provided for @paypalEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'PayPal email'**
  String get paypalEmailLabel;

  /// No description provided for @applePayEnabledOnDevice.
  ///
  /// In en, this message translates to:
  /// **'Apple Pay enabled on this device'**
  String get applePayEnabledOnDevice;

  /// No description provided for @savePaymentPreferences.
  ///
  /// In en, this message translates to:
  /// **'Save Payment Preferences'**
  String get savePaymentPreferences;

  /// No description provided for @paymentPrefsSavedInfo.
  ///
  /// In en, this message translates to:
  /// **'Payment preferences saved locally. Actual charging is handled via Stripe/other gateways later.'**
  String get paymentPrefsSavedInfo;

  /// No description provided for @failedToLoadImage.
  ///
  /// In en, this message translates to:
  /// **'Failed to load image'**
  String get failedToLoadImage;

  /// No description provided for @earningsTitle.
  ///
  /// In en, this message translates to:
  /// **'Earnings'**
  String get earningsTitle;

  /// No description provided for @couldNotLoadEarningsSummary.
  ///
  /// In en, this message translates to:
  /// **'Could not load earnings summary.'**
  String get couldNotLoadEarningsSummary;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No data.'**
  String get noData;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @summaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summaryTitle;

  /// No description provided for @totalLabel.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get totalLabel;

  /// No description provided for @pendingLabel.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pendingLabel;

  /// No description provided for @paidLabel.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paidLabel;

  /// No description provided for @pdfReportTitle.
  ///
  /// In en, this message translates to:
  /// **'PDF report'**
  String get pdfReportTitle;

  /// No description provided for @periodLabel.
  ///
  /// In en, this message translates to:
  /// **'Period'**
  String get periodLabel;

  /// No description provided for @periodThisMonth.
  ///
  /// In en, this message translates to:
  /// **'This month'**
  String get periodThisMonth;

  /// No description provided for @periodLastMonth.
  ///
  /// In en, this message translates to:
  /// **'Last month'**
  String get periodLastMonth;

  /// No description provided for @periodYtd.
  ///
  /// In en, this message translates to:
  /// **'Year to date'**
  String get periodYtd;

  /// No description provided for @periodAllTime.
  ///
  /// In en, this message translates to:
  /// **'All time'**
  String get periodAllTime;

  /// No description provided for @couldNotDownloadPdfReport.
  ///
  /// In en, this message translates to:
  /// **'Could not download PDF report.'**
  String get couldNotDownloadPdfReport;

  /// No description provided for @couldNotOpenPdfWithValue.
  ///
  /// In en, this message translates to:
  /// **'Could not open PDF: {error}'**
  String couldNotOpenPdfWithValue(Object error);

  /// No description provided for @savingFilesNotSupportedWeb.
  ///
  /// In en, this message translates to:
  /// **'Saving files is not supported on Web right now.'**
  String get savingFilesNotSupportedWeb;

  /// No description provided for @savedToDocumentsIosWithPath.
  ///
  /// In en, this message translates to:
  /// **'Saved to Documents (iOS):\n{path}'**
  String savedToDocumentsIosWithPath(Object path);

  /// No description provided for @savedToFilesWithPath.
  ///
  /// In en, this message translates to:
  /// **'Saved to files:\n{path}'**
  String savedToFilesWithPath(Object path);

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @failedToSavePdfWithValue.
  ///
  /// In en, this message translates to:
  /// **'Failed to save PDF: {error}'**
  String failedToSavePdfWithValue(Object error);

  /// No description provided for @openPdfReport.
  ///
  /// In en, this message translates to:
  /// **'Open PDF report'**
  String get openPdfReport;

  /// No description provided for @savePdfToDownloads.
  ///
  /// In en, this message translates to:
  /// **'Save PDF to Downloads'**
  String get savePdfToDownloads;

  /// No description provided for @reportWatermarkNote.
  ///
  /// In en, this message translates to:
  /// **'The report PDF should include the Styloria watermark.'**
  String get reportWatermarkNote;

  /// No description provided for @referFriendsTitle.
  ///
  /// In en, this message translates to:
  /// **'Refer friends'**
  String get referFriendsTitle;

  /// No description provided for @shareReferralCodeBody.
  ///
  /// In en, this message translates to:
  /// **'Share your referral code with friends. Later you can add rewards when they sign up and complete bookings.'**
  String get shareReferralCodeBody;

  /// No description provided for @yourReferralCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Your referral code:'**
  String get yourReferralCodeLabel;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @referralCodeCopiedWithCode.
  ///
  /// In en, this message translates to:
  /// **'Referral code copied: {code}'**
  String referralCodeCopiedWithCode(Object code);

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navBookings.
  ///
  /// In en, this message translates to:
  /// **'Bookings'**
  String get navBookings;

  /// No description provided for @navNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get navNotifications;

  /// No description provided for @navAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get navAccount;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @welcomeName.
  ///
  /// In en, this message translates to:
  /// **'Welcome, {name}'**
  String welcomeName(Object name);

  /// No description provided for @toggleThemeTooltip.
  ///
  /// In en, this message translates to:
  /// **'Toggle light/dark mode'**
  String get toggleThemeTooltip;

  /// No description provided for @loggedInAs.
  ///
  /// In en, this message translates to:
  /// **'Logged in as: {role}'**
  String loggedInAs(Object role);

  /// No description provided for @locationWithValue.
  ///
  /// In en, this message translates to:
  /// **'Location: {value}'**
  String locationWithValue(Object value);

  /// No description provided for @homeTagline.
  ///
  /// In en, this message translates to:
  /// **'Transform your grooming experience with real-time bookings and trusted providers.'**
  String get homeTagline;

  /// No description provided for @manageProviderProfile.
  ///
  /// In en, this message translates to:
  /// **'Manage Provider Profile'**
  String get manageProviderProfile;

  /// No description provided for @browseOpenJobs.
  ///
  /// In en, this message translates to:
  /// **'Browse Open Jobs'**
  String get browseOpenJobs;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick actions'**
  String get quickActions;

  /// No description provided for @newBooking.
  ///
  /// In en, this message translates to:
  /// **'New Booking'**
  String get newBooking;

  /// No description provided for @notificationsWithUnread.
  ///
  /// In en, this message translates to:
  /// **'Notifications ({count, plural, =1{1 unread} other{{count} unread}})'**
  String notificationsWithUnread(int count);

  /// No description provided for @liveLocationTrackingTitle.
  ///
  /// In en, this message translates to:
  /// **'Live Location Tracking'**
  String get liveLocationTrackingTitle;

  /// No description provided for @live.
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get live;

  /// No description provided for @locationServicesDisabled.
  ///
  /// In en, this message translates to:
  /// **'Location services are disabled.'**
  String get locationServicesDisabled;

  /// No description provided for @locationPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Location permission denied.'**
  String get locationPermissionDenied;

  /// No description provided for @locationPermissionPermanentlyDenied.
  ///
  /// In en, this message translates to:
  /// **'Location permission permanently denied. Please enable it in settings.'**
  String get locationPermissionPermanentlyDenied;

  /// No description provided for @failedToGetLocationWithValue.
  ///
  /// In en, this message translates to:
  /// **'Failed to get location: {error}'**
  String failedToGetLocationWithValue(Object error);

  /// No description provided for @youProvider.
  ///
  /// In en, this message translates to:
  /// **'You (Provider)'**
  String get youProvider;

  /// No description provided for @youCustomer.
  ///
  /// In en, this message translates to:
  /// **'You (Customer)'**
  String get youCustomer;

  /// No description provided for @customer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get customer;

  /// No description provided for @bookingDetails.
  ///
  /// In en, this message translates to:
  /// **'Booking Details'**
  String get bookingDetails;

  /// No description provided for @navigate.
  ///
  /// In en, this message translates to:
  /// **'Navigate'**
  String get navigate;

  /// No description provided for @failedToLoadNotifications.
  ///
  /// In en, this message translates to:
  /// **'Failed to load notifications.'**
  String get failedToLoadNotifications;

  /// No description provided for @failedToMarkAsRead.
  ///
  /// In en, this message translates to:
  /// **'Failed to mark as read'**
  String get failedToMarkAsRead;

  /// No description provided for @noNotificationsYet.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet.'**
  String get noNotificationsYet;

  /// No description provided for @markRead.
  ///
  /// In en, this message translates to:
  /// **'Mark read'**
  String get markRead;

  /// No description provided for @providerKycTitle.
  ///
  /// In en, this message translates to:
  /// **'Provider Verification (KYC)'**
  String get providerKycTitle;

  /// No description provided for @logoutTooltip.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logoutTooltip;

  /// No description provided for @statusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status: {status}'**
  String statusLabel(Object status);

  /// No description provided for @rejectedWithNotes.
  ///
  /// In en, this message translates to:
  /// **'Rejected: {notes}'**
  String rejectedWithNotes(Object notes);

  /// No description provided for @kycInstructions.
  ///
  /// In en, this message translates to:
  /// **'To access provider features, upload your ID and a selfie for verification.'**
  String get kycInstructions;

  /// No description provided for @idFrontRequired.
  ///
  /// In en, this message translates to:
  /// **'ID Front (required)'**
  String get idFrontRequired;

  /// No description provided for @selectIdFront.
  ///
  /// In en, this message translates to:
  /// **'Select ID Front'**
  String get selectIdFront;

  /// No description provided for @idBackRequired.
  ///
  /// In en, this message translates to:
  /// **'ID Back (required)'**
  String get idBackRequired;

  /// No description provided for @selectIdBackRequired.
  ///
  /// In en, this message translates to:
  /// **'Select ID Back'**
  String get selectIdBackRequired;

  /// No description provided for @selfieRequired.
  ///
  /// In en, this message translates to:
  /// **'Selfie (required)'**
  String get selfieRequired;

  /// No description provided for @selectSelfie.
  ///
  /// In en, this message translates to:
  /// **'Select Selfie'**
  String get selectSelfie;

  /// No description provided for @takeSelfie.
  ///
  /// In en, this message translates to:
  /// **'Take Selfie'**
  String get takeSelfie;

  /// No description provided for @errorUploadAllRequired.
  ///
  /// In en, this message translates to:
  /// **'Please upload ID (front), ID (back), and a selfie.'**
  String get errorUploadAllRequired;

  /// No description provided for @failedSubmitKycCode.
  ///
  /// In en, this message translates to:
  /// **'Failed to submit KYC (code {code}).'**
  String failedSubmitKycCode(Object code);

  /// No description provided for @submittedCurrentStatus.
  ///
  /// In en, this message translates to:
  /// **'Submitted. Current status: {status}'**
  String submittedCurrentStatus(Object status);

  /// No description provided for @unknownStatus.
  ///
  /// In en, this message translates to:
  /// **'unknown'**
  String get unknownStatus;

  /// No description provided for @submitKyc.
  ///
  /// In en, this message translates to:
  /// **'Submit KYC'**
  String get submitKyc;

  /// No description provided for @verificationMayTakeTimeNote.
  ///
  /// In en, this message translates to:
  /// **'Note: Verification may take time. You will be able to access provider features once approved.'**
  String get verificationMayTakeTimeNote;

  /// No description provided for @reviewsReceivedTitle.
  ///
  /// In en, this message translates to:
  /// **'Reviews Received'**
  String get reviewsReceivedTitle;

  /// No description provided for @noReviewsYetHelpText.
  ///
  /// In en, this message translates to:
  /// **'No reviews yet. Complete services to receive reviews from clients.'**
  String get noReviewsYetHelpText;

  /// No description provided for @failedToLoadReviewsWithError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load reviews: {error}'**
  String failedToLoadReviewsWithError(Object error);

  /// No description provided for @providerArrivingTitle.
  ///
  /// In en, this message translates to:
  /// **'{name} is on the way'**
  String providerArrivingTitle(Object name);

  /// No description provided for @etaIsEstimate.
  ///
  /// In en, this message translates to:
  /// **'* Estimated time (actual route may vary)'**
  String get etaIsEstimate;

  /// No description provided for @enterVerificationCodeTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter Verification Code'**
  String get enterVerificationCodeTitle;

  /// No description provided for @otpSentToUsername.
  ///
  /// In en, this message translates to:
  /// **'We sent a 6-digit code to the phone number\nassociated with \"{username}\".'**
  String otpSentToUsername(Object username);

  /// No description provided for @sixDigitCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'6-digit code'**
  String get sixDigitCodeLabel;

  /// No description provided for @enterSixDigitCodeValidation.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code'**
  String get enterSixDigitCodeValidation;

  /// No description provided for @otpInvalidOrExpired.
  ///
  /// In en, this message translates to:
  /// **'Invalid or expired code.'**
  String get otpInvalidOrExpired;

  /// No description provided for @failedLoadUserInfoAfterVerification.
  ///
  /// In en, this message translates to:
  /// **'Failed to load user info after verification.'**
  String get failedLoadUserInfoAfterVerification;

  /// No description provided for @chatWithSupportTitle.
  ///
  /// In en, this message translates to:
  /// **'Chat with Support'**
  String get chatWithSupportTitle;

  /// No description provided for @unableStartSupportChat.
  ///
  /// In en, this message translates to:
  /// **'Unable to start support chat.'**
  String get unableStartSupportChat;

  /// No description provided for @invalidSupportThreadReturned.
  ///
  /// In en, this message translates to:
  /// **'Invalid support thread returned from server.'**
  String get invalidSupportThreadReturned;

  /// No description provided for @noMessagesYet.
  ///
  /// In en, this message translates to:
  /// **'No messages yet. Start a conversation!'**
  String get noMessagesYet;

  /// No description provided for @supportDefaultName.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get supportDefaultName;

  /// No description provided for @aboutPoliciesTitle.
  ///
  /// In en, this message translates to:
  /// **'About & Policies'**
  String get aboutPoliciesTitle;

  /// No description provided for @newBookingTitle.
  ///
  /// In en, this message translates to:
  /// **'New Booking'**
  String get newBookingTitle;

  /// No description provided for @appointmentDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Appointment details'**
  String get appointmentDetailsTitle;

  /// No description provided for @pickDate.
  ///
  /// In en, this message translates to:
  /// **'Pick date'**
  String get pickDate;

  /// No description provided for @pickTime.
  ///
  /// In en, this message translates to:
  /// **'Pick time'**
  String get pickTime;

  /// No description provided for @serviceTypeTitle.
  ///
  /// In en, this message translates to:
  /// **'Service type'**
  String get serviceTypeTitle;

  /// No description provided for @serviceDropdownLabel.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get serviceDropdownLabel;

  /// No description provided for @serviceHaircutLabel.
  ///
  /// In en, this message translates to:
  /// **'Haircut'**
  String get serviceHaircutLabel;

  /// No description provided for @serviceBraidsLabel.
  ///
  /// In en, this message translates to:
  /// **'Braids'**
  String get serviceBraidsLabel;

  /// No description provided for @serviceShaveLabel.
  ///
  /// In en, this message translates to:
  /// **'Shave'**
  String get serviceShaveLabel;

  /// No description provided for @serviceHairColoringLabel.
  ///
  /// In en, this message translates to:
  /// **'Hair Coloring'**
  String get serviceHairColoringLabel;

  /// No description provided for @serviceManicureLabel.
  ///
  /// In en, this message translates to:
  /// **'Manicure'**
  String get serviceManicureLabel;

  /// No description provided for @servicePedicureLabel.
  ///
  /// In en, this message translates to:
  /// **'Pedicure'**
  String get servicePedicureLabel;

  /// No description provided for @serviceNailArtLabel.
  ///
  /// In en, this message translates to:
  /// **'Nail Art'**
  String get serviceNailArtLabel;

  /// No description provided for @serviceMakeupLabel.
  ///
  /// In en, this message translates to:
  /// **'Makeup'**
  String get serviceMakeupLabel;

  /// No description provided for @serviceFacialLabel.
  ///
  /// In en, this message translates to:
  /// **'Facial'**
  String get serviceFacialLabel;

  /// No description provided for @serviceWaxingLabel.
  ///
  /// In en, this message translates to:
  /// **'Waxing'**
  String get serviceWaxingLabel;

  /// No description provided for @serviceMassageLabel.
  ///
  /// In en, this message translates to:
  /// **'Massage'**
  String get serviceMassageLabel;

  /// No description provided for @serviceHairStylingLabel.
  ///
  /// In en, this message translates to:
  /// **'Hair Styling'**
  String get serviceHairStylingLabel;

  /// No description provided for @serviceHairTreatmentLabel.
  ///
  /// In en, this message translates to:
  /// **'Hair Treatment'**
  String get serviceHairTreatmentLabel;

  /// No description provided for @serviceHairExtensionsLabel.
  ///
  /// In en, this message translates to:
  /// **'Hair Extensions'**
  String get serviceHairExtensionsLabel;

  /// No description provided for @serviceOtherServicesLabel.
  ///
  /// In en, this message translates to:
  /// **'Other Services'**
  String get serviceOtherServicesLabel;

  /// No description provided for @notesForProviderOptionalLabel.
  ///
  /// In en, this message translates to:
  /// **'Notes for your provider (optional)'**
  String get notesForProviderOptionalLabel;

  /// No description provided for @locationTitle.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get locationTitle;

  /// No description provided for @latitudeLabel.
  ///
  /// In en, this message translates to:
  /// **'Latitude'**
  String get latitudeLabel;

  /// No description provided for @longitudeLabel.
  ///
  /// In en, this message translates to:
  /// **'Longitude'**
  String get longitudeLabel;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get requiredField;

  /// No description provided for @useMyCurrentLocation.
  ///
  /// In en, this message translates to:
  /// **'Use my current location'**
  String get useMyCurrentLocation;

  /// No description provided for @pricesShownIn.
  ///
  /// In en, this message translates to:
  /// **'Prices shown in {symbol} ({country})'**
  String pricesShownIn(Object symbol, Object country);

  /// No description provided for @chooseTimeLaterThanCurrent.
  ///
  /// In en, this message translates to:
  /// **'Please choose a time later than the current time.'**
  String get chooseTimeLaterThanCurrent;

  /// No description provided for @pleasePickDateAndTime.
  ///
  /// In en, this message translates to:
  /// **'Please pick date and time.'**
  String get pleasePickDateAndTime;

  /// No description provided for @locationUpdatedFromGps.
  ///
  /// In en, this message translates to:
  /// **'Location updated from GPS.'**
  String get locationUpdatedFromGps;

  /// No description provided for @failedToGetLocation.
  ///
  /// In en, this message translates to:
  /// **'Failed to get location: {error}'**
  String failedToGetLocation(Object error);

  /// No description provided for @bookingCreatedChoosePrice.
  ///
  /// In en, this message translates to:
  /// **'Booking created! ID: {id} • Choose your price option.'**
  String bookingCreatedChoosePrice(Object id);

  /// No description provided for @failedToCreateBooking.
  ///
  /// In en, this message translates to:
  /// **'Failed to create booking.'**
  String get failedToCreateBooking;

  /// No description provided for @paymentsNotSupportedLong.
  ///
  /// In en, this message translates to:
  /// **'Payments are not supported on this platform. Please run the app on Android, iOS, macOS, or Web to test real payments.'**
  String get paymentsNotSupportedLong;

  /// No description provided for @noBookingToConfirm.
  ///
  /// In en, this message translates to:
  /// **'No booking to confirm. Please create a booking first.'**
  String get noBookingToConfirm;

  /// No description provided for @pleaseChoosePriceOption.
  ///
  /// In en, this message translates to:
  /// **'Please choose a price option.'**
  String get pleaseChoosePriceOption;

  /// No description provided for @failedCreatePaymentTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Failed to create payment on server. Please try again.'**
  String get failedCreatePaymentTryAgain;

  /// No description provided for @paymentSuccessfulMessage.
  ///
  /// In en, this message translates to:
  /// **'Payment successful!\nBooking #{bookingId} • Paid: {paid}\nYour request is now visible to nearby providers.'**
  String paymentSuccessfulMessage(Object bookingId, Object paid);

  /// No description provided for @paymentSucceededButFailedUpdate.
  ///
  /// In en, this message translates to:
  /// **'Payment succeeded, but failed to update booking on server.'**
  String get paymentSucceededButFailedUpdate;

  /// No description provided for @paymentCancelledOrFailed.
  ///
  /// In en, this message translates to:
  /// **'Payment cancelled or failed: {reason}'**
  String paymentCancelledOrFailed(Object reason);

  /// No description provided for @unexpectedPaymentError.
  ///
  /// In en, this message translates to:
  /// **'Unexpected payment error: {error}'**
  String unexpectedPaymentError(Object error);

  /// No description provided for @createBookingButton.
  ///
  /// In en, this message translates to:
  /// **'Create Booking'**
  String get createBookingButton;

  /// No description provided for @chooseYourPriceOptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Price Option'**
  String get chooseYourPriceOptionTitle;

  /// No description provided for @transportationCostLabel.
  ///
  /// In en, this message translates to:
  /// **'Transportation cost: {cost}'**
  String transportationCostLabel(Object cost);

  /// No description provided for @budgetTierTitle.
  ///
  /// In en, this message translates to:
  /// **'BUDGET'**
  String get budgetTierTitle;

  /// No description provided for @standardTierTitle.
  ///
  /// In en, this message translates to:
  /// **'STANDARD'**
  String get standardTierTitle;

  /// No description provided for @priorityTierTitle.
  ///
  /// In en, this message translates to:
  /// **'PRIORITY'**
  String get priorityTierTitle;

  /// No description provided for @budgetTierDescription.
  ///
  /// In en, this message translates to:
  /// **'Best value among nearby providers'**
  String get budgetTierDescription;

  /// No description provided for @standardTierDescription.
  ///
  /// In en, this message translates to:
  /// **'Recommended balance of price & availability'**
  String get standardTierDescription;

  /// No description provided for @priorityTierDescription.
  ///
  /// In en, this message translates to:
  /// **'Premium option to attract top providers faster'**
  String get priorityTierDescription;

  /// No description provided for @naShort.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get naShort;

  /// No description provided for @priceBreakdownTitle.
  ///
  /// In en, this message translates to:
  /// **'Price Breakdown'**
  String get priceBreakdownTitle;

  /// No description provided for @servicePriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Service Price'**
  String get servicePriceLabel;

  /// No description provided for @transportationLabel.
  ///
  /// In en, this message translates to:
  /// **'Transportation'**
  String get transportationLabel;

  /// No description provided for @serviceFeeLabel.
  ///
  /// In en, this message translates to:
  /// **'Service Fee ({percent}%)'**
  String serviceFeeLabel(Object percent);

  /// No description provided for @allPricesIn.
  ///
  /// In en, this message translates to:
  /// **'All prices in {currency} ({country})'**
  String allPricesIn(Object currency, Object country);

  /// No description provided for @userCountryPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'User country'**
  String get userCountryPlaceholder;

  /// No description provided for @totalToPayTitle.
  ///
  /// In en, this message translates to:
  /// **'Total to Pay'**
  String get totalToPayTitle;

  /// No description provided for @includesServiceTransportation.
  ///
  /// In en, this message translates to:
  /// **'Includes service + transportation'**
  String get includesServiceTransportation;

  /// No description provided for @confirmAndPay.
  ///
  /// In en, this message translates to:
  /// **'Confirm & Pay'**
  String get confirmAndPay;

  /// No description provided for @howPricingWorksTitle.
  ///
  /// In en, this message translates to:
  /// **'How Pricing Works'**
  String get howPricingWorksTitle;

  /// No description provided for @howPricingWorksBullets.
  ///
  /// In en, this message translates to:
  /// **'• Budget: best value among nearby providers\n• Standard: recommended default\n• Priority: premium option to speed up acceptance\n• Transportation is included in the total'**
  String get howPricingWorksBullets;

  /// No description provided for @myBookingsTitle.
  ///
  /// In en, this message translates to:
  /// **'My Bookings'**
  String get myBookingsTitle;

  /// No description provided for @myAssignedJobsTitle.
  ///
  /// In en, this message translates to:
  /// **'My Assigned Jobs'**
  String get myAssignedJobsTitle;

  /// No description provided for @pleaseCompleteProviderProfileFirst.
  ///
  /// In en, this message translates to:
  /// **'Please complete your provider profile first.'**
  String get pleaseCompleteProviderProfileFirst;

  /// No description provided for @failedToLoadBookings.
  ///
  /// In en, this message translates to:
  /// **'Failed to load bookings.'**
  String get failedToLoadBookings;

  /// No description provided for @profileSetupRequiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile Setup Required'**
  String get profileSetupRequiredTitle;

  /// No description provided for @profileSetupRequiredBody.
  ///
  /// In en, this message translates to:
  /// **'You need to complete your provider profile before you can view assigned jobs and earnings.'**
  String get profileSetupRequiredBody;

  /// No description provided for @later.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get later;

  /// No description provided for @setupNow.
  ///
  /// In en, this message translates to:
  /// **'Setup Now'**
  String get setupNow;

  /// No description provided for @noBookingsFound.
  ///
  /// In en, this message translates to:
  /// **'No bookings found.'**
  String get noBookingsFound;

  /// No description provided for @findNearbyOpenJobs.
  ///
  /// In en, this message translates to:
  /// **'Find Nearby Open Jobs'**
  String get findNearbyOpenJobs;

  /// No description provided for @pay.
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get pay;

  /// No description provided for @rate.
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get rate;

  /// No description provided for @bookingNumber.
  ///
  /// In en, this message translates to:
  /// **'Booking #{id}'**
  String bookingNumber(Object id);

  /// No description provided for @whenOn.
  ///
  /// In en, this message translates to:
  /// **'When: {date}'**
  String whenOn(Object date);

  /// No description provided for @whenAt.
  ///
  /// In en, this message translates to:
  /// **'When: {date} at {time}'**
  String whenAt(Object date, Object time);

  /// No description provided for @providerLine.
  ///
  /// In en, this message translates to:
  /// **'Provider: {name}'**
  String providerLine(Object name);

  /// No description provided for @userLine.
  ///
  /// In en, this message translates to:
  /// **'User: {name}'**
  String userLine(Object name);

  /// No description provided for @estimatedPriceLine.
  ///
  /// In en, this message translates to:
  /// **'Estimated price: {price}'**
  String estimatedPriceLine(Object price);

  /// No description provided for @paymentLine.
  ///
  /// In en, this message translates to:
  /// **'Payment: {status}'**
  String paymentLine(Object status);

  /// No description provided for @paymentUnpaid.
  ///
  /// In en, this message translates to:
  /// **'unpaid'**
  String get paymentUnpaid;

  /// No description provided for @paymentUnknown.
  ///
  /// In en, this message translates to:
  /// **'unknown'**
  String get paymentUnknown;

  /// No description provided for @confirmPaymentTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm payment'**
  String get confirmPaymentTitle;

  /// No description provided for @confirmPaymentBody.
  ///
  /// In en, this message translates to:
  /// **'Pay {amount} to confirm this booking?'**
  String confirmPaymentBody(Object amount);

  /// No description provided for @yesPay.
  ///
  /// In en, this message translates to:
  /// **'Yes, Pay'**
  String get yesPay;

  /// No description provided for @failedToCreatePaymentIntent.
  ///
  /// In en, this message translates to:
  /// **'Failed to create payment intent.'**
  String get failedToCreatePaymentIntent;

  /// No description provided for @paymentSuccessfulShort.
  ///
  /// In en, this message translates to:
  /// **'Payment successful.'**
  String get paymentSuccessfulShort;

  /// No description provided for @paymentSucceededButFailedUpdateBooking.
  ///
  /// In en, this message translates to:
  /// **'Payment succeeded, but failed to update booking on server.'**
  String get paymentSucceededButFailedUpdateBooking;

  /// No description provided for @paymentCancelledOrFailedReason.
  ///
  /// In en, this message translates to:
  /// **'Payment cancelled or failed: {reason}'**
  String paymentCancelledOrFailedReason(Object reason);

  /// No description provided for @unexpectedPaymentErrorReason.
  ///
  /// In en, this message translates to:
  /// **'Unexpected payment error: {error}'**
  String unexpectedPaymentErrorReason(Object error);

  /// No description provided for @rateProviderTitle.
  ///
  /// In en, this message translates to:
  /// **'Rate {providerName}'**
  String rateProviderTitle(Object providerName);

  /// No description provided for @selectRatingHelp.
  ///
  /// In en, this message translates to:
  /// **'Select rating (1 = poor, 5 = excellent):'**
  String get selectRatingHelp;

  /// No description provided for @commentsOptionalLabel.
  ///
  /// In en, this message translates to:
  /// **'Comments (optional)'**
  String get commentsOptionalLabel;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @reviewSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Review submitted.'**
  String get reviewSubmitted;

  /// No description provided for @failedSubmitReview.
  ///
  /// In en, this message translates to:
  /// **'Failed to submit review.'**
  String get failedSubmitReview;

  /// No description provided for @failedToLoadProfile.
  ///
  /// In en, this message translates to:
  /// **'Failed to load profile: {error}'**
  String failedToLoadProfile(Object error);

  /// No description provided for @profileSavedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Profile {action} successfully!'**
  String profileSavedSuccess(Object action);

  /// No description provided for @genericError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String genericError(Object error);

  /// No description provided for @locationPermissionDeniedEnableInSettings.
  ///
  /// In en, this message translates to:
  /// **'Location permission denied. Please enable in settings.'**
  String get locationPermissionDeniedEnableInSettings;

  /// No description provided for @locationPermissionPermanentlyDeniedEnableInAppSettings.
  ///
  /// In en, this message translates to:
  /// **'Location permission permanently denied. Please enable in app settings.'**
  String get locationPermissionPermanentlyDeniedEnableInAppSettings;

  /// No description provided for @errorGettingLocation.
  ///
  /// In en, this message translates to:
  /// **'Error getting location: {error}'**
  String errorGettingLocation(Object error);

  /// No description provided for @pleaseEnterAddress.
  ///
  /// In en, this message translates to:
  /// **'Please enter an address'**
  String get pleaseEnterAddress;

  /// No description provided for @locationUpdatedFromAddress.
  ///
  /// In en, this message translates to:
  /// **'Location updated from address'**
  String get locationUpdatedFromAddress;

  /// No description provided for @couldNotFindLocationForAddress.
  ///
  /// In en, this message translates to:
  /// **'Could not find location for this address'**
  String get couldNotFindLocationForAddress;

  /// No description provided for @errorConvertingAddress.
  ///
  /// In en, this message translates to:
  /// **'Error converting address: {error}'**
  String errorConvertingAddress(Object error);

  /// No description provided for @portfolioUnavailableCompleteKycFirst.
  ///
  /// In en, this message translates to:
  /// **'Portfolio unavailable. If you are a provider, complete KYC verification first.'**
  String get portfolioUnavailableCompleteKycFirst;

  /// No description provided for @failedToLoadPortfolio.
  ///
  /// In en, this message translates to:
  /// **'Failed to load portfolio: {error}'**
  String failedToLoadPortfolio(Object error);

  /// No description provided for @addPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add Photo'**
  String get addPhoto;

  /// No description provided for @addVideo.
  ///
  /// In en, this message translates to:
  /// **'Add Video'**
  String get addVideo;

  /// No description provided for @addPost.
  ///
  /// In en, this message translates to:
  /// **'Add post'**
  String get addPost;

  /// No description provided for @captionOptionalTitle.
  ///
  /// In en, this message translates to:
  /// **'Caption (optional)'**
  String get captionOptionalTitle;

  /// No description provided for @captionHintExample.
  ///
  /// In en, this message translates to:
  /// **'e.g., “Knotless braids on client”'**
  String get captionHintExample;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @failedToCreatePortfolioPost.
  ///
  /// In en, this message translates to:
  /// **'Failed to create portfolio post.'**
  String get failedToCreatePortfolioPost;

  /// No description provided for @uploadFailedMediaUpload.
  ///
  /// In en, this message translates to:
  /// **'Upload failed (media upload).'**
  String get uploadFailedMediaUpload;

  /// No description provided for @uploadFailed.
  ///
  /// In en, this message translates to:
  /// **'Upload failed: {error}'**
  String uploadFailed(Object error);

  /// No description provided for @deletePostTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete post?'**
  String get deletePostTitle;

  /// No description provided for @deletePostBody.
  ///
  /// In en, this message translates to:
  /// **'This will remove the post from your portfolio.'**
  String get deletePostBody;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Delete failed.'**
  String get deleteFailed;

  /// No description provided for @deleteFailedWithError.
  ///
  /// In en, this message translates to:
  /// **'Delete failed: {error}'**
  String deleteFailedWithError(Object error);

  /// No description provided for @portfolioTitle.
  ///
  /// In en, this message translates to:
  /// **'Portfolio'**
  String get portfolioTitle;

  /// No description provided for @noPortfolioPostsYetHelpText.
  ///
  /// In en, this message translates to:
  /// **'No portfolio posts yet. Add photos/videos of your work to help clients trust your skills.'**
  String get noPortfolioPostsYetHelpText;

  /// No description provided for @setupProviderProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Setup Provider Profile'**
  String get setupProviderProfileTitle;

  /// No description provided for @providerProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Provider Profile'**
  String get providerProfileTitle;

  /// No description provided for @welcomeToStyloriaTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Styloria!'**
  String get welcomeToStyloriaTitle;

  /// No description provided for @completeProviderProfileToStartEarning.
  ///
  /// In en, this message translates to:
  /// **'Complete your provider profile to start accepting jobs and earning money.'**
  String get completeProviderProfileToStartEarning;

  /// No description provided for @reviewCountLabel.
  ///
  /// In en, this message translates to:
  /// **'({count} {count, plural, one{review} other{reviews}})'**
  String reviewCountLabel(int count);

  /// No description provided for @topRatedChip.
  ///
  /// In en, this message translates to:
  /// **'Top Rated'**
  String get topRatedChip;

  /// No description provided for @bioLabel.
  ///
  /// In en, this message translates to:
  /// **'Bio / Description'**
  String get bioLabel;

  /// No description provided for @bioHint.
  ///
  /// In en, this message translates to:
  /// **'Tell clients about your skills and experience...'**
  String get bioHint;

  /// No description provided for @pleaseEnterBio.
  ///
  /// In en, this message translates to:
  /// **'Please enter a bio'**
  String get pleaseEnterBio;

  /// No description provided for @bioMinLength.
  ///
  /// In en, this message translates to:
  /// **'Bio should be at least {min} characters'**
  String bioMinLength(int min);

  /// No description provided for @yourLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Location'**
  String get yourLocationTitle;

  /// No description provided for @locationHelpMatchNearbyClients.
  ///
  /// In en, this message translates to:
  /// **'Your location helps us match you with nearby clients'**
  String get locationHelpMatchNearbyClients;

  /// No description provided for @locationHelpUpdateToFindJobs.
  ///
  /// In en, this message translates to:
  /// **'Update your location to find jobs in different areas'**
  String get locationHelpUpdateToFindJobs;

  /// No description provided for @useMyCurrentLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Use My Current Location'**
  String get useMyCurrentLocationTitle;

  /// No description provided for @gpsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get location automatically using GPS'**
  String get gpsSubtitle;

  /// No description provided for @orLabel.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get orLabel;

  /// No description provided for @enterYourAddressTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Address'**
  String get enterYourAddressTitle;

  /// No description provided for @fullAddressLabel.
  ///
  /// In en, this message translates to:
  /// **'Full Address'**
  String get fullAddressLabel;

  /// No description provided for @fullAddressHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., 123 Main St, Accra, Ghana'**
  String get fullAddressHint;

  /// No description provided for @find.
  ///
  /// In en, this message translates to:
  /// **'Find'**
  String get find;

  /// No description provided for @addressHelpText.
  ///
  /// In en, this message translates to:
  /// **'Enter your street address, city, and country'**
  String get addressHelpText;

  /// No description provided for @coordinatesAutoFilledTitle.
  ///
  /// In en, this message translates to:
  /// **'Coordinates (Auto-filled)'**
  String get coordinatesAutoFilledTitle;

  /// No description provided for @servicePricingTitle.
  ///
  /// In en, this message translates to:
  /// **'Service Pricing'**
  String get servicePricingTitle;

  /// No description provided for @servicePricingHelp.
  ///
  /// In en, this message translates to:
  /// **'Set your price for each service. Check \"Not Offered\" for services you cannot provide.'**
  String get servicePricingHelp;

  /// No description provided for @serviceHeader.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get serviceHeader;

  /// No description provided for @priceHeader.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get priceHeader;

  /// No description provided for @notOfferedHeader.
  ///
  /// In en, this message translates to:
  /// **'Not Offered'**
  String get notOfferedHeader;

  /// No description provided for @priceHint.
  ///
  /// In en, this message translates to:
  /// **'0.00'**
  String get priceHint;

  /// No description provided for @providerHowPricingWorksTitle.
  ///
  /// In en, this message translates to:
  /// **'How Pricing Works:'**
  String get providerHowPricingWorksTitle;

  /// No description provided for @providerHowPricingWorksBody.
  ///
  /// In en, this message translates to:
  /// **'• Your price is what you charge for the service\n• Transportation cost = 80% of user\'s currency per km\n• Users see 3 options based on nearby providers:\n  - Budget: Lowest price among nearby providers\n  - Standard: Average price of nearby providers\n  - Priority: Highest price among nearby providers'**
  String get providerHowPricingWorksBody;

  /// No description provided for @availableForBookingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Available for Bookings'**
  String get availableForBookingsTitle;

  /// No description provided for @availableOnHelp.
  ///
  /// In en, this message translates to:
  /// **'✓ You will appear in search results for nearby clients'**
  String get availableOnHelp;

  /// No description provided for @availableOffHelp.
  ///
  /// In en, this message translates to:
  /// **'✗ You will not receive new job offers'**
  String get availableOffHelp;

  /// No description provided for @completeSetupStartEarning.
  ///
  /// In en, this message translates to:
  /// **'Complete Setup & Start Earning'**
  String get completeSetupStartEarning;

  /// No description provided for @updateProfile.
  ///
  /// In en, this message translates to:
  /// **'Update Profile'**
  String get updateProfile;

  /// No description provided for @skipForNow.
  ///
  /// In en, this message translates to:
  /// **'Skip for Now'**
  String get skipForNow;

  /// No description provided for @paymentsNotSupportedShort.
  ///
  /// In en, this message translates to:
  /// **'Payments are not supported on this platform. Please use Android, iOS, macOS, or Web.'**
  String get paymentsNotSupportedShort;

  /// No description provided for @genericContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get genericContact;

  /// No description provided for @genericProvider.
  ///
  /// In en, this message translates to:
  /// **'Provider'**
  String get genericProvider;

  /// No description provided for @genericNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get genericNotAvailable;

  /// No description provided for @reviewSelectRatingPrompt.
  ///
  /// In en, this message translates to:
  /// **'Select a rating (1 to 5).'**
  String get reviewSelectRatingPrompt;

  /// No description provided for @reviewCommentOptionalLabel.
  ///
  /// In en, this message translates to:
  /// **'Comment (optional)'**
  String get reviewCommentOptionalLabel;

  /// No description provided for @genericCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get genericCancel;

  /// No description provided for @genericSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get genericSubmit;

  /// No description provided for @reviewSubmitFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to submit review.'**
  String get reviewSubmitFailed;

  /// No description provided for @rateThisService.
  ///
  /// In en, this message translates to:
  /// **'Rate this service'**
  String get rateThisService;

  /// No description provided for @tipLeaveTitle.
  ///
  /// In en, this message translates to:
  /// **'Leave a tip'**
  String get tipLeaveTitle;

  /// No description provided for @tipChooseAmountPrompt.
  ///
  /// In en, this message translates to:
  /// **'Choose a tip amount, or enter a custom amount.'**
  String get tipChooseAmountPrompt;

  /// No description provided for @tipNoTip.
  ///
  /// In en, this message translates to:
  /// **'No tip'**
  String get tipNoTip;

  /// No description provided for @tipCustomAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Custom tip amount'**
  String get tipCustomAmountLabel;

  /// No description provided for @genericContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get genericContinue;

  /// No description provided for @tipSkipped.
  ///
  /// In en, this message translates to:
  /// **'Tip skipped.'**
  String get tipSkipped;

  /// No description provided for @tipFailedToSaveChoice.
  ///
  /// In en, this message translates to:
  /// **'Failed to save tip choice.'**
  String get tipFailedToSaveChoice;

  /// No description provided for @tipFailedToCreatePayment.
  ///
  /// In en, this message translates to:
  /// **'Failed to create tip payment.'**
  String get tipFailedToCreatePayment;

  /// No description provided for @tipPaidSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Tip paid successfully. Thank you!'**
  String get tipPaidSuccessfully;

  /// No description provided for @tipPaidButUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Tip payment succeeded, but updating the booking failed.'**
  String get tipPaidButUpdateFailed;

  /// No description provided for @tipCancelledOrFailed.
  ///
  /// In en, this message translates to:
  /// **'Tip cancelled/failed: {message}'**
  String tipCancelledOrFailed(Object message);

  /// No description provided for @tipUnexpectedError.
  ///
  /// In en, this message translates to:
  /// **'Unexpected tip error: {error}'**
  String tipUnexpectedError(Object error);

  /// No description provided for @tipAlreadyPaidLabel.
  ///
  /// In en, this message translates to:
  /// **'Tip already paid'**
  String get tipAlreadyPaidLabel;

  /// No description provided for @tipSkippedLabel.
  ///
  /// In en, this message translates to:
  /// **'Tip skipped'**
  String get tipSkippedLabel;

  /// No description provided for @tipLeaveButton.
  ///
  /// In en, this message translates to:
  /// **'Leave a tip'**
  String get tipLeaveButton;

  /// No description provided for @walletTitle.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get walletTitle;

  /// No description provided for @walletTooltip.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get walletTooltip;

  /// No description provided for @payoutSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Payout Settings'**
  String get payoutSettingsTitle;

  /// No description provided for @payoutSettingsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Payout settings'**
  String get payoutSettingsTooltip;

  /// No description provided for @walletNoWalletYet.
  ///
  /// In en, this message translates to:
  /// **'No wallet yet. Complete jobs to earn.'**
  String get walletNoWalletYet;

  /// No description provided for @walletCurrencyFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get walletCurrencyFieldLabel;

  /// No description provided for @walletAvailableLine.
  ///
  /// In en, this message translates to:
  /// **'Available: {amount} {currency}'**
  String walletAvailableLine(Object amount, Object currency);

  /// No description provided for @walletPendingLine.
  ///
  /// In en, this message translates to:
  /// **'Pending: {amount} {currency}'**
  String walletPendingLine(Object amount, Object currency);

  /// No description provided for @walletCashOutInstant.
  ///
  /// In en, this message translates to:
  /// **'Cash Out (Instant)'**
  String get walletCashOutInstant;

  /// No description provided for @walletCashOutFailed.
  ///
  /// In en, this message translates to:
  /// **'Cash out failed.'**
  String get walletCashOutFailed;

  /// No description provided for @walletCashOutSentTransfer.
  ///
  /// In en, this message translates to:
  /// **'Cash out sent. Transfer: {transferId}'**
  String walletCashOutSentTransfer(Object transferId);

  /// No description provided for @walletTransactionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get walletTransactionsTitle;

  /// No description provided for @walletNoTransactionsYet.
  ///
  /// In en, this message translates to:
  /// **'No transactions yet.'**
  String get walletNoTransactionsYet;

  /// No description provided for @payoutAutoPayoutsTitle.
  ///
  /// In en, this message translates to:
  /// **'Auto payouts'**
  String get payoutAutoPayoutsTitle;

  /// No description provided for @payoutAutoPayoutsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Automatically send payouts on your chosen schedule.'**
  String get payoutAutoPayoutsSubtitle;

  /// No description provided for @payoutDayUtcLabel.
  ///
  /// In en, this message translates to:
  /// **'Payout day (UTC)'**
  String get payoutDayUtcLabel;

  /// No description provided for @payoutHourUtcLabel.
  ///
  /// In en, this message translates to:
  /// **'Payout hour (UTC)'**
  String get payoutHourUtcLabel;

  /// No description provided for @payoutMinimumAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Minimum auto payout amount'**
  String get payoutMinimumAmountLabel;

  /// No description provided for @payoutMinimumAmountHelper.
  ///
  /// In en, this message translates to:
  /// **'Auto payout runs only if available balance ≥ this amount.'**
  String get payoutMinimumAmountHelper;

  /// No description provided for @payoutInstantCashOutEnabledTitle.
  ///
  /// In en, this message translates to:
  /// **'Instant cash out enabled'**
  String get payoutInstantCashOutEnabledTitle;

  /// No description provided for @payoutInstantCashOutEnabledSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Allow the “Cash Out” button (fee applies).'**
  String get payoutInstantCashOutEnabledSubtitle;

  /// No description provided for @payoutSettingsSaved.
  ///
  /// In en, this message translates to:
  /// **'Payout settings saved.'**
  String get payoutSettingsSaved;

  /// No description provided for @payoutSettingsSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to save payout settings.'**
  String get payoutSettingsSaveFailed;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'af',
        'ak',
        'am',
        'ar',
        'de',
        'en',
        'fr',
        'ha',
        'he',
        'hi',
        'it',
        'ja',
        'ko',
        'ru',
        'sw',
        'ur',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'af':
      return AppLocalizationsAf();
    case 'ak':
      return AppLocalizationsAk();
    case 'am':
      return AppLocalizationsAm();
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
    case 'ha':
      return AppLocalizationsHa();
    case 'he':
      return AppLocalizationsHe();
    case 'hi':
      return AppLocalizationsHi();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'ru':
      return AppLocalizationsRu();
    case 'sw':
      return AppLocalizationsSw();
    case 'ur':
      return AppLocalizationsUr();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
