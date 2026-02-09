// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Styloria';

  @override
  String get account => 'Account';

  @override
  String get profile => 'Profile';

  @override
  String get myBookings => 'My Bookings';

  @override
  String get openJobs => 'Open Jobs';

  @override
  String get earnings => 'Earnings';

  @override
  String get paymentMethods => 'Payment methods';

  @override
  String get referFriends => 'Refer friends';

  @override
  String get language => 'Language';

  @override
  String get settings => 'Settings';

  @override
  String get darkMode => 'Dark mode';

  @override
  String get systemDefault => 'System default';

  @override
  String get languageUpdated => 'Language updated';

  @override
  String get languageSetToSystemDefault => 'Language set to system default';

  @override
  String get helpAndSupport => 'Help & Support';

  @override
  String get chatWithCustomerService => 'Chat with customer service';

  @override
  String get aboutAndPolicies => 'About & Policies';

  @override
  String get viewUserPoliciesAndAgreements =>
      'View user policies and agreements';

  @override
  String get logOut => 'Log out';

  @override
  String get deleteAccount => 'Delete account';

  @override
  String get deleteAccountSubtitle => 'This action cannot be undone';

  @override
  String get deleteAccountTitle => 'Delete account';

  @override
  String get deleteAccountConfirmBody =>
      'Are you sure you want to delete your account?\n\nThis action will sign you out and you may lose access permanently.';

  @override
  String get no => 'No';

  @override
  String get yesDelete => 'Yes, delete';

  @override
  String get deleteAccountSheetTitle => 'We’re sorry to see you go.';

  @override
  String get deleteAccountSheetPrompt =>
      'Can you tell us why? (Select all that apply)';

  @override
  String get deleteAccountSelectAtLeastOneReason =>
      'Please select at least one reason.';

  @override
  String get tellUsMoreOptional => 'Tell us more (optional)';

  @override
  String get suggestionsToImproveOptional =>
      'Suggestions to improve (optional)';

  @override
  String get deleteMyAccount => 'Delete my account';

  @override
  String get cancel => 'Cancel';

  @override
  String get failedToDeleteAccount =>
      'Failed to delete account. Please try again.';

  @override
  String get choosePreferredLanguage => 'Choose your preferred language';

  @override
  String get noteSomeTextMayStillAppearInEnglish =>
      'Note: This changes the app language. Some text may still appear in English until translations are added.';

  @override
  String languageSetToName(Object name) {
    return 'Language set to $name';
  }

  @override
  String get close => 'Close';

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
  String get confirmPassword => 'Confirm Password';

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
  String get deletionReason1 => 'I no longer need Styloria';

  @override
  String get deletionReason2 =>
      'I had trouble verifying my account (email/KYC)';

  @override
  String get deletionReason3 => 'I couldn’t find services/providers near me';

  @override
  String get deletionReason4 => 'Prices or fees were too high / unclear';

  @override
  String get deletionReason5 => 'The app was confusing / hard to use';

  @override
  String get deletionReason6 => 'Bugs or performance issues';

  @override
  String get deletionReason7 => 'Payment/refund issues';

  @override
  String get deletionReason8 => 'Bad experience with a provider/user';

  @override
  String get deletionReason9 => 'Privacy or security concerns';

  @override
  String get deletionReason10 => 'I created this account by mistake';

  @override
  String get deletionReason11 => 'I’m switching to another platform';

  @override
  String get deletionReason12 => 'Other';

  @override
  String get loginWelcomeTitle => 'Welcome to Styloria';

  @override
  String get loginWelcomeSubtitle =>
      'Sign in to manage your bookings and services.';

  @override
  String get loginFailedToLoadUserInfo =>
      'Login succeeded but failed to load user info.';

  @override
  String get username => 'Username';

  @override
  String get password => 'Password';

  @override
  String get required => 'Required';

  @override
  String get login => 'Login';

  @override
  String get createNewAccount => 'Create a new account';

  @override
  String get requestEmailVerificationCode => 'Request email verification code';

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
  String get pleaseEnterAddress => 'Please enter an address';

  @override
  String get locationUpdatedFromAddress => 'Location updated from address';

  @override
  String get myCustomerRating => 'My Customer Rating';

  @override
  String get outOf5 => '/ 5.0';

  @override
  String reviewsFromProviders(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'reviews',
      one: 'review',
    );
    return '$count $_temp0 from providers';
  }

  @override
  String get failedToLoadReputation => 'Failed to load reputation data';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get retry => 'Retry';

  @override
  String weDetectedYoureIn(String country) {
    return '📍 We detected you\'re in $country. Please select your country below.';
  }

  @override
  String get locationMarkedAsOther =>
      'Location marked as \"Other\" - you can proceed with registration';

  @override
  String get createAccountTitle => 'Create Account';

  @override
  String get joinStyloria => 'Join Styloria';

  @override
  String get registerSubtitle =>
      'Create an account to book services or become a provider';

  @override
  String get iWantTo => 'I want to:';

  @override
  String get bookServices => 'Book Services';

  @override
  String get provideServices => 'Provide Services';

  @override
  String get personalInformation => 'Personal Information';

  @override
  String get firstName => 'First name';

  @override
  String get lastName => 'Last name';

  @override
  String get selectDateOfBirth => 'Select Date of Birth';

  @override
  String get phoneNumber => 'Phone number';

  @override
  String get pleaseEnterPhoneNumber => 'Please enter a phone number';

  @override
  String get accountInformation => 'Account Information';

  @override
  String get chooseUniqueUsernameHint => 'Choose a unique username';

  @override
  String get youAreCurrentlyUnavailable => 'You\'re Currently Unavailable';

  @override
  String get toBrowseAndAcceptJobsEnableAvailability =>
      'To browse and accept nearby job requests, you need to set yourself as available for bookings.';

  @override
  String get goToProfileSettings => 'Go to Profile Settings';

  @override
  String get tipToggleAvailableForBookings =>
      'Tip: Toggle \"Available for Bookings\" ON in your Provider Profile to start receiving job requests.';

  @override
  String requestedBy(String name) {
    return 'Requested by: $name';
  }

  @override
  String locationLabel(String address) {
    return 'Location: $address';
  }

  @override
  String get email => 'Email';

  @override
  String get emailHint => 'your@email.com';

  @override
  String get enterValidEmail => 'Enter a valid email';

  @override
  String get security => 'Security';

  @override
  String get passwordHintAtLeast10 => 'At least 10 characters';

  @override
  String get passwordMin10 => 'Password must be at least 10 characters';

  @override
  String get iAgreeTo => 'I agree to the ';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get and => 'and';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get passwordIsRequired => 'Password is required';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get pleaseSelectDob => 'Please select your date of birth.';

  @override
  String get pleaseSelectCountry => 'Please select your country.';

  @override
  String get pleaseSelectCity => 'Please select your city.';

  @override
  String get pleaseEnterValidPhone => 'Please enter a valid phone number.';

  @override
  String get mustAcceptTerms => 'You must accept the terms and conditions.';

  @override
  String get mustBeAtLeast18 =>
      'You must be at least 18 years old to register.';

  @override
  String get agreeToTerms =>
      'I agree to the Terms of Service and Privacy Policy';

  @override
  String get createAccountButton => 'Create Account';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get emailVerifiedSuccessPleaseLogin =>
      'Email verified successfully. Please login.';

  @override
  String get pleaseVerifyEmailToContinue =>
      'Please verify your email to continue.';

  @override
  String get requestVerificationCodeTitle => 'Request verification code';

  @override
  String get requestVerificationInstructions =>
      'Enter your email or username.\nWe’ll send a new verification code to the email on that account.';

  @override
  String get emailOrUsername => 'Email or Username';

  @override
  String get sendCode => 'Send code';

  @override
  String get ifAccountExistsCodeSent =>
      'If that account exists, a code was sent.';

  @override
  String get failedToSendVerificationCode =>
      'Failed to send verification code.';

  @override
  String get verifyYourEmailTitle => 'Verify your email';

  @override
  String get verificationCodeSentInfo =>
      'A verification code was sent to the email on this account.';

  @override
  String emailVerificationInstructions(Object identifier) {
    return 'Enter the 6-digit code sent to the email on this account:\n$identifier';
  }

  @override
  String get verificationCodeLabel => 'Verification code';

  @override
  String get sendingEllipsis => 'Sending...';

  @override
  String get resendCode => 'Resend code';

  @override
  String get enter6DigitCodeError => 'Enter the 6-digit code.';

  @override
  String get verifyingEllipsis => 'Verifying...';

  @override
  String get verify => 'Verify';

  @override
  String get invalidOrExpiredCodeTryResending =>
      'Invalid or expired code. Try resending.';

  @override
  String bookingTitle(Object id) {
    return 'Booking #$id';
  }

  @override
  String get invalidBookingIdForChat => 'Invalid booking ID for chat.';

  @override
  String get invalidBookingIdForCall => 'Invalid booking ID for call.';

  @override
  String get unableToLoadContactInfo =>
      'Unable to load contact info. Make sure the booking is active.';

  @override
  String noPhoneNumberAvailableForName(Object name) {
    return 'No phone number available for $name.';
  }

  @override
  String get deviceCannotPlaceCalls => 'This device cannot place phone calls.';

  @override
  String get cancelBookingDialogTitle => 'Cancel booking';

  @override
  String get cancelBookingDialogBody =>
      'Do you really want to cancel this booking?\n\nNote: If the provider has already accepted and more than 7 minutes have passed (but less than about 40 minutes), a penalty may be applied according to the rules.';

  @override
  String get yesCancel => 'Yes, cancel';

  @override
  String get failedToCancelBooking => 'Failed to cancel booking.';

  @override
  String bookingCancelledPenaltyApplied(Object amount) {
    return 'Booking cancelled. A penalty of $amount has been applied.';
  }

  @override
  String get bookingCancelledSuccessfully => 'Booking cancelled successfully.';

  @override
  String get failedToConfirmCompletion =>
      'Failed to confirm completion. Please try again.';

  @override
  String get bothSidesConfirmedCompletedPayoutReleased =>
      'Both sides confirmed. Booking marked as completed and payout released.';

  @override
  String get youConfirmedCompletionWaitingForProvider =>
      'You confirmed completion. Waiting for provider to confirm.';

  @override
  String get youConfirmedCompletionWaitingForUser =>
      'You confirmed completion. Waiting for user to confirm.';

  @override
  String get statusUnknown => 'unknown';

  @override
  String get statusAccepted => 'accepted';

  @override
  String get statusInProgress => 'in progress';

  @override
  String get statusCompleted => 'completed';

  @override
  String get statusCancelled => 'cancelled';

  @override
  String get paymentPaid => 'paid';

  @override
  String get paymentPending => 'pending';

  @override
  String get paymentFailed => 'failed';

  @override
  String bookingAcceptedBy(Object name) {
    return 'Booking accepted by $name';
  }

  @override
  String get whenLabel => 'When';

  @override
  String atTime(Object time) {
    return 'at $time';
  }

  @override
  String get userLabel => 'User';

  @override
  String get providerLabel => 'Provider';

  @override
  String get estimatedPriceLabel => 'Estimated price';

  @override
  String get offeredPaidLabel => 'Offered / paid';

  @override
  String get distanceLabel => 'Distance';

  @override
  String distanceMiles(Object miles) {
    return '$miles miles';
  }

  @override
  String get acceptedAtLabel => 'Accepted at';

  @override
  String get cancelledAtLabel => 'Cancelled at';

  @override
  String get cancelledByLabel => 'Cancelled by';

  @override
  String penaltyAppliedLabel(Object amount) {
    return 'Penalty applied: $amount';
  }

  @override
  String get userConfirmedLabel => 'User confirmed';

  @override
  String get providerConfirmedLabel => 'Provider confirmed';

  @override
  String get payoutReleasedLabel => 'Payout released';

  @override
  String get yesLower => 'yes';

  @override
  String get noLower => 'no';

  @override
  String get chat => 'Chat';

  @override
  String get call => 'Call';

  @override
  String get actions => 'Actions';

  @override
  String get confirmCompletion => 'Confirm completion';

  @override
  String get noFurtherActionsForBooking =>
      'No further actions available for this booking.';

  @override
  String freeCancellationEndsIn(Object time) {
    return 'Free cancellation ends in $time';
  }

  @override
  String get earlyFreeCancellationEndedWarning =>
      'Early free cancellation has ended. Until about 40 minutes after acceptance, late cancellations may incur a penalty.';

  @override
  String get cancelBooking => 'Cancel booking';

  @override
  String get cancelBookingNoPenalty => 'Cancel booking (no penalty)';

  @override
  String get cancelBookingPenaltyMayApply =>
      'Cancel booking (penalty may apply)';

  @override
  String get cancellationPolicyInfo =>
      'You can cancel without penalty in the first 7 minutes after provider acceptance, and again after about 40 minutes if needed. Between those times, a penalty may be applied according to the rules.';

  @override
  String ratingLine(Object rating, int reviewCount) {
    String _temp0 = intl.Intl.pluralLogic(
      reviewCount,
      locale: localeName,
      other: '$reviewCount reviews',
      one: '1 review',
    );
    return 'Rating: $rating ($_temp0)';
  }

  @override
  String get proofOfSkillsPortfolio => 'Proof of skills (Portfolio)';

  @override
  String get noPortfolioPostsAvailable => 'No portfolio posts available.';

  @override
  String get deleteProfilePicture => 'Delete Profile Picture';

  @override
  String get deleteProfilePictureTitle => 'Delete Profile Picture';

  @override
  String get deleteProfilePictureConfirmation =>
      'Are you sure you want to delete your profile picture?';

  @override
  String get profilePictureDeletedSuccessfully =>
      'Profile picture deleted successfully.';

  @override
  String get failedToDeleteProfilePicture =>
      'Failed to delete profile picture.';

  @override
  String get bookingLocation => 'Booking location';

  @override
  String get location => 'Location';

  @override
  String get latitude => 'Latitude';

  @override
  String get longitude => 'Longitude';

  @override
  String get mapWillAppearWhenCoordinatesValid =>
      'Map will appear here when coordinates are valid.';

  @override
  String chatForBookingTitle(Object id) {
    return 'Chat for booking #$id';
  }

  @override
  String get unableToStartChat =>
      'Unable to start chat. Chat is only available when the booking is accepted, in progress, or completed within the last day.';

  @override
  String get invalidChatThreadFromServer =>
      'Invalid chat thread returned from server.';

  @override
  String get messageNotSentPolicy =>
      'Message not sent. Note: sharing phone numbers or emails is not allowed in chat.';

  @override
  String get unknown => 'Unknown';

  @override
  String get typeMessageHint => 'Type a message to support...';

  @override
  String get uploadProfilePicture => 'Upload Profile Picture';

  @override
  String get currentProfilePicture => 'Current Profile Picture';

  @override
  String get newPicturePreview => 'New Picture Preview';

  @override
  String get chooseImage => 'Choose Image';

  @override
  String get upload => 'Upload';

  @override
  String get noImageBytesFoundWeb => 'No image bytes found (web).';

  @override
  String get pleasePickAnImageFirst => 'Please pick an image first.';

  @override
  String get uploadFailedCheckServerLogs =>
      'Upload failed. Check server logs / token.';

  @override
  String get profilePictureUploadedSuccessfully =>
      'Profile picture uploaded successfully!';

  @override
  String errorWithValue(Object error) {
    return 'Error: $error';
  }

  @override
  String get tapToChangeProfilePicture => 'Tap to change profile picture';

  @override
  String usernameValue(Object username) {
    return 'Username: $username';
  }

  @override
  String roleValue(Object role) {
    return 'Role: $role';
  }

  @override
  String get dateOfBirthYyyyMmDd => 'Date of birth (YYYY-MM-DD)';

  @override
  String get saveProfile => 'Save Profile';

  @override
  String get failedToSaveProfile => 'Failed to save profile. Please try again.';

  @override
  String get profileUpdated => 'Profile updated.';

  @override
  String get completeYourProviderProfile => 'Complete Your Provider Profile';

  @override
  String get completeProviderProfileBody =>
      'To start accepting jobs and earning money, complete your provider profile.';

  @override
  String get setupProfileNow => 'Setup Profile Now';

  @override
  String get doItLater => 'Do It Later';

  @override
  String get bookingTimerPenaltyPeriodActive => 'Penalty period active';

  @override
  String get bookingTimerFreeCancellationPeriod => 'Free cancellation period';

  @override
  String bookingTimerTimeRemaining(Object time) {
    return 'Time remaining: $time';
  }

  @override
  String get bookingTimerCancellingNowPenalty =>
      'Cancelling now will incur a 10% penalty.';

  @override
  String get bookingTimerCancelNoPenalty => 'You can cancel without penalty.';

  @override
  String get myReviewsTitle => 'My Reviews';

  @override
  String get failedToLoadReviews => 'Failed to load reviews.';

  @override
  String get noReviewsYet => 'You have not left any reviews yet.';

  @override
  String providerWithName(Object name) {
    return 'Provider: $name';
  }

  @override
  String get providerGeneric => 'Provider';

  @override
  String ratingWithValue(Object rating) {
    return 'Rating: $rating';
  }

  @override
  String get nearbyOpenJobsTitle => 'Nearby Open Jobs';

  @override
  String get failedToLoadOpenJobsHint =>
      'Failed to load open jobs.\nMake sure you have a provider profile with location set and available=true.';

  @override
  String errorLoadingJobsWithValue(Object error) {
    return 'Error loading jobs: $error';
  }

  @override
  String get noOpenJobsFoundNearbyTitle => 'No open jobs found nearby';

  @override
  String get noOpenJobsFoundNearbyBody =>
      'Make sure:\n- You have set your provider location\n- You are marked as available\n- Users have created and paid for bookings';

  @override
  String currencyLabel(Object symbol) {
    return 'Currency: $symbol';
  }

  @override
  String pricesShownInCurrency(Object symbol, Object country) {
    return 'Prices shown in $symbol ($country)';
  }

  @override
  String jobTitleWithId(Object id) {
    return 'Job #$id';
  }

  @override
  String serviceLine(Object service) {
    return 'Service: $service';
  }

  @override
  String whenLine(Object date, Object time) {
    return 'When: $date $time';
  }

  @override
  String priceLine(Object price) {
    return 'Price: $price';
  }

  @override
  String get acceptJob => 'Accept Job';

  @override
  String get failedToAcceptJob => 'Failed to accept job.';

  @override
  String get jobAcceptedSuccessfully => 'Job accepted successfully.';

  @override
  String get newServiceRequestTitle => 'New Service Request';

  @override
  String get reviewAlreadySubmitted => 'Review submitted ✓';

  @override
  String get offeredPriceLabel => 'Offered price';

  @override
  String get offeredPriceHint => 'e.g. 25.00';

  @override
  String get enterValidPrice => 'Enter a valid price';

  @override
  String get bookAndPay => 'Book & Pay';

  @override
  String bookAndPayAmount(Object amount) {
    return 'Book & Pay $amount';
  }

  @override
  String get haircutService => 'Haircut';

  @override
  String get stylingService => 'Styling';

  @override
  String get timeLabel => 'Time:';

  @override
  String get notesLabel => 'Notes';

  @override
  String get requestCreatedAndPaidBroadcast =>
      'Request created & paid! Broadcast to providers.';

  @override
  String locationLatLng(Object lat, Object lng) {
    return 'Location: $lat, $lng';
  }

  @override
  String get paymentMethodsTitle => 'Payment methods';

  @override
  String get paymentPreferencesInfo =>
      'These preferences are stored locally on your device. Actual payments are processed securely via Stripe/other gateways.';

  @override
  String get preferredMethodLabel =>
      'Preferred method (local gateway selected by country)';

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
  String get mobileMoneyNumberLabel => 'Mobile Money Number';

  @override
  String get wechatAlipayIdLabel => 'WeChat/Alipay ID';

  @override
  String get cardLast4DigitsLabel => 'Card last 4 digits';

  @override
  String get paypalEmailLabel => 'PayPal email';

  @override
  String get applePayEnabledOnDevice => 'Apple Pay enabled on this device';

  @override
  String get savePaymentPreferences => 'Save Payment Preferences';

  @override
  String get paymentPrefsSavedInfo =>
      'Payment preferences saved locally. Actual charging is handled via Stripe/other gateways later.';

  @override
  String get failedToLoadImage => 'Failed to load image';

  @override
  String get earningsTitle => 'Earnings';

  @override
  String get couldNotLoadEarningsSummary => 'Could not load earnings summary.';

  @override
  String get noData => 'No data.';

  @override
  String get summaryTitle => 'Summary';

  @override
  String get totalLabel => 'Total';

  @override
  String get pendingLabel => 'Pending';

  @override
  String get paidLabel => 'Paid';

  @override
  String get pdfReportTitle => 'PDF report';

  @override
  String get periodLabel => 'Period';

  @override
  String get periodThisMonth => 'This month';

  @override
  String get periodLastMonth => 'Last month';

  @override
  String get periodYtd => 'Year to date';

  @override
  String get periodAllTime => 'All time';

  @override
  String get couldNotDownloadPdfReport => 'Could not download PDF report.';

  @override
  String couldNotOpenPdfWithValue(Object error) {
    return 'Could not open PDF: $error';
  }

  @override
  String get savingFilesNotSupportedWeb =>
      'Saving files is not supported on Web right now.';

  @override
  String savedToDocumentsIosWithPath(Object path) {
    return 'Saved to Documents (iOS):\n$path';
  }

  @override
  String savedToFilesWithPath(Object path) {
    return 'Saved to files:\n$path';
  }

  @override
  String get open => 'Open';

  @override
  String failedToSavePdfWithValue(Object error) {
    return 'Failed to save PDF: $error';
  }

  @override
  String get openPdfReport => 'Open PDF report';

  @override
  String get savePdfToDownloads => 'Save PDF to Downloads';

  @override
  String get reportWatermarkNote =>
      'The report PDF should include the Styloria watermark.';

  @override
  String get referFriendsTitle => 'Refer friends';

  @override
  String get shareReferralCodeBody =>
      'Share your referral code with friends. Later you can add rewards when they sign up and complete bookings.';

  @override
  String get yourReferralCodeLabel => 'Your referral code:';

  @override
  String get copy => 'Copy';

  @override
  String referralCodeCopiedWithCode(Object code) {
    return 'Referral code copied: $code';
  }

  @override
  String get navHome => 'Home';

  @override
  String get navBookings => 'Bookings';

  @override
  String get navNotifications => 'Notifications';

  @override
  String get navAccount => 'Account';

  @override
  String get welcome => 'Welcome';

  @override
  String welcomeName(Object name) {
    return 'Welcome, $name';
  }

  @override
  String get toggleThemeTooltip => 'Toggle light/dark mode';

  @override
  String loggedInAs(Object role) {
    return 'Logged in as: $role';
  }

  @override
  String locationWithValue(Object value) {
    return 'Location: $value';
  }

  @override
  String get homeTagline =>
      'Transform your grooming experience with real-time bookings and trusted providers.';

  @override
  String get manageProviderProfile => 'Manage Provider Profile';

  @override
  String get browseOpenJobs => 'Browse Open Jobs';

  @override
  String get quickActions => 'Quick actions';

  @override
  String get newBooking => 'New Booking';

  @override
  String notificationsWithUnread(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count unread',
      one: '1 unread',
    );
    return 'Notifications ($_temp0)';
  }

  @override
  String get liveLocationTrackingTitle => 'Live Location Tracking';

  @override
  String get live => 'Live';

  @override
  String get locationServicesDisabled => 'Location services are disabled.';

  @override
  String get locationPermissionDenied => 'Location permission denied.';

  @override
  String get locationPermissionPermanentlyDenied =>
      'Location permission permanently denied. Please enable it in settings.';

  @override
  String failedToGetLocationWithValue(Object error) {
    return 'Failed to get location: $error';
  }

  @override
  String get youProvider => 'You (Provider)';

  @override
  String get youCustomer => 'You (Customer)';

  @override
  String get customer => 'Customer';

  @override
  String get bookingDetails => 'Booking Details';

  @override
  String get navigate => 'Navigate';

  @override
  String get failedToLoadNotifications => 'Failed to load notifications.';

  @override
  String get failedToMarkAsRead => 'Failed to mark as read';

  @override
  String get noNotificationsYet => 'No notifications yet.';

  @override
  String get markRead => 'Mark read';

  @override
  String get customerReviewSubmitted => 'Customer review submitted!';

  @override
  String get loadingCustomerDetails => 'Loading customer details...';

  @override
  String get customerDetails => 'Customer Details';

  @override
  String get navigateButton => 'Navigate';

  @override
  String get callButton => 'Call';

  @override
  String get whatOthersSay => 'What others say';

  @override
  String get showLess => 'Show less';

  @override
  String showMoreCount(int count) {
    return 'Show more ($count more)';
  }

  @override
  String get todayLabel => 'Today';

  @override
  String get yesterdayLabel => 'Yesterday';

  @override
  String daysAgoShort(int days) {
    return '$days days ago';
  }

  @override
  String weeksAgoShort(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: 's',
      one: '',
    );
    return '$weeks week$_temp0 ago';
  }

  @override
  String providerHasArrived(String name) {
    return '$name has arrived!';
  }

  @override
  String get meetProviderToBeginService =>
      'Please meet your provider to begin your service';

  @override
  String get locationNotAvailable => 'Location not available';

  @override
  String get couldNotOpenMaps => 'Could not open maps';

  @override
  String get cannotMakePhoneCalls => 'Cannot make phone calls on this device';

  @override
  String get confirmCompletionWarning =>
      'Only confirm if the service has been fully completed. You may not be able to undo this.';

  @override
  String get paymentVerificationTitle => 'Payment Verification';

  @override
  String get paymentVerificationMessage =>
      'After completing the payment in your browser, tap \"Verify Payment\" to confirm.';

  @override
  String get verifyPaymentButton => 'Verify Payment';

  @override
  String get verifyingPayment => 'Verifying payment...';

  @override
  String get couldNotOpenPaymentPage =>
      'Could not open payment page. Please try again.';

  @override
  String get paymentStillProcessing =>
      'Payment is still processing. Please check back in a moment.';

  @override
  String get statusPending => 'Pending';

  @override
  String get customerProfile => 'Customer Profile';

  @override
  String get newCustomer => 'New customer';

  @override
  String get newCustomerNoReviews =>
      'This is a new customer with no reviews yet.';

  @override
  String get whatOtherProvidersSay => 'What other providers say';

  @override
  String get justNow => 'Just now';

  @override
  String monthsAgoShort(int months) {
    return '${months}mo ago';
  }

  @override
  String daysAgoShortCompact(int days) {
    return '${days}d ago';
  }

  @override
  String hoursAgoShort(int hours) {
    return '${hours}h ago';
  }

  @override
  String get generalArea => 'General Area';

  @override
  String get serviceCompleted => 'Service completed';

  @override
  String get completedServiceArea => 'Completed service area';

  @override
  String get serviceArea => 'Service area';

  @override
  String get locationHiddenAfterCancellation =>
      'For your safety, exact location details are hidden after cancellation. Only general area is shown.';

  @override
  String get locationHiddenAfterCompletion =>
      'For your safety, exact location details are hidden after service completion. Only general area is shown.';

  @override
  String get mapMarkerMe => 'Me';

  @override
  String get mapMarkerOther => 'Other';

  @override
  String get requestPlaced => 'Request Placed';

  @override
  String get whenBookingSubmitted => 'When this booking was submitted';

  @override
  String yourLocalTimeTimezone(String timezone) {
    return 'Your local time ($timezone)';
  }

  @override
  String get bookingTimeline => 'Booking Timeline';

  @override
  String get timelineRequestCreated => 'Request Created';

  @override
  String get timelineAccepted => 'Accepted';

  @override
  String get timelineInProgress => 'In Progress';

  @override
  String get timelineCompleted => 'Completed';

  @override
  String get timelineCancelled => 'Cancelled';

  @override
  String get timelinePending => 'Pending...';

  @override
  String get viewLess => 'View Less';

  @override
  String viewMoreCount(int count) {
    return 'View More ($count more)';
  }

  @override
  String get paymentRequiredImmediately => 'Payment Required Immediately!';

  @override
  String get paymentReminder => 'Payment Reminder';

  @override
  String hoursRemaining(String hours) {
    return '⏱ ${hours}h remaining';
  }

  @override
  String get serviceAppointment => 'Service Appointment';

  @override
  String get todayBadge => 'TODAY';

  @override
  String get locationField => 'Location';

  @override
  String get serviceAreaField => 'Service Area';

  @override
  String get requestedField => 'Requested';

  @override
  String allTimesInLocalTimezone(String timezone) {
    return 'All times shown in your local timezone ($timezone)';
  }

  @override
  String get completionConfirmed => 'Completion confirmed';

  @override
  String get rateCustomer => 'Rate Customer';

  @override
  String get customerReviewed => 'Customer reviewed';

  @override
  String get failedToSubmitReviewTryAgain =>
      'Failed to submit review. Please try again.';

  @override
  String get shareYourExperience => 'Share your experience...';

  @override
  String rateRequesterTitle(String name) {
    return 'Rate $name';
  }

  @override
  String get howWasExperienceWithCustomer =>
      'How was your experience with this customer?';

  @override
  String get commentOptional => 'Comment (optional)';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get submitButton => 'Submit';

  @override
  String get ratingPoor => 'Poor';

  @override
  String get ratingFair => 'Fair';

  @override
  String get ratingGood => 'Good';

  @override
  String get ratingVeryGood => 'Very Good';

  @override
  String get ratingExcellent => 'Excellent';

  @override
  String get profileCompletion => 'Profile completion';

  @override
  String get viewProfile => 'View Profile';

  @override
  String get providerKycTitle => 'Provider Verification (KYC)';

  @override
  String get logoutTooltip => 'Log out';

  @override
  String statusLabel(Object status) {
    return 'Status: $status';
  }

  @override
  String rejectedWithNotes(Object notes) {
    return 'Rejected: $notes';
  }

  @override
  String get kycInstructions =>
      'To access provider features, upload your ID and a selfie for verification.';

  @override
  String get idFrontRequired => 'ID Front (required)';

  @override
  String get selectIdFront => 'Select ID Front';

  @override
  String get idBackRequired => 'ID Back (required)';

  @override
  String get selectIdBackRequired => 'Select ID Back';

  @override
  String get selfieRequired => 'Selfie (required)';

  @override
  String get selectSelfie => 'Select Selfie';

  @override
  String get takeSelfie => 'Take Selfie';

  @override
  String get errorUploadAllRequired =>
      'Please upload ID (front), ID (back), and a selfie.';

  @override
  String failedSubmitKycCode(Object code) {
    return 'Failed to submit KYC (code $code).';
  }

  @override
  String submittedCurrentStatus(Object status) {
    return 'Submitted. Current status: $status';
  }

  @override
  String get unknownStatus => 'unknown';

  @override
  String get submitKyc => 'Submit KYC';

  @override
  String get verificationMayTakeTimeNote =>
      'Note: Verification may take time. You will be able to access provider features once approved.';

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
  String get enterVerificationCodeTitle => 'Enter Verification Code';

  @override
  String otpSentToUsername(Object username) {
    return 'We sent a 6-digit code to the phone number\nassociated with \"$username\".';
  }

  @override
  String get sixDigitCodeLabel => '6-digit code';

  @override
  String get enterSixDigitCodeValidation => 'Enter the 6-digit code';

  @override
  String get otpInvalidOrExpired => 'Invalid or expired code.';

  @override
  String get failedLoadUserInfoAfterVerification =>
      'Failed to load user info after verification.';

  @override
  String get chatWithSupportTitle => 'Chat with Support';

  @override
  String get unableStartSupportChat => 'Unable to start support chat.';

  @override
  String get invalidSupportThreadReturned =>
      'Invalid support thread returned from server.';

  @override
  String get noMessagesYet => 'No messages yet. Start a conversation!';

  @override
  String get supportDefaultName => 'Support';

  @override
  String get aboutPoliciesTitle => 'About & Policies';

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
    return 'Rate $providerName';
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
    return 'Failed to load profile: $error';
  }

  @override
  String profileSavedSuccess(Object action) {
    return 'Profile $action successfully!';
  }

  @override
  String genericError(Object error) {
    return 'Error: $error';
  }

  @override
  String get locationPermissionDeniedEnableInSettings =>
      'Location permission denied. Please enable in settings.';

  @override
  String get locationPermissionPermanentlyDeniedEnableInAppSettings =>
      'Location permission permanently denied. Please enable in app settings.';

  @override
  String errorGettingLocation(Object error) {
    return 'Error getting location: $error';
  }

  @override
  String get couldNotFindLocationForAddress =>
      'Could not find location for this address';

  @override
  String errorConvertingAddress(Object error) {
    return 'Error converting address: $error';
  }

  @override
  String get portfolioUnavailableCompleteKycFirst =>
      'Portfolio unavailable. If you are a provider, complete KYC verification first.';

  @override
  String failedToLoadPortfolio(Object error) {
    return 'Failed to load portfolio: $error';
  }

  @override
  String get addPhoto => 'Add Photo';

  @override
  String get addVideo => 'Add Video';

  @override
  String get addPost => 'Add post';

  @override
  String get captionOptionalTitle => 'Caption (optional)';

  @override
  String get captionHintExample => 'e.g., “Knotless braids on client”';

  @override
  String get skip => 'Skip';

  @override
  String get save => 'Save';

  @override
  String get failedToCreatePortfolioPost => 'Failed to create portfolio post.';

  @override
  String get uploadFailedMediaUpload => 'Upload failed (media upload).';

  @override
  String uploadFailed(Object error) {
    return 'Upload failed: $error';
  }

  @override
  String get deletePostTitle => 'Delete post?';

  @override
  String get deletePostBody => 'This will remove the post from your portfolio.';

  @override
  String get delete => 'Delete';

  @override
  String get deleteFailed => 'Delete failed.';

  @override
  String deleteFailedWithError(Object error) {
    return 'Delete failed: $error';
  }

  @override
  String get portfolioTitle => 'Portfolio';

  @override
  String get noPortfolioPostsYetHelpText =>
      'No portfolio posts yet. Add photos/videos of your work to help clients trust your skills.';

  @override
  String get setupProviderProfileTitle => 'Setup Provider Profile';

  @override
  String get providerProfileTitle => 'Provider Profile';

  @override
  String get welcomeToStyloriaTitle => 'Welcome to Styloria!';

  @override
  String get completeProviderProfileToStartEarning =>
      'Complete your provider profile to start accepting jobs and earning money.';

  @override
  String reviewCountLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'reviews',
      one: 'review',
    );
    return '($count $_temp0)';
  }

  @override
  String get topRatedChip => 'Top Rated';

  @override
  String get bioLabel => 'Bio / Description';

  @override
  String get bioHint => 'Tell clients about your skills and experience...';

  @override
  String get pleaseEnterBio => 'Please enter a bio';

  @override
  String bioMinLength(int min) {
    return 'Bio should be at least $min characters';
  }

  @override
  String get yourLocationTitle => 'Your Location';

  @override
  String get locationHelpMatchNearbyClients =>
      'Your location helps us match you with nearby clients';

  @override
  String get locationHelpUpdateToFindJobs =>
      'Update your location to find jobs in different areas';

  @override
  String get useMyCurrentLocationTitle => 'Use My Current Location';

  @override
  String get gpsSubtitle => 'Get location automatically using GPS';

  @override
  String get orLabel => 'OR';

  @override
  String get enterYourAddressTitle => 'Enter Your Address';

  @override
  String get fullAddressLabel => 'Full Address';

  @override
  String get fullAddressHint => 'e.g., 123 Main St, Accra, Ghana';

  @override
  String get find => 'Find';

  @override
  String get addressHelpText => 'Enter your street address, city, and country';

  @override
  String get coordinatesAutoFilledTitle => 'Coordinates (Auto-filled)';

  @override
  String get servicePricingTitle => 'Service Pricing';

  @override
  String get servicePricingHelp =>
      'Set your price for each service. Check \"Not Offered\" for services you cannot provide.';

  @override
  String get serviceHeader => 'Service';

  @override
  String get priceHeader => 'Price';

  @override
  String get notOfferedHeader => 'Not Offered';

  @override
  String get priceHint => '0.00';

  @override
  String get providerHowPricingWorksTitle => 'How Pricing Works:';

  @override
  String get providerHowPricingWorksBody =>
      '• Your price is what you charge for the service\n• Transportation cost = 80% of user\'s currency per km\n• Users see 3 options based on nearby providers:\n  - Budget: Lowest price among nearby providers\n  - Standard: Average price of nearby providers\n  - Priority: Highest price among nearby providers';

  @override
  String get availableForBookingsTitle => 'Available for Bookings';

  @override
  String get availableOnHelp =>
      '✓ You will appear in search results for nearby clients';

  @override
  String get availableOffHelp => '✗ You will not receive new job offers';

  @override
  String get completeSetupStartEarning => 'Complete Setup & Start Earning';

  @override
  String get updateProfile => 'Update Profile';

  @override
  String get skipForNow => 'Skip for Now';

  @override
  String get paymentsNotSupportedShort =>
      'Payments are not supported on this platform. Please use Android, iOS, macOS, or Web.';

  @override
  String get genericContact => 'Contact';

  @override
  String get genericProvider => 'Provider';

  @override
  String get genericNotAvailable => 'N/A';

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
  String locationConfirmed(String country) {
    return '✓ Location confirmed: $country';
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
  String get reviewSelectRatingPrompt => 'Select a rating (1 to 5).';

  @override
  String get reviewCommentOptionalLabel => 'Comment (optional)';

  @override
  String get genericCancel => 'Cancel';

  @override
  String get genericSubmit => 'Submit';

  @override
  String get reviewSubmitFailed => 'Failed to submit review.';

  @override
  String get rateThisService => 'Rate this service';

  @override
  String get tipLeaveTitle => 'Leave a tip';

  @override
  String get tipChooseAmountPrompt =>
      'Choose a tip amount, or enter a custom amount.';

  @override
  String get tipNoTip => 'No tip';

  @override
  String get tipCustomAmountLabel => 'Custom tip amount';

  @override
  String get genericContinue => 'Continue';

  @override
  String get tipSkipped => 'Tip skipped.';

  @override
  String get tipFailedToSaveChoice => 'Failed to save tip choice.';

  @override
  String get tipFailedToCreatePayment => 'Failed to create tip payment.';

  @override
  String get tipPaidSuccessfully => 'Tip paid successfully. Thank you!';

  @override
  String get tipPaidButUpdateFailed =>
      'Tip payment succeeded, but updating the booking failed.';

  @override
  String tipCancelledOrFailed(Object message) {
    return 'Tip cancelled/failed: $message';
  }

  @override
  String tipUnexpectedError(Object error) {
    return 'Unexpected tip error: $error';
  }

  @override
  String get tipAlreadyPaidLabel => 'Tip already paid';

  @override
  String get tipSkippedLabel => 'Tip skipped';

  @override
  String get tipLeaveButton => 'Leave a tip';

  @override
  String get walletTitle => 'Wallet';

  @override
  String get walletTooltip => 'Wallet';

  @override
  String get payoutSettingsTitle => 'Payout Settings';

  @override
  String get payoutSettingsTooltip => 'Payout settings';

  @override
  String get walletNoWalletYet => 'No wallet yet. Complete jobs to earn.';

  @override
  String get walletCurrencyFieldLabel => 'Currency';

  @override
  String walletAvailableLine(Object amount, Object currency) {
    return 'Available: $amount $currency';
  }

  @override
  String walletPendingLine(Object amount, Object currency) {
    return 'Pending: $amount $currency';
  }

  @override
  String get walletCashOutInstant => 'Cash Out (Instant)';

  @override
  String get walletCashOutFailed => 'Cash out failed.';

  @override
  String walletCashOutSentTransfer(Object transferId) {
    return 'Cash out sent. Transfer: $transferId';
  }

  @override
  String get walletTransactionsTitle => 'Transactions';

  @override
  String get walletNoTransactionsYet => 'No transactions yet.';

  @override
  String get payoutAutoPayoutsTitle => 'Auto payouts';

  @override
  String get payoutAutoPayoutsSubtitle =>
      'Automatically send payouts on your chosen schedule.';

  @override
  String get payoutDayUtcLabel => 'Payout day (UTC)';

  @override
  String get payoutHourUtcLabel => 'Payout hour (UTC)';

  @override
  String get payoutMinimumAmountLabel => 'Minimum auto payout amount';

  @override
  String get payoutMinimumAmountHelper =>
      'Auto payout runs only if available balance ≥ this amount.';

  @override
  String get payoutInstantCashOutEnabledTitle => 'Instant cash out enabled';

  @override
  String get payoutInstantCashOutEnabledSubtitle =>
      'Allow the “Cash Out” button (fee applies).';

  @override
  String get payoutSettingsSaved => 'Payout settings saved.';

  @override
  String get payoutSettingsSaveFailed => 'Failed to save payout settings.';

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

  @override
  String get signOut => 'Sign out';

  @override
  String get kycIdFrontPhoto => 'ID Front Photo';

  @override
  String get kycIdFrontMessage => 'Take a photo of the front of your ID card';

  @override
  String get kycIdBackPhoto => 'ID Back Photo';

  @override
  String get kycIdBackMessage => 'Take a photo of the back of your ID card';

  @override
  String get kycCamera => 'Camera';

  @override
  String get kycGallery => 'Gallery';

  @override
  String get kycChooseSource => 'Choose source:';

  @override
  String get kycFailedCaptureImage => 'Failed to capture image';

  @override
  String get kycFailedCaptureSelfie => 'Failed to capture selfie';

  @override
  String get kycCameraNotAvailable => 'Camera not available';

  @override
  String get kycCameraNotAvailableMessage =>
      'Camera is not available. Would you like to select an image from your gallery instead?';

  @override
  String get kycUseGallery => 'Use Gallery';

  @override
  String get kycDocumentsLocked =>
      'Documents are locked while pending review. You cannot make changes until verification is complete.';

  @override
  String get kycVerificationSubmittedSuccessfully =>
      'Verification submitted successfully';

  @override
  String get kycVerificationSubmitted => 'Verification Submitted';

  @override
  String get kycThankYouSubmitting =>
      'Thank you for submitting your verification documents!';

  @override
  String get kycWhatHappensNext => 'What happens next:';

  @override
  String get kycReviewTime =>
      'Our team will review your documents within 24-48 hours';

  @override
  String get kycEmailNotification =>
      'You\'ll receive an email once your verification is complete';

  @override
  String get kycCheckEmail =>
      'Check your email for updates on your verification status';

  @override
  String get kycLocked =>
      'Your documents are now locked and cannot be changed during review';

  @override
  String get kycRecommendSignOut =>
      'We recommend signing out and checking back later for your verification result.';

  @override
  String get kycStaySignedIn => 'Stay Signed In';

  @override
  String get kycVerificationPending => 'Verification Pending';

  @override
  String get kycVerificationPendingSubtitle =>
      'Your documents are being reviewed';

  @override
  String get kycVerificationApproved => 'Verification Approved';

  @override
  String get kycVerificationApprovedSubtitle =>
      'You can now access all provider features';

  @override
  String get kycVerificationRejected => 'Verification Rejected';

  @override
  String get kycVerificationRejectedSubtitle =>
      'Please review the notes below and resubmit';

  @override
  String get kycVerificationRequired => 'Verification Required';

  @override
  String get kycVerificationRequiredSubtitle =>
      'Complete verification to access provider features';

  @override
  String get kycReviewNotes => 'Review Notes';

  @override
  String get kycIdCardFront => 'ID Card (Front)';

  @override
  String get kycIdCardBack => 'ID Card (Back)';

  @override
  String get kycVerificationSelfie => 'Verification Selfie';

  @override
  String get kycButtonLocked => 'Locked';

  @override
  String get kycCaptureIdFront => 'Capture ID Front';

  @override
  String get kycCaptureIdBack => 'Capture ID Back';

  @override
  String get kycDocumentsLockedButton => 'Documents Locked';

  @override
  String get kycTipsTitle => '📸 Tips for good photos:';

  @override
  String get kycTipGoodLighting => '• Use good lighting';

  @override
  String get kycTipFlatCard => '• Place ID card on a flat surface';

  @override
  String get kycTipReadableText => '• Make sure all text is readable';

  @override
  String get kycTipFaceCamera => '• Face the camera directly for selfie';

  @override
  String get kycTipAvoidGlare => '• Avoid glare or shadows';

  @override
  String get kycFailedSubmitVerification => 'Failed to submit verification';

  @override
  String get paystackSetupTitle => 'Setup Payout Account';

  @override
  String get paystackVerifying => 'Verifying...';

  @override
  String get paystackVerificationSuccess =>
      'Payout settings saved successfully!';

  @override
  String get paystackVerificationFailed => 'Failed to save payout settings';

  @override
  String get paystackSelectBank => 'Select Your Bank';

  @override
  String get paystackAccountNumber => 'Account Number';

  @override
  String get paystackVerifyAccount => 'Verify Account';

  @override
  String get paystackAccountVerified => 'Account Verified';

  @override
  String get paystackSavePayoutAccount => 'Save Payout Account';

  @override
  String paystackNoBanksAvailable(Object country) {
    return 'No banks available for $country';
  }

  @override
  String get paystackRetry => 'Retry';

  @override
  String get paystackPayoutsInfo =>
      'Your earnings will be sent to this account. Payouts are processed within 24 hours.';

  @override
  String get paystackConnected => 'Account: connected';

  @override
  String get paystackNotConnected => 'Account: not connected';

  @override
  String get paystackDetailsSubmitted => 'Details submitted:';

  @override
  String get paystackPayoutsEnabled => 'Payouts enabled:';

  @override
  String get paystackYes => 'yes';

  @override
  String get paystackNo => 'no';

  @override
  String get paystackFinishSetup => 'Finish Stripe Setup';

  @override
  String get paystackConnectStripe => 'Connect Stripe';

  @override
  String get paystackOpenDashboard => 'Open Stripe Dashboard';

  @override
  String get paystackMustFinishSetup =>
      'You must finish Stripe setup before you can cash out.';

  @override
  String get paystackPayouts => 'Paystack Payouts';

  @override
  String get paystackAddBankDetails =>
      'Add your bank account details in Payout Settings to receive payouts via Paystack.';

  @override
  String get paystackOpenSettings => 'Open Payout Settings';

  @override
  String payoutPaystackForCountry(Object country) {
    return 'Payouts via Paystack for $country';
  }

  @override
  String payoutFlutterwaveForCountry(Object country) {
    return 'Payouts are processed via Flutterwave for $country';
  }

  @override
  String get payoutStripeConnect => 'Stripe Connect';

  @override
  String get payoutBankAccountDetails => 'Bank Account Details';

  @override
  String get payoutAccountHolderName => 'Account Holder Name';

  @override
  String get payoutAccountHolderNameHint =>
      'Enter name as it appears on your bank account';

  @override
  String get payoutSelectBank => 'Select Bank *';

  @override
  String get payoutBankName => 'Bank Name *';

  @override
  String get payoutBankNameManual => 'Bank Name (manual)';

  @override
  String get payoutBankNameHint => 'e.g., GCB Bank, Ecobank';

  @override
  String get payoutBankCode => 'Bank Code *';

  @override
  String get payoutBankCodeManual => 'Bank Code (manual)';

  @override
  String get payoutBankCodeHint => 'Flutterwave bank code';

  @override
  String get payoutBankCodeHelper => 'Contact support if unsure of bank code';

  @override
  String get payoutAccountNumber => 'Account Number *';

  @override
  String get payoutAccountNumberHint => 'Enter your bank account number';

  @override
  String get payoutMobileMoney => 'Mobile Money';

  @override
  String get payoutFullName => 'Full Name (as registered) *';

  @override
  String get payoutFullNameHint =>
      'Name registered on your mobile money account';

  @override
  String get payoutMobileNetwork => 'Mobile Network *';

  @override
  String get payoutSelectNetwork => 'Select your mobile network';

  @override
  String get payoutMobileNetworkHint => 'e.g., MTN, Vodafone, Airtel';

  @override
  String get payoutCountryCode => 'Country Code';

  @override
  String get payoutMobileMoneyNumber => 'Mobile Money Number *';

  @override
  String get payoutMobileMoneyNumberHint => 'e.g., 0541234567';

  @override
  String get payoutZipCode => 'ZIP/Postal Code';

  @override
  String get payoutZipCodeHint => 'If required by your network';

  @override
  String get payoutMethod => 'Payout Method';

  @override
  String get payoutBankTransfer => 'Bank Transfer';

  @override
  String get payoutCurrency => 'Currency';

  @override
  String payoutCurrencyLocked(Object country) {
    return 'Locked to $country currency';
  }

  @override
  String get payoutBeneficiaryId => 'Beneficiary ID';

  @override
  String get payoutBeneficiaryIdHint => 'Optional - for recurring transfers';

  @override
  String get payoutSchedule => 'Payout Schedule';

  @override
  String get payoutFrequency => 'Payout Frequency';

  @override
  String get payoutFrequencyWeekly => 'Weekly';

  @override
  String get payoutFrequencyMonthly => 'Monthly (1st of each month)';

  @override
  String get payoutDayHelper => 'Available: Tuesday, Thursday, Friday';

  @override
  String get payoutMonthlyInfo =>
      'Monthly payouts are processed on the 1st of each month.';

  @override
  String get payoutInstantCashout => 'Instant Cashout';

  @override
  String get payoutInstantCashoutInfo =>
      '• Unlimited instant cashouts available\n• 5% fee applies to instant cashouts\n• Scheduled payouts have no fees';

  @override
  String get payoutNextScheduled => 'Next Scheduled Payout';

  @override
  String payoutYourLocalTime(Object timezone) {
    return 'Your local time ($timezone)';
  }

  @override
  String get payoutAmountToCashOut => 'Amount to cash out';

  @override
  String payoutMinMaxRange(Object min, Object max) {
    return 'Min: $min - Max: $max';
  }

  @override
  String get payoutMaxButton => 'MAX';

  @override
  String get payoutCashOutNow => 'Cash Out (Instant)';

  @override
  String get payoutAvailableBalance => 'Available Balance';

  @override
  String get payoutPendingFunds => 'Pending';

  @override
  String get payoutPendingInfo =>
      'Pending funds will be available after the hold period';

  @override
  String get payoutLifetimeEarnings => 'Lifetime Earnings';

  @override
  String get payoutTotalCashedOut => 'Total Cashed Out';

  @override
  String get payoutUnlimitedCashouts => 'Unlimited';

  @override
  String get mainHello => 'Hello';

  @override
  String get mainViewProfile => 'View Profile';

  @override
  String get mainBookings => 'Bookings';

  @override
  String get mainNotifications => 'Notifications';

  @override
  String get mainReferral => 'Referral';

  @override
  String get mainSettings => 'Settings';

  @override
  String get mainHelp => 'Help';

  @override
  String get mainWallet => 'Wallet';

  @override
  String get mainEarnings => 'Earnings';

  @override
  String get mainOpenJobs => 'Open Jobs';

  @override
  String get mainAssignedJobs => 'Assigned Jobs';

  @override
  String get mainMyReputation => 'My Reputation';

  @override
  String get reputationTitle => 'My Reputation';

  @override
  String get reputationYourCustomerRating => 'Your Customer Rating';

  @override
  String reputationBasedOnReviews(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'reviews',
      one: 'review',
    );
    return 'Based on $count $_temp0';
  }

  @override
  String get reputationExcellentCustomer => '⭐ Excellent Customer';

  @override
  String get reputationGreatCustomer => '👍 Great Customer';

  @override
  String get reputationGoodCustomer => '✓ Good Customer';

  @override
  String get reputationAverage => 'Average';

  @override
  String get reputationNeedsImprovement => 'Needs Improvement';

  @override
  String get reputationNoRatingYet => 'No Rating Yet';

  @override
  String get reputationWhatProvidersSay => 'What Providers Say About You';

  @override
  String get reputationNoReviews => 'No Reviews Yet';

  @override
  String get reputationNoReviewsHelp =>
      'Complete bookings to build your reputation!\nProviders will rate you after completing services.';

  @override
  String reputationShowMore(int count) {
    return 'Show More ($count more)';
  }

  @override
  String get reputationShowLess => 'Show Less';

  @override
  String get reputationJustNow => 'Just now';

  @override
  String reputationMinutesAgo(int minutes) {
    return '$minutes min ago';
  }

  @override
  String reputationHoursAgo(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'hours',
      one: 'hour',
    );
    return '$hours $_temp0 ago';
  }

  @override
  String reputationDaysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'days',
      one: 'day',
    );
    return '$days $_temp0 ago';
  }

  @override
  String reputationWeeksAgo(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: 'weeks',
      one: 'week',
    );
    return '$weeks $_temp0 ago';
  }

  @override
  String reputationMonthsAgo(int months) {
    String _temp0 = intl.Intl.pluralLogic(
      months,
      locale: localeName,
      other: 'months',
      one: 'month',
    );
    return '$months $_temp0 ago';
  }

  @override
  String reputationYearsAgo(int years) {
    String _temp0 = intl.Intl.pluralLogic(
      years,
      locale: localeName,
      other: 'years',
      one: 'year',
    );
    return '$years $_temp0 ago';
  }

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsNoNotifications => 'No notifications yet.';
}
