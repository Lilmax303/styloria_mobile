// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Amharic (`am`).
class AppLocalizationsAm extends AppLocalizations {
  AppLocalizationsAm([String locale = 'am']) : super(locale);

  @override
  String get appTitle => 'Styloria';

  @override
  String get account => 'መለያ';

  @override
  String get profile => 'ፕሮፋይል';

  @override
  String get myBookings => 'የእኔ ቦታ ማስያዝ';

  @override
  String get openJobs => 'ክፍት ስራዎች';

  @override
  String get earnings => 'ገቢ';

  @override
  String get paymentMethods => 'የክፍያ መንገዶች';

  @override
  String get referFriends => 'ጓደኞችን ይጋብዙ';

  @override
  String get language => 'ቋንቋ';

  @override
  String get settings => 'ቅንብሮች';

  @override
  String get darkMode => 'ጨለማ ሁኔታ';

  @override
  String get systemDefault => 'የስርዓት ነባሪ';

  @override
  String get languageUpdated => 'ቋንቋ ተዘምኗል';

  @override
  String get languageSetToSystemDefault => 'ቋንቋ ወደ የስርዓት ነባሪ ተመልሷል';

  @override
  String get helpAndSupport => 'እርዳታ እና ድጋፍ';

  @override
  String get chatWithCustomerService => 'ከደንበኛ አገልግሎት ጋር ይወያዩ';

  @override
  String get aboutAndPolicies => 'ስለ እኛ እና ፖሊሲዎች';

  @override
  String get viewUserPoliciesAndAgreements => 'የተጠቃሚ ፖሊሲዎችን እና ስምምነቶችን ይመልከቱ';

  @override
  String get logOut => 'ውጣ';

  @override
  String get deleteAccount => 'መለያ ሰርዝ';

  @override
  String get deleteAccountSubtitle => 'ይህ እርምጃ ሊመለስ አይችልም';

  @override
  String get deleteAccountTitle => 'መለያ ሰርዝ';

  @override
  String get deleteAccountConfirmBody =>
      'መለያዎን ማጥፋት እርግጠኛ ነዎት?\n\nይህ እርምጃ ከመለያዎ ያወጣዎታል እና ለዘላቂ ጊዜ መዳረሻ ሊጠፋ ይችላል።';

  @override
  String get no => 'አይ';

  @override
  String get yesDelete => 'አዎ፣ ሰርዝ';

  @override
  String get deleteAccountSheetTitle => 'መሄድዎን እናዝናለን።';

  @override
  String get deleteAccountSheetPrompt => 'ለምን እንደሚሄዱ ሊነግሩን ይችላሉ? (ሁሉንም ይምረጡ)';

  @override
  String get deleteAccountSelectAtLeastOneReason => 'እባክዎ ቢያንስ አንድ ምክንያት ይምረጡ።';

  @override
  String get tellUsMoreOptional => 'ተጨማሪ ይንገሩን (አማራጭ)';

  @override
  String get suggestionsToImproveOptional => 'ለማሻሻል ሀሳቦች (አማራጭ)';

  @override
  String get deleteMyAccount => 'መለያዬን ሰርዝ';

  @override
  String get cancel => 'ሰርዝ/ተወው';

  @override
  String get failedToDeleteAccount => 'መለያ ማጥፋት አልተሳካም። እንደገና ይሞክሩ።';

  @override
  String get choosePreferredLanguage => 'የሚመርጡትን ቋንቋ ይምረጡ';

  @override
  String get noteSomeTextMayStillAppearInEnglish =>
      'ማስታወሻ፡ ይህ የመተግበሪያውን ቋንቋ ይቀይራል። ትርጉሞች እስኪጨምሩ ድረስ አንዳንድ ጽሁፍ በእንግሊዝኛ ሊታይ ይችላል።';

