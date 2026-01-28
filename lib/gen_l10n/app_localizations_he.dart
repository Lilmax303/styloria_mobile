// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class AppLocalizationsHe extends AppLocalizations {
  AppLocalizationsHe([String locale = 'he']) : super(locale);

  @override
  String get appTitle => 'Styloria';

  @override
  String get account => 'חשבון';

  @override
  String get profile => 'פרופיל';

  @override
  String get myBookings => 'ההזמנות שלי';

  @override
  String get openJobs => 'משרות פתוחות';

  @override
  String get earnings => 'רווחים';

  @override
  String get paymentMethods => 'אמצעי תשלום';

  @override
  String get referFriends => 'הזמנת חברים';

  @override
  String get language => 'שפה';

  @override
  String get settings => 'הגדרות';

  @override
  String get darkMode => 'מצב כהה';

  @override
  String get systemDefault => 'ברירת מחדל של המערכת';

  @override
  String get languageUpdated => 'השפה עודכנה';

  @override
  String get languageSetToSystemDefault => 'השפה הוגדרה לברירת המחדל של המערכת';

  @override
  String get helpAndSupport => 'עזרה ותמיכה';

  @override
  String get chatWithCustomerService => 'צ\'אט עם שירות הלקוחות';

  @override
  String get aboutAndPolicies => 'אודות ומדיניות';

  @override
  String get viewUserPoliciesAndAgreements => 'צפייה במדיניות ובהסכמי משתמש';

  @override
  String get logOut => 'התנתקות';

  @override
  String get deleteAccount => 'מחיקת חשבון';

  @override
  String get deleteAccountSubtitle => 'לא ניתן לבטל פעולה זו';

  @override
  String get deleteAccountTitle => 'מחיקת חשבון';

  @override
  String get deleteAccountConfirmBody =>
      'האם אתה בטוח שברצונך למחוק את החשבון שלך?\n\nפעולה זו תנתק אותך וייתכן שתאבד גישה לצמיתות.';

  @override
  String get no => 'לא';

  @override
  String get yesDelete => 'כן, למחוק';

  @override
  String get deleteAccountSheetTitle => 'מצטערים לראות אותך עוזב/ת.';

  @override
  String get deleteAccountSheetPrompt => 'אפשר לדעת למה? (בחר/י את כל המתאים)';

  @override
  String get deleteAccountSelectAtLeastOneReason => 'אנא בחר/י לפחות סיבה אחת.';

  @override
  String get tellUsMoreOptional => 'ספר/י לנו עוד (אופציונלי)';

  @override
  String get suggestionsToImproveOptional => 'הצעות לשיפור (אופציונלי)';

  @override
  String get deleteMyAccount => 'מחק את החשבון שלי';

  @override
  String get cancel => 'ביטול';

  @override
  String get failedToDeleteAccount => 'מחיקת החשבון נכשלה. נסה/י שוב.';

  @override
  String get choosePreferredLanguage => 'בחר/י את השפה המועדפת';

  @override
  String get noteSomeTextMayStillAppearInEnglish =>
      'הערה: פעולה זו משנה את שפת האפליקציה. ייתכן שחלק מהטקסט יופיע באנגלית עד שיוסיפו תרגומים.';

  @override
  String languageSetToName(Object name) {
    return 'השפה הוגדרה ל־$name';
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
  String get confirmPassword => 'אימות סיסמה';

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
  String get deletionReason1 => 'אני כבר לא צריך/ה את Styloria';

  @override
  String get deletionReason2 => 'הייתה לי בעיה באימות החשבון (אימייל/KYC)';

  @override
  String get deletionReason3 => 'לא מצאתי שירותים/ספקים בקרבתי';

  @override
  String get deletionReason4 => 'המחירים או העמלות היו גבוהים מדי / לא ברורים';

  @override
  String get deletionReason5 => 'האפליקציה הייתה מבלבלת / קשה לשימוש';

  @override
  String get deletionReason6 => 'באגים או בעיות ביצועים';

  @override
  String get deletionReason7 => 'בעיות תשלום/החזר';

  @override
  String get deletionReason8 => 'חוויה רעה עם ספק/משתמש';

  @override
  String get deletionReason9 => 'חששות לגבי פרטיות או אבטחה';

  @override
  String get deletionReason10 => 'יצרתי את החשבון הזה בטעות';

  @override
  String get deletionReason11 => 'אני עובר/ת לפלטפורמה אחרת';

  @override
  String get deletionReason12 => 'אחר';

  @override
  String get loginWelcomeTitle => 'ברוך הבא ל‑Styloria';

  @override
  String get loginWelcomeSubtitle => 'התחבר כדי לנהל הזמנות ושירותים.';

  @override
  String get loginFailedToLoadUserInfo =>
      'ההתחברות הצליחה אך לא ניתן לטעון את פרטי המשתמש.';

  @override
  String get username => 'שם משתמש';

  @override
  String get password => 'סיסמה';

  @override
  String get required => 'נדרש';

  @override
  String get login => 'התחברות';

  @override
  String get createNewAccount => 'יצירת חשבון חדש';

  @override
  String get requestEmailVerificationCode => 'בקשת קוד אימות לאימייל';

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
  String get pleaseEnterAddress => 'אנא הזן כתובת';

  @override
  String get locationUpdatedFromAddress => 'המיקום עודכן מהכתובת';

  @override
  String get createAccountTitle => 'יצירת חשבון';

  @override
  String get joinStyloria => 'הצטרפות ל‑Styloria';

  @override
  String get registerSubtitle => 'צרו חשבון כדי להזמין שירותים או להפוך לספק';

  @override
  String get iWantTo => 'אני רוצה:';

  @override
  String get bookServices => 'להזמין שירותים';

  @override
  String get provideServices => 'להציע שירותים';

  @override
  String get personalInformation => 'פרטים אישיים';

  @override
  String get firstName => 'שם פרטי';

  @override
  String get lastName => 'שם משפחה';

  @override
  String get selectDateOfBirth => 'בחר/י תאריך לידה';

  @override
  String get phoneNumber => 'מספר טלפון';

  @override
  String get pleaseEnterPhoneNumber => 'נא להזין מספר טלפון';

  @override
  String get accountInformation => 'פרטי חשבון';

  @override
  String get chooseUniqueUsernameHint => 'בחר/י שם משתמש ייחודי';

  @override
  String get youAreCurrentlyUnavailable => 'אתה כרגע לא זמין';

  @override
  String get toBrowseAndAcceptJobsEnableAvailability =>
      'כדי לעיין ולקבל בקשות עבודה בקרבת מקום, עליך להגדיר את עצמך כזמין להזמנות.';

  @override
  String get goToProfileSettings => 'עבור להגדרות הפרופיל';

  @override
  String get tipToggleAvailableForBookings =>
      'טיפ: הפעל את \"זמין להזמנות\" בפרופיל הספק שלך כדי להתחיל לקבל בקשות עבודה.';

  @override
  String requestedBy(String name) {
    return 'התבקש על ידי: $name';
  }

  @override
  String locationLabel(String address) {
    return 'מיקום: $address';
  }

  @override
  String get email => 'אימייל';

  @override
  String get emailHint => 'your@email.com';

  @override
  String get enterValidEmail => 'נא להזין אימייל תקין';

  @override
  String get security => 'אבטחה';

  @override
  String get passwordHintAtLeast10 => 'לפחות 10 תווים';

  @override
  String get passwordMin10 => 'הסיסמה חייבת להכיל לפחות 10 תווים';

  @override
  String get iAgreeTo => 'אני מסכים ל';

  @override
  String get termsOfService => 'תנאי השירות';

  @override
  String get and => 'ו';

  @override
  String get privacyPolicy => 'מדיניות הפרטיות';

  @override
  String get passwordIsRequired => 'סיסמה נדרשת';

  @override
  String get passwordsDoNotMatch => 'הסיסמאות אינן תואמות';

  @override
  String get pleaseSelectDob => 'נא לבחור תאריך לידה.';

  @override
  String get pleaseSelectCountry => 'נא לבחור מדינה.';

  @override
  String get pleaseSelectCity => 'נא לבחור עיר.';

  @override
  String get pleaseEnterValidPhone => 'נא להזין מספר טלפון תקין.';

  @override
  String get mustAcceptTerms => 'חובה לאשר את התנאים.';

  @override
  String get mustBeAtLeast18 => 'עליך להיות בן/בת 18 לפחות כדי להירשם.';

  @override
  String get agreeToTerms => 'אני מסכים/ה לתנאי השירות ולמדיניות הפרטיות';

  @override
  String get createAccountButton => 'יצירת חשבון';

  @override
  String get alreadyHaveAccount => 'כבר יש לך חשבון?';

  @override
  String get emailVerifiedSuccessPleaseLogin =>
      'האימייל אומת בהצלחה. נא להתחבר.';

  @override
  String get pleaseVerifyEmailToContinue => 'נא לאמת את האימייל כדי להמשיך.';

  @override
  String get requestVerificationCodeTitle => 'בקשת קוד אימות';

  @override
  String get requestVerificationInstructions =>
      'הזן/י אימייל או שם משתמש.\nנשלח קוד אימות חדש לאימייל של החשבון.';

  @override
  String get emailOrUsername => 'אימייל או שם משתמש';

  @override
  String get sendCode => 'שליחת קוד';

  @override
  String get ifAccountExistsCodeSent => 'אם החשבון קיים, נשלח קוד.';

  @override
  String get failedToSendVerificationCode => 'שליחת קוד האימות נכשלה.';

  @override
  String get verifyYourEmailTitle => 'אימות אימייל';

  @override
  String get verificationCodeSentInfo =>
      'קוד אימות נשלח לאימייל של החשבון הזה.';

  @override
  String emailVerificationInstructions(Object identifier) {
    return 'הזן/י את הקוד בן 6 הספרות שנשלח לאימייל של החשבון:\n$identifier';
  }

  @override
  String get verificationCodeLabel => 'קוד אימות';

  @override
  String get sendingEllipsis => 'שולח...';

  @override
  String get resendCode => 'שלח מחדש';

  @override
  String get enter6DigitCodeError => 'הזן/י קוד בן 6 ספרות.';

  @override
  String get verifyingEllipsis => 'מאמת...';

  @override
  String get verify => 'אמת';

  @override
  String get invalidOrExpiredCodeTryResending =>
      'הקוד שגוי או פג תוקף. נסה/י לשלוח מחדש.';

  @override
  String bookingTitle(Object id) {
    return 'הזמנה #$id';
  }

  @override
  String get invalidBookingIdForChat => 'מזהה הזמנה לא תקין לצ\'אט.';

  @override
  String get invalidBookingIdForCall => 'מזהה הזמנה לא תקין לשיחה.';

  @override
  String get unableToLoadContactInfo =>
      'לא ניתן לטעון פרטי קשר. ודא/י שההזמנה פעילה.';

  @override
  String noPhoneNumberAvailableForName(Object name) {
    return 'אין מספר טלפון זמין עבור $name.';
  }

  @override
  String get deviceCannotPlaceCalls => 'המכשיר הזה לא יכול לבצע שיחות טלפון.';

  @override
  String get cancelBookingDialogTitle => 'ביטול הזמנה';

  @override
  String get cancelBookingDialogBody =>
      'האם באמת ברצונך לבטל את ההזמנה הזו?\n\nהערה: אם הספק כבר אישר ועברו יותר מ-7 דקות (אך פחות מכ-40 דקות), ייתכן שיוחל קנס לפי הכללים.';

  @override
  String get yesCancel => 'כן, לבטל';

  @override
  String get failedToCancelBooking => 'ביטול ההזמנה נכשל.';

  @override
  String bookingCancelledPenaltyApplied(Object amount) {
    return 'ההזמנה בוטלה. הוחל קנס בסך $amount.';
  }

  @override
  String get bookingCancelledSuccessfully => 'ההזמנה בוטלה בהצלחה.';

  @override
  String get failedToConfirmCompletion => 'אישור הסיום נכשל. נסה/י שוב.';

  @override
  String get bothSidesConfirmedCompletedPayoutReleased =>
      'שני הצדדים אישרו. ההזמנה סומנה כהושלמה והתווך שוחרר.';

  @override
  String get youConfirmedCompletionWaitingForProvider =>
      'אישרת סיום. ממתינים לאישור הספק.';

  @override
  String get youConfirmedCompletionWaitingForUser =>
      'אישרת סיום. ממתינים לאישור המשתמש.';

  @override
  String get statusUnknown => 'לא ידוע';

  @override
  String get statusAccepted => 'התקבל';

  @override
  String get statusInProgress => 'בתהליך';

  @override
  String get statusCompleted => 'הושלם';

  @override
  String get statusCancelled => 'בוטל';

  @override
  String get paymentPaid => 'שולם';

  @override
  String get paymentPending => 'בהמתנה';

  @override
  String get paymentFailed => 'נכשל';

  @override
  String bookingAcceptedBy(Object name) {
    return 'ההזמנה אושרה על ידי $name';
  }

  @override
  String get whenLabel => 'מתי';

  @override
  String atTime(Object time) {
    return 'בשעה $time';
  }

  @override
  String get userLabel => 'משתמש';

  @override
  String get providerLabel => 'ספק';

  @override
  String get estimatedPriceLabel => 'מחיר משוער';

  @override
  String get offeredPaidLabel => 'הוצע / שולם';

  @override
  String get distanceLabel => 'מרחק';

  @override
  String distanceMiles(Object miles) {
    return '$miles מייל';
  }

  @override
  String get acceptedAtLabel => 'אושר ב-';

  @override
  String get cancelledAtLabel => 'בוטל ב-';

  @override
  String get cancelledByLabel => 'בוטל על ידי';

  @override
  String penaltyAppliedLabel(Object amount) {
    return 'הוחל קנס: $amount';
  }

  @override
  String get userConfirmedLabel => 'המשתמש אישר';

  @override
  String get providerConfirmedLabel => 'הספק אישר';

  @override
  String get payoutReleasedLabel => 'התשלום שוחרר';

  @override
  String get yesLower => 'כן';

  @override
  String get noLower => 'לא';

  @override
  String get chat => 'צ\'אט';

  @override
  String get call => 'שיחה';

  @override
  String get actions => 'פעולות';

  @override
  String get confirmCompletion => 'אשר/י סיום';

  @override
  String get noFurtherActionsForBooking =>
      'אין פעולות נוספות זמינות עבור הזמנה זו.';

  @override
  String freeCancellationEndsIn(Object time) {
    return 'הביטול החינמי מסתיים בעוד $time';
  }

  @override
  String get earlyFreeCancellationEndedWarning =>
      'תקופת הביטול החינמי המוקדמת הסתיימה. עד כ-40 דקות לאחר האישור, ביטול מאוחר עלול לגרור קנס.';

  @override
  String get cancelBooking => 'בטל/י הזמנה';

  @override
  String get cancelBookingNoPenalty => 'בטל/י הזמנה (ללא קנס)';

  @override
  String get cancelBookingPenaltyMayApply => 'בטל/י הזמנה (ייתכן קנס)';

  @override
  String get cancellationPolicyInfo =>
      'ניתן לבטל ללא קנס בשבע הדקות הראשונות לאחר אישור הספק, ושוב לאחר כ-40 דקות במידת הצורך. בין הזמנים הללו ייתכן שיוחל קנס לפי הכללים.';

  @override
  String ratingLine(Object rating, int reviewCount) {
    String _temp0 = intl.Intl.pluralLogic(
      reviewCount,
      locale: localeName,
      other: '$reviewCount ביקורות',
      one: 'ביקורת אחת',
    );
    return 'דירוג: $rating ($_temp0)';
  }

  @override
  String get proofOfSkillsPortfolio => 'הוכחת מיומנויות (תיק עבודות)';

  @override
  String get noPortfolioPostsAvailable => 'אין פריטי תיק עבודות זמינים.';

  @override
  String get bookingLocation => 'מיקום ההזמנה';

  @override
  String get location => 'מיקום';

  @override
  String get latitude => 'קו רוחב';

  @override
  String get longitude => 'קו אורך';

  @override
  String get mapWillAppearWhenCoordinatesValid =>
      'המפה תופיע כאן כאשר הקואורדינטות תקינות.';

  @override
  String chatForBookingTitle(Object id) {
    return 'צ\'אט להזמנה #$id';
  }

  @override
  String get unableToStartChat =>
      'לא ניתן להתחיל צ\'אט. הצ\'אט זמין רק כאשר ההזמנה אושרה, בתהליך, או הושלמה בתוך היום האחרון.';

  @override
  String get invalidChatThreadFromServer => 'השרת החזיר שרשור צ\'אט לא תקין.';

  @override
  String get messageNotSentPolicy =>
      'ההודעה לא נשלחה. הערה: אסור לשתף מספרי טלפון או אימייל בצ\'אט.';

  @override
  String get unknown => 'לא ידוע';

  @override
  String get typeMessageHint => 'הקלד הודעה לתמיכה...';

  @override
  String get uploadProfilePicture => 'העלה/י תמונת פרופיל';

  @override
  String get currentProfilePicture => 'תמונת פרופיל נוכחית';

  @override
  String get newPicturePreview => 'תצוגה מקדימה של תמונה חדשה';

  @override
  String get chooseImage => 'בחר/י תמונה';

  @override
  String get upload => 'העלה/י';

  @override
  String get noImageBytesFoundWeb => 'לא נמצאו נתוני תמונה (ווב).';

  @override
  String get pleasePickAnImageFirst => 'בחר/י קודם תמונה.';

  @override
  String get uploadFailedCheckServerLogs =>
      'ההעלאה נכשלה. בדוק/י לוגים בשרת / טוקן.';

  @override
  String get profilePictureUploadedSuccessfully =>
      'תמונת הפרופיל הועלתה בהצלחה!';

  @override
  String errorWithValue(Object error) {
    return 'שגיאה: $error';
  }

  @override
  String get tapToChangeProfilePicture => 'הקש/י כדי לשנות תמונת פרופיל';

  @override
  String usernameValue(Object username) {
    return 'שם משתמש: $username';
  }

  @override
  String roleValue(Object role) {
    return 'תפקיד: $role';
  }

  @override
  String get dateOfBirthYyyyMmDd => 'תאריך לידה (YYYY-MM-DD)';

  @override
  String get saveProfile => 'שמור/י פרופיל';

  @override
  String get failedToSaveProfile => 'נכשל לשמור את הפרופיל. נסה שוב.';

  @override
  String get profileUpdated => 'הפרופיל עודכן.';

  @override
  String get completeYourProviderProfile => 'השלם/י את פרופיל הספק';

  @override
  String get completeProviderProfileBody =>
      'כדי להתחיל לקבל עבודות ולהרוויח כסף, השלם/י את פרופיל הספק.';

  @override
  String get setupProfileNow => 'הגדר פרופיל עכשיו';

  @override
  String get doItLater => 'אחר כך';

  @override
  String get bookingTimerPenaltyPeriodActive => 'תקופת קנס פעילה';

  @override
  String get bookingTimerFreeCancellationPeriod => 'תקופת ביטול חינמית';

  @override
  String bookingTimerTimeRemaining(Object time) {
    return 'זמן שנותר: $time';
  }

  @override
  String get bookingTimerCancellingNowPenalty =>
      'ביטול עכשיו יגרור קנס של 10%.';

  @override
  String get bookingTimerCancelNoPenalty => 'אפשר לבטל ללא קנס.';

  @override
  String get myReviewsTitle => 'הביקורות שלי';

  @override
  String get failedToLoadReviews => 'טעינת הביקורות נכשלה.';

  @override
  String get noReviewsYet => 'עדיין לא השארת ביקורות.';

  @override
  String providerWithName(Object name) {
    return 'ספק: $name';
  }

  @override
  String get providerGeneric => 'ספק';

  @override
  String ratingWithValue(Object rating) {
    return 'דירוג: $rating';
  }

  @override
  String get nearbyOpenJobsTitle => 'עבודות פתוחות בקרבת מקום';

  @override
  String get failedToLoadOpenJobsHint =>
      'לא ניתן לטעון עבודות פתוחות.\nודא/י שיש לך פרופיל ספק עם מיקום מוגדר ו available=true.';

  @override
  String errorLoadingJobsWithValue(Object error) {
    return 'שגיאה בטעינת עבודות: $error';
  }

  @override
  String get noOpenJobsFoundNearbyTitle => 'לא נמצאו עבודות פתוחות בקרבת מקום';

  @override
  String get noOpenJobsFoundNearbyBody =>
      'ודא/י:\n- שהגדרת מיקום ספק\n- שסומנת כזמין/ה\n- שמשתמשים יצרו ושילמו על הזמנות';

  @override
  String currencyLabel(Object symbol) {
    return 'מטבע: $symbol';
  }

  @override
  String pricesShownInCurrency(Object symbol, Object country) {
    return 'המחירים מוצגים ב-$symbol ($country)';
  }

  @override
  String jobTitleWithId(Object id) {
    return 'עבודה #$id';
  }

  @override
  String serviceLine(Object service) {
    return 'שירות: $service';
  }

  @override
  String whenLine(Object date, Object time) {
    return 'מתי: $date $time';
  }

  @override
  String priceLine(Object price) {
    return 'מחיר: $price';
  }

  @override
  String get acceptJob => 'קבל/י עבודה';

  @override
  String get failedToAcceptJob => 'הקבלה של העבודה נכשלה.';

  @override
  String get jobAcceptedSuccessfully => 'העבודה התקבלה בהצלחה.';

  @override
  String get newServiceRequestTitle => 'בקשת שירות חדשה';

  @override
  String get reviewAlreadySubmitted => 'Review submitted ✓';

  @override
  String get offeredPriceLabel => 'מחיר מוצע';

  @override
  String get offeredPriceHint => 'לדוגמה 25.00';

  @override
  String get enterValidPrice => 'הזן/י מחיר תקין';

  @override
  String get bookAndPay => 'הזמן/י ושלם/י';

  @override
  String bookAndPayAmount(Object amount) {
    return 'הזמן/י ושלם/י $amount';
  }

  @override
  String get haircutService => 'תספורת';

  @override
  String get stylingService => 'עיצוב שיער';

  @override
  String get timeLabel => 'זמן:';

  @override
  String get notesLabel => 'הערות';

  @override
  String get requestCreatedAndPaidBroadcast =>
      'הבקשה נוצרה ושולמה! נשלח לספקים.';

  @override
  String locationLatLng(Object lat, Object lng) {
    return 'מיקום: $lat, $lng';
  }

  @override
  String get paymentMethodsTitle => 'אמצעי תשלום';

  @override
  String get paymentPreferencesInfo =>
      'ההעדפות נשמרות מקומית במכשיר. תשלומים בפועל מעובדים בצורה מאובטחת דרך Stripe/שערים אחרים.';

  @override
  String get preferredMethodLabel => 'שיטה מועדפת (שער מקומי נבחר לפי מדינה)';

  @override
  String get methodVisaMastercard => 'Visa/Mastercard';

  @override
  String get methodMobileMoney => 'Mobile Money (Momo/Paystack/Africa)';

  @override
  String get methodPaypal => 'PayPal';

  @override
  String get methodApplePayGooglePay => 'Apple Pay/Google Pay';

  @override
  String get methodWeChatPay => 'WeChat Pay (סין)';

  @override
  String get methodAlipay => 'Alipay (סין)';

  @override
  String get methodUnionPay => 'UnionPay (סין)';

  @override
  String get mobileMoneyNumberLabel => 'מספר Mobile Money';

  @override
  String get wechatAlipayIdLabel => 'מזהה WeChat/Alipay';

  @override
  String get cardLast4DigitsLabel => '4 ספרות אחרונות של הכרטיס';

  @override
  String get paypalEmailLabel => 'אימייל PayPal';

  @override
  String get applePayEnabledOnDevice => 'Apple Pay מופעל במכשיר זה';

  @override
  String get savePaymentPreferences => 'שמור/י העדפות תשלום';

  @override
  String get paymentPrefsSavedInfo =>
      'העדפות התשלום נשמרו מקומית. חיוב בפועל יטופל בהמשך דרך Stripe/שערים אחרים.';

  @override
  String get failedToLoadImage => 'טעינת התמונה נכשלה';

  @override
  String get earningsTitle => 'רווחים';

  @override
  String get couldNotLoadEarningsSummary => 'לא ניתן לטעון סיכום רווחים.';

  @override
  String get noData => 'אין נתונים.';

  @override
  String get retry => 'נסה/י שוב';

  @override
  String get summaryTitle => 'סיכום';

  @override
  String get totalLabel => 'סה״כ';

  @override
  String get pendingLabel => 'ממתין';

  @override
  String get paidLabel => 'שולם';

  @override
  String get pdfReportTitle => 'דוח PDF';

  @override
  String get periodLabel => 'תקופה';

  @override
  String get periodThisMonth => 'החודש';

  @override
  String get periodLastMonth => 'החודש הקודם';

  @override
  String get periodYtd => 'מתחילת השנה';

  @override
  String get periodAllTime => 'כל הזמן';

  @override
  String get couldNotDownloadPdfReport => 'לא ניתן להוריד דוח PDF.';

  @override
  String couldNotOpenPdfWithValue(Object error) {
    return 'לא ניתן לפתוח PDF: $error';
  }

  @override
  String get savingFilesNotSupportedWeb => 'שמירת קבצים אינה נתמכת בווב כרגע.';

  @override
  String savedToDocumentsIosWithPath(Object path) {
    return 'נשמר ב-Documents (iOS):\n$path';
  }

  @override
  String savedToFilesWithPath(Object path) {
    return 'נשמר בקבצים:\n$path';
  }

  @override
  String get open => 'פתח';

  @override
  String failedToSavePdfWithValue(Object error) {
    return 'שמירת PDF נכשלה: $error';
  }

  @override
  String get openPdfReport => 'פתח דוח PDF';

  @override
  String get savePdfToDownloads => 'שמור PDF להורדות';

  @override
  String get reportWatermarkNote =>
      'דוח ה-PDF צריך לכלול סימן מים של Styloria.';

  @override
  String get referFriendsTitle => 'הזמן/י חברים';

  @override
  String get shareReferralCodeBody =>
      'שתף/י את קוד ההפניה עם חברים. בהמשך ניתן להוסיף תגמולים כשהם נרשמים ומסיימים הזמנות.';

  @override
  String get yourReferralCodeLabel => 'קוד ההפניה שלך:';

  @override
  String get copy => 'העתק';

  @override
  String referralCodeCopiedWithCode(Object code) {
    return 'קוד ההפניה הועתק: $code';
  }

  @override
  String get navHome => 'בית';

  @override
  String get navBookings => 'הזמנות';

  @override
  String get navNotifications => 'התראות';

  @override
  String get navAccount => 'חשבון';

  @override
  String get welcome => 'ברוך הבא';

  @override
  String welcomeName(Object name) {
    return 'ברוך הבא, $name';
  }

  @override
  String get toggleThemeTooltip => 'החלפת מצב בהיר/כהה';

  @override
  String loggedInAs(Object role) {
    return 'מחובר כ: $role';
  }

  @override
  String locationWithValue(Object value) {
    return 'מיקום: $value';
  }

  @override
  String get homeTagline =>
      'שדרגו את חוויית הטיפוח שלכם עם הזמנות בזמן אמת וספקים אמינים.';

  @override
  String get manageProviderProfile => 'ניהול פרופיל ספק';

  @override
  String get browseOpenJobs => 'עיון בעבודות פתוחות';

  @override
  String get quickActions => 'פעולות מהירות';

  @override
  String get newBooking => 'הזמנה חדשה';

  @override
  String notificationsWithUnread(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count לא נקראו',
      one: '1 לא נקראה',
    );
    return 'התראות ($_temp0)';
  }

  @override
  String get liveLocationTrackingTitle => 'מעקב מיקום בזמן אמת';

  @override
  String get live => 'חי';

  @override
  String get locationServicesDisabled => 'שירותי מיקום מושבתים.';

  @override
  String get locationPermissionDenied => 'הרשאת מיקום נדחתה.';

  @override
  String get locationPermissionPermanentlyDenied =>
      'הרשאת מיקום נדחתה לצמיתות. אנא אפשר בהגדרות.';

  @override
  String failedToGetLocationWithValue(Object error) {
    return 'נכשל לקבל מיקום: $error';
  }

  @override
  String get youProvider => 'אתה (ספק)';

  @override
  String get youCustomer => 'אתה (לקוח)';

  @override
  String get customer => 'לקוח';

  @override
  String get bookingDetails => 'פרטי הזמנה';

  @override
  String get navigate => 'נווט';

  @override
  String get failedToLoadNotifications => 'טעינת ההתראות נכשלה.';

  @override
  String get failedToMarkAsRead => 'נכשל לסמן כנקרא';

  @override
  String get noNotificationsYet => 'אין התראות עדיין.';

  @override
  String get markRead => 'סמן כנקרא';

  @override
  String get providerKycTitle => 'אימות ספק (KYC)';

  @override
  String get logoutTooltip => 'התנתקות';

  @override
  String statusLabel(Object status) {
    return 'סטטוס: $status';
  }

  @override
  String rejectedWithNotes(Object notes) {
    return 'נדחה: $notes';
  }

  @override
  String get kycInstructions =>
      'כדי לקבל גישה לתכונות ספק, העלו תעודת זהות וסלפי לצורך אימות.';

  @override
  String get idFrontRequired => 'תעודה קדמית (נדרש)';

  @override
  String get selectIdFront => 'בחר תעודה קדמית';

  @override
  String get idBackRequired => 'תעודה אחורית (נדרש)';

  @override
  String get selectIdBackRequired => 'בחר תעודה אחורית';

  @override
  String get selfieRequired => 'סלפי (נדרש)';

  @override
  String get selectSelfie => 'בחר סלפי';

  @override
  String get takeSelfie => 'צלם סלפי';

  @override
  String get errorUploadAllRequired =>
      'אנא העלו תעודה (קדמי), תעודה (אחורי) וסלפי.';

  @override
  String failedSubmitKycCode(Object code) {
    return 'נכשל שליחת KYC (קוד $code).';
  }

  @override
  String submittedCurrentStatus(Object status) {
    return 'נשלח. סטטוס נוכחי: $status';
  }

  @override
  String get unknownStatus => 'לא ידוע';

  @override
  String get submitKyc => 'שלח KYC';

  @override
  String get verificationMayTakeTimeNote =>
      'הערה: האימות עשוי לקחת זמן. תוכלו לגשת לתכונות ספק לאחר אישור.';

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
  String get enterVerificationCodeTitle => 'הזן קוד אימות';

  @override
  String otpSentToUsername(Object username) {
    return 'שלחנו קוד בן 6 ספרות למספר הטלפון\nהמשויך ל-\"$username\".';
  }

  @override
  String get sixDigitCodeLabel => 'קוד בן 6 ספרות';

  @override
  String get enterSixDigitCodeValidation => 'הזן את הקוד בן 6 הספרות';

  @override
  String get otpInvalidOrExpired => 'קוד לא תקין או שפג תוקפו.';

  @override
  String get failedLoadUserInfoAfterVerification =>
      'נכשל לטעון מידע משתמש לאחר האימות.';

  @override
  String get chatWithSupportTitle => 'צ\'אט עם התמיכה';

  @override
  String get unableStartSupportChat => 'לא ניתן להתחיל צ\'אט תמיכה.';

  @override
  String get invalidSupportThreadReturned =>
      'התקבלה שיחת תמיכה לא תקינה מהשרת.';

  @override
  String get noMessagesYet => 'אין הודעות עדיין. התחילו שיחה!';

  @override
  String get supportDefaultName => 'תמיכה';

  @override
  String get aboutPoliciesTitle => 'אודות ומדיניות';

  @override
  String get newBookingTitle => 'הזמנה חדשה';

  @override
  String get appointmentDetailsTitle => 'פרטי פגישה';

  @override
  String get pickDate => 'בחר תאריך';

  @override
  String get pickTime => 'בחר שעה';

  @override
  String get serviceTypeTitle => 'סוג שירות';

  @override
  String get serviceDropdownLabel => 'שירות';

  @override
  String get serviceHaircutLabel => 'תספורת';

  @override
  String get serviceBraidsLabel => 'צמות';

  @override
  String get serviceShaveLabel => 'גילוח';

  @override
  String get serviceHairColoringLabel => 'צביעת שיער';

  @override
  String get serviceManicureLabel => 'מניקור';

  @override
  String get servicePedicureLabel => 'פדיקור';

  @override
  String get serviceNailArtLabel => 'קישוט ציפורניים';

  @override
  String get serviceMakeupLabel => 'איפור';

  @override
  String get serviceFacialLabel => 'טיפול פנים';

  @override
  String get serviceWaxingLabel => 'שעווה';

  @override
  String get serviceMassageLabel => 'עיסוי';

  @override
  String get serviceTattooLabel => 'Tattoo';

  @override
  String get serviceHairStylingLabel => 'עיצוב שיער';

  @override
  String get serviceHairTreatmentLabel => 'טיפול שיער';

  @override
  String get serviceHairExtensionsLabel => 'תוספות שיער';

  @override
  String get serviceOtherServicesLabel => 'שירותים אחרים';

  @override
  String get notesForProviderOptionalLabel => 'הערות לספק (אופציונלי)';

  @override
  String get locationTitle => 'מיקום';

  @override
  String get latitudeLabel => 'קו רוחב';

  @override
  String get longitudeLabel => 'קו אורך';

  @override
  String get requiredField => 'נדרש';

  @override
  String get useMyCurrentLocation => 'השתמש במיקום הנוכחי שלי';

  @override
  String pricesShownIn(Object symbol, Object country) {
    return 'המחירים מוצגים ב־$symbol ($country)';
  }

  @override
  String get chooseTimeLaterThanCurrent =>
      'אנא בחר זמן מאוחר יותר מהזמן הנוכחי.';

  @override
  String get pleasePickDateAndTime => 'אנא בחר תאריך ושעה.';

  @override
  String get locationUpdatedFromGps => 'המיקום עודכן מה‑GPS.';

  @override
  String failedToGetLocation(Object error) {
    return 'נכשל לקבל מיקום: $error';
  }

  @override
  String bookingCreatedChoosePrice(Object id) {
    return 'ההזמנה נוצרה! מזהה: $id • בחר אפשרות מחיר.';
  }

  @override
  String get failedToCreateBooking => 'נכשל ליצור הזמנה.';

  @override
  String get paymentsNotSupportedLong =>
      'תשלומים אינם נתמכים בפלטפורמה זו. הרץ את האפליקציה ב‑Android, iOS, macOS או Web כדי לבדוק תשלומים אמיתיים.';

  @override
  String get noBookingToConfirm => 'אין הזמנה לאישור. אנא צור הזמנה תחילה.';

  @override
  String get pleaseChoosePriceOption => 'אנא בחר אפשרות מחיר.';

  @override
  String get failedCreatePaymentTryAgain => 'נכשל ליצור תשלום בשרת. נסה שוב.';

  @override
  String paymentSuccessfulMessage(Object bookingId, Object paid) {
    return 'התשלום הצליח!\nהזמנה #$bookingId • שולם: $paid\nהבקשה שלך כעת נראית לספקים בקרבת מקום.';
  }

  @override
  String get paymentSucceededButFailedUpdate =>
      'התשלום הצליח, אך עדכון ההזמנה בשרת נכשל.';

  @override
  String paymentCancelledOrFailed(Object reason) {
    return 'התשלום בוטל או נכשל: $reason';
  }

  @override
  String unexpectedPaymentError(Object error) {
    return 'שגיאת תשלום לא צפויה: $error';
  }

  @override
  String get createBookingButton => 'צור הזמנה';

  @override
  String get chooseYourPriceOptionTitle => 'בחר אפשרות מחיר';

  @override
  String transportationCostLabel(Object cost) {
    return 'עלות נסיעה: $cost';
  }

  @override
  String get budgetTierTitle => 'חסכוני';

  @override
  String get standardTierTitle => 'סטנדרטי';

  @override
  String get priorityTierTitle => 'עדיפות';

  @override
  String get budgetTierDescription => 'הערך הטוב ביותר מבין ספקים קרובים';

  @override
  String get standardTierDescription => 'איזון מומלץ בין מחיר לזמינות';

  @override
  String get priorityTierDescription =>
      'אפשרות פרימיום למשיכת ספקים מובילים מהר יותר';

  @override
  String get naShort => 'לא זמין';

  @override
  String get priceBreakdownTitle => 'פירוט מחיר';

  @override
  String get servicePriceLabel => 'מחיר שירות';

  @override
  String get transportationLabel => 'נסיעה';

  @override
  String serviceFeeLabel(Object percent) {
    return 'עמלת שירות ($percent%)';
  }

  @override
  String allPricesIn(Object currency, Object country) {
    return 'כל המחירים ב־$currency ($country)';
  }

  @override
  String get userCountryPlaceholder => 'מדינת משתמש';

  @override
  String get totalToPayTitle => 'סה״כ לתשלום';

  @override
  String get includesServiceTransportation => 'כולל שירות + נסיעה';

  @override
  String get confirmAndPay => 'אישור ותשלום';

  @override
  String get howPricingWorksTitle => 'איך התמחור עובד';

  @override
  String get howPricingWorksBullets =>
      '• חסכוני: הערך הטוב ביותר בקרבת מקום\n• סטנדרטי: ברירת מחדל מומלצת\n• עדיפות: פרימיום להאצת קבלה\n• הנסיעה כלולה בסכום הכולל';

  @override
  String get myBookingsTitle => 'ההזמנות שלי';

  @override
  String get myAssignedJobsTitle => 'העבודות שהוקצו לי';

  @override
  String get pleaseCompleteProviderProfileFirst =>
      'אנא השלם תחילה את פרופיל הספק.';

  @override
  String get failedToLoadBookings => 'נכשל לטעון הזמנות.';

  @override
  String get profileSetupRequiredTitle => 'נדרשת הגדרת פרופיל';

  @override
  String get profileSetupRequiredBody =>
      'עליך להשלים את פרופיל הספק לפני שתוכל לראות עבודות שהוקצו ורווחים.';

  @override
  String get later => 'אחר כך';

  @override
  String get setupNow => 'הגדר עכשיו';

  @override
  String get noBookingsFound => 'לא נמצאו הזמנות.';

  @override
  String get findNearbyOpenJobs => 'מצא עבודות פתוחות בקרבת מקום';

  @override
  String get pay => 'שלם';

  @override
  String get rate => 'דרג';

  @override
  String bookingNumber(Object id) {
    return 'הזמנה #$id';
  }

  @override
  String whenOn(Object date) {
    return 'מתי: $date';
  }

  @override
  String whenAt(Object date, Object time) {
    return 'מתי: $date בשעה $time';
  }

  @override
  String providerLine(Object name) {
    return 'ספק: $name';
  }

  @override
  String userLine(Object name) {
    return 'משתמש: $name';
  }

  @override
  String estimatedPriceLine(Object price) {
    return 'מחיר משוער: $price';
  }

  @override
  String paymentLine(Object status) {
    return 'תשלום: $status';
  }

  @override
  String get paymentUnpaid => 'לא שולם';

  @override
  String get paymentUnknown => 'לא ידוע';

  @override
  String get confirmPaymentTitle => 'אשר תשלום';

  @override
  String confirmPaymentBody(Object amount) {
    return 'לשלם $amount כדי לאשר הזמנה זו?';
  }

  @override
  String get yesPay => 'כן, שלם';

  @override
  String get failedToCreatePaymentIntent => 'נכשל ליצור תשלום.';

  @override
  String get paymentSuccessfulShort => 'התשלום הצליח.';

  @override
  String get paymentSucceededButFailedUpdateBooking =>
      'התשלום הצליח, אך עדכון ההזמנה בשרת נכשל.';

  @override
  String paymentCancelledOrFailedReason(Object reason) {
    return 'התשלום בוטל או נכשל: $reason';
  }

  @override
  String unexpectedPaymentErrorReason(Object error) {
    return 'שגיאת תשלום לא צפויה: $error';
  }

  @override
  String rateProviderTitle(Object providerName) {
    return 'דרג את $providerName';
  }

  @override
  String get selectRatingHelp => 'בחר דירוג (1 = גרוע, 5 = מצוין):';

  @override
  String get commentsOptionalLabel => 'תגובות (אופציונלי)';

  @override
  String get submit => 'שלח';

  @override
  String get reviewSubmitted => 'הביקורת נשלחה.';

  @override
  String get failedSubmitReview => 'נכשל לשלוח דירוג.';

  @override
  String failedToLoadProfile(Object error) {
    return 'נכשל לטעון פרופיל: $error';
  }

  @override
  String profileSavedSuccess(Object action) {
    return 'הפרופיל $action בהצלחה!';
  }

  @override
  String genericError(Object error) {
    return 'שגיאה: $error';
  }

  @override
  String get locationPermissionDeniedEnableInSettings =>
      'הרשאת מיקום נדחתה. אנא אפשר בהגדרות.';

  @override
  String get locationPermissionPermanentlyDeniedEnableInAppSettings =>
      'הרשאת מיקום נדחתה לצמיתות. אנא אפשר בהגדרות האפליקציה.';

  @override
  String errorGettingLocation(Object error) {
    return 'שגיאה בקבלת מיקום: $error';
  }

  @override
  String get couldNotFindLocationForAddress =>
      'לא ניתן למצוא מיקום עבור כתובת זו';

  @override
  String errorConvertingAddress(Object error) {
    return 'שגיאה בהמרת כתובת: $error';
  }

  @override
  String get portfolioUnavailableCompleteKycFirst =>
      'הפורטפוליו אינו זמין. אם אתה ספק, השלם תחילה אימות KYC.';

  @override
  String failedToLoadPortfolio(Object error) {
    return 'נכשל לטעון פורטפוליו: $error';
  }

  @override
  String get addPhoto => 'הוסף תמונה';

  @override
  String get addVideo => 'הוסף וידאו';

  @override
  String get addPost => 'הוסף פוסט';

  @override
  String get captionOptionalTitle => 'כיתוב (אופציונלי)';

  @override
  String get captionHintExample => 'למשל: \"צמות ללא קשר ללקוחה\"';

  @override
  String get skip => 'דלג';

  @override
  String get save => 'שמור';

  @override
  String get failedToCreatePortfolioPost => 'נכשל ליצור פוסט בפורטפוליו.';

  @override
  String get uploadFailedMediaUpload => 'העלאה נכשלה (העלאת מדיה).';

  @override
  String uploadFailed(Object error) {
    return 'העלאה נכשלה: $error';
  }

  @override
  String get deletePostTitle => 'למחוק את הפוסט?';

  @override
  String get deletePostBody => 'הפוסט יוסר מהפורטפוליו שלך.';

  @override
  String get delete => 'מחק';

  @override
  String get deleteFailed => 'המחיקה נכשלה.';

  @override
  String deleteFailedWithError(Object error) {
    return 'המחיקה נכשלה: $error';
  }

  @override
  String get portfolioTitle => 'פורטפוליו';

  @override
  String get noPortfolioPostsYetHelpText =>
      'אין עדיין פוסטים בפורטפוליו. הוסף תמונות/וידאו של העבודה שלך כדי לעזור ללקוחות לסמוך על הכישורים שלך.';

  @override
  String get setupProviderProfileTitle => 'הגדרת פרופיל ספק';

  @override
  String get providerProfileTitle => 'פרופיל ספק';

  @override
  String get welcomeToStyloriaTitle => 'ברוך הבא ל‑Styloria!';

  @override
  String get completeProviderProfileToStartEarning =>
      'השלם את פרופיל הספק כדי להתחיל לקבל עבודות ולהרוויח.';

  @override
  String reviewCountLabel(int count) {
    return '($count ביקורות)';
  }

  @override
  String get topRatedChip => 'מדורג גבוה';

  @override
  String get bioLabel => 'ביו / תיאור';

  @override
  String get bioHint => 'ספר ללקוחות על הכישורים והניסיון שלך...';

  @override
  String get pleaseEnterBio => 'אנא הזן ביו';

  @override
  String bioMinLength(int min) {
    return 'הביו צריך להיות לפחות $min תווים';
  }

  @override
  String get yourLocationTitle => 'המיקום שלך';

  @override
  String get locationHelpMatchNearbyClients =>
      'המיקום שלך עוזר לנו להתאים אותך ללקוחות קרובים';

  @override
  String get locationHelpUpdateToFindJobs =>
      'עדכן מיקום כדי למצוא עבודות באזורים אחרים';

  @override
  String get useMyCurrentLocationTitle => 'השתמש במיקום הנוכחי שלי';

  @override
  String get gpsSubtitle => 'קבל מיקום אוטומטית באמצעות GPS';

  @override
  String get orLabel => 'או';

  @override
  String get enterYourAddressTitle => 'הזן את הכתובת שלך';

  @override
  String get fullAddressLabel => 'כתובת מלאה';

  @override
  String get fullAddressHint => 'למשל: 123 Main St, Accra, Ghana';

  @override
  String get find => 'חפש';

  @override
  String get addressHelpText => 'הזן רחוב, עיר ומדינה';

  @override
  String get coordinatesAutoFilledTitle => 'קואורדינטות (מילוי אוטומטי)';

  @override
  String get servicePricingTitle => 'תמחור שירותים';

  @override
  String get servicePricingHelp =>
      'קבע מחיר לכל שירות. סמן \"לא מוצע\" לשירותים שאינך מספק.';

  @override
  String get serviceHeader => 'שירות';

  @override
  String get priceHeader => 'מחיר';

  @override
  String get notOfferedHeader => 'לא מוצע';

  @override
  String get priceHint => '0.00';

  @override
  String get providerHowPricingWorksTitle => 'איך התמחור עובד:';

  @override
  String get providerHowPricingWorksBody =>
      '• המחיר שלך הוא מה שאתה גובה עבור השירות\n• עלות נסיעה = 80% ממטבע המשתמש לכל ק\"מ\n• המשתמשים רואים 3 אפשרויות לפי ספקים קרובים:\n  - Budget: המחיר הנמוך ביותר\n  - Standard: מחיר ממוצע\n  - Priority: המחיר הגבוה ביותר';

  @override
  String get availableForBookingsTitle => 'זמין להזמנות';

  @override
  String get availableOnHelp => '✓ תופיע בתוצאות החיפוש של לקוחות קרובים';

  @override
  String get availableOffHelp => '✗ לא תקבל הצעות עבודה חדשות';

  @override
  String get completeSetupStartEarning => 'סיים הגדרה והתחל להרוויח';

  @override
  String get updateProfile => 'עדכן פרופיל';

  @override
  String get skipForNow => 'דלג בינתיים';

  @override
  String get paymentsNotSupportedShort =>
      'תשלומים אינם נתמכים בפלטפורמה זו. הרץ ב‑Android, iOS, macOS או Web.';

  @override
  String get genericContact => 'איש קשר';

  @override
  String get genericProvider => 'נותן שירות';

  @override
  String get genericNotAvailable => 'לא זמין';

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
  String get reviewSelectRatingPrompt => 'בחר/י דירוג (1 עד 5).';

  @override
  String get reviewCommentOptionalLabel => 'תגובה (אופציונלי)';

  @override
  String get genericCancel => 'ביטול';

  @override
  String get genericSubmit => 'שליחה';

  @override
  String get reviewSubmitFailed => 'שליחת הביקורת נכשלה.';

  @override
  String get rateThisService => 'דרג/י את השירות';

  @override
  String get tipLeaveTitle => 'השאר/י טיפ';

  @override
  String get tipChooseAmountPrompt => 'בחר/י סכום טיפ או הזן/י סכום מותאם.';

  @override
  String get tipNoTip => 'בלי טיפ';

  @override
  String get tipCustomAmountLabel => 'סכום טיפ מותאם';

  @override
  String get genericContinue => 'המשך';

  @override
  String get tipSkipped => 'הטיפ דולג.';

  @override
  String get tipFailedToSaveChoice => 'לא ניתן לשמור את בחירת הטיפ.';

  @override
  String get tipFailedToCreatePayment => 'לא ניתן ליצור תשלום טיפ.';

  @override
  String get tipPaidSuccessfully => 'הטיפ שולם בהצלחה. תודה!';

  @override
  String get tipPaidButUpdateFailed =>
      'תשלום הטיפ הצליח, אך עדכון ההזמנה נכשל.';

  @override
  String tipCancelledOrFailed(Object message) {
    return 'הטיפ בוטל/נכשל: $message';
  }

  @override
  String tipUnexpectedError(Object error) {
    return 'שגיאת טיפ לא צפויה: $error';
  }

  @override
  String get tipAlreadyPaidLabel => 'הטיפ כבר שולם';

  @override
  String get tipSkippedLabel => 'טיפ דולג';

  @override
  String get tipLeaveButton => 'השאר/י טיפ';

  @override
  String get walletTitle => 'ארנק';

  @override
  String get walletTooltip => 'ארנק';

  @override
  String get payoutSettingsTitle => 'הגדרות תשלום';

  @override
  String get payoutSettingsTooltip => 'הגדרות תשלום';

  @override
  String get walletNoWalletYet => 'אין ארנק עדיין. השלימו עבודות כדי להרוויח.';

  @override
  String get walletCurrencyFieldLabel => 'מטבע';

  @override
  String walletAvailableLine(Object amount, Object currency) {
    return 'זמין: $amount $currency';
  }

  @override
  String walletPendingLine(Object amount, Object currency) {
    return 'בהמתנה: $amount $currency';
  }

  @override
  String get walletCashOutInstant => 'משיכה מיידית';

  @override
  String get walletCashOutFailed => 'המשיכה נכשלה.';

  @override
  String walletCashOutSentTransfer(Object transferId) {
    return 'בקשת המשיכה נשלחה. העברה: $transferId';
  }

  @override
  String get walletTransactionsTitle => 'עסקאות';

  @override
  String get walletNoTransactionsYet => 'אין עסקאות עדיין.';

  @override
  String get payoutAutoPayoutsTitle => 'תשלומים אוטומטיים';

  @override
  String get payoutAutoPayoutsSubtitle =>
      'שליחת תשלומים אוטומטית לפי לוח הזמנים שבחרת.';

  @override
  String get payoutDayUtcLabel => 'יום תשלום (UTC)';

  @override
  String get payoutHourUtcLabel => 'שעת תשלום (UTC)';

  @override
  String get payoutMinimumAmountLabel => 'סכום מינימלי לתשלום אוטומטי';

  @override
  String get payoutMinimumAmountHelper =>
      'תשלום אוטומטי יתבצע רק אם היתרה הזמינה ≥ סכום זה.';

  @override
  String get payoutInstantCashOutEnabledTitle => 'הפעלת משיכה מיידית';

  @override
  String get payoutInstantCashOutEnabledSubtitle =>
      'לאפשר כפתור „משיכה” (חלה עמלה).';

  @override
  String get payoutSettingsSaved => 'הגדרות התשלום נשמרו.';

  @override
  String get payoutSettingsSaveFailed => 'שמירת הגדרות התשלום נכשלה.';

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
