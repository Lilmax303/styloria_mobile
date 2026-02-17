// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'Styloria';

  @override
  String get account => '계정';

  @override
  String get profile => '프로필';

  @override
  String get myBookings => '내 예약';

  @override
  String get openJobs => '오픈 잡';

  @override
  String get earnings => '수익';

  @override
  String get paymentMethods => '결제 수단';

  @override
  String get referFriends => '친구 추천';

  @override
  String get language => '언어';

  @override
  String get settings => '설정';

  @override
  String get darkMode => '다크 모드';

  @override
  String get systemDefault => '시스템 기본값';

  @override
  String get languageUpdated => '언어가 업데이트되었습니다';

  @override
  String get languageSetToSystemDefault => '언어가 시스템 기본값으로 설정되었습니다';

  @override
  String get helpAndSupport => '도움말 및 지원';

  @override
  String get chatWithCustomerService => '고객 지원과 채팅';

  @override
  String get aboutAndPolicies => '정보 및 정책';

  @override
  String get viewUserPoliciesAndAgreements => '사용자 정책 및 약관 보기';

  @override
  String get logOut => '로그아웃';

  @override
  String get deleteAccount => '계정 삭제';

  @override
  String get deleteAccountSubtitle => '이 작업은 되돌릴 수 없습니다';

  @override
  String get deleteAccountTitle => '계정 삭제';

  @override
  String get deleteAccountConfirmBody =>
      '계정을 삭제하시겠습니까?\n\n이 작업은 로그아웃되며 영구적으로 접근 권한을 잃을 수 있습니다.';

  @override
  String get no => '아니오';

  @override
  String get yesDelete => '예, 삭제';

  @override
  String get deleteAccountSheetTitle => '떠나셔서 아쉽습니다.';

  @override
  String get deleteAccountSheetPrompt => '이유를 알려주실 수 있나요? (해당되는 항목 모두 선택)';

  @override
  String get deleteAccountSelectAtLeastOneReason => '최소 한 가지 이유를 선택해 주세요.';

  @override
  String get tellUsMoreOptional => '자세히 알려주세요(선택)';

  @override
  String get suggestionsToImproveOptional => '개선 제안(선택)';

  @override
  String get deleteMyAccount => '내 계정 삭제';

  @override
  String get cancel => '취소';

  @override
  String get failedToDeleteAccount => '계정 삭제에 실패했습니다. 다시 시도해 주세요.';

  @override
  String get choosePreferredLanguage => '선호 언어 선택';

  @override
  String get noteSomeTextMayStillAppearInEnglish =>
      '참고: 앱 언어가 변경됩니다. 번역이 추가되기 전까지 일부 텍스트는 영어로 표시될 수 있습니다.';

  @override
  String languageSetToName(Object name) {
    return '언어가 $name(으)로 설정되었습니다';
  }

  @override
  String get close => 'Close';

  @override
  String get customerNotes => 'Customer Notes';

  @override
  String get yourNotes => 'Your Notes';

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
  String get confirmPassword => '비밀번호 확인';

  @override
  String get dateOfBirth => 'Date of Birth';

  @override
  String get verificationCode => 'Verification Code';

  @override
  String get invalidEmail => 'Please enter a valid email';

  @override
  String get invalidCode => 'Please enter a valid code';

  @override
  String get cantFindEmailTitle => 'Can\'t find the email?';

  @override
  String get checkSpamJunkNotice =>
      'Please check your Spam, Junk, or Promotions folder. The email may take a moment to arrive. Be sure to mark it as \"Not Spam\" so you receive future communications from us.';

  @override
  String get passwordTooShort => 'Password must be at least 8 characters';

  @override
  String get changeEmail => 'Use a different email';

  @override
  String get backToLogin => 'Back to Login';

  @override
  String get deletionReason1 => 'Styloria가 더 이상 필요하지 않아요';

  @override
  String get deletionReason2 => '계정 인증(이메일/KYC)에 문제가 있었어요';

  @override
  String get deletionReason3 => '근처에서 서비스/제공자를 찾을 수 없었어요';

  @override
  String get deletionReason4 => '가격 또는 수수료가 너무 비싸거나 불명확했어요';

  @override
  String get deletionReason5 => '앱이 혼란스럽거나 사용하기 어려웠어요';

  @override
  String get deletionReason6 => '버그 또는 성능 문제';

  @override
  String get deletionReason7 => '결제/환불 문제';

  @override
  String get deletionReason8 => '제공자/사용자와의 나쁜 경험';

  @override
  String get deletionReason9 => '개인정보 또는 보안 우려';

  @override
  String get deletionReason10 => '실수로 계정을 만들었어요';

  @override
  String get deletionReason11 => '다른 플랫폼으로 옮길 거예요';

  @override
  String get deletionReason12 => '기타';

  @override
  String get loginWelcomeTitle => 'Styloria에 오신 것을 환영합니다';

  @override
  String get loginWelcomeSubtitle => '예약과 서비스를 관리하려면 로그인하세요.';

  @override
  String get loginFailedToLoadUserInfo => '로그인은 성공했지만 사용자 정보를 불러오지 못했습니다.';

  @override
  String get username => '사용자 이름';

  @override
  String get password => '비밀번호';

  @override
  String get required => '필수';

  @override
  String get login => '로그인';

  @override
  String get createNewAccount => '새 계정 만들기';

  @override
  String get requestEmailVerificationCode => '이메일 인증 코드 요청';

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
  String get pleaseEnterAddress => '주소를 입력해 주세요';

  @override
  String get locationUpdatedFromAddress => '주소로 위치가 업데이트되었습니다';

  @override
  String get myCustomerRating => '내 고객 평점';

  @override
  String get outOf5 => '/ 5.0';

  @override
  String reviewsFromProviders(int count) {
    return '서비스 제공자로부터 $count개의 리뷰';
  }

  @override
  String get failedToLoadReputation => '평판 데이터를 불러오지 못했습니다';

  @override
  String get somethingWentWrong => '문제가 발생했습니다';

  @override
  String get retry => '다시 시도';

  @override
  String weDetectedYoureIn(String country) {
    return '📍 현재 위치가 $country(으)로 감지되었습니다. 아래에서 국가를 선택해 주세요.';
  }

  @override
  String get locationMarkedAsOther => '위치가 \"기타\"로 표시됨 - 등록을 계속할 수 있습니다';

  @override
  String get createAccountTitle => '계정 만들기';

  @override
  String get joinStyloria => 'Styloria 가입';

  @override
  String get registerSubtitle => '서비스를 예약하거나 제공자가 되기 위해 계정을 만드세요';

  @override
  String get iWantTo => '원하는 작업:';

  @override
  String get bookServices => '서비스 예약';

  @override
  String get provideServices => '서비스 제공';

  @override
  String get personalInformation => '개인 정보';

  @override
  String get firstName => '이름';

  @override
  String get lastName => '성';

  @override
  String get selectDateOfBirth => '생년월일 선택';

  @override
  String get phoneNumber => '전화번호';

  @override
  String get pleaseEnterPhoneNumber => '전화번호를 입력해 주세요';

  @override
  String get accountInformation => '계정 정보';

  @override
  String get chooseUniqueUsernameHint => '고유한 사용자 이름을 선택하세요';

  @override
  String get youAreCurrentlyUnavailable => '현재 이용 불가 상태입니다';

  @override
  String get toBrowseAndAcceptJobsEnableAvailability =>
      '주변 작업 요청을 찾아보고 수락하려면 예약 가능 상태로 설정해야 합니다.';

  @override
  String get goToProfileSettings => '프로필 설정으로 이동';

  @override
  String get tipToggleAvailableForBookings =>
      '팁: 서비스 제공자 프로필에서 \"예약 가능\"을 켜서 작업 요청을 받기 시작하세요.';

  @override
  String requestedBy(String name) {
    return '요청자: $name';
  }

  @override
  String locationLabel(String address) {
    return '위치: $address';
  }

  @override
  String get email => '이메일';

  @override
  String get emailHint => 'your@email.com';

  @override
  String get enterValidEmail => '유효한 이메일을 입력하세요';

  @override
  String get security => '보안';

  @override
  String get passwordHintAtLeast10 => '최소 10자 이상';

  @override
  String get passwordMin10 => '비밀번호는 최소 10자 이상이어야 합니다';

  @override
  String get iAgreeTo => '동의합니다: ';

  @override
  String get termsOfService => '서비스 약관';

  @override
  String get and => '및';

  @override
  String get privacyPolicy => '개인정보 처리방침';

  @override
  String get passwordIsRequired => '비밀번호가 필요합니다';

  @override
  String get passwordsDoNotMatch => '비밀번호가 일치하지 않습니다';

  @override
  String get pleaseSelectDob => '생년월일을 선택해 주세요.';

  @override
  String get pleaseSelectCountry => '국가를 선택해 주세요.';

  @override
  String get pleaseSelectCity => '도시를 선택해 주세요.';

  @override
  String get pleaseEnterValidPhone => '유효한 전화번호를 입력해 주세요.';

  @override
  String get mustAcceptTerms => '약관에 동의해야 합니다.';

  @override
  String get mustBeAtLeast18 => '가입하려면 만 18세 이상이어야 합니다.';

  @override
  String get agreeToTerms => '서비스 약관 및 개인정보 처리방침에 동의합니다';

  @override
  String get createAccountButton => '계정 만들기';

  @override
  String get alreadyHaveAccount => '이미 계정이 있으신가요?';

  @override
  String get emailVerifiedSuccessPleaseLogin => '이메일 인증이 완료되었습니다. 로그인해 주세요.';

  @override
  String get pleaseVerifyEmailToContinue => '계속하려면 이메일을 인증해 주세요.';

  @override
  String get requestVerificationCodeTitle => '인증 코드 요청';

  @override
  String get requestVerificationInstructions =>
      '이메일 또는 사용자 이름을 입력하세요.\n해당 계정의 이메일로 새 인증 코드를 보내드립니다.';

  @override
  String get emailOrUsername => '이메일 또는 사용자 이름';

  @override
  String get sendCode => '코드 보내기';

  @override
  String get ifAccountExistsCodeSent => '계정이 존재한다면 코드가 전송되었습니다.';

  @override
  String get failedToSendVerificationCode => '인증 코드 전송에 실패했습니다.';

  @override
  String get verifyYourEmailTitle => '이메일 인증';

  @override
  String get verificationCodeSentInfo => '이 계정의 이메일로 인증 코드가 전송되었습니다.';

  @override
  String emailVerificationInstructions(Object identifier) {
    return '이 계정의 이메일로 전송된 6자리 코드를 입력하세요:\n$identifier';
  }

  @override
  String get verificationCodeLabel => '인증 코드';

  @override
  String get sendingEllipsis => '전송 중...';

  @override
  String get resendCode => '코드 재전송';

  @override
  String get enter6DigitCodeError => '6자리 코드를 입력하세요.';

  @override
  String get verifyingEllipsis => '확인 중...';

  @override
  String get verify => '확인';

  @override
  String get invalidOrExpiredCodeTryResending =>
      '코드가 잘못되었거나 만료되었습니다. 다시 전송해 보세요.';

  @override
  String bookingTitle(Object id) {
    return '예약 #$id';
  }

  @override
  String get invalidBookingIdForChat => '채팅을 위한 예약 ID가 올바르지 않습니다.';

  @override
  String get invalidBookingIdForCall => '통화를 위한 예약 ID가 올바르지 않습니다.';

  @override
  String get unableToLoadContactInfo =>
      '연락처 정보를 불러올 수 없습니다. 예약이 활성 상태인지 확인하세요.';

  @override
  String noPhoneNumberAvailableForName(Object name) {
    return '$name의 전화번호를 사용할 수 없습니다.';
  }

  @override
  String get deviceCannotPlaceCalls => '이 기기에서는 전화 통화를 할 수 없습니다.';

  @override
  String get cancelBookingDialogTitle => '예약 취소';

  @override
  String get cancelBookingDialogBody =>
      '이 예약을 정말로 취소하시겠습니까?\n\n참고: 제공자가 이미 수락했고 7분이 지났다면(약 40분 미만), 규정에 따라 페널티가 적용될 수 있습니다.';

  @override
  String get yesCancel => '예, 취소';

  @override
  String get failedToCancelBooking => '예약 취소에 실패했습니다.';

  @override
  String bookingCancelledPenaltyApplied(Object amount) {
    return '예약이 취소되었습니다. $amount의 페널티가 적용되었습니다.';
  }

  @override
  String get bookingCancelledSuccessfully => '예약이 성공적으로 취소되었습니다.';

  @override
  String get failedToConfirmCompletion => '완료 확인에 실패했습니다. 다시 시도해 주세요.';

  @override
  String get bothSidesConfirmedCompletedPayoutReleased =>
      '양쪽 모두 확인했습니다. 예약이 완료로 표시되고 정산이 해제되었습니다.';

  @override
  String get youConfirmedCompletionWaitingForProvider =>
      '완료를 확인했습니다. 제공자의 확인을 기다리는 중입니다.';

  @override
  String get youConfirmedCompletionWaitingForUser =>
      '완료를 확인했습니다. 사용자의 확인을 기다리는 중입니다.';

  @override
  String get statusUnknown => '알 수 없음';

  @override
  String get statusAccepted => '수락됨';

  @override
  String get statusInProgress => '진행 중';

  @override
  String get statusCompleted => '완료됨';

  @override
  String get statusCancelled => '취소됨';

  @override
  String get paymentPaid => '결제됨';

  @override
  String get paymentPending => '대기 중';

  @override
  String get paymentFailed => '실패';

  @override
  String bookingAcceptedBy(Object name) {
    return '$name님이 예약을 수락했습니다';
  }

  @override
  String get whenLabel => '일정';

  @override
  String atTime(Object time) {
    return '$time에';
  }

  @override
  String get userLabel => '사용자';

  @override
  String get providerLabel => '제공자';

  @override
  String get estimatedPriceLabel => '예상 가격';

  @override
  String get offeredPaidLabel => '제안 / 결제';

  @override
  String get distanceLabel => '거리';

  @override
  String distanceMiles(Object miles) {
    return '$miles마일';
  }

  @override
  String get acceptedAtLabel => '수락 시간';

  @override
  String get cancelledAtLabel => '취소 시간';

  @override
  String get cancelledByLabel => '취소한 사람';

  @override
  String penaltyAppliedLabel(Object amount) {
    return '적용된 페널티: $amount';
  }

  @override
  String get userConfirmedLabel => '사용자 확인';

  @override
  String get providerConfirmedLabel => '제공자 확인';

  @override
  String get payoutReleasedLabel => '정산 해제';

  @override
  String get yesLower => '예';

  @override
  String get noLower => '아니요';

  @override
  String get chat => '채팅';

  @override
  String get call => '전화';

  @override
  String get actions => '작업';

  @override
  String get confirmCompletion => '완료 확인';

  @override
  String get noFurtherActionsForBooking => '이 예약에 대해 더 이상 가능한 작업이 없습니다.';

  @override
  String freeCancellationEndsIn(Object time) {
    return '무료 취소 종료까지 $time';
  }

  @override
  String get earlyFreeCancellationEndedWarning =>
      '초기 무료 취소 기간이 종료되었습니다. 수락 후 약 40분까지는 늦은 취소에 페널티가 부과될 수 있습니다.';

  @override
  String get cancelBooking => '예약 취소';

  @override
  String get cancelBookingNoPenalty => '예약 취소(페널티 없음)';

  @override
  String get cancelBookingPenaltyMayApply => '예약 취소(페널티 발생 가능)';

  @override
  String get cancellationPolicyInfo =>
      '제공자 수락 후 처음 7분 동안은 페널티 없이 취소할 수 있으며, 필요 시 약 40분 이후에도 다시 페널티 없이 취소할 수 있습니다. 그 사이에는 규정에 따라 페널티가 적용될 수 있습니다.';

  @override
  String ratingLine(Object rating, int reviewCount) {
    String _temp0 = intl.Intl.pluralLogic(
      reviewCount,
      locale: localeName,
      other: '리뷰 $reviewCount개',
      one: '리뷰 1개',
    );
    return '평점: $rating ($_temp0)';
  }

  @override
  String get proofOfSkillsPortfolio => '기술 증빙(포트폴리오)';

  @override
  String get noPortfolioPostsAvailable => '포트폴리오 게시물이 없습니다.';

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
  String get bookingLocation => '예약 위치';

  @override
  String get location => '위치';

  @override
  String get latitude => '위도';

  @override
  String get longitude => '경도';

  @override
  String get mapWillAppearWhenCoordinatesValid => '좌표가 유효하면 여기에 지도가 표시됩니다.';

  @override
  String chatForBookingTitle(Object id) {
    return '예약 #$id 채팅';
  }

  @override
  String get unableToStartChat =>
      '채팅을 시작할 수 없습니다. 채팅은 예약이 수락됨/진행 중이거나 최근 1일 내 완료된 경우에만 가능합니다.';

  @override
  String get invalidChatThreadFromServer => '서버에서 반환된 채팅 스레드가 올바르지 않습니다.';

  @override
  String get messageNotSentPolicy =>
      '메시지가 전송되지 않았습니다. 참고: 채팅에서 전화번호나 이메일 공유는 허용되지 않습니다.';

  @override
  String get unknown => '알 수 없음';

  @override
  String get typeMessageHint => '지원팀에 보낼 메시지를 입력하세요...';

  @override
  String get uploadProfilePicture => '프로필 사진 업로드';

  @override
  String get currentProfilePicture => '현재 프로필 사진';

  @override
  String get newPicturePreview => '새 사진 미리보기';

  @override
  String get chooseImage => '이미지 선택';

  @override
  String get upload => '업로드';

  @override
  String get noImageBytesFoundWeb => '이미지 바이트를 찾을 수 없습니다(웹).';

  @override
  String get pleasePickAnImageFirst => '먼저 이미지를 선택하세요.';

  @override
  String get uploadFailedCheckServerLogs => '업로드에 실패했습니다. 서버 로그/토큰을 확인하세요.';

  @override
  String get profilePictureUploadedSuccessfully => '프로필 사진이 성공적으로 업로드되었습니다!';

  @override
  String errorWithValue(Object error) {
    return '오류: $error';
  }

  @override
  String get tapToChangeProfilePicture => '탭하여 프로필 사진 변경';

  @override
  String usernameValue(Object username) {
    return '사용자 이름: $username';
  }

  @override
  String roleValue(Object role) {
    return '역할: $role';
  }

  @override
  String get dateOfBirthYyyyMmDd => '생년월일(YYYY-MM-DD)';

  @override
  String get saveProfile => '프로필 저장';

  @override
  String get failedToSaveProfile => '프로필 저장에 실패했습니다. 다시 시도해 주세요.';

  @override
  String get profileUpdated => '프로필이 업데이트되었습니다.';

  @override
  String get completeYourProviderProfile => '제공자 프로필을 완료하세요';

  @override
  String get completeProviderProfileBody => '일을 수락하고 수익을 얻으려면 제공자 프로필을 완료하세요.';

  @override
  String get setupProfileNow => '프로필 지금 설정';

  @override
  String get doItLater => '나중에 하기';

  @override
  String get bookingTimerPenaltyPeriodActive => '페널티 기간 활성';

  @override
  String get bookingTimerFreeCancellationPeriod => '무료 취소 기간';

  @override
  String bookingTimerTimeRemaining(Object time) {
    return '남은 시간: $time';
  }

  @override
  String get bookingTimerCancellingNowPenalty => '지금 취소하면 10% 페널티가 부과됩니다.';

  @override
  String get bookingTimerCancelNoPenalty => '페널티 없이 취소할 수 있습니다.';

  @override
  String get myReviewsTitle => '내 리뷰';

  @override
  String get failedToLoadReviews => '리뷰를 불러오지 못했습니다.';

  @override
  String get noReviewsYet => '아직 남긴 리뷰가 없습니다.';

  @override
  String providerWithName(Object name) {
    return '제공자: $name';
  }

  @override
  String get providerGeneric => '제공자';

  @override
  String ratingWithValue(Object rating) {
    return '평점: $rating';
  }

  @override
  String get nearbyOpenJobsTitle => '근처 오픈 작업';

  @override
  String get failedToLoadOpenJobsHint =>
      '오픈 작업을 불러오지 못했습니다.\n위치가 설정되어 있고 available=true인 제공자 프로필이 있는지 확인하세요.';

  @override
  String errorLoadingJobsWithValue(Object error) {
    return '작업 로드 오류: $error';
  }

  @override
  String get noOpenJobsFoundNearbyTitle => '근처에 오픈 작업이 없습니다';

  @override
  String get noOpenJobsFoundNearbyBody =>
      '확인 사항:\n- 제공자 위치를 설정했는지\n- 사용 가능으로 표시되어 있는지\n- 사용자가 예약을 만들고 결제했는지';

  @override
  String currencyLabel(Object symbol) {
    return '통화: $symbol';
  }

  @override
  String pricesShownInCurrency(Object symbol, Object country) {
    return '가격은 $symbol ($country) 기준으로 표시됩니다';
  }

  @override
  String jobTitleWithId(Object id) {
    return '작업 #$id';
  }

  @override
  String serviceLine(Object service) {
    return '서비스: $service';
  }

  @override
  String whenLine(Object date, Object time) {
    return '시간: $date $time';
  }

  @override
  String priceLine(Object price) {
    return '가격: $price';
  }

  @override
  String get acceptJob => '작업 수락';

  @override
  String get failedToAcceptJob => '작업 수락에 실패했습니다.';

  @override
  String get jobAcceptedSuccessfully => '작업을 성공적으로 수락했습니다.';

  @override
  String get newServiceRequestTitle => '새 서비스 요청';

  @override
  String get reviewAlreadySubmitted => 'Review submitted ✓';

  @override
  String get offeredPriceLabel => '제안 가격';

  @override
  String get offeredPriceHint => '예: 25.00';

  @override
  String get enterValidPrice => '올바른 가격을 입력하세요';

  @override
  String get bookAndPay => '예약 및 결제';

  @override
  String bookAndPayAmount(Object amount) {
    return '예약 및 결제 $amount';
  }

  @override
  String get haircutService => '헤어컷';

  @override
  String get stylingService => '스타일링';

  @override
  String get timeLabel => '시간:';

  @override
  String get notesLabel => '메모';

  @override
  String get requestCreatedAndPaidBroadcast => '요청이 생성되고 결제되었습니다! 제공자에게 전송됩니다.';

  @override
  String locationLatLng(Object lat, Object lng) {
    return '위치: $lat, $lng';
  }

  @override
  String get paymentMethodsTitle => '결제 수단';

  @override
  String get paymentPreferencesInfo =>
      '이 설정은 기기에 로컬로 저장됩니다. 실제 결제는 Stripe/기타 게이트웨이를 통해 안전하게 처리됩니다.';

  @override
  String get preferredMethodLabel => '선호 결제 수단(국가별 로컬 게이트웨이 선택)';

  @override
  String get methodVisaMastercard => 'Visa/Mastercard';

  @override
  String get methodMobileMoney => '모바일 머니(Momo/Paystack/아프리카)';

  @override
  String get methodPaypal => 'PayPal';

  @override
  String get methodApplePayGooglePay => 'Apple Pay/Google Pay';

  @override
  String get methodWeChatPay => 'WeChat Pay(중국)';

  @override
  String get methodAlipay => 'Alipay(중국)';

  @override
  String get methodUnionPay => 'UnionPay 카드(중국)';

  @override
  String get mobileMoneyNumberLabel => '모바일 머니 번호';

  @override
  String get wechatAlipayIdLabel => 'WeChat/Alipay ID';

  @override
  String get cardLast4DigitsLabel => '카드 뒤 4자리';

  @override
  String get paypalEmailLabel => 'PayPal 이메일';

  @override
  String get applePayEnabledOnDevice => '이 기기에서 Apple Pay 사용';

  @override
  String get savePaymentPreferences => '결제 설정 저장';

  @override
  String get paymentPrefsSavedInfo =>
      '결제 설정이 로컬에 저장되었습니다. 실제 결제는 추후 Stripe/기타 게이트웨이로 처리됩니다.';

  @override
  String get failedToLoadImage => '이미지 로드 실패';

  @override
  String get earningsTitle => '수익';

  @override
  String get couldNotLoadEarningsSummary => '수익 요약을 불러올 수 없습니다.';

  @override
  String get noData => '데이터 없음.';

  @override
  String get summaryTitle => '요약';

  @override
  String get totalLabel => '합계';

  @override
  String get pendingLabel => '대기';

  @override
  String get paidLabel => '지급됨';

  @override
  String get pdfReportTitle => 'PDF 보고서';

  @override
  String get periodLabel => '기간';

  @override
  String get periodDaily => 'Daily';

  @override
  String get periodWeekly => 'Weekly';

  @override
  String get periodMonthly => 'Monthly';

  @override
  String get periodYearly => 'Yearly';

  @override
  String get periodThisMonth => '이번 달';

  @override
  String get periodLastMonth => '지난달';

  @override
  String get periodYtd => '연초 이후';

  @override
  String get periodAllTime => '전체';

  @override
  String get couldNotDownloadPdfReport => 'PDF 보고서를 다운로드할 수 없습니다.';

  @override
  String couldNotOpenPdfWithValue(Object error) {
    return 'PDF를 열 수 없습니다: $error';
  }

  @override
  String get savingFilesNotSupportedWeb => '웹에서는 현재 파일 저장이 지원되지 않습니다.';

  @override
  String savedToDocumentsIosWithPath(Object path) {
    return 'Documents(iOS)에 저장됨:\n$path';
  }

  @override
  String savedToFilesWithPath(Object path) {
    return '파일에 저장됨:\n$path';
  }

  @override
  String get open => '열기';

  @override
  String failedToSavePdfWithValue(Object error) {
    return 'PDF 저장 실패: $error';
  }

  @override
  String get openPdfReport => 'PDF 보고서 열기';

  @override
  String get savePdfToDownloads => 'PDF를 다운로드에 저장';

  @override
  String get reportWatermarkNote => '보고서 PDF에는 Styloria 워터마크가 포함되어야 합니다.';

  @override
  String get earningsCategoryAll => 'All Earnings';

  @override
  String get earningsCategoryCompletedServices => 'Completed Service Payments';

  @override
  String get earningsCategoryTips => 'Tips Received';

  @override
  String get earningsCategoryCancellationPenalty =>
      'Cancellation Penalty Income';

  @override
  String get earningsCategoryPending => 'Pending / Processing';

  @override
  String get earningsCategoryInstantCashouts => 'Instant Cashouts';

  @override
  String get earningsCategoryScheduledPayouts => 'Scheduled Payouts';

  @override
  String get earningsCategoryRefunds => 'Refunds / Reversals';

  @override
  String get earningsCategoryAdjustments => 'Adjustments / Corrections';

  @override
  String get earningsTimeFilter => 'Time Period';

  @override
  String get earningsCategoryFilter => 'Category';

  @override
  String get earningsFilteredTotal => 'Filtered Total';

  @override
  String get earningsTotalCredits => 'Total Credits';

  @override
  String get earningsTotalDebits => 'Total Debits';

  @override
  String get earningsNetAmount => 'Net Amount';

  @override
  String earningsTransactionCount(Object count) {
    return '$count transaction(s)';
  }

  @override
  String get earningsNoTransactions => 'No transactions found for this filter.';

  @override
  String get earningsAvailableBalance => 'Available Balance';

  @override
  String get earningsPendingBalance => 'Pending Balance';

  @override
  String get earningsTotalBalance => 'Total Balance';

  @override
  String get earningsLifetimeEarnings => 'Lifetime Earnings';

  @override
  String get earningsLifetimePayouts => 'Lifetime Payouts';

  @override
  String get earningsLoadMore => 'Load more';

  @override
  String get earningsReportSection => 'Generate Report';

  @override
  String get earningsReportDescription =>
      'Download a detailed PDF report for the currently selected filters.';

  @override
  String get referFriendsTitle => '친구 추천';

  @override
  String get shareReferralCodeBody =>
      '추천 코드를 친구와 공유하세요. 나중에 친구가 가입하고 예약을 완료하면 보상을 추가할 수 있습니다.';

  @override
  String get yourReferralCodeLabel => '내 추천 코드:';

  @override
  String get copy => '복사';

  @override
  String referralCodeCopiedWithCode(Object code) {
    return '추천 코드가 복사됨: $code';
  }

  @override
  String get navHome => '홈';

  @override
  String get navBookings => '예약';

  @override
  String get navNotifications => '알림';

  @override
  String get navAccount => '계정';

  @override
  String get welcome => '환영합니다';

  @override
  String welcomeName(Object name) {
    return '$name님, 환영합니다';
  }

  @override
  String get toggleThemeTooltip => '라이트/다크 모드 전환';

  @override
  String loggedInAs(Object role) {
    return '로그인: $role';
  }

  @override
  String locationWithValue(Object value) {
    return '위치: $value';
  }

  @override
  String get homeTagline => '실시간 예약과 신뢰할 수 있는 제공자와 함께 그루밍 경험을 업그레이드하세요.';

  @override
  String get manageProviderProfile => '제공자 프로필 관리';

  @override
  String get browseOpenJobs => '오픈 작업 보기';

  @override
  String get quickActions => '빠른 작업';

  @override
  String get newBooking => '새 예약';

  @override
  String notificationsWithUnread(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count개 읽지 않음',
      one: '1개 읽지 않음',
    );
    return '알림 ($_temp0)';
  }

  @override
  String get liveLocationTrackingTitle => '실시간 위치 추적';

  @override
  String get live => '실시간';

  @override
  String get locationServicesDisabled => '위치 서비스가 비활성화되어 있습니다.';

  @override
  String get locationPermissionDenied => '위치 권한이 거부되었습니다.';

  @override
  String get locationPermissionPermanentlyDenied =>
      '위치 권한이 영구적으로 거부되었습니다. 설정에서 활성화해 주세요.';

  @override
  String failedToGetLocationWithValue(Object error) {
    return '위치를 가져오지 못했습니다: $error';
  }

  @override
  String get youProvider => '나(제공자)';

  @override
  String get youCustomer => '나(고객)';

  @override
  String get customer => '고객';

  @override
  String get bookingDetails => '예약 상세';

  @override
  String get navigate => '길찾기';

  @override
  String get failedToLoadNotifications => '알림을 불러오지 못했습니다.';

  @override
  String get failedToMarkAsRead => '읽음 처리에 실패했습니다';

  @override
  String get noNotificationsYet => '아직 알림이 없습니다.';

  @override
  String get markRead => '읽음';

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
  String get providerKycTitle => '제공자 인증(KYC)';

  @override
  String get logoutTooltip => '로그아웃';

  @override
  String statusLabel(Object status) {
    return '상태: $status';
  }

  @override
  String rejectedWithNotes(Object notes) {
    return '거절됨: $notes';
  }

  @override
  String get kycInstructions => '제공자 기능을 사용하려면 신분증과 셀피를 업로드하여 인증을 완료하세요.';

  @override
  String get idFrontRequired => '신분증 앞면(필수)';

  @override
  String get selectIdFront => '신분증 앞면 선택';

  @override
  String get idBackRequired => '신분증 뒷면(필수)';

  @override
  String get selectIdBackRequired => '신분증 뒷면 선택';

  @override
  String get selfieRequired => '셀피(필수)';

  @override
  String get selectSelfie => '셀피 선택';

  @override
  String get takeSelfie => '셀피 촬영';

  @override
  String get errorUploadAllRequired => '신분증(앞면), 신분증(뒷면), 셀피를 모두 업로드해 주세요.';

  @override
  String failedSubmitKycCode(Object code) {
    return 'KYC 제출에 실패했습니다(코드 $code).';
  }

  @override
  String submittedCurrentStatus(Object status) {
    return '제출됨. 현재 상태: $status';
  }

  @override
  String get unknownStatus => '알 수 없음';

  @override
  String get submitKyc => 'KYC 제출';

  @override
  String get verificationMayTakeTimeNote =>
      '참고: 인증에는 시간이 걸릴 수 있습니다. 승인되면 제공자 기능을 사용할 수 있습니다.';

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
  String get enterVerificationCodeTitle => '인증 코드 입력';

  @override
  String otpSentToUsername(Object username) {
    return '\"$username\"에 연결된 전화번호로 6자리 코드를 보냈습니다.\n';
  }

  @override
  String get sixDigitCodeLabel => '6자리 코드';

  @override
  String get enterSixDigitCodeValidation => '6자리 코드를 입력하세요';

  @override
  String get otpInvalidOrExpired => '코드가 올바르지 않거나 만료되었습니다.';

  @override
  String get failedLoadUserInfoAfterVerification => '인증 후 사용자 정보를 불러오지 못했습니다.';

  @override
  String get chatWithSupportTitle => '지원팀과 채팅';

  @override
  String get unableStartSupportChat => '지원 채팅을 시작할 수 없습니다.';

  @override
  String get invalidSupportThreadReturned => '서버에서 잘못된 지원 스레드를 반환했습니다.';

  @override
  String get noMessagesYet => '아직 메시지가 없습니다. 대화를 시작해 보세요!';

  @override
  String get supportDefaultName => '지원';

  @override
  String get aboutPoliciesTitle => '정보 및 정책';

  @override
  String get newBookingTitle => '새 예약';

  @override
  String get appointmentDetailsTitle => '예약 상세';

  @override
  String get pickDate => '날짜 선택';

  @override
  String get pickTime => '시간 선택';

  @override
  String get serviceTypeTitle => '서비스 유형';

  @override
  String get serviceDropdownLabel => '서비스';

  @override
  String get serviceHaircutLabel => '커트';

  @override
  String get serviceBraidsLabel => '브레이드';

  @override
  String get serviceShaveLabel => '면도';

  @override
  String get serviceHairColoringLabel => '염색';

  @override
  String get serviceManicureLabel => '매니큐어';

  @override
  String get servicePedicureLabel => '페디큐어';

  @override
  String get serviceNailArtLabel => '네일 아트';

  @override
  String get serviceMakeupLabel => '메이크업';

  @override
  String get serviceFacialLabel => '페이셜';

  @override
  String get serviceWaxingLabel => '왁싱';

  @override
  String get serviceMassageLabel => '마사지';

  @override
  String get serviceTattooLabel => 'Tattoo';

  @override
  String get serviceHairStylingLabel => '헤어 스타일링';

  @override
  String get serviceHairTreatmentLabel => '헤어 트리트먼트';

  @override
  String get serviceHairExtensionsLabel => '헤어 익스텐션';

  @override
  String get serviceOtherServicesLabel => '기타 서비스';

  @override
  String get notesForProviderOptionalLabel => '제공자에게 메모(선택)';

  @override
  String get locationTitle => '위치';

  @override
  String get latitudeLabel => '위도';

  @override
  String get longitudeLabel => '경도';

  @override
  String get requiredField => '필수';

  @override
  String get useMyCurrentLocation => '현재 위치 사용';

  @override
  String pricesShownIn(Object symbol, Object country) {
    return '표시 가격: $symbol ($country)';
  }

  @override
  String get chooseTimeLaterThanCurrent => '현재 시간보다 늦은 시간을 선택해 주세요.';

  @override
  String get pleasePickDateAndTime => '날짜와 시간을 선택해 주세요.';

  @override
  String get locationUpdatedFromGps => 'GPS로 위치가 업데이트되었습니다.';

  @override
  String failedToGetLocation(Object error) {
    return '위치를 가져오지 못했습니다: $error';
  }

  @override
  String bookingCreatedChoosePrice(Object id) {
    return '예약이 생성되었습니다! ID: $id • 가격 옵션을 선택하세요.';
  }

  @override
  String get failedToCreateBooking => '예약 생성에 실패했습니다.';

  @override
  String get paymentsNotSupportedLong =>
      '이 플랫폼에서는 결제를 지원하지 않습니다. 실제 결제를 테스트하려면 Android, iOS, macOS 또는 Web에서 실행하세요.';

  @override
  String get noBookingToConfirm => '확인할 예약이 없습니다. 먼저 예약을 생성해 주세요.';

  @override
  String get pleaseChoosePriceOption => '가격 옵션을 선택해 주세요.';

  @override
  String get failedCreatePaymentTryAgain => '서버에서 결제를 생성하지 못했습니다. 다시 시도해 주세요.';

  @override
  String paymentSuccessfulMessage(Object bookingId, Object paid) {
    return '결제 성공!\n예약 #$bookingId • 결제 금액: $paid\n요청이 이제 근처 제공자에게 표시됩니다.';
  }

  @override
  String get paymentSucceededButFailedUpdate =>
      '결제는 성공했지만 서버에서 예약 업데이트에 실패했습니다.';

  @override
  String paymentCancelledOrFailed(Object reason) {
    return '결제가 취소되었거나 실패했습니다: $reason';
  }

  @override
  String unexpectedPaymentError(Object error) {
    return '예기치 않은 결제 오류: $error';
  }

  @override
  String get createBookingButton => '예약 생성';

  @override
  String get chooseYourPriceOptionTitle => '가격 옵션 선택';

  @override
  String transportationCostLabel(Object cost) {
    return '교통비: $cost';
  }

  @override
  String get budgetTierTitle => 'BUDGET';

  @override
  String get standardTierTitle => 'STANDARD';

  @override
  String get priorityTierTitle => 'PRIORITY';

  @override
  String get budgetTierDescription => '근처 제공자 중 최고의 가성비';

  @override
  String get standardTierDescription => '가격과 가용성의 추천 균형';

  @override
  String get priorityTierDescription => '상위 제공자를 더 빠르게 끌어들이는 프리미엄 옵션';

  @override
  String get naShort => '해당 없음';

  @override
  String get priceBreakdownTitle => '가격 구성';

  @override
  String get servicePriceLabel => '서비스 요금';

  @override
  String get transportationLabel => '교통';

  @override
  String serviceFeeLabel(Object percent) {
    return '서비스 수수료($percent%)';
  }

  @override
  String allPricesIn(Object currency, Object country) {
    return '모든 가격: $currency ($country)';
  }

  @override
  String get userCountryPlaceholder => '사용자 국가';

  @override
  String get totalToPayTitle => '결제 총액';

  @override
  String get includesServiceTransportation => '서비스 + 교통 포함';

  @override
  String get confirmAndPay => '확인 및 결제';

  @override
  String get howPricingWorksTitle => '가격 책정 방식';

  @override
  String get howPricingWorksBullets =>
      '• Budget: 근처 제공자 중 최고의 가성비\n• Standard: 추천 기본 옵션\n• Priority: 빠른 수락을 위한 프리미엄 옵션\n• 교통비는 총액에 포함됩니다';

  @override
  String get myBookingsTitle => '내 예약';

  @override
  String get myAssignedJobsTitle => '내 배정 작업';

  @override
  String get pleaseCompleteProviderProfileFirst => '먼저 제공자 프로필을 완료해 주세요.';

  @override
  String get failedToLoadBookings => '예약을 불러오지 못했습니다.';

  @override
  String get profileSetupRequiredTitle => '프로필 설정 필요';

  @override
  String get profileSetupRequiredBody => '배정된 작업과 수익을 보려면 제공자 프로필을 완료해야 합니다.';

  @override
  String get later => '나중에';

  @override
  String get setupNow => '지금 설정';

  @override
  String get noBookingsFound => '예약이 없습니다.';

  @override
  String get findNearbyOpenJobs => '근처 오픈 작업 찾기';

  @override
  String get pay => '결제';

  @override
  String get rate => '평가';

  @override
  String bookingNumber(Object id) {
    return '예약 #$id';
  }

  @override
  String whenOn(Object date) {
    return '일시: $date';
  }

  @override
  String whenAt(Object date, Object time) {
    return '일시: $date $time';
  }

  @override
  String providerLine(Object name) {
    return '제공자: $name';
  }

  @override
  String userLine(Object name) {
    return '사용자: $name';
  }

  @override
  String estimatedPriceLine(Object price) {
    return '예상 금액: $price';
  }

  @override
  String paymentLine(Object status) {
    return '결제: $status';
  }

  @override
  String get paymentUnpaid => '미결제';

  @override
  String get paymentUnknown => '알 수 없음';

  @override
  String get confirmPaymentTitle => '결제 확인';

  @override
  String confirmPaymentBody(Object amount) {
    return '$amount을(를) 결제하여 예약을 확정할까요?';
  }

  @override
  String get yesPay => '예, 결제';

  @override
  String get failedToCreatePaymentIntent => '결제 인텐트를 생성하지 못했습니다.';

  @override
  String get paymentSuccessfulShort => '결제 성공.';

  @override
  String get paymentSucceededButFailedUpdateBooking =>
      '결제는 성공했지만 서버에서 예약 업데이트에 실패했습니다.';

  @override
  String paymentCancelledOrFailedReason(Object reason) {
    return '결제가 취소되었거나 실패했습니다: $reason';
  }

  @override
  String unexpectedPaymentErrorReason(Object error) {
    return '예기치 않은 결제 오류: $error';
  }

  @override
  String rateProviderTitle(Object providerName) {
    return '$providerName 평가';
  }

  @override
  String get selectRatingHelp => '평점을 선택하세요(1 = 나쁨, 5 = 매우 좋음):';

  @override
  String get commentsOptionalLabel => '코멘트(선택)';

  @override
  String get submit => '제출';

  @override
  String get reviewSubmitted => '리뷰가 제출되었습니다.';

  @override
  String get failedSubmitReview => '리뷰 제출에 실패했습니다.';

  @override
  String failedToLoadProfile(Object error) {
    return '프로필을 불러오지 못했습니다: $error';
  }

  @override
  String profileSavedSuccess(Object action) {
    return '프로필이 성공적으로 $action되었습니다!';
  }

  @override
  String genericError(Object error) {
    return '오류: $error';
  }

  @override
  String get locationPermissionDeniedEnableInSettings =>
      '위치 권한이 거부되었습니다. 설정에서 활성화해 주세요.';

  @override
  String get locationPermissionPermanentlyDeniedEnableInAppSettings =>
      '위치 권한이 영구적으로 거부되었습니다. 앱 설정에서 활성화해 주세요.';

  @override
  String errorGettingLocation(Object error) {
    return '위치를 가져오는 중 오류: $error';
  }

  @override
  String get couldNotFindLocationForAddress => '이 주소의 위치를 찾을 수 없습니다';

  @override
  String errorConvertingAddress(Object error) {
    return '주소 변환 오류: $error';
  }

  @override
  String get portfolioUnavailableCompleteKycFirst =>
      '포트폴리오를 사용할 수 없습니다. 제공자라면 먼저 KYC 인증을 완료해 주세요.';

  @override
  String failedToLoadPortfolio(Object error) {
    return '포트폴리오를 불러오지 못했습니다: $error';
  }

  @override
  String get addPhoto => '사진 추가';

  @override
  String get addVideo => '동영상 추가';

  @override
  String get addPost => '게시물 추가';

  @override
  String get captionOptionalTitle => '캡션(선택)';

  @override
  String get captionHintExample => '예: “고객에게 한 노트리스 브레이드”';

  @override
  String get skip => '건너뛰기';

  @override
  String get save => '저장';

  @override
  String get failedToCreatePortfolioPost => '포트폴리오 게시물을 만들지 못했습니다.';

  @override
  String get uploadFailedMediaUpload => '업로드 실패(미디어 업로드).';

  @override
  String uploadFailed(Object error) {
    return '업로드 실패: $error';
  }

  @override
  String get deletePostTitle => '게시물을 삭제할까요?';

  @override
  String get deletePostBody => '포트폴리오에서 해당 게시물이 제거됩니다.';

  @override
  String get delete => '삭제';

  @override
  String get deleteFailed => '삭제에 실패했습니다.';

  @override
  String deleteFailedWithError(Object error) {
    return '삭제 실패: $error';
  }

  @override
  String get portfolioTitle => '포트폴리오';

  @override
  String get noPortfolioPostsYetHelpText =>
      '포트폴리오 게시물이 아직 없습니다. 작업 사진/영상을 추가하면 고객 신뢰에 도움이 됩니다.';

  @override
  String get setupProviderProfileTitle => '제공자 프로필 설정';

  @override
  String get providerProfileTitle => '제공자 프로필';

  @override
  String get welcomeToStyloriaTitle => 'Styloria에 오신 것을 환영합니다!';

  @override
  String get completeProviderProfileToStartEarning =>
      '제공자 프로필을 완료하여 작업을 수락하고 수익을 얻으세요.';

  @override
  String reviewCountLabel(int count) {
    return '($count개 리뷰)';
  }

  @override
  String get topRatedChip => '최고 평점';

  @override
  String get bioLabel => '소개 / 설명';

  @override
  String get bioHint => '고객에게 당신의 기술과 경험을 알려 주세요...';

  @override
  String get pleaseEnterBio => '소개를 입력해 주세요';

  @override
  String bioMinLength(int min) {
    return '소개는 최소 $min자 이상이어야 합니다';
  }

  @override
  String get yourLocationTitle => '내 위치';

  @override
  String get locationHelpMatchNearbyClients => '위치는 근처 고객과 매칭하는 데 도움이 됩니다';

  @override
  String get locationHelpUpdateToFindJobs => '다른 지역에서 일을 찾으려면 위치를 업데이트하세요';

  @override
  String get useMyCurrentLocationTitle => '현재 위치 사용';

  @override
  String get gpsSubtitle => 'GPS로 자동으로 위치 가져오기';

  @override
  String get orLabel => '또는';

  @override
  String get enterYourAddressTitle => '주소 입력';

  @override
  String get fullAddressLabel => '전체 주소';

  @override
  String get fullAddressHint => '예: 123 Main St, Accra, Ghana';

  @override
  String get find => '찾기';

  @override
  String get addressHelpText => '도로명 주소, 도시, 국가를 입력하세요';

  @override
  String get coordinatesAutoFilledTitle => '좌표(자동 입력)';

  @override
  String get servicePricingTitle => '서비스 가격';

  @override
  String get servicePricingHelp =>
      '각 서비스의 가격을 설정하세요. 제공할 수 없는 서비스는 “미제공”을 체크하세요.';

  @override
  String get serviceHeader => '서비스';

  @override
  String get priceHeader => '가격';

  @override
  String get notOfferedHeader => '미제공';

  @override
  String get priceHint => '0.00';

  @override
  String get providerHowPricingWorksTitle => '가격 책정 방식:';

  @override
  String get providerHowPricingWorksBody =>
      '• 당신의 가격은 서비스에 대해 청구하는 금액입니다\n• 교통비 = 사용자 통화의 80% / km\n• 사용자는 근처 제공자 기준 3가지 옵션을 봅니다:\n  - Budget: 최저가\n  - Standard: 평균가\n  - Priority: 최고가';

  @override
  String get availableForBookingsTitle => '예약 가능';

  @override
  String get availableOnHelp => '✓ 근처 고객의 검색 결과에 표시됩니다';

  @override
  String get availableOffHelp => '✗ 새로운 작업 제안을 받지 않습니다';

  @override
  String get completeSetupStartEarning => '설정 완료 및 수익 시작';

  @override
  String get updateProfile => '프로필 업데이트';

  @override
  String get skipForNow => '지금은 건너뛰기';

  @override
  String get paymentsNotSupportedShort =>
      'Payments are not supported on this platform. Please use Android, iOS, macOS, or Web.';

  @override
  String get genericContact => '연락처';

  @override
  String get genericProvider => '서비스 제공자';

  @override
  String get genericNotAvailable => '해당 없음';

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
    return '✓ 위치 확인됨: $country';
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
  String get reviewSelectRatingPrompt => '평점을 선택하세요(1~5).';

  @override
  String get reviewCommentOptionalLabel => '댓글(선택 사항)';

  @override
  String get genericCancel => '취소';

  @override
  String get genericSubmit => '제출';

  @override
  String get reviewSubmitFailed => '리뷰 제출에 실패했습니다.';

  @override
  String get rateThisService => '이 서비스 평가하기';

  @override
  String get tipLeaveTitle => '팁 남기기';

  @override
  String get tipChooseAmountPrompt => '팁 금액을 선택하거나 직접 입력하세요.';

  @override
  String get tipNoTip => '팁 없음';

  @override
  String get tipCustomAmountLabel => '사용자 지정 팁 금액';

  @override
  String get genericContinue => '계속';

  @override
  String get tipSkipped => '팁을 건너뛰었습니다.';

  @override
  String get tipFailedToSaveChoice => '팁 선택을 저장하지 못했습니다.';

  @override
  String get tipFailedToCreatePayment => '팁 결제를 생성하지 못했습니다.';

  @override
  String get tipPaidSuccessfully => '팁 결제가 완료되었습니다. 감사합니다!';

  @override
  String get tipPaidButUpdateFailed => '팁 결제는 성공했지만 예약 업데이트에 실패했습니다.';

  @override
  String tipCancelledOrFailed(Object message) {
    return '팁이 취소/실패했습니다: $message';
  }

  @override
  String tipUnexpectedError(Object error) {
    return '예기치 않은 팁 오류: $error';
  }

  @override
  String get tipAlreadyPaidLabel => '이미 팁을 결제했습니다';

  @override
  String get tipSkippedLabel => '팁 건너뜀';

  @override
  String get tipLeaveButton => '팁 남기기';

  @override
  String get walletTitle => '지갑';

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
  String get walletCashOutFailed => '현금 인출 실패.';

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
  String get signOut => '로그아웃';

  @override
  String get kycIdFrontPhoto => '신분증 앞면 사진';

  @override
  String get kycIdFrontMessage => '신분증 앞면 사진을 촬영하세요';

  @override
  String get kycIdBackPhoto => '신분증 뒷면 사진';

  @override
  String get kycIdBackMessage => '신분증 뒷면 사진을 촬영하세요';

  @override
  String get kycCamera => '카메라';

  @override
  String get kycGallery => '갤러리';

  @override
  String get kycChooseSource => '소스 선택:';

  @override
  String get kycFailedCaptureImage => '이미지 캡처 실패';

  @override
  String get kycFailedCaptureSelfie => '셀카 촬영 실패';

  @override
  String get kycCameraNotAvailable => '카메라를 사용할 수 없습니다';

  @override
  String get kycCameraNotAvailableMessage =>
      '카메라를 사용할 수 없습니다. 대신 갤러리에서 이미지를 선택하시겠습니까?';

  @override
  String get kycUseGallery => '갤러리 사용';

  @override
  String get kycDocumentsLocked =>
      '검토 대기 중인 문서는 잠겨 있습니다. 인증이 완료될 때까지 변경할 수 없습니다.';

  @override
  String get kycVerificationSubmittedSuccessfully => '인증이 성공적으로 제출되었습니다';

  @override
  String get kycVerificationSubmitted => '인증 제출됨';

  @override
  String get kycThankYouSubmitting => '인증 서류를 제출해 주셔서 감사합니다!';

  @override
  String get kycWhatHappensNext => '다음 단계:';

  @override
  String get kycReviewTime => '저희 팀이 24~48시간 이내에 문서를 검토합니다';

  @override
  String get kycEmailNotification => '인증이 완료되면 이메일을 받게 됩니다';

  @override
  String get kycCheckEmail => '인증 상태 업데이트를 위해 이메일을 확인하세요';

  @override
  String get kycLocked => '문서가 잠겨 있으며 검토 중에는 변경할 수 없습니다';

  @override
  String get kycRecommendSignOut => '로그아웃 후 나중에 인증 결과를 확인하시는 것을 권장합니다.';

  @override
  String get kycStaySignedIn => '로그인 유지';

  @override
  String get kycVerificationPending => '인증 대기 중';

  @override
  String get kycVerificationPendingSubtitle => '문서를 검토 중입니다';

  @override
  String get kycVerificationApproved => '인증 승인됨';

  @override
  String get kycVerificationApprovedSubtitle => '이제 모든 제공자 기능에 액세스할 수 있습니다';

  @override
  String get kycVerificationRejected => '인증 거부됨';

  @override
  String get kycVerificationRejectedSubtitle => '아래 메모를 검토하고 다시 제출하세요';

  @override
  String get kycVerificationRequired => '인증 필요';

  @override
  String get kycVerificationRequiredSubtitle => '제공자 기능에 액세스하려면 인증을 완료하세요';

  @override
  String get kycReviewNotes => '검토 메모';

  @override
  String get kycIdCardFront => '신분증 (앞면)';

  @override
  String get kycIdCardBack => '신분증 (뒷면)';

  @override
  String get kycVerificationSelfie => '인증 셀카';

  @override
  String get kycButtonLocked => '잠김';

  @override
  String get kycCaptureIdFront => '신분증 앞면 촬영';

  @override
  String get kycCaptureIdBack => '신분증 뒷면 촬영';

  @override
  String get kycDocumentsLockedButton => '문서 잠김';

  @override
  String get kycTipsTitle => '📸 좋은 사진을 위한 팁:';

  @override
  String get kycTipGoodLighting => '• 좋은 조명을 사용하세요';

  @override
  String get kycTipFlatCard => '• 신분증을 평평한 곳에 놓으세요';

  @override
  String get kycTipReadableText => '• 모든 텍스트가 읽을 수 있는지 확인하세요';

  @override
  String get kycTipFaceCamera => '• 셀카는 카메라를 정면으로 보세요';

  @override
  String get kycTipAvoidGlare => '• 빛 반사나 그림자를 피하세요';

  @override
  String get kycFailedSubmitVerification => '인증 제출 실패';

  @override
  String get paystackSetupTitle => '지급 계정 설정';

  @override
  String get paystackVerifying => '확인 중...';

  @override
  String get paystackVerificationSuccess => '지급 설정이 성공적으로 저장되었습니다!';

  @override
  String get paystackVerificationFailed => '지급 설정 저장 실패';

  @override
  String get paystackSelectBank => '은행 선택';

  @override
  String get paystackAccountNumber => '계좌번호';

  @override
  String get paystackVerifyAccount => '계정 확인';

  @override
  String get paystackAccountVerified => '계정 확인됨';

  @override
  String get paystackSavePayoutAccount => '지급 계정 저장';

  @override
  String paystackNoBanksAvailable(Object country) {
    return '$country에 사용 가능한 은행이 없습니다';
  }

  @override
  String get paystackRetry => '재시도';

  @override
  String get paystackPayoutsInfo => '수익은 이 계정으로 전송됩니다. 지급은 24시간 이내에 처리됩니다.';

  @override
  String get paystackConnected => '계정: 연결됨';

  @override
  String get paystackNotConnected => '계정: 연결되지 않음';

  @override
  String get paystackDetailsSubmitted => '제출된 세부정보:';

  @override
  String get paystackPayoutsEnabled => '지급 활성화:';

  @override
  String get paystackYes => '예';

  @override
  String get paystackNo => '아니오';

  @override
  String get paystackFinishSetup => 'Stripe 설정 완료';

  @override
  String get paystackConnectStripe => 'Stripe 연결';

  @override
  String get paystackOpenDashboard => 'Stripe 대시보드 열기';

  @override
  String get paystackMustFinishSetup => '현금 인출 전에 Stripe 설정을 완료해야 합니다.';

  @override
  String get paystackPayouts => 'Paystack 지급';

  @override
  String get paystackAddBankDetails =>
      'Paystack을 통해 지급을 받으려면 지급 설정에서 은행 계좌 정보를 추가하세요.';

  @override
  String get paystackOpenSettings => '지급 설정 열기';

  @override
  String payoutPaystackForCountry(Object country) {
    return '$country의 Paystack을 통한 지급';
  }

  @override
  String payoutFlutterwaveForCountry(Object country) {
    return '$country의 지급은 Flutterwave를 통해 처리됩니다';
  }

  @override
  String get payoutStripeConnect => 'Stripe Connect';

  @override
  String get payoutBankAccountDetails => '은행 계좌 세부정보';

  @override
  String get payoutAccountHolderName => '예금주명';

  @override
  String get payoutAccountHolderNameHint => '은행 계좌에 표시된 이름을 입력하세요';

  @override
  String get payoutSelectBank => '은행 선택 *';

  @override
  String get payoutBankName => '은행명 *';

  @override
  String get payoutBankNameManual => '은행명 (수동)';

  @override
  String get payoutBankNameHint => '예: GCB Bank, Ecobank';

  @override
  String get payoutBankCode => '은행 코드 *';

  @override
  String get payoutBankCodeManual => '은행 코드 (수동)';

  @override
  String get payoutBankCodeHint => 'Flutterwave 은행 코드';

  @override
  String get payoutBankCodeHelper => '은행 코드를 모르는 경우 지원팀에 문의하세요';

  @override
  String get payoutAccountNumber => '계좌번호 *';

  @override
  String get payoutAccountNumberHint => '은행 계좌번호를 입력하세요';

  @override
  String get payoutMobileMoney => '모바일 머니';

  @override
  String get payoutFullName => '전체 이름 (등록된 대로) *';

  @override
  String get payoutFullNameHint => '모바일 머니 계정에 등록된 이름';

  @override
  String get payoutMobileNetwork => '모바일 네트워크 *';

  @override
  String get payoutSelectNetwork => '모바일 네트워크 선택';

  @override
  String get payoutMobileNetworkHint => '예: MTN, Vodafone, Airtel';

  @override
  String get payoutCountryCode => '국가 코드';

  @override
  String get payoutMobileMoneyNumber => '모바일 머니 번호 *';

  @override
  String get payoutMobileMoneyNumberHint => '예: 0541234567';

  @override
  String get payoutZipCode => '우편번호';

  @override
  String get payoutZipCodeHint => '네트워크에서 필요한 경우';

  @override
  String get payoutMethod => '지급 방법';

  @override
  String get payoutBankTransfer => '은행 송금';

  @override
  String get payoutCurrency => '통화';

  @override
  String payoutCurrencyLocked(Object country) {
    return '$country 통화로 잠김';
  }

  @override
  String get payoutBeneficiaryId => '수취인 ID';

  @override
  String get payoutBeneficiaryIdHint => '선택사항 - 반복 송금용';

  @override
  String get payoutSchedule => '지급 일정';

  @override
  String get payoutFrequency => '지급 빈도';

  @override
  String get payoutFrequencyWeekly => '주간';

  @override
  String get payoutFrequencyMonthly => '월간 (매월 1일)';

  @override
  String get payoutDayHelper => '사용 가능: 화요일, 목요일, 금요일';

  @override
  String get payoutMonthlyInfo => '월간 지급은 매월 1일에 처리됩니다.';

  @override
  String get payoutInstantCashout => '즉시 현금 인출';

  @override
  String get payoutInstantCashoutInfo =>
      '• 무제한 즉시 현금 인출 가능\n• 즉시 현금 인출에 5% 수수료 적용\n• 예약된 지급은 수수료 없음';

  @override
  String get payoutNextScheduled => '다음 예정된 지급';

  @override
  String payoutYourLocalTime(Object timezone) {
    return '현지 시간 ($timezone)';
  }

  @override
  String get payoutAmountToCashOut => '인출 금액';

  @override
  String payoutMinMaxRange(Object min, Object max) {
    return '최소: $min - 최대: $max';
  }

  @override
  String get payoutMaxButton => '최대';

  @override
  String get payoutCashOutNow => '현금 인출 (즉시)';

  @override
  String get payoutAvailableBalance => '사용 가능 잔액';

  @override
  String get payoutPendingFunds => '보류 중';

  @override
  String get payoutPendingInfo => '보류 중인 자금은 보류 기간 후에 사용 가능합니다';

  @override
  String get payoutLifetimeEarnings => '총 수익';

  @override
  String get payoutTotalCashedOut => '총 인출액';

  @override
  String get payoutUnlimitedCashouts => '무제한';

  @override
  String get mainHello => '안녕하세요';

  @override
  String get mainViewProfile => '프로필 보기';

  @override
  String get mainBookings => '예약';

  @override
  String get mainNotifications => '알림';

  @override
  String get mainReferral => '추천';

  @override
  String get mainSettings => '설정';

  @override
  String get mainHelp => '도움말';

  @override
  String get mainWallet => '지갑';

  @override
  String get mainEarnings => '수익';

  @override
  String get mainOpenJobs => '진행 중인 작업';

  @override
  String get mainAssignedJobs => '할당된 작업';

  @override
  String get mainMyReputation => '내 평판';

  @override
  String get reputationTitle => '내 평판';

  @override
  String get reputationYourCustomerRating => '고객 평가';

  @override
  String reputationBasedOnReviews(int count) {
    return '$count개의 리뷰 기반';
  }

  @override
  String get reputationExcellentCustomer => '⭐ 우수 고객';

  @override
  String get reputationGreatCustomer => '👍 훌륭한 고객';

  @override
  String get reputationGoodCustomer => '✓ 좋은 고객';

  @override
  String get reputationAverage => '평균';

  @override
  String get reputationNeedsImprovement => '개선 필요';

  @override
  String get reputationNoRatingYet => '아직 평가 없음';

  @override
  String get reputationWhatProvidersSay => '제공자의 평가';

  @override
  String get reputationNoReviews => '아직 리뷰 없음';

  @override
  String get reputationNoReviewsHelp =>
      '예약을 완료하여 평판을 쌓으세요!\n서비스 완료 후 제공자가 평가합니다.';

  @override
  String reputationShowMore(int count) {
    return '더 보기 ($count개 더)';
  }

  @override
  String get reputationShowLess => '간략히 보기';

  @override
  String get reputationJustNow => '방금';

  @override
  String reputationMinutesAgo(int minutes) {
    return '$minutes분 전';
  }

  @override
  String reputationHoursAgo(int hours) {
    return '$hours시간 전';
  }

  @override
  String reputationDaysAgo(int days) {
    return '$days일 전';
  }

  @override
  String reputationWeeksAgo(int weeks) {
    return '$weeks주 전';
  }

  @override
  String reputationMonthsAgo(int months) {
    return '$months개월 전';
  }

  @override
  String reputationYearsAgo(int years) {
    return '$years년 전';
  }

  @override
  String get notificationsTitle => '알림';

  @override
  String get notificationsNoNotifications => '아직 알림이 없습니다.';
}