  @override
  String languageSetToName(Object name) {
    return 'ቋንቋ ወደ $name ተቀይሯል';
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
  String get confirmPassword => 'የይለፍ ቃል አረጋግጥ';

  @override
  String get dateOfBirth => 'Date of Birth';

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
  String get deletionReason1 => 'Styloria አሁን አልፈልግም';

  @override
  String get deletionReason2 => 'መለያ ማረጋገጥ (ኢሜይል/KYC) ላይ ችግኝ ነበር';

  @override
  String get deletionReason3 => 'በአቅራቢያዬ አገልግሎት/አቅራቢ አላገኘሁም';

  @override
  String get deletionReason4 => 'ዋጋዎች ወይም ክፍያዎች በጣም ከፍ ነበሩ / አልተገለጹም';

  @override
  String get deletionReason5 => 'መተግበሪያው ያስተላለፈ / መጠቀም አስቸጋሪ ነበር';

  @override
  String get deletionReason6 => 'ባግ ወይም የአፈጻጸም ችግኝ';

  @override
  String get deletionReason7 => 'የክፍያ/መመለስ ችግኝ';

  @override
  String get deletionReason8 => 'ከአቅራቢ/ተጠቃሚ ጋር መጥፎ ልምድ';

  @override
  String get deletionReason9 => 'የግል መረጃ ወይም ደህንነት ጉዳይ';

  @override
  String get deletionReason10 => 'መለያውን በስህተት ፈጠርሁ';

  @override
  String get deletionReason11 => 'ወደ ሌላ መድረክ እቀየራለሁ';

  @override
  String get deletionReason12 => 'ሌላ';

  @override
  String get loginWelcomeTitle => 'ወደ Styloria እንኳን በደህና መጡ';

  @override
  String get loginWelcomeSubtitle => 'ቦታ ማስያዝዎን እና አገልግሎቶችን ለመቆጣጠር ይግቡ።';

  @override
  String get loginFailedToLoadUserInfo =>
      'መግባት ተሳክቷል ነገር ግን የተጠቃሚ መረጃ ማግኘት አልተቻለም።';

  @override
  String get username => 'የተጠቃሚ ስም';

  @override
  String get password => 'የይለፍ ቃል';

  @override
  String get required => 'አስፈላጊ';

  @override
  String get login => 'ግባ';

  @override
  String get createNewAccount => 'አዲስ መለያ ፍጠር';

  @override
  String get requestEmailVerificationCode => 'የኢሜይል ማረጋገጫ ኮድ ጠይቅ';

  @override
  String get serviceLocationHint =>
      'Enter where you want the service performed. This can be different from your current location.';

  @override
  String get serviceAddressLabel => 'Service Address';

  @override
  String get serviceAddressHint => 'e.g., 123 Main St, Accra, Ghana';

  @override
  String get searchAddressTooltip => 'Find this address';

  @override
  String get serviceLocationSet => 'Service location set';

  @override
  String get coordinatesLabel => 'Coordinates';

  @override
  String get pleaseEnterAddress => 'እባክዎ አድራሻ ያስገቡ';

  @override
  String get locationUpdatedFromAddress => 'ቦታ ከአድራሻ ተዘምኗል';

  @override
  String get createAccountTitle => 'መለያ ፍጠር';

  @override
  String get joinStyloria => 'Styloria ተቀላቀል';

  @override
  String get registerSubtitle => 'አገልግሎት ለማስያዝ ወይም አቅራቢ ለመሆን መለያ ፍጠሩ';

  @override
  String get iWantTo => 'እፈልጋለሁ:';

  @override
  String get bookServices => 'አገልግሎት ማስያዝ';

  @override
  String get provideServices => 'አገልግሎት መስጠት';

  @override
  String get personalInformation => 'የግል መረጃ';

  @override
  String get firstName => 'የመጀመሪያ ስም';

  @override
  String get lastName => 'የአያት ስም';

  @override
  String get selectDateOfBirth => 'የትውልድ ቀን ይምረጡ';

  @override
  String get phoneNumber => 'የስልክ ቁጥር';

  @override
  String get pleaseEnterPhoneNumber => 'እባክዎ ስልክ ቁጥር ያስገቡ';

  @override
  String get accountInformation => 'የመለያ መረጃ';

  @override
  String get chooseUniqueUsernameHint => 'ልዩ የተጠቃሚ ስም ይምረጡ';

  @override
  String get youAreCurrentlyUnavailable => 'አሁን አይገኙም';

  @override
  String get toBrowseAndAcceptJobsEnableAvailability =>
      'በአቅራቢያ ያሉ የስራ ጥያቄዎችን ለማሰስ እና ለመቀበል፣ እራስዎን ለቦታ ማስያዝ ዝግጁ አድርገው ማቀናበር አለብዎት።';

  @override
  String get goToProfileSettings => 'ወደ መገለጫ ቅንብሮች ይሂዱ';

  @override
  String get tipToggleAvailableForBookings =>
      'ምክር: የስራ ጥያቄዎችን መቀበል ለመጀመር በአቅራቢ መገለጫዎ ውስጥ \"ለቦታ ማስያዝ ይገኛል\" የሚለውን ያብሩ።';

  @override
  String requestedBy(String name) {
    return 'ጠያቂ: $name';
  }

  @override
  String locationLabel(String address) {
    return 'ቦታ: $address';
  }

  @override
  String get email => 'ኢሜይል';

  @override
  String get emailHint => 'your@email.com';

  @override
  String get enterValidEmail => 'ትክክለኛ ኢሜይል ያስገቡ';

  @override
  String get security => 'ደህንነት';

  @override
  String get passwordHintAtLeast10 => 'ቢያንስ 10 ቁምፊዎች';

  @override
  String get passwordMin10 => 'የይለፍ ቃል ቢያንስ 10 ቁምፊዎች መሆን አለበት';

  @override
  String get iAgreeTo => 'እስማማለሁ ';

  @override
  String get termsOfService => 'የአገልግሎት ውል';

  @override
  String get and => 'እና';

  @override
  String get privacyPolicy => 'የግላዊነት ፖሊሲ';

  @override
  String get passwordIsRequired => 'የይለፍ ቃል አስፈላጊ ነው';

  @override
  String get passwordsDoNotMatch => 'የይለፍ ቃሎቹ አይመሳሰሉም';

  @override
  String get pleaseSelectDob => 'እባክዎ የትውልድ ቀን ይምረጡ።';

  @override
  String get pleaseSelectCountry => 'እባክዎ ሀገር ይምረጡ።';

  @override
  String get pleaseSelectCity => 'እባክዎ ከተማ ይምረጡ።';

  @override
  String get pleaseEnterValidPhone => 'እባክዎ ትክክለኛ ስልክ ቁጥር ያስገቡ።';

  @override
  String get mustAcceptTerms => 'መመሪያዎችን መቀበል አለብዎት።';

  @override
  String get mustBeAtLeast18 => 'ለመመዝገብ ቢያንስ 18 ዓመት መሆን አለብዎት።';

  @override
  String get agreeToTerms => 'የአገልግሎት መመሪያዎችን እና የግል መረጃ ፖሊሲን እቀበላለሁ';

  @override
  String get createAccountButton => 'መለያ ፍጠር';

  @override
  String get alreadyHaveAccount => 'አስቀድሞ መለያ አለዎት?';

  @override
  String get emailVerifiedSuccessPleaseLogin => 'ኢሜይል ተረጋግጧል። እባክዎ ይግቡ።';

  @override
  String get pleaseVerifyEmailToContinue => 'ለመቀጠል እባክዎ ኢሜይልዎን ያረጋግጡ።';

  @override
  String get requestVerificationCodeTitle => 'የማረጋገጫ ኮድ ጠይቅ';

  @override
  String get requestVerificationInstructions =>
      'ኢሜይል ወይም የተጠቃሚ ስም ያስገቡ።\nለዚህ መለያ ኢሜይል አዲስ ኮድ እንልካለን።';

  @override
  String get emailOrUsername => 'ኢሜይል ወይም የተጠቃሚ ስም';

  @override
  String get sendCode => 'ኮድ ላክ';

  @override
  String get ifAccountExistsCodeSent => 'መለያው ካለ ኮድ ተልኳል።';

  @override
  String get failedToSendVerificationCode => 'የማረጋገጫ ኮድ መላክ አልተሳካም።';

  @override
  String get verifyYourEmailTitle => 'ኢሜይልዎን ያረጋግጡ';

  @override
  String get verificationCodeSentInfo => 'ለዚህ መለያ ኢሜይል የማረጋገጫ ኮድ ተልኳል።';

  @override
  String emailVerificationInstructions(Object identifier) {
    return 'ለዚህ መለያ ኢሜይል የተላከውን 6-አሃዝ ኮድ ያስገቡ:\n$identifier';
  }

  @override
  String get verificationCodeLabel => 'የማረጋገጫ ኮድ';

  @override
  String get sendingEllipsis => 'በመላክ ላይ...';

  @override
  String get resendCode => 'ኮድን ዳግም ላክ';

  @override
  String get enter6DigitCodeError => '6-አሃዝ ኮድ ያስገቡ።';

  @override
  String get verifyingEllipsis => 'በማረጋገጥ ላይ...';

  @override
  String get verify => 'አረጋግጥ';

  @override
  String get invalidOrExpiredCodeTryResending =>
      'ኮዱ ተሳስቷል ወይም ጊዜው አልፎታል። ዳግም ላክ ብለው ይሞክሩ።';

  @override
  String bookingTitle(Object id) {
    return 'ቦታ ማስያዝ #$id';
  }

  @override
  String get invalidBookingIdForChat => 'ለቻት የቦታ ማስያዝ ID ትክክል አይደለም።';

  @override
  String get invalidBookingIdForCall => 'ለጥሪ የቦታ ማስያዝ ID ትክክል አይደለም።';

  @override
  String get unableToLoadContactInfo =>
      'የእውቂያ መረጃ መโหลด አልተቻለም። ቦታ ማስያዝ እንዳለ አረጋግጥ።';

  @override
  String noPhoneNumberAvailableForName(Object name) {
    return 'ለ$name የስልክ ቁጥር አልተገኘም።';
  }

  @override
  String get deviceCannotPlaceCalls => 'ይህ መሣሪያ የስልክ ጥሪ ማድረግ አይችልም።';

  @override
  String get cancelBookingDialogTitle => 'ቦታ ማስያዝ ሰርዝ';

  @override
  String get cancelBookingDialogBody =>
      'ይህን ቦታ ማስያዝ በእርግጥ መሰረዝ ይፈልጋሉ?\n\nማስታወሻ፦ አቅራቢው አስቀድሞ ከተቀበለ እና ከ7 ደቂቃ በላይ (ነገር ግን ከ40 ደቂቃ በታች) ካለፈ፣ በመመሪያዎች መሠረት ቅጣት ሊተገበር ይችላል።';

  @override
  String get yesCancel => 'አዎ፣ ሰርዝ';

  @override
  String get failedToCancelBooking => 'ቦታ ማስያዝ መሰረዝ አልተቻለም።';

  @override
  String bookingCancelledPenaltyApplied(Object amount) {
    return 'ቦታ ማስያዝ ተሰርዟል። $amount ቅጣት ተተግብሯል።';
  }

  @override
  String get bookingCancelledSuccessfully => 'ቦታ ማስያዝ በተሳካ ሁኔታ ተሰርዟል።';

  @override
  String get failedToConfirmCompletion =>
      'መጨረሻነት ማረጋገጥ አልተቻለም። እባክዎ ደግመው ይሞክሩ።';

  @override
  String get bothSidesConfirmedCompletedPayoutReleased =>
      'ሁለቱም ወገኖች አረጋግጠዋል። ቦታ ማስያዝ እንደ ተጠናቀቀ ተመልክቶ ክፍያው ተለቋል።';

  @override
  String get youConfirmedCompletionWaitingForProvider =>
      'እርስዎ መጨረሻነትን አረጋግጠዋል። የአቅራቢውን ማረጋገጫ በመጠበቅ ላይ።';

  @override
  String get youConfirmedCompletionWaitingForUser =>
      'እርስዎ መጨረሻነትን አረጋግጠዋል። የተጠቃሚውን ማረጋገጫ በመጠበቅ ላይ።';

  @override
  String get statusUnknown => 'ያልታወቀ';

  @override
  String get statusAccepted => 'ተቀባይነት ተሰጥቷል';

  @override
  String get statusInProgress => 'በሂደት ላይ';

  @override
  String get statusCompleted => 'ተጠናቋል';

  @override
  String get statusCancelled => 'ተሰርዟል';

  @override
  String get paymentPaid => 'ተከፍሏል';

  @override
  String get paymentPending => 'በመጠበቅ ላይ';

  @override
  String get paymentFailed => 'አልተሳካም';

  @override
  String bookingAcceptedBy(Object name) {
    return 'ቦታ ማስያዝ በ$name ተቀብሏል';
  }

  @override
  String get whenLabel => 'መቼ';

  @override
  String atTime(Object time) {
    return 'በ $time';
  }

  @override
  String get userLabel => 'ተጠቃሚ';

  @override
  String get providerLabel => 'አቅራቢ';

  @override
  String get estimatedPriceLabel => 'የተገመተ ዋጋ';

  @override
  String get offeredPaidLabel => 'ቀርቧል / ተከፍሏል';

  @override
  String get distanceLabel => 'ርቀት';

  @override
  String distanceMiles(Object miles) {
    return '$miles ማይል';
  }

  @override
  String get acceptedAtLabel => 'ተቀብሏል በ';

  @override
  String get cancelledAtLabel => 'ተሰርዟል በ';

  @override
  String get cancelledByLabel => 'ተሰርዟል በ';

  @override
  String penaltyAppliedLabel(Object amount) {
    return 'ቅጣት ተተግብሯል: $amount';
  }

  @override
  String get userConfirmedLabel => 'ተጠቃሚው አረጋግጧል';

  @override
  String get providerConfirmedLabel => 'አቅራቢው አረጋግጧል';

  @override
  String get payoutReleasedLabel => 'ክፍያ ተለቋል';

  @override
  String get yesLower => 'አዎ';

  @override
  String get noLower => 'አይ';

  @override
  String get chat => 'ቻት';

  @override
  String get call => 'ጥሪ';

  @override
  String get actions => 'እርምጃዎች';

  @override
  String get confirmCompletion => 'መጨረሻነትን አረጋግጥ';

  @override
  String get noFurtherActionsForBooking => 'ለዚህ ቦታ ማስያዝ ተጨማሪ እርምጃ የለም።';

  @override
  String freeCancellationEndsIn(Object time) {
    return 'ነፃ ሰርዝ በ $time ውስጥ ያበቃል';
  }

  @override
  String get earlyFreeCancellationEndedWarning =>
      'የመጀመሪያ ነፃ ሰርዝ ጊዜ አበቃ። ከተቀባይነት በኋላ እስከ 40 ደቂቃ ድረስ የዘገየ ሰርዝ ቅጣት ሊኖረው ይችላል።';

  @override
  String get cancelBooking => 'ቦታ ማስያዝ ሰርዝ';

  @override
  String get cancelBookingNoPenalty => 'ቦታ ማስያዝ ሰርዝ (ቅጣት የለም)';

  @override
  String get cancelBookingPenaltyMayApply => 'ቦታ ማስያዝ ሰርዝ (ቅጣት ሊኖር ይችላል)';

  @override
  String get cancellationPolicyInfo =>
      'ከአቅራቢው ተቀባይነት በኋላ በመጀመሪያዎቹ 7 ደቂቃዎች ውስጥ ያለ ቅጣት ማሰረዝ ይችላሉ፣ እና ካስፈለገ ከአስቀድሞ 40 ደቂቃ በኋላ ደግሞ። በመካከላቸው ጊዜ ቅጣት ሊተገበር ይችላል።';

  @override
  String ratingLine(Object rating, int reviewCount) {
    String _temp0 = intl.Intl.pluralLogic(
      reviewCount,
      locale: localeName,
      other: '$reviewCount ግምገማዎች',
      one: '1 ግምገማ',
    );
    return 'ደረጃ: $rating ($_temp0)';
  }

  @override
  String get proofOfSkillsPortfolio => 'የችሎታ ማስረጃ (Portfolio)';

  @override
  String get noPortfolioPostsAvailable => 'ምንም የፖርትፎሊዮ ፖስቶች የሉም።';

  @override
  String get bookingLocation => 'የቦታ ማስያዝ ቦታ';

  @override
  String get location => 'ቦታ';

  @override
  String get latitude => 'Latitude';

  @override
  String get longitude => 'Longitude';

  @override
  String get mapWillAppearWhenCoordinatesValid =>
      'ኮኦርዲኔቶቹ ትክክል ሲሆኑ ካርታው እዚህ ይታያል።';

  @override
  String chatForBookingTitle(Object id) {
    return 'ለቦታ ማስያዝ #$id ቻት';
  }

  @override
  String get unableToStartChat =>
      'ቻት መጀመር አልተቻለም። ቻት ቦታ ማስያዝ ተቀብሏል፣ በሂደት ላይ ነው፣ ወይም ባለፈው 1 ቀን ውስጥ ተጠናቀቀ ብቻ ይገኛል።';

  @override
  String get invalidChatThreadFromServer => 'ከሰርቨር የተመለሰው የቻት ክር ትክክል አይደለም።';

  @override
  String get messageNotSentPolicy =>
      'መልዕክት አልተላከም። ማስታወሻ፡ በውይይት ውስጥ የስልክ ቁጥር ወይም ኢሜይል መแชร์ አይፈቀድም።';

  @override
  String get unknown => 'ያልታወቀ';

  @override
  String get typeMessageHint => 'ወደ ድጋፍ መልዕክት ይጻፉ...';

  @override
  String get uploadProfilePicture => 'የፕሮፋይል ምስል ይስቀሉ';

  @override
  String get currentProfilePicture => 'የአሁኑ ፕሮፋይል ምስል';

  @override
  String get newPicturePreview => 'አዲስ ምስል ቅድመ እይታ';

  @override
  String get chooseImage => 'ምስል ይምረጡ';

  @override
  String get upload => 'ይስቀሉ';

  @override
  String get noImageBytesFoundWeb => 'የምስል bytes አልተገኙም (web).';

  @override
  String get pleasePickAnImageFirst => 'እባክዎ በመጀመሪያ ምስል ይምረጡ።';

  @override
  String get uploadFailedCheckServerLogs =>
      'መስቀል አልተሳካም። የሰርቨር ሎጎች / token ይመርምሩ።';

  @override
  String get profilePictureUploadedSuccessfully => 'የፕሮፋይል ምስል በተሳካ ሁኔታ ተሰቅሏል!';

  @override
  String errorWithValue(Object error) {
    return 'ስህተት: $error';
  }

  @override
  String get tapToChangeProfilePicture => 'ፕሮፋይል ምስል ለመቀየር ይንኩ';

  @override
  String usernameValue(Object username) {
    return 'የተጠቃሚ ስም: $username';
  }

  @override
  String roleValue(Object role) {
    return 'ሚና: $role';
  }

  @override
  String get dateOfBirthYyyyMmDd => 'የትውልድ ቀን (YYYY-MM-DD)';

  @override
  String get saveProfile => 'ፕሮፋይል ያስቀምጡ';

  @override
  String get failedToSaveProfile => 'መገለጫን ማስቀመጥ አልተሳካም። እባክዎ እንደገና ይሞክሩ።';

  @override
  String get profileUpdated => 'ፕሮፋይል ተዘምኗል።';

  @override
  String get completeYourProviderProfile => 'የአቅራቢ ፕሮፋይልዎን ያጠናቅቁ';

  @override
  String get completeProviderProfileBody =>
      'ስራዎችን ለመቀበል እና ገንዘብ ለማግኘት፣ የአቅራቢ ፕሮፋይልዎን ያጠናቅቁ።';

  @override
  String get setupProfileNow => 'ፕሮፋይል አሁን ያዘጋጁ';

  @override
  String get doItLater => 'በኋላ';

  @override
  String get bookingTimerPenaltyPeriodActive => 'የቅጣት ጊዜ ንቁ ነው';

  @override
  String get bookingTimerFreeCancellationPeriod => 'ነፃ ማሰረዝ ጊዜ';

  @override
  String bookingTimerTimeRemaining(Object time) {
    return 'የቀረ ጊዜ: $time';
  }

  @override
  String get bookingTimerCancellingNowPenalty => 'አሁን መሰረዝ 10% ቅጣት ያመጣል።';

  @override
  String get bookingTimerCancelNoPenalty => 'ያለ ቅጣት ማሰረዝ ይችላሉ።';

  @override
  String get myReviewsTitle => 'የእኔ ግምገማዎች';

  @override
  String get failedToLoadReviews => 'ግምገማዎችን መโหลด አልተቻለም።';

  @override
  String get noReviewsYet => 'እስካሁን ምንም ግምገማ አልተወዱም።';

  @override
  String providerWithName(Object name) {
    return 'አቅራቢ: $name';
  }

  @override
  String get providerGeneric => 'አቅራቢ';

  @override
  String ratingWithValue(Object rating) {
    return 'ደረጃ: $rating';
  }

  @override
  String get nearbyOpenJobsTitle => 'በአቅራቢያ ያሉ ክፍት ስራዎች';

  @override
  String get failedToLoadOpenJobsHint =>
      'ክፍት ስራዎችን መโหลด አልተቻለም።\nአቅራቢ ፕሮፋይል ከቦታ ጋር እና available=true መሆኑን ያረጋግጡ።';

  @override
  String errorLoadingJobsWithValue(Object error) {
    return 'ስራዎችን ለመโหลด ስህተት: $error';
  }

  @override
  String get noOpenJobsFoundNearbyTitle => 'በአቅራቢያ ምንም ክፍት ስራ አልተገኘም';

  @override
  String get noOpenJobsFoundNearbyBody =>
      'ያረጋግጡ:\n- የአቅራቢ ቦታ አስቀምጠዋል\n- እንደ available ተመልክተዋል\n- ተጠቃሚዎች bookings ፈጥረው ከፍለዋል';

  @override
  String currencyLabel(Object symbol) {
    return 'ገንዘብ: $symbol';
  }

  @override
  String pricesShownInCurrency(Object symbol, Object country) {
    return 'ዋጋዎች በ $symbol ($country) ይታያሉ';
  }

  @override
  String jobTitleWithId(Object id) {
    return 'ስራ #$id';
  }

  @override
  String serviceLine(Object service) {
    return 'አገልግሎት: $service';
  }

  @override
  String whenLine(Object date, Object time) {
    return 'መቼ: $date $time';
  }

  @override
  String priceLine(Object price) {
    return 'ዋጋ: $price';
  }

  @override
  String get acceptJob => 'ስራ ተቀበል';

  @override
  String get failedToAcceptJob => 'ስራውን መቀበል አልተቻለም።';

  @override
  String get jobAcceptedSuccessfully => 'ስራው በተሳካ ሁኔታ ተቀብሏል።';

  @override
  String get newServiceRequestTitle => 'አዲስ የአገልግሎት ጥያቄ';

  @override
  String get reviewAlreadySubmitted => 'Review submitted ✓';

  @override
  String get offeredPriceLabel => 'የቀረበ ዋጋ';

  @override
  String get offeredPriceHint => 'ለምሳሌ 25.00';

  @override
  String get enterValidPrice => 'ትክክለኛ ዋጋ ያስገቡ';

  @override
  String get bookAndPay => 'ቦታ ያስይዙ እና ይክፈሉ';

  @override
  String bookAndPayAmount(Object amount) {
    return 'ቦታ ያስይዙ እና ይክፈሉ $amount';
  }

  @override
  String get haircutService => 'ፀጉር መቁረጥ';

  @override
  String get stylingService => 'ስታይሊንግ';

  @override
  String get timeLabel => 'ሰዓት:';

  @override
  String get notesLabel => 'ማስታወሻዎች';

  @override
  String get requestCreatedAndPaidBroadcast =>
      'ጥያቄው ተፈጥሯል እና ተከፍሏል! ለአቅራቢዎች ተልኳል።';

  @override
  String locationLatLng(Object lat, Object lng) {
    return 'ቦታ: $lat, $lng';
  }

  @override
  String get paymentMethodsTitle => 'የክፍያ መንገዶች';

  @override
  String get paymentPreferencesInfo =>
      'እነዚህ ምርጫዎች በመሣሪያዎ ውስጥ በአካባቢያዊ መልኩ ይቀመጣሉ። እውነተኛ ክፍያ በStripe/ሌሎች መዋቅሮች በደህና ይሰራል።';

  @override
  String get preferredMethodLabel => 'የተመረጠ መንገድ (በሀገር መሰረት አካባቢያዊ መዋቅር ይመረጣል)';

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
  String get mobileMoneyNumberLabel => 'Mobile Money ቁጥር';

  @override
  String get wechatAlipayIdLabel => 'WeChat/Alipay ID';

  @override
  String get cardLast4DigitsLabel => 'የካርድ የመጨረሻ 4 አሃዞች';

  @override
  String get paypalEmailLabel => 'PayPal ኢሜይል';

  @override
  String get applePayEnabledOnDevice => 'Apple Pay በዚህ መሣሪያ ላይ ነቅቷል';

  @override
  String get savePaymentPreferences => 'የክፍያ ምርጫዎችን አስቀምጥ';

  @override
  String get paymentPrefsSavedInfo =>
      'የክፍያ ምርጫዎች በአካባቢያዊ ሁኔታ ተቀምጠዋል። እውነተኛ መቁረጥ በኋላ በStripe/ሌሎች መዋቅሮች ይሰራል።';

  @override
  String get failedToLoadImage => 'ምስሉን መโหลด አልተቻለም።';

  @override
  String get earningsTitle => 'ገቢ';

  @override
  String get couldNotLoadEarningsSummary => 'የገቢ ማጠቃለያ መโหลด አልተቻለም።';

  @override
  String get noData => 'ምንም መረጃ የለም።';

  @override
  String get retry => 'ደግመው ይሞክሩ';

  @override
  String get summaryTitle => 'ማጠቃለያ';

  @override
  String get totalLabel => 'ጠቅላላ';

  @override
  String get pendingLabel => 'በመጠበቅ ላይ';

  @override
  String get paidLabel => 'ተከፍሏል';

  @override
  String get pdfReportTitle => 'የPDF ሪፖርት';

  @override
  String get periodLabel => 'ወቅት';

  @override
  String get periodThisMonth => 'ይህ ወር';

  @override
  String get periodLastMonth => 'ያለፈው ወር';

  @override
  String get periodYtd => 'ከዓመቱ መጀመሪያ ጀምሮ';

  @override
  String get periodAllTime => 'ሁልጊዜ';

  @override
  String get couldNotDownloadPdfReport => 'የPDF ሪፖርቱን ማውረድ አልተቻለም።';

  @override
  String couldNotOpenPdfWithValue(Object error) {
    return 'PDF መክፈት አልተቻለም: $error';
  }

  @override
  String get savingFilesNotSupportedWeb => 'በWeb ላይ ፋይሎችን ማስቀመጥ አሁን አይደገፍም።';

  @override
  String savedToDocumentsIosWithPath(Object path) {
    return 'በDocuments (iOS) ተቀምጧል:\n$path';
  }

  @override
  String savedToFilesWithPath(Object path) {
    return 'በፋይሎች ውስጥ ተቀምጧል:\n$path';
  }

  @override
  String get open => 'ክፈት';

  @override
  String failedToSavePdfWithValue(Object error) {
    return 'PDF ማስቀመጥ አልተቻለም: $error';
  }

  @override
  String get openPdfReport => 'የPDF ሪፖርትን ክፈት';

  @override
  String get savePdfToDownloads => 'PDF ወደ Downloads አስቀምጥ';

  @override
  String get reportWatermarkNote =>
      'የሪፖርት PDF ውስጥ የStyloria watermark መኖር አለበት።';

  @override
  String get referFriendsTitle => 'ጓደኞችን ያስገቡ';

  @override
  String get shareReferralCodeBody =>
      'የሪፈራል ኮድዎን ከጓደኞችዎ ጋር ያጋሩ። በኋላ እነሱ ሲመዝገቡ እና bookings ሲጨርሱ ሽልማት ማከል ይችላሉ።';

  @override
  String get yourReferralCodeLabel => 'የእርስዎ ሪፈራል ኮድ:';

  @override
  String get copy => 'ኮፒ';

  @override
  String referralCodeCopiedWithCode(Object code) {
    return 'የሪፈራል ኮድ ተኮፒ ተደርጓል: $code';
  }

  @override
  String get navHome => 'መነሻ';

  @override
  String get navBookings => 'ቦታ ማስያዝ';

  @override
  String get navNotifications => 'ማሳወቂያዎች';

  @override
  String get navAccount => 'መለያ';

  @override
  String get welcome => 'እንኳን ደህና መጡ';

  @override
  String welcomeName(Object name) {
    return 'እንኳን ደህና መጡ፣ $name';
  }

  @override
  String get toggleThemeTooltip => 'ብርሃን/ጨለማ ሁኔታ ቀይር';

  @override
  String loggedInAs(Object role) {
    return 'ገብተዋል እንደ: $role';
  }

  @override
  String locationWithValue(Object value) {
    return 'ቦታ: $value';
  }

  @override
  String get homeTagline => 'በቀጥታ ቦታ ማስያዝ እና ታማኝ አቅራቢዎች ጋር የግሩሚንግ ተሞክሮዎን ያሻሽሉ።';

  @override
  String get manageProviderProfile => 'የአቅራቢ ፕሮፋይል አስተዳድር';

  @override
  String get browseOpenJobs => 'ክፍት ስራዎችን ተመልከት';

  @override
  String get quickActions => 'ፈጣን እርምጃዎች';

  @override
  String get newBooking => 'አዲስ ቦታ ማስያዝ';

  @override
  String notificationsWithUnread(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ያልተነበቡ',
      one: '1 ያልተነበበ',
    );
    return 'ማሳወቂያዎች ($_temp0)';
  }

