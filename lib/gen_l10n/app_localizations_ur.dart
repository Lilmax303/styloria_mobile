// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get appTitle => 'Styloria';

  @override
  String get account => 'اکاؤنٹ';

  @override
  String get profile => 'پروفائل';

  @override
  String get myBookings => 'میری بکنگز';

  @override
  String get openJobs => 'اوپن جابز';

  @override
  String get earnings => 'کمائی';

  @override
  String get paymentMethods => 'ادائیگی کے طریقے';

  @override
  String get referFriends => 'دوستوں کو ریفر کریں';

  @override
  String get language => 'زبان';

  @override
  String get settings => 'سیٹنگز';

  @override
  String get darkMode => 'ڈارک موڈ';

  @override
  String get systemDefault => 'سسٹم ڈیفالٹ';

  @override
  String get languageUpdated => 'زبان اپڈیٹ ہو گئی';

  @override
  String get languageSetToSystemDefault => 'زبان سسٹم ڈیفالٹ پر سیٹ ہو گئی';

  @override
  String get helpAndSupport => 'مدد اور سپورٹ';

  @override
  String get chatWithCustomerService => 'کسٹمر سروس سے چیٹ کریں';

  @override
  String get aboutAndPolicies => 'تعارف اور پالیسیاں';

  @override
  String get viewUserPoliciesAndAgreements => 'یوزر پالیسیاں اور معاہدے دیکھیں';

  @override
  String get logOut => 'لاگ آؤٹ';

  @override
  String get deleteAccount => 'اکاؤنٹ حذف کریں';

  @override
  String get deleteAccountSubtitle => 'یہ عمل واپس نہیں ہو سکتا';

  @override
  String get deleteAccountTitle => 'اکاؤنٹ حذف کریں';

  @override
  String get deleteAccountConfirmBody =>
      'کیا آپ واقعی اپنا اکاؤنٹ حذف کرنا چاہتے ہیں؟\n\nیہ عمل آپ کو سائن آؤٹ کر دے گا اور آپ مستقل طور پر رسائی کھو سکتے ہیں۔';

  @override
  String get no => 'نہیں';

  @override
  String get yesDelete => 'ہاں، حذف کریں';

  @override
  String get deleteAccountSheetTitle => 'ہمیں افسوس ہے کہ آپ جا رہے ہیں۔';

  @override
  String get deleteAccountSheetPrompt =>
      'کیا آپ وجہ بتا سکتے ہیں؟ (جو لاگو ہو سب منتخب کریں)';

  @override
  String get deleteAccountSelectAtLeastOneReason =>
      'براہ کرم کم از کم ایک وجہ منتخب کریں۔';

  @override
  String get tellUsMoreOptional => 'مزید بتائیں (اختیاری)';

  @override
  String get suggestionsToImproveOptional => 'بہتری کی تجاویز (اختیاری)';

  @override
  String get deleteMyAccount => 'میرا اکاؤنٹ حذف کریں';

  @override
  String get cancel => 'منسوخ';

  @override
  String get failedToDeleteAccount =>
      'اکاؤنٹ حذف نہیں ہو سکا۔ دوبارہ کوشش کریں۔';

  @override
  String get choosePreferredLanguage => 'اپنی پسندیدہ زبان منتخب کریں';

  @override
  String get noteSomeTextMayStillAppearInEnglish =>
      'نوٹ: اس سے ایپ کی زبان بدل جائے گی۔ ترجمے شامل ہونے تک کچھ متن انگریزی میں نظر آ سکتا ہے۔';

  @override
  String languageSetToName(Object name) {
    return 'زبان $name پر سیٹ کر دی گئی';
  }

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get forgotPasswordTitle => 'Reset Your Password';

  @override
  String get forgotPasswordSubtitle =>
      'Enter your email address and we\'ll send you a code to reset your password.';

  @override
  String get resetPasswordTitle => 'Create New Password';

  @override
  String get resetPasswordSubtitle =>
      'Enter the code sent to your email and choose a new password.';

  @override
  String get sendResetCode => 'Send Reset Code';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get confirmPassword => 'پاس ورڈ کی تصدیق';

  @override
  String get verificationCode => 'Verification Code';

  @override
  String get invalidEmail => 'Please enter a valid email';

  @override
  String get invalidCode => 'Please enter a valid code';

  @override
  String get passwordTooShort => 'Password must be at least 8 characters';

  @override
  String get changeEmail => 'Use a different email';

  @override
  String get backToLogin => 'Back to Login';

  @override
  String get deletionReason1 => 'مجھے Styloria کی مزید ضرورت نہیں';

  @override
  String get deletionReason2 => 'اکاؤنٹ کی تصدیق (ای میل/KYC) میں مسئلہ ہوا';

  @override
  String get deletionReason3 => 'میرے نزدیک سروسز/پرووائیڈرز نہیں ملے';

  @override
  String get deletionReason4 => 'قیمتیں یا فیس بہت زیادہ/غیر واضح تھیں';

  @override
  String get deletionReason5 => 'ایپ سمجھنے میں مشکل / استعمال میں مشکل تھی';

  @override
  String get deletionReason6 => 'بگز یا کارکردگی کے مسائل';

  @override
  String get deletionReason7 => 'ادائیگی/ریفنڈ کے مسائل';

  @override
  String get deletionReason8 => 'کسی پرووائیڈر/یوزر کے ساتھ برا تجربہ';

  @override
  String get deletionReason9 => 'پرائیویسی یا سکیورٹی سے متعلق خدشات';

  @override
  String get deletionReason10 => 'میں نے غلطی سے یہ اکاؤنٹ بنایا';

  @override
  String get deletionReason11 => 'میں کسی اور پلیٹ فارم پر جا رہا ہوں';

  @override
  String get deletionReason12 => 'دیگر';

  @override
  String get loginWelcomeTitle => 'Styloria میں خوش آمدید';

  @override
  String get loginWelcomeSubtitle =>
      'اپنی بکنگز اور سروسز مینیج کرنے کے لیے لاگ اِن کریں۔';

  @override
  String get loginFailedToLoadUserInfo =>
      'لاگ اِن کامیاب ہوا لیکن صارف کی معلومات لوڈ نہیں ہو سکیں۔';

  @override
  String get username => 'یوزرنیم';

  @override
  String get password => 'پاس ورڈ';

  @override
  String get required => 'ضروری';

  @override
  String get login => 'لاگ اِن';

  @override
  String get createNewAccount => 'نیا اکاؤنٹ بنائیں';

  @override
  String get requestEmailVerificationCode => 'ای میل ویریفیکیشن کوڈ مانگیں';

  @override
  String get createAccountTitle => 'اکاؤنٹ بنائیں';

  @override
  String get joinStyloria => 'Styloria میں شامل ہوں';

  @override
  String get registerSubtitle =>
      'سروسز بک کرنے یا پرووائیڈر بننے کے لیے اکاؤنٹ بنائیں';

  @override
  String get iWantTo => 'میں چاہتا/چاہتی ہوں:';

  @override
  String get bookServices => 'سروسز بک کریں';

  @override
  String get provideServices => 'سروسز فراہم کریں';

  @override
  String get personalInformation => 'ذاتی معلومات';

  @override
  String get firstName => 'پہلا نام';

  @override
  String get lastName => 'آخری نام';

  @override
  String get selectDateOfBirth => 'تاریخِ پیدائش منتخب کریں';

  @override
  String get phoneNumber => 'فون نمبر';

  @override
  String get pleaseEnterPhoneNumber => 'براہ کرم فون نمبر درج کریں';

  @override
  String get accountInformation => 'اکاؤنٹ معلومات';

  @override
  String get chooseUniqueUsernameHint => 'ایک منفرد یوزرنیم منتخب کریں';

  @override
  String get youAreCurrentlyUnavailable => 'آپ فی الحال دستیاب نہیں ہیں';

  @override
  String get toBrowseAndAcceptJobsEnableAvailability =>
      'قریبی کام کی درخواستیں دیکھنے اور قبول کرنے کے لیے، آپ کو بکنگ کے لیے دستیاب ہونا ضروری ہے۔';

  @override
  String get goToProfileSettings => 'پروفائل سیٹنگز پر جائیں';

  @override
  String get tipToggleAvailableForBookings =>
      'مشورہ: کام کی درخواستیں حاصل کرنا شروع کرنے کے لیے اپنے پرووائیڈر پروفائل میں \"بکنگ کے لیے دستیاب\" آن کریں۔';

  @override
  String requestedBy(String name) {
    return 'درخواست کنندہ: $name';
  }

  @override
  String locationLabel(String address) {
    return 'مقام: $address';
  }

  @override
  String get email => 'ای میل';

  @override
  String get emailHint => 'your@email.com';

  @override
  String get enterValidEmail => 'درست ای میل درج کریں';

  @override
  String get security => 'سکیورٹی';

  @override
  String get passwordHintAtLeast10 => 'کم از کم 10 حروف';

  @override
  String get passwordMin10 => 'پاس ورڈ کم از کم 10 حروف کا ہونا چاہیے';

  @override
  String get iAgreeTo => 'میں متفق ہوں ';

  @override
  String get termsOfService => 'سروس کی شرائط';

  @override
  String get and => 'اور';

  @override
  String get privacyPolicy => 'رازداری کی پالیسی';

  @override
  String get passwordIsRequired => 'پاس ورڈ ضروری ہے';

  @override
  String get passwordsDoNotMatch => 'پاس ورڈز میچ نہیں کرتے';

  @override
  String get pleaseSelectDob => 'براہ کرم اپنی تاریخِ پیدائش منتخب کریں۔';

  @override
  String get pleaseSelectCountry => 'براہ کرم اپنا ملک منتخب کریں۔';

  @override
  String get pleaseSelectCity => 'براہ کرم اپنا شہر منتخب کریں۔';

  @override
  String get pleaseEnterValidPhone => 'براہ کرم درست فون نمبر درج کریں۔';

  @override
  String get mustAcceptTerms => 'آپ کو شرائط و ضوابط قبول کرنا ہوں گے۔';

  @override
  String get mustBeAtLeast18 =>
      'رجسٹر ہونے کے لیے آپ کی عمر کم از کم 18 سال ہونی چاہیے۔';

  @override
  String get agreeToTerms =>
      'میں سروس کی شرائط اور پرائیویسی پالیسی سے اتفاق کرتا/کرتی ہوں';

  @override
  String get createAccountButton => 'اکاؤنٹ بنائیں';

  @override
  String get alreadyHaveAccount => 'کیا آپ کے پاس پہلے سے اکاؤنٹ ہے؟';

  @override
  String get emailVerifiedSuccessPleaseLogin =>
      'ای میل کامیابی سے ویریفائی ہوگئی۔ براہ کرم لاگ اِن کریں۔';

  @override
  String get pleaseVerifyEmailToContinue =>
      'جاری رکھنے کے لیے براہ کرم اپنی ای میل ویریفائی کریں۔';

  @override
  String get requestVerificationCodeTitle => 'ویریفیکیشن کوڈ کی درخواست';

  @override
  String get requestVerificationInstructions =>
      'اپنی ای میل یا یوزرنیم درج کریں۔\nہم اس اکاؤنٹ کی ای میل پر نیا ویریفیکیشن کوڈ بھیجیں گے۔';

  @override
  String get emailOrUsername => 'ای میل یا یوزرنیم';

  @override
  String get sendCode => 'کوڈ بھیجیں';

  @override
  String get ifAccountExistsCodeSent =>
      'اگر اکاؤنٹ موجود ہے تو کوڈ بھیج دیا گیا ہے۔';

  @override
  String get failedToSendVerificationCode =>
      'ویریفیکیشن کوڈ بھیجنے میں ناکامی۔';

  @override
  String get verifyYourEmailTitle => 'اپنی ای میل ویریفائی کریں';

  @override
  String get verificationCodeSentInfo =>
      'اس اکاؤنٹ کی ای میل پر ویریفیکیشن کوڈ بھیجا گیا ہے۔';

  @override
  String emailVerificationInstructions(Object identifier) {
    return 'اس اکاؤنٹ کی ای میل پر بھیجا گیا 6 ہندسوں کا کوڈ درج کریں:\n$identifier';
  }

  @override
  String get verificationCodeLabel => 'ویریفیکیشن کوڈ';

  @override
  String get sendingEllipsis => 'بھیج رہے ہیں...';

  @override
  String get resendCode => 'کوڈ دوبارہ بھیجیں';

  @override
  String get enter6DigitCodeError => '6 ہندسوں کا کوڈ درج کریں۔';

  @override
  String get verifyingEllipsis => 'ویریفائی کر رہے ہیں...';

  @override
  String get verify => 'تصدیق کریں';

  @override
  String get invalidOrExpiredCodeTryResending =>
      'کوڈ غلط یا میعاد ختم ہو چکی ہے۔ دوبارہ بھیج کر دیکھیں۔';

  @override
  String bookingTitle(Object id) {
    return 'بکنگ #$id';
  }

  @override
  String get invalidBookingIdForChat => 'چیٹ کے لیے بکنگ آئی ڈی غلط ہے۔';

  @override
  String get invalidBookingIdForCall => 'کال کے لیے بکنگ آئی ڈی غلط ہے۔';

  @override
  String get unableToLoadContactInfo =>
      'رابطہ معلومات لوڈ نہیں ہو سکیں۔ یقین کریں کہ بکنگ فعال ہے۔';

  @override
  String noPhoneNumberAvailableForName(Object name) {
    return '$name کے لیے کوئی فون نمبر دستیاب نہیں۔';
  }

  @override
  String get deviceCannotPlaceCalls => 'یہ ڈیوائس فون کال نہیں کر سکتی۔';

  @override
  String get cancelBookingDialogTitle => 'بکنگ منسوخ کریں';

  @override
  String get cancelBookingDialogBody =>
      'کیا آپ واقعی اس بکنگ کو منسوخ کرنا چاہتے ہیں؟\n\nنوٹ: اگر فراہم کنندہ نے پہلے ہی قبول کر لیا ہے اور 7 منٹ سے زیادہ (لیکن تقریباً 40 منٹ سے کم) گزر چکے ہیں تو قواعد کے مطابق جرمانہ لگ سکتا ہے۔';

  @override
  String get yesCancel => 'ہاں، منسوخ کریں';

  @override
  String get failedToCancelBooking => 'بکنگ منسوخ نہیں ہو سکی۔';

  @override
  String bookingCancelledPenaltyApplied(Object amount) {
    return 'بکنگ منسوخ کر دی گئی۔ $amount کا جرمانہ لاگو کیا گیا ہے۔';
  }

  @override
  String get bookingCancelledSuccessfully => 'بکنگ کامیابی سے منسوخ ہو گئی۔';

  @override
  String get failedToConfirmCompletion =>
      'تکمیل کی تصدیق ناکام رہی۔ براہ کرم دوبارہ کوشش کریں۔';

  @override
  String get bothSidesConfirmedCompletedPayoutReleased =>
      'دونوں طرف سے تصدیق ہو گئی۔ بکنگ مکمل قرار دے دی گئی اور ادائیگی جاری کر دی گئی۔';

  @override
  String get youConfirmedCompletionWaitingForProvider =>
      'آپ نے تکمیل کی تصدیق کر دی۔ فراہم کنندہ کی تصدیق کا انتظار ہے۔';

  @override
  String get youConfirmedCompletionWaitingForUser =>
      'آپ نے تکمیل کی تصدیق کر دی۔ صارف کی تصدیق کا انتظار ہے۔';

  @override
  String get statusUnknown => 'نامعلوم';

  @override
  String get statusAccepted => 'قبول شدہ';

  @override
  String get statusInProgress => 'جاری';

  @override
  String get statusCompleted => 'مکمل';

  @override
  String get statusCancelled => 'منسوخ';

  @override
  String get paymentPaid => 'ادا شدہ';

  @override
  String get paymentPending => 'زیرِ التواء';

  @override
  String get paymentFailed => 'ناکام';

  @override
  String bookingAcceptedBy(Object name) {
    return 'بکنگ $name نے قبول کی';
  }

  @override
  String get whenLabel => 'کب';

  @override
  String atTime(Object time) {
    return '$time پر';
  }

  @override
  String get userLabel => 'صارف';

  @override
  String get providerLabel => 'فراہم کنندہ';

  @override
  String get estimatedPriceLabel => 'اندازاً قیمت';

  @override
  String get offeredPaidLabel => 'پیشکش / ادا شدہ';

  @override
  String get distanceLabel => 'فاصلہ';

  @override
  String distanceMiles(Object miles) {
    return '$miles میل';
  }

  @override
  String get acceptedAtLabel => 'قبول کیا گیا';

  @override
  String get cancelledAtLabel => 'منسوخ کیا گیا';

  @override
  String get cancelledByLabel => 'منسوخ کرنے والا';

  @override
  String penaltyAppliedLabel(Object amount) {
    return 'جرمانہ لاگو: $amount';
  }

  @override
  String get userConfirmedLabel => 'صارف نے تصدیق کی';

  @override
  String get providerConfirmedLabel => 'فراہم کنندہ نے تصدیق کی';

  @override
  String get payoutReleasedLabel => 'ادائیگی جاری';

  @override
  String get yesLower => 'ہاں';

  @override
  String get noLower => 'نہیں';

  @override
  String get chat => 'چیٹ';

  @override
  String get call => 'کال';

  @override
  String get actions => 'کارروائیاں';

  @override
  String get confirmCompletion => 'تکمیل کی تصدیق کریں';

  @override
  String get noFurtherActionsForBooking =>
      'اس بکنگ کے لیے مزید کوئی کارروائی دستیاب نہیں۔';

  @override
  String freeCancellationEndsIn(Object time) {
    return 'بلا جرمانہ منسوخی $time میں ختم ہو جائے گی';
  }

  @override
  String get earlyFreeCancellationEndedWarning =>
      'ابتدائی بلا جرمانہ منسوخی ختم ہو گئی ہے۔ قبولیت کے بعد تقریباً 40 منٹ تک، دیر سے منسوخی پر جرمانہ لگ سکتا ہے۔';

  @override
  String get cancelBooking => 'بکنگ منسوخ کریں';

  @override
  String get cancelBookingNoPenalty => 'بکنگ منسوخ کریں (بلا جرمانہ)';

  @override
  String get cancelBookingPenaltyMayApply =>
      'بکنگ منسوخ کریں (جرمانہ لگ سکتا ہے)';

  @override
  String get cancellationPolicyInfo =>
      'فراہم کنندہ کے قبول کرنے کے بعد پہلے 7 منٹ میں آپ بلا جرمانہ منسوخ کر سکتے ہیں، اور ضرورت ہو تو تقریباً 40 منٹ بعد دوبارہ بلا جرمانہ منسوخ کر سکتے ہیں۔ ان اوقات کے درمیان قواعد کے مطابق جرمانہ لگ سکتا ہے۔';

  @override
  String ratingLine(Object rating, int reviewCount) {
    String _temp0 = intl.Intl.pluralLogic(
      reviewCount,
      locale: localeName,
      other: '$reviewCount ریویوز',
      one: '1 ریویو',
    );
    return 'ریٹنگ: $rating ($_temp0)';
  }

  @override
  String get proofOfSkillsPortfolio => 'مہارت کا ثبوت (پورٹ فولیو)';

  @override
  String get noPortfolioPostsAvailable => 'کوئی پورٹ فولیو پوسٹس دستیاب نہیں۔';

  @override
  String get bookingLocation => 'بکنگ مقام';

  @override
  String get location => 'مقام';

  @override
  String get latitude => 'عرضِ بلد';

  @override
  String get longitude => 'طولِ بلد';

  @override
  String get mapWillAppearWhenCoordinatesValid =>
      'جب کوآرڈینیٹس درست ہوں گے تو نقشہ یہاں ظاہر ہوگا۔';

  @override
  String chatForBookingTitle(Object id) {
    return 'بکنگ #$id کے لیے چیٹ';
  }

  @override
  String get unableToStartChat =>
      'چیٹ شروع نہیں ہو سکی۔ چیٹ صرف اس وقت دستیاب ہے جب بکنگ قبول ہو، جاری ہو، یا پچھلے ایک دن کے اندر مکمل ہوئی ہو۔';

  @override
  String get invalidChatThreadFromServer => 'سرور سے غلط چیٹ تھریڈ موصول ہوا۔';

  @override
  String get messageNotSentPolicy =>
      'پیغام نہیں بھیجا گیا۔ نوٹ: چیٹ میں فون نمبر یا ای میل شیئر کرنا منع ہے۔';

  @override
  String get unknown => 'نامعلوم';

  @override
  String get typeMessageHint => 'سپورٹ کو پیغام لکھیں...';

  @override
  String get uploadProfilePicture => 'پروفائل تصویر اپلوڈ کریں';

  @override
  String get currentProfilePicture => 'موجودہ پروفائل تصویر';

  @override
  String get newPicturePreview => 'نئی تصویر کا پیش منظر';

  @override
  String get chooseImage => 'تصویر منتخب کریں';

  @override
  String get upload => 'اپلوڈ';

  @override
  String get noImageBytesFoundWeb => 'تصویر کے بائٹس نہیں ملے (ویب)۔';

  @override
  String get pleasePickAnImageFirst => 'براہ کرم پہلے تصویر منتخب کریں۔';

  @override
  String get uploadFailedCheckServerLogs =>
      'اپلوڈ ناکام۔ سرور لاگز / ٹوکن چیک کریں۔';

  @override
  String get profilePictureUploadedSuccessfully =>
      'پروفائل تصویر کامیابی سے اپلوڈ ہو گئی!';

  @override
  String errorWithValue(Object error) {
    return 'خرابی: $error';
  }

  @override
  String get tapToChangeProfilePicture => 'پروفائل تصویر بدلنے کے لیے ٹیپ کریں';

  @override
  String usernameValue(Object username) {
    return 'یوزرنیم: $username';
  }

  @override
  String roleValue(Object role) {
    return 'کردار: $role';
  }

  @override
  String get dateOfBirthYyyyMmDd => 'تاریخِ پیدائش (YYYY-MM-DD)';

  @override
  String get saveProfile => 'پروفائل محفوظ کریں';

  @override
  String get failedToSaveProfile =>
      'پروفائل محفوظ نہیں ہو سکا۔ دوبارہ کوشش کریں۔';

  @override
  String get profileUpdated => 'پروفائل اپڈیٹ ہو گیا۔';

  @override
  String get completeYourProviderProfile =>
      'اپنا فراہم کنندہ پروفائل مکمل کریں';

  @override
  String get completeProviderProfileBody =>
      'کام قبول کرنے اور پیسے کمانے کے لیے اپنا فراہم کنندہ پروفائل مکمل کریں۔';

  @override
  String get setupProfileNow => 'ابھی پروفائل سیٹ اپ کریں';

  @override
  String get doItLater => 'بعد میں';

  @override
  String get bookingTimerPenaltyPeriodActive => 'جرمانے کی مدت فعال ہے';

  @override
  String get bookingTimerFreeCancellationPeriod => 'بلا جرمانہ منسوخی کی مدت';

  @override
  String bookingTimerTimeRemaining(Object time) {
    return 'باقی وقت: $time';
  }

  @override
  String get bookingTimerCancellingNowPenalty =>
      'اب منسوخ کرنے پر 10% جرمانہ ہوگا۔';

  @override
  String get bookingTimerCancelNoPenalty => 'آپ بلا جرمانہ منسوخ کر سکتے ہیں۔';

  @override
  String get myReviewsTitle => 'میری ریویوز';

  @override
  String get failedToLoadReviews => 'ریویوز لوڈ نہیں ہو سکیں۔';

  @override
  String get noReviewsYet => 'آپ نے ابھی تک کوئی ریویو نہیں دیا۔';

  @override
  String providerWithName(Object name) {
    return 'فراہم کنندہ: $name';
  }

  @override
  String get providerGeneric => 'فراہم کنندہ';

  @override
  String ratingWithValue(Object rating) {
    return 'ریٹنگ: $rating';
  }

  @override
  String get nearbyOpenJobsTitle => 'قریب موجود اوپن جابز';

  @override
  String get failedToLoadOpenJobsHint =>
      'اوپن جابز لوڈ نہیں ہو سکیں۔\nیقین کریں کہ آپ کے پاس لوکیشن کے ساتھ پرووائیڈر پروفائل ہے اور available=true ہے۔';

  @override
  String errorLoadingJobsWithValue(Object error) {
    return 'جابز لوڈ کرنے میں خرابی: $error';
  }

  @override
  String get noOpenJobsFoundNearbyTitle => 'قریب کوئی اوپن جاب نہیں ملی';

  @override
  String get noOpenJobsFoundNearbyBody =>
      'یقین کریں:\n- آپ نے اپنی پرووائیڈر لوکیشن سیٹ کی ہے\n- آپ دستیاب ہیں\n- یوزرز نے بکنگ بنائی اور ادائیگی کی ہے';

  @override
  String currencyLabel(Object symbol) {
    return 'کرنسی: $symbol';
  }

  @override
  String pricesShownInCurrency(Object symbol, Object country) {
    return 'قیمتیں $symbol ($country) میں دکھائی جا رہی ہیں';
  }

  @override
  String jobTitleWithId(Object id) {
    return 'جاب #$id';
  }

  @override
  String serviceLine(Object service) {
    return 'سروس: $service';
  }

  @override
  String whenLine(Object date, Object time) {
    return 'وقت: $date $time';
  }

  @override
  String priceLine(Object price) {
    return 'قیمت: $price';
  }

  @override
  String get acceptJob => 'جاب قبول کریں';

  @override
  String get failedToAcceptJob => 'جاب قبول نہیں ہو سکی۔';

  @override
  String get jobAcceptedSuccessfully => 'جاب کامیابی سے قبول ہو گئی۔';

  @override
  String get newServiceRequestTitle => 'نیا سروس ریکویسٹ';

  @override
  String get reviewAlreadySubmitted => 'Review submitted ✓';

  @override
  String get offeredPriceLabel => 'پیش کردہ قیمت';

  @override
  String get offeredPriceHint => 'مثلاً 25.00';

  @override
  String get enterValidPrice => 'درست قیمت درج کریں';

  @override
  String get bookAndPay => 'بک اور ادائیگی';

  @override
  String bookAndPayAmount(Object amount) {
    return 'بک اور ادائیگی $amount';
  }

  @override
  String get haircutService => 'ہیئر کٹ';

  @override
  String get stylingService => 'اسٹائلنگ';

  @override
  String get timeLabel => 'وقت:';

  @override
  String get notesLabel => 'نوٹس';

  @override
  String get requestCreatedAndPaidBroadcast =>
      'ریکویسٹ بن گئی اور ادا ہو گئی! پرووائیڈرز کو بھیج دی گئی۔';

  @override
  String locationLatLng(Object lat, Object lng) {
    return 'لوکیشن: $lat, $lng';
  }

  @override
  String get paymentMethodsTitle => 'ادائیگی کے طریقے';

  @override
  String get paymentPreferencesInfo =>
      'یہ ترجیحات آپ کے ڈیوائس پر لوکلی محفوظ ہوتی ہیں۔ اصل ادائیگیاں Stripe/دیگر گیٹ ویز کے ذریعے محفوظ طریقے سے ہوتی ہیں۔';

  @override
  String get preferredMethodLabel =>
      'پسندیدہ طریقہ (ملک کے مطابق لوکل گیٹ وے منتخب ہوگا)';

  @override
  String get methodVisaMastercard => 'Visa/Mastercard';

  @override
  String get methodMobileMoney => 'Mobile Money (Momo/Paystack/Africa)';

  @override
  String get methodPaypal => 'PayPal';

  @override
  String get methodApplePayGooglePay => 'Apple Pay/Google Pay';

  @override
  String get methodWeChatPay => 'WeChat Pay (China)';

  @override
  String get methodAlipay => 'Alipay (China)';

  @override
  String get methodUnionPay => 'UnionPay Card (China)';

  @override
  String get mobileMoneyNumberLabel => 'موبائل منی نمبر';

  @override
  String get wechatAlipayIdLabel => 'WeChat/Alipay ID';

  @override
  String get cardLast4DigitsLabel => 'کارڈ کے آخری 4 ہندسے';

  @override
  String get paypalEmailLabel => 'PayPal ای میل';

  @override
  String get applePayEnabledOnDevice => 'اس ڈیوائس پر Apple Pay فعال ہے';

  @override
  String get savePaymentPreferences => 'ادائیگی کی ترجیحات محفوظ کریں';

  @override
  String get paymentPrefsSavedInfo =>
      'ادائیگی کی ترجیحات لوکلی محفوظ ہو گئیں۔ اصل چارجنگ بعد میں Stripe/دیگر گیٹ ویز کے ذریعے ہوگی۔';

  @override
  String get failedToLoadImage => 'تصویر لوڈ نہیں ہو سکی';

  @override
  String get earningsTitle => 'کمائی';

  @override
  String get couldNotLoadEarningsSummary => 'کمائی کا خلاصہ لوڈ نہیں ہو سکا۔';

  @override
  String get noData => 'کوئی ڈیٹا نہیں۔';

  @override
  String get retry => 'دوبارہ کوشش کریں';

  @override
  String get summaryTitle => 'خلاصہ';

  @override
  String get totalLabel => 'کل';

  @override
  String get pendingLabel => 'زیرِ التوا';

  @override
  String get paidLabel => 'ادا شدہ';

  @override
  String get pdfReportTitle => 'PDF رپورٹ';

  @override
  String get periodLabel => 'مدت';

  @override
  String get periodThisMonth => 'اس ماہ';

  @override
  String get periodLastMonth => 'پچھلا ماہ';

  @override
  String get periodYtd => 'سال تا حال';

  @override
  String get periodAllTime => 'ہر وقت';

  @override
  String get couldNotDownloadPdfReport => 'PDF رپورٹ ڈاؤن لوڈ نہیں ہو سکی۔';

  @override
  String couldNotOpenPdfWithValue(Object error) {
    return 'PDF نہیں کھل سکا: $error';
  }

  @override
  String get savingFilesNotSupportedWeb =>
      'ویب پر فی الحال فائل محفوظ کرنا سپورٹڈ نہیں۔';

  @override
  String savedToDocumentsIosWithPath(Object path) {
    return 'Documents (iOS) میں محفوظ ہوا:\n$path';
  }

  @override
  String savedToFilesWithPath(Object path) {
    return 'فائلز میں محفوظ ہوا:\n$path';
  }

  @override
  String get open => 'کھولیں';

  @override
  String failedToSavePdfWithValue(Object error) {
    return 'PDF محفوظ نہیں ہو سکا: $error';
  }

  @override
  String get openPdfReport => 'PDF رپورٹ کھولیں';

  @override
  String get savePdfToDownloads => 'PDF ڈاؤن لوڈز میں محفوظ کریں';

  @override
  String get reportWatermarkNote =>
      'رپورٹ PDF میں Styloria واٹرمارک شامل ہونا چاہیے۔';

  @override
  String get referFriendsTitle => 'دوستوں کو ریفر کریں';

  @override
  String get shareReferralCodeBody =>
      'اپنا ریفرل کوڈ دوستوں کے ساتھ شیئر کریں۔ بعد میں جب وہ سائن اپ کریں اور بکنگ مکمل کریں تو آپ انعامات شامل کر سکتے ہیں۔';

  @override
  String get yourReferralCodeLabel => 'آپ کا ریفرل کوڈ:';

  @override
  String get copy => 'کاپی';

  @override
  String referralCodeCopiedWithCode(Object code) {
    return 'ریفرل کوڈ کاپی ہو گیا: $code';
  }

  @override
  String get navHome => 'ہوم';

  @override
  String get navBookings => 'بکنگز';

  @override
  String get navNotifications => 'نوٹیفیکیشنز';

  @override
  String get navAccount => 'اکاؤنٹ';

  @override
  String get welcome => 'خوش آمدید';

  @override
  String welcomeName(Object name) {
    return 'خوش آمدید، $name';
  }

  @override
  String get toggleThemeTooltip => 'لائٹ/ڈارک موڈ تبدیل کریں';

  @override
  String loggedInAs(Object role) {
    return 'لاگ اِن بطور: $role';
  }

  @override
  String locationWithValue(Object value) {
    return 'لوکیشن: $value';
  }

  @override
  String get homeTagline =>
      'ریئل ٹائم بکنگز اور قابلِ اعتماد پرووائیڈرز کے ساتھ اپنی گرومنگ کا تجربہ بہتر بنائیں۔';

  @override
  String get manageProviderProfile => 'پرووائیڈر پروفائل مینیج کریں';

  @override
  String get browseOpenJobs => 'اوپن جابز دیکھیں';

  @override
  String get quickActions => 'فوری اقدامات';

  @override
  String get newBooking => 'نئی بکنگ';

  @override
  String notificationsWithUnread(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ان پڑھے',
      one: '1 ان پڑھا',
    );
    return 'نوٹیفیکیشنز ($_temp0)';
  }

  @override
  String get liveLocationTrackingTitle => 'لائیو لوکیشن ٹریکنگ';

  @override
  String get live => 'لائیو';

  @override
  String get locationServicesDisabled => 'لوکیشن سروسز بند ہیں۔';

  @override
  String get locationPermissionDenied => 'لوکیشن کی اجازت مسترد کر دی گئی۔';

  @override
  String get locationPermissionPermanentlyDenied =>
      'لوکیشن کی اجازت مستقل طور پر مسترد ہے۔ براہِ کرم سیٹنگز میں فعال کریں۔';

  @override
  String failedToGetLocationWithValue(Object error) {
    return 'لوکیشن حاصل نہیں ہو سکی: $error';
  }

  @override
  String get youProvider => 'آپ (پرووائیڈر)';

  @override
  String get youCustomer => 'آپ (کسٹمر)';

  @override
  String get customer => 'کسٹمر';

  @override
  String get bookingDetails => 'بکنگ کی تفصیل';

  @override
  String get navigate => 'نیویگیٹ';

  @override
  String get failedToLoadNotifications => 'نوٹیفیکیشنز لوڈ نہیں ہو سکیں۔';

  @override
  String get failedToMarkAsRead => 'پڑھا ہوا مارک نہیں ہو سکا';

  @override
  String get noNotificationsYet => 'ابھی کوئی نوٹیفیکیشن نہیں۔';

  @override
  String get markRead => 'پڑھا ہوا';

  @override
  String get providerKycTitle => 'فراہم کنندہ کی تصدیق (KYC)';

  @override
  String get logoutTooltip => 'لاگ آؤٹ';

  @override
  String statusLabel(Object status) {
    return 'اسٹیٹس: $status';
  }

  @override
  String rejectedWithNotes(Object notes) {
    return 'مسترد: $notes';
  }

  @override
  String get kycInstructions =>
      'فراہم کنندہ کی خصوصیات تک رسائی کے لیے، تصدیق کے لیے اپنی شناختی دستاویز اور ایک سیلفی اپلوڈ کریں۔';

  @override
  String get idFrontRequired => 'شناختی دستاویز سامنے (ضروری)';

  @override
  String get selectIdFront => 'شناختی دستاویز سامنے منتخب کریں';

  @override
  String get idBackRequired => 'شناختی دستاویز پیچھے (ضروری)';

  @override
  String get selectIdBackRequired => 'شناختی دستاویز پیچھے منتخب کریں';

  @override
  String get selfieRequired => 'سیلفی (ضروری)';

  @override
  String get selectSelfie => 'سیلفی منتخب کریں';

  @override
  String get takeSelfie => 'سیلفی لیں';

  @override
  String get errorUploadAllRequired =>
      'براہ کرم شناختی دستاویز (سامنے)، شناختی دستاویز (پیچھے)، اور سیلفی اپلوڈ کریں۔';

  @override
  String failedSubmitKycCode(Object code) {
    return 'KYC جمع کرانے میں ناکام (کوڈ $code).';
  }

  @override
  String submittedCurrentStatus(Object status) {
    return 'جمع ہو گیا۔ موجودہ اسٹیٹس: $status';
  }

  @override
  String get unknownStatus => 'نامعلوم';

  @override
  String get submitKyc => 'KYC جمع کریں';

  @override
  String get verificationMayTakeTimeNote =>
      'نوٹ: تصدیق میں وقت لگ سکتا ہے۔ منظوری کے بعد آپ فراہم کنندہ کی خصوصیات تک رسائی حاصل کر سکیں گے۔';

  @override
  String get reviewsReceivedTitle => 'Reviews Received';

  @override
  String get noReviewsYetHelpText =>
      'No reviews yet. Complete services to receive reviews from clients.';

  @override
  String failedToLoadReviewsWithError(Object error) {
    return 'Failed to load reviews: $error';
  }

  @override
  String providerArrivingTitle(Object name) {
    return '$name is on the way';
  }

  @override
  String get etaIsEstimate => '* Estimated time (actual route may vary)';

  @override
  String get enterVerificationCodeTitle => 'تصدیقی کوڈ درج کریں';

  @override
  String otpSentToUsername(Object username) {
    return 'ہم نے \"$username\" سے منسلک فون نمبر پر 6 ہندسوں کا کوڈ بھیجا ہے۔\n';
  }

  @override
  String get sixDigitCodeLabel => '6 ہندسوں کا کوڈ';

  @override
  String get enterSixDigitCodeValidation => '6 ہندسوں کا کوڈ درج کریں';

  @override
  String get otpInvalidOrExpired => 'غلط یا میعاد ختم شدہ کوڈ۔';

  @override
  String get failedLoadUserInfoAfterVerification =>
      'تصدیق کے بعد صارف کی معلومات لوڈ نہیں ہو سکیں۔';

  @override
  String get chatWithSupportTitle => 'سپورٹ سے چیٹ';

  @override
  String get unableStartSupportChat => 'سپورٹ چیٹ شروع نہیں ہو سکی۔';

  @override
  String get invalidSupportThreadReturned =>
      'سرور نے غلط سپورٹ تھریڈ واپس کیا۔';

  @override
  String get noMessagesYet => 'ابھی کوئی پیغام نہیں۔ گفتگو شروع کریں!';

  @override
  String get supportDefaultName => 'سپورٹ';

  @override
  String get aboutPoliciesTitle => 'تعارف اور پالیسیاں';

  @override
  String get newBookingTitle => 'نئی بکنگ';

  @override
  String get appointmentDetailsTitle => 'اپائنٹمنٹ کی تفصیلات';

  @override
  String get pickDate => 'تاریخ منتخب کریں';

  @override
  String get pickTime => 'وقت منتخب کریں';

  @override
  String get serviceTypeTitle => 'سروس کی قسم';

  @override
  String get serviceDropdownLabel => 'سروس';

  @override
  String get serviceHaircutLabel => 'ہیئر کٹ';

  @override
  String get serviceBraidsLabel => 'بریڈز';

  @override
  String get serviceShaveLabel => 'شیو';

  @override
  String get serviceHairColoringLabel => 'بال رنگ کرنا';

  @override
  String get serviceManicureLabel => 'مینیکیور';

  @override
  String get servicePedicureLabel => 'پیڈیکیور';

  @override
  String get serviceNailArtLabel => 'نیل آرٹ';

  @override
  String get serviceMakeupLabel => 'میک اپ';

  @override
  String get serviceFacialLabel => 'فیشل';

  @override
  String get serviceWaxingLabel => 'ویکسنگ';

  @override
  String get serviceMassageLabel => 'مساج';

  @override
  String get serviceTattooLabel => 'Tattoo';

  @override
  String get serviceHairStylingLabel => 'ہیئر اسٹائلنگ';

  @override
  String get serviceHairTreatmentLabel => 'ہیئر ٹریٹمنٹ';

  @override
  String get serviceHairExtensionsLabel => 'ہیئر ایکسٹینشنز';

  @override
  String get serviceOtherServicesLabel => 'دیگر سروسز';

  @override
  String get notesForProviderOptionalLabel =>
      'اپنے فراہم کنندہ کے لیے نوٹس (اختیاری)';

  @override
  String get locationTitle => 'مقام';

  @override
  String get latitudeLabel => 'عرضِ بلد';

  @override
  String get longitudeLabel => 'طولِ بلد';

  @override
  String get requiredField => 'ضروری';

  @override
  String get useMyCurrentLocation => 'میرا موجودہ مقام استعمال کریں';

  @override
  String pricesShownIn(Object symbol, Object country) {
    return 'قیمتیں $symbol میں دکھائی جا رہی ہیں ($country)';
  }

  @override
  String get chooseTimeLaterThanCurrent =>
      'براہِ کرم موجودہ وقت سے بعد کا وقت منتخب کریں۔';

  @override
  String get pleasePickDateAndTime => 'براہِ کرم تاریخ اور وقت منتخب کریں۔';

  @override
  String get locationUpdatedFromGps => 'GPS سے مقام اپڈیٹ ہو گیا۔';

  @override
  String failedToGetLocation(Object error) {
    return 'مقام حاصل کرنے میں ناکامی: $error';
  }

  @override
  String bookingCreatedChoosePrice(Object id) {
    return 'بکنگ بن گئی! ID: $id • اپنی قیمت کا آپشن منتخب کریں۔';
  }

  @override
  String get failedToCreateBooking => 'بکنگ بنانے میں ناکامی۔';

  @override
  String get paymentsNotSupportedLong =>
      'اس پلیٹ فارم پر ادائیگیاں سپورٹ نہیں ہیں۔ حقیقی ادائیگیاں ٹیسٹ کرنے کے لیے ایپ کو Android، iOS، macOS یا Web پر چلائیں۔';

  @override
  String get noBookingToConfirm =>
      'تصدیق کے لیے کوئی بکنگ نہیں۔ پہلے بکنگ بنائیں۔';

  @override
  String get pleaseChoosePriceOption => 'براہِ کرم قیمت کا آپشن منتخب کریں۔';

  @override
  String get failedCreatePaymentTryAgain =>
      'سرور پر ادائیگی بنانے میں ناکامی۔ دوبارہ کوشش کریں۔';

  @override
  String paymentSuccessfulMessage(Object bookingId, Object paid) {
    return 'ادائیگی کامیاب!\nبکنگ #$bookingId • ادا شدہ: $paid\nآپ کی درخواست اب قریبی فراہم کنندگان کو نظر آئے گی۔';
  }

  @override
  String get paymentSucceededButFailedUpdate =>
      'ادائیگی کامیاب ہوئی، مگر سرور پر بکنگ اپڈیٹ نہیں ہو سکی۔';

  @override
  String paymentCancelledOrFailed(Object reason) {
    return 'ادائیگی منسوخ یا ناکام: $reason';
  }

  @override
  String unexpectedPaymentError(Object error) {
    return 'غیر متوقع ادائیگی کی خرابی: $error';
  }

  @override
  String get createBookingButton => 'بکنگ بنائیں';

  @override
  String get chooseYourPriceOptionTitle => 'اپنی قیمت کا آپشن منتخب کریں';

  @override
  String transportationCostLabel(Object cost) {
    return 'ٹرانسپورٹ لاگت: $cost';
  }

  @override
  String get budgetTierTitle => 'کم بجٹ';

  @override
  String get standardTierTitle => 'معیاری';

  @override
  String get priorityTierTitle => 'ترجیحی';

  @override
  String get budgetTierDescription => 'قریبی فراہم کنندگان میں بہترین قیمت';

  @override
  String get standardTierDescription => 'قیمت اور دستیابی کا تجویز کردہ توازن';

  @override
  String get priorityTierDescription =>
      'پریمیم آپشن تاکہ بہترین فراہم کنندگان جلد متوجہ ہوں';

  @override
  String get naShort => 'N/A';

  @override
  String get priceBreakdownTitle => 'قیمت کی تفصیل';

  @override
  String get servicePriceLabel => 'سروس کی قیمت';

  @override
  String get transportationLabel => 'ٹرانسپورٹ';

  @override
  String serviceFeeLabel(Object percent) {
    return 'سروس فیس ($percent%)';
  }

  @override
  String allPricesIn(Object currency, Object country) {
    return 'تمام قیمتیں $currency میں ($country)';
  }

  @override
  String get userCountryPlaceholder => 'صارف کا ملک';

  @override
  String get totalToPayTitle => 'ادا کرنے کی کل رقم';

  @override
  String get includesServiceTransportation => 'سروس + ٹرانسپورٹ شامل';

  @override
  String get confirmAndPay => 'تصدیق کریں اور ادائیگی کریں';

  @override
  String get howPricingWorksTitle => 'قیمت کیسے بنتی ہے';

  @override
  String get howPricingWorksBullets =>
      '• کم بجٹ: قریبی فراہم کنندگان میں بہترین قیمت\n• معیاری: تجویز کردہ ڈیفالٹ\n• ترجیحی: قبولیت تیز کرنے کے لیے پریمیم\n• ٹرانسپورٹ کل میں شامل ہے';

  @override
  String get myBookingsTitle => 'میری بکنگز';

  @override
  String get myAssignedJobsTitle => 'میرے تفویض کردہ کام';

  @override
  String get pleaseCompleteProviderProfileFirst =>
      'براہِ کرم پہلے اپنا فراہم کنندہ پروفائل مکمل کریں۔';

  @override
  String get failedToLoadBookings => 'بکنگز لوڈ نہیں ہو سکیں۔';

  @override
  String get profileSetupRequiredTitle => 'پروفائل سیٹ اپ ضروری ہے';

  @override
  String get profileSetupRequiredBody =>
      'تفویض کردہ کام اور کمائی دیکھنے سے پہلے آپ کو اپنا فراہم کنندہ پروفائل مکمل کرنا ہوگا۔';

  @override
  String get later => 'بعد میں';

  @override
  String get setupNow => 'ابھی سیٹ اپ کریں';

  @override
  String get noBookingsFound => 'کوئی بکنگ نہیں ملی۔';

  @override
  String get findNearbyOpenJobs => 'قریبی کھلے کام تلاش کریں';

  @override
  String get pay => 'ادائیگی';

  @override
  String get rate => 'ریٹ کریں';

  @override
  String bookingNumber(Object id) {
    return 'بکنگ #$id';
  }

  @override
  String whenOn(Object date) {
    return 'وقت: $date';
  }

  @override
  String whenAt(Object date, Object time) {
    return 'وقت: $date پر $time';
  }

  @override
  String providerLine(Object name) {
    return 'فراہم کنندہ: $name';
  }

  @override
  String userLine(Object name) {
    return 'صارف: $name';
  }

  @override
  String estimatedPriceLine(Object price) {
    return 'متوقع قیمت: $price';
  }

  @override
  String paymentLine(Object status) {
    return 'ادائیگی: $status';
  }

  @override
  String get paymentUnpaid => 'غیر ادا شدہ';

  @override
  String get paymentUnknown => 'نامعلوم';

  @override
  String get confirmPaymentTitle => 'ادائیگی کی تصدیق';

  @override
  String confirmPaymentBody(Object amount) {
    return 'اس بکنگ کی تصدیق کے لیے $amount ادا کریں؟';
  }

  @override
  String get yesPay => 'ہاں، ادائیگی کریں';

  @override
  String get failedToCreatePaymentIntent => 'ادائیگی بنانے میں ناکامی۔';

  @override
  String get paymentSuccessfulShort => 'ادائیگی کامیاب۔';

  @override
  String get paymentSucceededButFailedUpdateBooking =>
      'ادائیگی کامیاب ہوئی، مگر سرور پر بکنگ اپڈیٹ نہیں ہو سکی۔';

  @override
  String paymentCancelledOrFailedReason(Object reason) {
    return 'ادائیگی منسوخ یا ناکام: $reason';
  }

  @override
  String unexpectedPaymentErrorReason(Object error) {
    return 'غیر متوقع ادائیگی کی خرابی: $error';
  }

  @override
  String rateProviderTitle(Object providerName) {
    return '$providerName کو ریٹ کریں';
  }

  @override
  String get selectRatingHelp => 'ریٹنگ منتخب کریں (1 = خراب، 5 = بہترین):';

  @override
  String get commentsOptionalLabel => 'تبصرے (اختیاری)';

  @override
  String get submit => 'جمع کریں';

  @override
  String get reviewSubmitted => 'ریویو جمع ہو گیا۔';

  @override
  String get failedSubmitReview => 'ریویو جمع کرنے میں ناکامی۔';

  @override
  String failedToLoadProfile(Object error) {
    return 'پروفائل لوڈ نہیں ہو سکا: $error';
  }

  @override
  String profileSavedSuccess(Object action) {
    return 'پروفائل کامیابی سے $action ہو گیا!';
  }

  @override
  String genericError(Object error) {
    return 'خرابی: $error';
  }

  @override
  String get locationPermissionDeniedEnableInSettings =>
      'لوکیشن کی اجازت مسترد ہے۔ براہِ کرم سیٹنگز میں فعال کریں۔';

  @override
  String get locationPermissionPermanentlyDeniedEnableInAppSettings =>
      'لوکیشن کی اجازت مستقل طور پر مسترد ہے۔ براہِ کرم ایپ سیٹنگز میں فعال کریں۔';

  @override
  String errorGettingLocation(Object error) {
    return 'لوکیشن حاصل کرنے میں خرابی: $error';
  }

  @override
  String get pleaseEnterAddress => 'براہِ کرم ایک پتہ درج کریں';

  @override
  String get locationUpdatedFromAddress => 'پتے سے لوکیشن اپڈیٹ ہو گئی';

  @override
  String get couldNotFindLocationForAddress =>
      'اس پتے کے لیے لوکیشن نہیں مل سکی';

  @override
  String errorConvertingAddress(Object error) {
    return 'پتہ تبدیل کرنے میں خرابی: $error';
  }

  @override
  String get portfolioUnavailableCompleteKycFirst =>
      'پورٹ فولیو دستیاب نہیں۔ اگر آپ فراہم کنندہ ہیں تو پہلے KYC مکمل کریں۔';

  @override
  String failedToLoadPortfolio(Object error) {
    return 'پورٹ فولیو لوڈ نہیں ہو سکا: $error';
  }

  @override
  String get addPhoto => 'تصویر شامل کریں';

  @override
  String get addVideo => 'ویڈیو شامل کریں';

  @override
  String get addPost => 'پوسٹ شامل کریں';

  @override
  String get captionOptionalTitle => 'کیپشن (اختیاری)';

  @override
  String get captionHintExample => 'مثلاً: “کلائنٹ پر ناٹ لیس بریڈز”';

  @override
  String get skip => 'چھوڑ دیں';

  @override
  String get save => 'محفوظ کریں';

  @override
  String get failedToCreatePortfolioPost => 'پورٹ فولیو پوسٹ بن نہیں سکی۔';

  @override
  String get uploadFailedMediaUpload => 'اپلوڈ ناکام (میڈیا اپلوڈ).';

  @override
  String uploadFailed(Object error) {
    return 'اپلوڈ ناکام: $error';
  }

  @override
  String get deletePostTitle => 'پوسٹ حذف کریں؟';

  @override
  String get deletePostBody => 'یہ پوسٹ آپ کے پورٹ فولیو سے ہٹا دی جائے گی۔';

  @override
  String get delete => 'حذف کریں';

  @override
  String get deleteFailed => 'حذف کرنا ناکام۔';

  @override
  String deleteFailedWithError(Object error) {
    return 'حذف کرنا ناکام: $error';
  }

  @override
  String get portfolioTitle => 'پورٹ فولیو';

  @override
  String get noPortfolioPostsYetHelpText =>
      'ابھی تک کوئی پورٹ فولیو پوسٹ نہیں۔ اپنے کام کی تصاویر/ویڈیوز شامل کریں تاکہ کلائنٹس آپ کی مہارت پر اعتماد کریں۔';

  @override
  String get setupProviderProfileTitle => 'پرووائیڈر پروفائل سیٹ اپ';

  @override
  String get providerProfileTitle => 'پرووائیڈر پروفائل';

  @override
  String get welcomeToStyloriaTitle => 'Styloria میں خوش آمدید!';

  @override
  String get completeProviderProfileToStartEarning =>
      'کام قبول کرنے اور کمائی شروع کرنے کے لیے اپنا پرووائیڈر پروفائل مکمل کریں۔';

  @override
  String reviewCountLabel(int count) {
    return '($count ریویوز)';
  }

  @override
  String get topRatedChip => 'اعلیٰ ریٹنگ';

  @override
  String get bioLabel => 'بایو / تفصیل';

  @override
  String get bioHint => 'کلائنٹس کو اپنی مہارت اور تجربہ بتائیں...';

  @override
  String get pleaseEnterBio => 'براہِ کرم بایو درج کریں';

  @override
  String bioMinLength(int min) {
    return 'بایو کم از کم $min حروف کا ہونا چاہیے';
  }

  @override
  String get yourLocationTitle => 'آپ کا مقام';

  @override
  String get locationHelpMatchNearbyClients =>
      'آپ کا مقام ہمیں قریبی کلائنٹس سے میچ کرنے میں مدد دیتا ہے';

  @override
  String get locationHelpUpdateToFindJobs =>
      'مختلف علاقوں میں کام ڈھونڈنے کے لیے مقام اپڈیٹ کریں';

  @override
  String get useMyCurrentLocationTitle => 'میرا موجودہ مقام استعمال کریں';

  @override
  String get gpsSubtitle => 'GPS کے ذریعے خودکار طور پر مقام حاصل کریں';

  @override
  String get orLabel => 'یا';

  @override
  String get enterYourAddressTitle => 'اپنا پتہ درج کریں';

  @override
  String get fullAddressLabel => 'مکمل پتہ';

  @override
  String get fullAddressHint => 'مثلاً: 123 Main St, Accra, Ghana';

  @override
  String get find => 'تلاش کریں';

  @override
  String get addressHelpText => 'گلی، شہر اور ملک درج کریں';

  @override
  String get coordinatesAutoFilledTitle => 'کوآرڈینیٹس (خودکار)';

  @override
  String get servicePricingTitle => 'سروس کی قیمتیں';

  @override
  String get servicePricingHelp =>
      'ہر سروس کے لیے اپنی قیمت مقرر کریں۔ جن سروسز کی آپ پیشکش نہیں کر سکتے اُن کے لیے “Not Offered” منتخب کریں۔';

  @override
  String get serviceHeader => 'سروس';

  @override
  String get priceHeader => 'قیمت';

  @override
  String get notOfferedHeader => 'پیشکش نہیں';

  @override
  String get priceHint => '0.00';

  @override
  String get providerHowPricingWorksTitle => 'قیمت کیسے بنتی ہے:';

  @override
  String get providerHowPricingWorksBody =>
      '• آپ کی قیمت وہ ہے جو آپ سروس کے لیے لیتے ہیں\n• ٹرانسپورٹ لاگت = صارف کی کرنسی کا 80% فی کلومیٹر\n• صارف قریبی پرووائیڈرز کی بنیاد پر 3 آپشنز دیکھتا ہے:\n  - Budget: کم ترین قیمت\n  - Standard: اوسط قیمت\n  - Priority: بلند ترین قیمت';

  @override
  String get availableForBookingsTitle => 'بکنگز کے لیے دستیاب';

  @override
  String get availableOnHelp =>
      '✓ آپ قریبی کلائنٹس کے سرچ نتائج میں نظر آئیں گے';

  @override
  String get availableOffHelp => '✗ آپ کو نئی جاب آفرز نہیں ملیں گی';

  @override
  String get completeSetupStartEarning =>
      'سیٹ اپ مکمل کریں اور کمائی شروع کریں';

  @override
  String get updateProfile => 'پروفائل اپڈیٹ کریں';

  @override
  String get skipForNow => 'ابھی چھوڑ دیں';

  @override
  String get paymentsNotSupportedShort =>
      'اس پلیٹ فارم پر ادائیگیاں سپورٹ نہیں ہیں۔ براہِ کرم Android، iOS، macOS یا Web پر چلائیں۔';

  @override
  String get genericContact => 'رابطہ';

  @override
  String get genericProvider => 'سروس فراہم کنندہ';

  @override
  String get genericNotAvailable => 'موجود نہیں';

  @override
  String get showPassword => 'Show password';

  @override
  String get hidePassword => 'Hide password';

  @override
  String get tapEyeToShowPassword => 'Tap the eye icon to show/hide password';

  @override
  String get certificationRequiredTitle => 'Certification Required';

  @override
  String certificationRequiredMessage(Object service) {
    return 'This service requires a verified professional certification to protect both you and your clients.\n\nMassage services require proof of massage therapy training/licensing.';
  }

  @override
  String get certificationPendingTitle => 'Certification Pending Review';

  @override
  String get certificationPendingMessage =>
      'Your certification is awaiting admin verification. This usually takes 24-48 hours. You\'ll be able to offer this service once approved.';

  @override
  String get certificationExpiredTitle => 'Certification Expired';

  @override
  String get certificationExpiredMessage =>
      'Your certification has expired. Please upload a valid, current certification to continue offering this service.';

  @override
  String get certificationStepsTitle => 'How to get certified:';

  @override
  String get certificationStep1 =>
      '1. Go to \'Certifications & Licenses\' section below';

  @override
  String get certificationStep2 =>
      '2. Upload your massage therapy license/certificate';

  @override
  String get certificationStep3 =>
      '3. Wait for admin verification (24-48 hours)';

  @override
  String get addCertification => 'Add Certification';

  @override
  String get scrollToCertificationsHint =>
      'Scroll down to the Certifications section to add your certification';

  @override
  String get requiresCertificationTooltip =>
      'This service requires a verified certification';

  @override
  String get detectingYourLocation => 'Detecting your location...';

  @override
  String locationDetectedAs(Object country) {
    return 'Location detected: $country';
  }

  @override
  String get refresh => 'Refresh';

  @override
  String get countryMismatchWarningTitle => 'Different country selected';

  @override
  String countryMismatchWarningBody(Object country) {
    return 'We detected your location as $country. If you\'re traveling or relocating, you can continue with your selection. Your currency will be based on your selected country.';
  }

  @override
  String get reviewSelectRatingPrompt => 'ریٹنگ منتخب کریں (1 سے 5)۔';

  @override
  String get reviewCommentOptionalLabel => 'تبصرہ (اختیاری)';

  @override
  String get genericCancel => 'منسوخ کریں';

  @override
  String get genericSubmit => 'جمع کریں';

  @override
  String get reviewSubmitFailed => 'ریویو جمع نہیں ہو سکا۔';

  @override
  String get rateThisService => 'اس سروس کو ریٹ کریں';

  @override
  String get tipLeaveTitle => 'ٹِپ دیں';

  @override
  String get tipChooseAmountPrompt =>
      'ٹِپ کی رقم منتخب کریں یا اپنی مرضی کی رقم درج کریں۔';

  @override
  String get tipNoTip => 'کوئی ٹِپ نہیں';

  @override
  String get tipCustomAmountLabel => 'حسبِ ضرورت ٹِپ رقم';

  @override
  String get genericContinue => 'جاری رکھیں';

  @override
  String get tipSkipped => 'ٹِپ چھوڑ دی گئی۔';

  @override
  String get tipFailedToSaveChoice => 'ٹِپ کا انتخاب محفوظ نہیں ہو سکا۔';

  @override
  String get tipFailedToCreatePayment => 'ٹِپ کی ادائیگی بن نہیں سکی۔';

  @override
  String get tipPaidSuccessfully => 'ٹِپ کامیابی سے ادا ہو گئی۔ شکریہ!';

  @override
  String get tipPaidButUpdateFailed =>
      'ٹِپ کی ادائیگی کامیاب ہوئی، لیکن بکنگ اپڈیٹ نہیں ہو سکی۔';

  @override
  String tipCancelledOrFailed(Object message) {
    return 'ٹِپ منسوخ/ناکام: $message';
  }

  @override
  String tipUnexpectedError(Object error) {
    return 'ٹِپ میں غیر متوقع خرابی: $error';
  }

  @override
  String get tipAlreadyPaidLabel => 'ٹِپ پہلے ہی ادا ہو چکی ہے';

  @override
  String get tipSkippedLabel => 'ٹِپ چھوڑ دی گئی';

  @override
  String get tipLeaveButton => 'ٹِپ دیں';

  @override
  String get walletTitle => 'والیٹ';

  @override
  String get walletTooltip => 'والیٹ';

  @override
  String get payoutSettingsTitle => 'ادائیگی کی ترتیبات';

  @override
  String get payoutSettingsTooltip => 'ادائیگی کی ترتیبات';

  @override
  String get walletNoWalletYet =>
      'ابھی کوئی والیٹ نہیں ہے۔ کمانے کے لیے کام مکمل کریں۔';

  @override
  String get walletCurrencyFieldLabel => 'کرنسی';

  @override
  String walletAvailableLine(Object amount, Object currency) {
    return 'دستیاب: $amount $currency';
  }

  @override
  String walletPendingLine(Object amount, Object currency) {
    return 'زیرِ التواء: $amount $currency';
  }

  @override
  String get walletCashOutInstant => 'فوری نکالیں';

  @override
  String get walletCashOutFailed => 'کیش آؤٹ ناکام ہوگیا۔';

  @override
  String walletCashOutSentTransfer(Object transferId) {
    return 'کیش آؤٹ بھیج دیا گیا۔ ٹرانسفر: $transferId';
  }

  @override
  String get walletTransactionsTitle => 'لین دین';

  @override
  String get walletNoTransactionsYet => 'ابھی کوئی لین دین نہیں۔';

  @override
  String get payoutAutoPayoutsTitle => 'خودکار ادائیگیاں';

  @override
  String get payoutAutoPayoutsSubtitle =>
      'اپنے منتخب شیڈول کے مطابق خودکار ادائیگیاں بھیجیں۔';

  @override
  String get payoutDayUtcLabel => 'ادائیگی کا دن (UTC)';

  @override
  String get payoutHourUtcLabel => 'ادائیگی کا وقت (UTC)';

  @override
  String get payoutMinimumAmountLabel => 'خودکار ادائیگی کی کم از کم رقم';

  @override
  String get payoutMinimumAmountHelper =>
      'خودکار ادائیگی تبھی چلے گی جب دستیاب بیلنس ≥ اس رقم کے ہو۔';

  @override
  String get payoutInstantCashOutEnabledTitle => 'فوری کیش آؤٹ فعال';

  @override
  String get payoutInstantCashOutEnabledSubtitle =>
      '“کیش آؤٹ” بٹن کی اجازت دیں (فیس لاگو ہوگی)۔';

  @override
  String get payoutSettingsSaved => 'ادائیگی کی ترتیبات محفوظ ہوگئیں۔';

  @override
  String get payoutSettingsSaveFailed =>
      'ادائیگی کی ترتیبات محفوظ نہیں ہو سکیں۔';

  @override
  String servicePricingStepIndicator(Object current, Object total) {
    return 'Step $current of $total';
  }

  @override
  String get serviceSelectionTitle => 'What services do you offer?';

  @override
  String get serviceSelectionSubtitle =>
      'Tap to select the services you provide. You can change this anytime.';

  @override
  String get priceSettingTitle => 'Set your prices';

  @override
  String get priceSettingSubtitle =>
      'Enter your price for each service you selected.';

  @override
  String get nextButton => 'Next';

  @override
  String get backButton => 'Back';

  @override
  String get editServicesLink => 'Edit services';

  @override
  String get selectAtLeastOneService =>
      'Please select at least one service to continue.';

  @override
  String get noServicesSelectedYet =>
      'No services selected yet. Go back to select services.';

  @override
  String servicesSelectedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'services',
      one: 'service',
    );
    return '$count $_temp0 selected';
  }

  @override
  String get certificationRequiredChip => 'Requires certification';

  @override
  String get savePrices => 'Save Prices';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingGetStarted => 'Get Started';

  @override
  String get onboardingMaybeLater => 'Maybe Later';

  @override
  String get onboardingEnableLocation => 'Enable Location';

  @override
  String get onboardingWelcomeTitle => 'Welcome to Styloria';

  @override
  String get onboardingWelcomeSubtitle =>
      'Your personal beauty & grooming marketplace';

  @override
  String get onboardingWelcomeDescription =>
      'Book professional stylists, barbers, and beauty experts — anytime, anywhere.';

  @override
  String get onboardingCustomerTitle => 'Book Services Instantly';

  @override
  String get onboardingCustomerSubtitle =>
      'Find and book beauty services with ease';

  @override
  String get onboardingCustomerBullet1 => 'Find verified providers near you';

  @override
  String get onboardingCustomerBullet2 => 'Compare prices transparently';

  @override
  String get onboardingCustomerBullet3 => 'Pay securely in-app';

  @override
  String get onboardingCustomerBullet4 => 'Track your provider in real-time';

  @override
  String get onboardingProviderTitle => 'Grow Your Business';

  @override
  String get onboardingProviderSubtitle => 'Turn your skills into income';

  @override
  String get onboardingProviderBullet1 => 'Set your own prices & schedule';

  @override
  String get onboardingProviderBullet2 => 'Get matched with nearby clients';

  @override
  String get onboardingProviderBullet3 => 'Build your reputation with reviews';

  @override
  String get onboardingProviderBullet4 => 'Instant payouts to your account';

  @override
  String get onboardingLocationTitle => 'Enable Location Services';

  @override
  String get onboardingLocationSubtitle =>
      'Styloria uses your location to connect you with nearby services';

  @override
  String get onboardingLocationBenefit1 => 'Find service providers near you';

  @override
  String get onboardingLocationBenefit2 =>
      'Calculate accurate transportation costs';

  @override
  String get onboardingLocationBenefit3 =>
      'Match you with available professionals';

  @override
  String get onboardingLocationBenefit4 =>
      'Enable real-time tracking during appointments';

  @override
  String get onboardingLocationPrivacyNote =>
      'Your location is only used while the app is open. We never track you in the background.';

  @override
  String get onboardingLocationEnabled => 'Location enabled successfully!';

  @override
  String get onboardingLocationDeniedTitle => 'Location Permission Denied';

  @override
  String get onboardingLocationDeniedMessage =>
      'Without location access, you\'ll need to enter your address manually when booking services. You can enable location later in your device settings.';

  @override
  String get onboardingContinueWithoutLocation => 'Continue Without Location';

  @override
  String get onboardingOpenSettings => 'Open Settings';

  @override
  String get onboardingLocationServicesOffTitle => 'Location Services Disabled';

  @override
  String get onboardingLocationServicesOffMessage =>
      'Your device\'s location services are turned off. Enable them to get the full Styloria experience.';

  @override
  String get onboardingEnableLocationServices => 'Enable Location Services';

  @override
  String get providerLocationRequiredTitle => 'Location Required';

  @override
  String get providerLocationRequiredMessage =>
      'To appear in search results and receive job requests from nearby clients, you need to enable location access.';

  @override
  String get providerLocationRequiredBenefitsTitle =>
      'Why we need your location:';

  @override
  String get providerLocationRequiredBenefit1 =>
      '• Appear in nearby client searches';

  @override
  String get providerLocationRequiredBenefit2 =>
      '• Receive job requests in your area';

  @override
  String get providerLocationRequiredBenefit3 =>
      '• Calculate accurate distances for clients';

  @override
  String get providerStayUnavailable => 'Stay Unavailable';

  @override
  String get providerEnableLocation => 'Enable Location';

  @override
  String get providerLocationEnabledNowAvailable =>
      'Location enabled! You\'re now available for bookings.';

  @override
  String get providerLocationPermanentlyDeniedTitle =>
      'Location Permission Required';

  @override
  String get providerLocationPermanentlyDeniedMessage =>
      'Location permission was permanently denied. To enable availability, please open your device settings and grant location access to Styloria.';

  @override
  String get providerOpenSettings => 'Open Settings';

  @override
  String get providerLocationServicesDisabled =>
      'Location services are disabled on your device.';

  @override
  String get providerEnableLocationServices => 'Enable';

  @override
  String get providerLocationDeniedCannotBeAvailable =>
      'Location access denied. You cannot be available for bookings without location enabled.';
}