  @override
  String get liveLocationTrackingTitle => 'ቀጥታ የቦታ ክትትል';

  @override
  String get live => 'Live';

  @override
  String get locationServicesDisabled => 'የቦታ አገልግሎቶች ተዘግተዋል';

  @override
  String get locationPermissionDenied => 'የቦታ ፍቃድ ተከልክሏል';

  @override
  String get locationPermissionPermanentlyDenied => 'የቦታ ፍቃድ በቋሚነት ተከልክሏል';

  @override
  String failedToGetLocationWithValue(Object error) {
    return 'ቦታ ማግኘት አልተቻለም: $error';
  }

  @override
  String get youProvider => 'እርስዎ (አቅራቢ)';

  @override
  String get youCustomer => 'እርስዎ (ደንበኛ)';

  @override
  String get customer => 'ደንበኛ';

  @override
  String get bookingDetails => 'የቦታ ማስያዝ ዝርዝር';

  @override
  String get navigate => 'አቅጣጫ';

  @override
  String get failedToLoadNotifications => 'ማሳወቂያዎችን መโหลด አልተቻለም።';

  @override
  String get failedToMarkAsRead => 'እንደ ተነበበ ማስመልከት አልተቻለም';

  @override
  String get noNotificationsYet => 'እስካሁን ማሳወቂያ የለም።';

  @override
  String get markRead => 'ተነበበ አድርግ';

  @override
  String get providerKycTitle => 'የአቅራቢ ማረጋገጫ (KYC)';

  @override
  String get logoutTooltip => 'ውጣ';

  @override
  String statusLabel(Object status) {
    return 'ሁኔታ፡ $status';
  }

  @override
  String rejectedWithNotes(Object notes) {
    return 'ተቀባይነት አልተሰጠም፡ $notes';
  }

  @override
  String get kycInstructions => 'የአቅራቢ ባህሪያትን ለመጠቀም መታወቂያዎን እና ሴልፊ ለማረጋገጫ ይጫኑ።';

  @override
  String get idFrontRequired => 'መታወቂያ ፊት (አስፈላጊ)';

  @override
  String get selectIdFront => 'መታወቂያ ፊት ይምረጡ';

  @override
  String get idBackRequired => 'መታወቂያ ጀርባ (አስፈላጊ)';

  @override
  String get selectIdBackRequired => 'መታወቂያ ጀርባ ይምረጡ';

  @override
  String get selfieRequired => 'ሴልፊ (አስፈላጊ)';

  @override
  String get selectSelfie => 'ሴልፊ ይምረጡ';

  @override
  String get takeSelfie => 'ሴልፊ ያንሱ';

  @override
  String get errorUploadAllRequired =>
      'እባክዎ መታወቂያ (ፊት)፣ መታወቂያ (ጀርባ) እና ሴልፊ ይጫኑ።';

  @override
  String failedSubmitKycCode(Object code) {
    return 'KYC ማስገባት አልተሳካም (ኮድ $code).';
  }

  @override
  String submittedCurrentStatus(Object status) {
    return 'ተላክ። የአሁኑ ሁኔታ፡ $status';
  }

  @override
  String get unknownStatus => 'ያልታወቀ';

  @override
  String get submitKyc => 'KYC ላክ';

  @override
  String get verificationMayTakeTimeNote =>
      'ማስታወሻ፡ ማረጋገጫው ጊዜ ሊወስድ ይችላል። ከተፈቀደ በኋላ የአቅራቢ ባህሪያትን መጠቀም ይችላሉ።';

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
  String get enterVerificationCodeTitle => 'የማረጋገጫ ኮድ ያስገቡ';

  @override
  String otpSentToUsername(Object username) {
    return 'ከ\"$username\" ጋር የተያያዘው ስልክ ቁጥር ወደ 6 አሃዝ ኮድ\nላክነዋል።';
  }

  @override
  String get sixDigitCodeLabel => '6 አሃዝ ኮድ';

  @override
  String get enterSixDigitCodeValidation => '6 አሃዝ ኮድ ያስገቡ';

  @override
  String get otpInvalidOrExpired => 'የተሳሳተ ወይም ጊዜው ያለፈ ኮድ።';

  @override
  String get failedLoadUserInfoAfterVerification =>
      'ማረጋገጫ በኋላ የተጠቃሚ መረጃ መጫን አልተሳካም።';

  @override
  String get chatWithSupportTitle => 'ከድጋፍ ጋር ውይይት';

  @override
  String get unableStartSupportChat => 'የድጋፍ ውይይት መጀመር አልተቻለም።';

  @override
  String get invalidSupportThreadReturned => 'ከሰርቨር የተመለሰው የድጋፍ ትርድ ልክ አይደለም።';

  @override
  String get noMessagesYet => 'እስካሁን መልዕክቶች የሉም። ውይይት ጀምሩ!';

  @override
  String get supportDefaultName => 'ድጋፍ';

  @override
  String get aboutPoliciesTitle => 'ስለ እኛ እና ፖሊሲዎች';

  @override
  String get newBookingTitle => 'New Booking';

  @override
  String get appointmentDetailsTitle => 'Appointment details';

  @override
  String get pickDate => 'Pick date';

  @override
  String get pickTime => 'Pick time';

  @override
  String get serviceTypeTitle => 'Service type';

  @override
  String get serviceDropdownLabel => 'Service';

  @override
  String get serviceHaircutLabel => 'Haircut';

  @override
  String get serviceBraidsLabel => 'Braids';

  @override
  String get serviceShaveLabel => 'Shave';

  @override
  String get serviceHairColoringLabel => 'Hair Coloring';

  @override
  String get serviceManicureLabel => 'Manicure';

  @override
  String get servicePedicureLabel => 'Pedicure';

  @override
  String get serviceNailArtLabel => 'Nail Art';

  @override
  String get serviceMakeupLabel => 'Makeup';

  @override
  String get serviceFacialLabel => 'Facial';

  @override
  String get serviceWaxingLabel => 'Waxing';

  @override
  String get serviceMassageLabel => 'Massage';

  @override
  String get serviceTattooLabel => 'Tattoo';

  @override
  String get serviceHairStylingLabel => 'Hair Styling';

  @override
  String get serviceHairTreatmentLabel => 'Hair Treatment';

  @override
  String get serviceHairExtensionsLabel => 'Hair Extensions';

  @override
  String get serviceOtherServicesLabel => 'Other Services';

  @override
  String get notesForProviderOptionalLabel =>
      'Notes for your provider (optional)';

  @override
  String get locationTitle => 'Location';

  @override
  String get latitudeLabel => 'Latitude';

  @override
  String get longitudeLabel => 'Longitude';

  @override
  String get requiredField => 'Required';

  @override
  String get useMyCurrentLocation => 'Use my current location';

  @override
  String pricesShownIn(Object symbol, Object country) {
    return 'Prices shown in $symbol ($country)';
  }

  @override
  String get chooseTimeLaterThanCurrent =>
      'Please choose a time later than the current time.';

  @override
  String get pleasePickDateAndTime => 'Please pick date and time.';

  @override
  String get locationUpdatedFromGps => 'Location updated from GPS.';

  @override
  String failedToGetLocation(Object error) {
    return 'Failed to get location: $error';
  }

  @override
  String bookingCreatedChoosePrice(Object id) {
    return 'Booking created! ID: $id • Choose your price option.';
  }

  @override
  String get failedToCreateBooking => 'Failed to create booking.';

  @override
  String get paymentsNotSupportedLong =>
      'Payments are not supported on this platform. Please run the app on Android, iOS, macOS, or Web to test real payments.';

  @override
  String get noBookingToConfirm =>
      'No booking to confirm. Please create a booking first.';

  @override
  String get pleaseChoosePriceOption => 'Please choose a price option.';

  @override
  String get failedCreatePaymentTryAgain =>
      'Failed to create payment on server. Please try again.';

  @override
  String paymentSuccessfulMessage(Object bookingId, Object paid) {
    return 'Payment successful!\nBooking #$bookingId • Paid: $paid\nYour request is now visible to nearby providers.';
  }

  @override
  String get paymentSucceededButFailedUpdate =>
      'Payment succeeded, but failed to update booking on server.';

  @override
  String paymentCancelledOrFailed(Object reason) {
    return 'Payment cancelled or failed: $reason';
  }

  @override
  String unexpectedPaymentError(Object error) {
    return 'Unexpected payment error: $error';
  }

  @override
  String get createBookingButton => 'Create Booking';

  @override
  String get chooseYourPriceOptionTitle => 'Choose Your Price Option';

  @override
  String transportationCostLabel(Object cost) {
    return 'Transportation cost: $cost';
  }

  @override
  String get budgetTierTitle => 'BUDGET';

  @override
  String get standardTierTitle => 'STANDARD';

  @override
  String get priorityTierTitle => 'PRIORITY';

  @override
  String get budgetTierDescription => 'Best value among nearby providers';

  @override
  String get standardTierDescription =>
      'Recommended balance of price & availability';

  @override
  String get priorityTierDescription =>
      'Premium option to attract top providers faster';

  @override
  String get naShort => 'N/A';

  @override
  String get priceBreakdownTitle => 'Price Breakdown';

  @override
  String get servicePriceLabel => 'Service Price';

  @override
  String get transportationLabel => 'Transportation';

  @override
  String serviceFeeLabel(Object percent) {
    return 'Service Fee ($percent%)';
  }

  @override
  String allPricesIn(Object currency, Object country) {
    return 'All prices in $currency ($country)';
  }

  @override
  String get userCountryPlaceholder => 'User country';

  @override
  String get totalToPayTitle => 'Total to Pay';

  @override
  String get includesServiceTransportation =>
      'Includes service + transportation';

  @override
  String get confirmAndPay => 'Confirm & Pay';

  @override
  String get howPricingWorksTitle => 'How Pricing Works';

  @override
  String get howPricingWorksBullets =>
      '• Budget: best value among nearby providers\n• Standard: recommended default\n• Priority: premium option to speed up acceptance\n• Transportation is included in the total';

  @override
  String get myBookingsTitle => 'My Bookings';

  @override
  String get myAssignedJobsTitle => 'My Assigned Jobs';

  @override
  String get pleaseCompleteProviderProfileFirst =>
      'Please complete your provider profile first.';

  @override
  String get failedToLoadBookings => 'Failed to load bookings.';

  @override
  String get profileSetupRequiredTitle => 'Profile Setup Required';

  @override
  String get profileSetupRequiredBody =>
      'You need to complete your provider profile before you can view assigned jobs and earnings.';

  @override
  String get later => 'Later';

  @override
  String get setupNow => 'Setup Now';

  @override
  String get noBookingsFound => 'No bookings found.';

  @override
  String get findNearbyOpenJobs => 'Find Nearby Open Jobs';

  @override
  String get pay => 'Pay';

  @override
  String get rate => 'Rate';

  @override
  String bookingNumber(Object id) {
    return 'Booking #$id';
  }

  @override
  String whenOn(Object date) {
    return 'When: $date';
  }

  @override
  String whenAt(Object date, Object time) {
    return 'When: $date at $time';
  }

  @override
  String providerLine(Object name) {
    return 'Provider: $name';
  }

  @override
  String userLine(Object name) {
    return 'User: $name';
  }

  @override
  String estimatedPriceLine(Object price) {
    return 'Estimated price: $price';
  }

  @override
  String paymentLine(Object status) {
    return 'Payment: $status';
  }

  @override
  String get paymentUnpaid => 'unpaid';

  @override
  String get paymentUnknown => 'unknown';

  @override
  String get confirmPaymentTitle => 'Confirm payment';

  @override
  String confirmPaymentBody(Object amount) {
    return 'Pay $amount to confirm this booking?';
  }

  @override
  String get yesPay => 'Yes, Pay';

  @override
  String get failedToCreatePaymentIntent => 'Failed to create payment intent.';

  @override
  String get paymentSuccessfulShort => 'Payment successful.';

  @override
  String get paymentSucceededButFailedUpdateBooking =>
      'Payment succeeded, but failed to update booking on server.';

  @override
  String paymentCancelledOrFailedReason(Object reason) {
    return 'Payment cancelled or failed: $reason';
  }

  @override
  String unexpectedPaymentErrorReason(Object error) {
    return 'Unexpected payment error: $error';
  }

  @override
  String rateProviderTitle(Object providerName) {
    return '$providerNameን ደረጃ ይስጡ';
  }

  @override
  String get selectRatingHelp => 'Select rating (1 = poor, 5 = excellent):';

  @override
  String get commentsOptionalLabel => 'Comments (optional)';

  @override
  String get submit => 'Submit';

  @override
  String get reviewSubmitted => 'Review submitted.';

  @override
  String get failedSubmitReview => 'Failed to submit review.';

  @override
  String failedToLoadProfile(Object error) {
    return 'መገለጫን መጫን አልተሳካም፦ $error';
  }

  @override
  String profileSavedSuccess(Object action) {
    return 'መገለጫ በተሳካ ሁኔታ $action ተደርጓል!';
  }

  @override
  String genericError(Object error) {
    return 'ስህተት፦ $error';
  }

  @override
  String get locationPermissionDeniedEnableInSettings =>
      'የቦታ ፍቃድ ተከልክሏል። እባክዎ በቅንብሮች ያንቁ።';

  @override
  String get locationPermissionPermanentlyDeniedEnableInAppSettings =>
      'የቦታ ፍቃድ በቋሚነት ተከልክሏል። እባክዎ በመተግበሪያ ቅንብሮች ያንቁ።';

  @override
  String errorGettingLocation(Object error) {
    return 'ቦታ ሲያገኝ ስህተት፦ $error';
  }

  @override
  String get couldNotFindLocationForAddress => 'ለዚህ አድራሻ ቦታ ማግኘት አልተቻለም';

  @override
  String errorConvertingAddress(Object error) {
    return 'አድራሻ ሲቀየር ስህተት፦ $error';
  }

  @override
  String get portfolioUnavailableCompleteKycFirst =>
      'ፖርትፎሊዮ አይገኝም። አገልጋይ ከሆኑ መጀመሪያ KYC ማረጋገጫን ያጠናቅቁ።';

  @override
  String failedToLoadPortfolio(Object error) {
    return 'ፖርትፎሊዮን መጫን አልተሳካም፦ $error';
  }

  @override
  String get addPhoto => 'ፎቶ ጨምር';

  @override
  String get addVideo => 'ቪዲዮ ጨምር';

  @override
  String get addPost => 'ፖስት ጨምር';

  @override
  String get captionOptionalTitle => 'መግለጫ (አማራጭ)';

  @override
  String get captionHintExample => 'ምሳሌ፦ “Knotless braids በደንበኛ”';

  @override
  String get skip => 'ዝለል';

  @override
  String get save => 'አስቀምጥ';

  @override
  String get failedToCreatePortfolioPost => 'የፖርትፎሊዮ ፖስት መፍጠር አልተሳካም።';

  @override
  String get uploadFailedMediaUpload => 'መስቀል (upload) አልተሳካም (ሚዲያ መስቀል).';

  @override
  String uploadFailed(Object error) {
    return 'መስቀል (upload) አልተሳካም፦ $error';
  }

  @override
  String get deletePostTitle => 'ፖስት ማጥፋት?';

  @override
  String get deletePostBody => 'ይህ ፖስቱን ከፖርትፎሊዮዎ ያስወግዳል።';

  @override
  String get delete => 'አጥፋ';

  @override
  String get deleteFailed => 'ማጥፋት አልተሳካም።';

  @override
  String deleteFailedWithError(Object error) {
    return 'ማጥፋት አልተሳካም፦ $error';
  }

  @override
  String get portfolioTitle => 'ፖርትፎሊዮ';

  @override
  String get noPortfolioPostsYetHelpText =>
      'እስካሁን ፖርትፎሊዮ ፖስቶች የሉም። የስራዎን ፎቶ/ቪዲዮ ይጨምሩ እንዲታመኑ ይረዳል።';

  @override
  String get setupProviderProfileTitle => 'የአገልጋይ መገለጫ አዘጋጅ';

  @override
  String get providerProfileTitle => 'የአገልጋይ መገለጫ';

  @override
  String get welcomeToStyloriaTitle => 'ወደ Styloria እንኳን ደህና መጡ!';

  @override
  String get completeProviderProfileToStartEarning =>
      'ስራ ለመቀበል እና ገንዘብ ለማግኘት የአገልጋይ መገለጫዎን ያጠናቅቁ።';

  @override
  String reviewCountLabel(int count) {
    return '($count ግምገማዎች)';
  }

  @override
  String get topRatedChip => 'ከፍተኛ ደረጃ';

  @override
  String get bioLabel => 'ባዮ / መግለጫ';

  @override
  String get bioHint => 'ለደንበኞች ስለ ችሎታዎ እና ልምድዎ ይንገሩ...';

  @override
  String get pleaseEnterBio => 'እባክዎ ባዮ ያስገቡ';

  @override
  String bioMinLength(int min) {
    return 'ባዮ ቢያንስ $min ቁምፊ መሆን አለበት';
  }

  @override
  String get yourLocationTitle => 'ቦታዎ';

  @override
  String get locationHelpMatchNearbyClients => 'ቦታዎ ከአቅራቢ ደንበኞች ጋር ለመያያዝ ይረዳል';

  @override
  String get locationHelpUpdateToFindJobs => 'በተለያዩ አካባቢዎች ስራ ለማግኘት ቦታዎን ያዘምኑ';

  @override
  String get useMyCurrentLocationTitle => 'የአሁኑን ቦታዬን ተጠቀም';

  @override
  String get gpsSubtitle => 'GPS በመጠቀም ቦታን በራስ-ሰር ያግኙ';

  @override
  String get orLabel => 'ወይም';

  @override
  String get enterYourAddressTitle => 'አድራሻዎን ያስገቡ';

  @override
  String get fullAddressLabel => 'ሙሉ አድራሻ';

  @override
  String get fullAddressHint => 'ምሳሌ፦ 123 Main St, Accra, Ghana';

  @override
  String get find => 'ፈልግ';

  @override
  String get addressHelpText => 'የመንገድ አድራሻ፣ ከተማ፣ እና ሀገር ያስገቡ';

  @override
  String get coordinatesAutoFilledTitle => 'ኮኦርዲኔቶች (በራስ-ሰር ይሞላ)';

  @override
  String get servicePricingTitle => 'የአገልግሎት ዋጋ';

  @override
  String get servicePricingHelp =>
      'ለእያንዳንዱ አገልግሎት ዋጋዎን ያዘጋጁ። ማቅረብ የማይችሉትን “Not Offered” ይምረጡ።';

  @override
  String get serviceHeader => 'አገልግሎት';

  @override
  String get priceHeader => 'ዋጋ';

  @override
  String get notOfferedHeader => 'አይቀርብም';

  @override
  String get priceHint => '0.00';

  @override
  String get providerHowPricingWorksTitle => 'የዋጋ አሰራር:';

  @override
  String get providerHowPricingWorksBody =>
      '• ዋጋዎ ለአገልግሎት የሚያከፍሉት ነው\n• የትራንስፖርት ወጪ = 80% ከተጠቃሚ ምንዛሬ በኪ.ሜ\n• ተጠቃሚዎች በአቅራቢ አገልጋዮች መሠረት 3 አማራጮች ያያሉ:\n  - Budget: ዝቅተኛ ዋጋ\n  - Standard: አማካይ ዋጋ\n  - Priority: ከፍተኛ ዋጋ';

  @override
  String get availableForBookingsTitle => 'ለቦኪንግ ዝግጁ';

  @override
  String get availableOnHelp => '✓ በአቅራቢ ደንበኞች ፍለጋ ውጤቶች ውስጥ ትታያላችሁ';

  @override
  String get availableOffHelp => '✗ አዲስ የስራ እንቅስቃሴ አትቀበሉም';

  @override
  String get completeSetupStartEarning => 'ማዘጋጀት ጨርስ እና መቆጠር ጀምር';

  @override
  String get updateProfile => 'መገለጫ አዘምን';

  @override
  String get skipForNow => 'ለአሁን ዝለል';

  @override
  String get paymentsNotSupportedShort =>
      'በዚህ መድረክ ላይ ክፍያ አይደገፍም። እባክዎ Android, iOS, macOS ወይም Web ላይ ያስኪዱ።';

  @override
  String get genericContact => 'እውቂያ';

  @override
  String get genericProvider => 'አገልግሎት አቅራቢ';

  @override
  String get genericNotAvailable => 'አይገኝም';

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
  String get reviewSelectRatingPrompt => 'ደረጃ ይምረጡ (1 እስከ 5).';

  @override
  String get reviewCommentOptionalLabel => 'አስተያየት (አማራጭ)';

  @override
  String get genericCancel => 'ሰርዝ';

  @override
  String get genericSubmit => 'አስገባ';

  @override
  String get reviewSubmitFailed => 'ግምገማ መላክ አልተሳካም።';

  @override
  String get rateThisService => 'ይህን አገልግሎት ደረጃ ይስጡ';

  @override
  String get tipLeaveTitle => 'ቲፕ ይስጡ';

  @override
  String get tipChooseAmountPrompt => 'የቲፕ መጠን ይምረጡ ወይም የራስዎን ያስገቡ።';

  @override
  String get tipNoTip => 'ቲፕ የለም';

  @override
  String get tipCustomAmountLabel => 'ብጁ የቲፕ መጠን';

  @override
  String get genericContinue => 'ቀጥል';

  @override
  String get tipSkipped => 'ቲፕ ተወው።';

  @override
  String get tipFailedToSaveChoice => 'የቲፕ ምርጫ ማስቀመጥ አልተሳካም።';

  @override
  String get tipFailedToCreatePayment => 'የቲፕ ክፍያ መፍጠር አልተሳካም።';

  @override
  String get tipPaidSuccessfully => 'ቲፕ በተሳካ ሁኔታ ተከፍሏል። እናመሰግናለን!';

  @override
  String get tipPaidButUpdateFailed => 'የቲፕ ክፍያ ተሳክቷል፣ ግን ቦታ ማሻሻል አልተሳካም።';

  @override
  String tipCancelledOrFailed(Object message) {
    return 'ቲፕ ተሰርዟል/አልተሳካም: $message';
  }

  @override
  String tipUnexpectedError(Object error) {
    return 'ያልተጠበቀ የቲፕ ስህተት: $error';
  }

  @override
  String get tipAlreadyPaidLabel => 'ቲፕ አስቀድሞ ተከፍሏል';

  @override
  String get tipSkippedLabel => 'ቲፕ ተወው';

  @override
  String get tipLeaveButton => 'ቲፕ ይስጡ';

  @override
  String get walletTitle => 'ዋሌት';

  @override
  String get walletTooltip => 'ዋሌት';

  @override
  String get payoutSettingsTitle => 'የክፍያ ቅንብሮች';

  @override
  String get payoutSettingsTooltip => 'የክፍያ ቅንብሮች';

  @override
  String get walletNoWalletYet => 'አሁን ዋሌት የለም። ስራዎችን ጨርሰው ለመገኘት ይጀምሩ።';

  @override
  String get walletCurrencyFieldLabel => 'ምንዛሬ';

  @override
  String walletAvailableLine(Object amount, Object currency) {
    return 'የሚገኝ: $amount $currency';
  }

  @override
  String walletPendingLine(Object amount, Object currency) {
    return 'በመጠባበቅ ላይ: $amount $currency';
  }

  @override
  String get walletCashOutInstant => 'አሁን መውጣት';

  @override
  String get walletCashOutFailed => 'መውጣት አልተሳካም።';

  @override
  String walletCashOutSentTransfer(Object transferId) {
    return 'መውጣት ተልኳል። ማስተላለፊያ: $transferId';
  }

  @override
  String get walletTransactionsTitle => 'ግብይቶች';

  @override
  String get walletNoTransactionsYet => 'እስካሁን ግብይት የለም።';

  @override
  String get payoutAutoPayoutsTitle => 'ራስ-ሰር ክፍያዎች';

  @override
  String get payoutAutoPayoutsSubtitle =>
      'እንደ ተመረጠው መርሃ ግብር ክፍያዎችን በራስ-ሰር ይላኩ።';

  @override
  String get payoutDayUtcLabel => 'የክፍያ ቀን (UTC)';

  @override
  String get payoutHourUtcLabel => 'የክፍያ ሰዓት (UTC)';

  @override
  String get payoutMinimumAmountLabel => 'ዝቅተኛ የራስ-ሰር ክፍያ መጠን';

  @override
  String get payoutMinimumAmountHelper =>
      'የሚገኝ ቀሪ ሂሳብ ≥ ከዚህ መጠን ሲሆን ብቻ ራስ-ሰር ክፍያ ይሄዳል።';

  @override
  String get payoutInstantCashOutEnabledTitle => 'ፈጣን መውጣት ነቅቷል';

  @override
  String get payoutInstantCashOutEnabledSubtitle =>
      '“መውጣት” አዝራርን ያንቁ (ክፍያ ሊኖር ይችላል)።';

  @override
  String get payoutSettingsSaved => 'የክፍያ ቅንብሮች ተቀምጠዋል።';

  @override
  String get payoutSettingsSaveFailed => 'የክፍያ ቅንብሮችን ማስቀመጥ አልተሳካም።';

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
