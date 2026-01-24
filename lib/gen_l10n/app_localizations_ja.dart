// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Styloria';

  @override
  String get account => 'アカウント';

  @override
  String get profile => 'プロフィール';

  @override
  String get myBookings => '予約一覧';

  @override
  String get openJobs => '募集中の案件';

  @override
  String get earnings => '収益';

  @override
  String get paymentMethods => '支払い方法';

  @override
  String get referFriends => '友達を紹介';

  @override
  String get language => '言語';

  @override
  String get settings => '設定';

  @override
  String get darkMode => 'ダークモード';

  @override
  String get systemDefault => 'システム設定';

  @override
  String get languageUpdated => '言語を更新しました';

  @override
  String get languageSetToSystemDefault => '言語をシステム設定に戻しました';

  @override
  String get helpAndSupport => 'ヘルプとサポート';

  @override
  String get chatWithCustomerService => 'カスタマーサポートとチャット';

  @override
  String get aboutAndPolicies => 'アプリ情報とポリシー';

  @override
  String get viewUserPoliciesAndAgreements => 'ユーザーポリシーと規約を表示';

  @override
  String get logOut => 'ログアウト';

  @override
  String get deleteAccount => 'アカウント削除';

  @override
  String get deleteAccountSubtitle => 'この操作は取り消せません';

  @override
  String get deleteAccountTitle => 'アカウント削除';

  @override
  String get deleteAccountConfirmBody =>
      'アカウントを削除しますか？\n\nサインアウトされ、今後アクセスできなくなる可能性があります。';

  @override
  String get no => 'いいえ';

  @override
  String get yesDelete => 'はい、削除';

  @override
  String get deleteAccountSheetTitle => 'ご利用ありがとうございました。';

  @override
  String get deleteAccountSheetPrompt => '理由を教えてください（複数選択可）';

  @override
  String get deleteAccountSelectAtLeastOneReason => '少なくとも1つ理由を選択してください。';

  @override
  String get tellUsMoreOptional => '詳細（任意）';

  @override
  String get suggestionsToImproveOptional => '改善の提案（任意）';

  @override
  String get deleteMyAccount => 'アカウントを削除する';

  @override
  String get cancel => 'キャンセル';

  @override
  String get failedToDeleteAccount => 'アカウント削除に失敗しました。もう一度お試しください。';

  @override
  String get choosePreferredLanguage => '希望の言語を選択';

  @override
  String get noteSomeTextMayStillAppearInEnglish =>
      '注：アプリの言語が変更されます。翻訳が追加されるまで一部のテキストは英語のままの場合があります。';

  @override
  String languageSetToName(Object name) {
    return '言語を$nameに設定しました';
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
  String get confirmPassword => 'パスワード確認';

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
  String get deletionReason1 => 'Styloriaが不要になった';

  @override
  String get deletionReason2 => 'アカウント確認（メール/KYC）で問題があった';

  @override
  String get deletionReason3 => '近くのサービス/提供者が見つからなかった';

  @override
  String get deletionReason4 => '価格や手数料が高すぎる／分かりにくい';

  @override
  String get deletionReason5 => 'アプリが分かりにくい／使いにくい';

  @override
  String get deletionReason6 => 'バグやパフォーマンスの問題';

  @override
  String get deletionReason7 => '支払い/返金の問題';

  @override
  String get deletionReason8 => '提供者/ユーザーとの悪い経験';

  @override
  String get deletionReason9 => 'プライバシーまたはセキュリティの懸念';

  @override
  String get deletionReason10 => '誤ってアカウントを作成した';

  @override
  String get deletionReason11 => '別のプラットフォームに移行する';

  @override
  String get deletionReason12 => 'その他';

  @override
  String get loginWelcomeTitle => 'Styloriaへようこそ';

  @override
  String get loginWelcomeSubtitle => '予約やサービスを管理するためにログインしてください。';

  @override
  String get loginFailedToLoadUserInfo => 'ログインは成功しましたが、ユーザー情報の取得に失敗しました。';

  @override
  String get username => 'ユーザー名';

  @override
  String get password => 'パスワード';

  @override
  String get required => '必須';

  @override
  String get login => 'ログイン';

  @override
  String get createNewAccount => '新しいアカウントを作成';

  @override
  String get requestEmailVerificationCode => 'メール確認コードをリクエスト';

  @override
  String get createAccountTitle => 'アカウント作成';

  @override
  String get joinStyloria => 'Styloriaに参加';

  @override
  String get registerSubtitle => 'サービスを予約する、または提供者になるためにアカウントを作成します';

  @override
  String get iWantTo => '希望：';

  @override
  String get bookServices => 'サービスを予約';

  @override
  String get provideServices => 'サービスを提供';

  @override
  String get personalInformation => '個人情報';

  @override
  String get firstName => '名';

  @override
  String get lastName => '姓';

  @override
  String get selectDateOfBirth => '生年月日を選択';

  @override
  String get phoneNumber => '電話番号';

  @override
  String get pleaseEnterPhoneNumber => '電話番号を入力してください';

  @override
  String get accountInformation => 'アカウント情報';

  @override
  String get chooseUniqueUsernameHint => 'ユニークなユーザー名を選択してください';

  @override
  String get youAreCurrentlyUnavailable => '現在利用不可の状態です';

  @override
  String get toBrowseAndAcceptJobsEnableAvailability =>
      '近くの仕事リクエストを閲覧・承諾するには、予約可能に設定する必要があります。';

  @override
  String get goToProfileSettings => 'プロフィール設定へ移動';

  @override
  String get tipToggleAvailableForBookings =>
      'ヒント：プロバイダープロフィールで「予約可能」をオンにすると、仕事リクエストの受信が開始されます。';

  @override
  String requestedBy(String name) {
    return 'リクエスト者：$name';
  }

  @override
  String locationLabel(String address) {
    return '場所：$address';
  }

  @override
  String get email => 'メール';

  @override
  String get emailHint => 'your@email.com';

  @override
  String get enterValidEmail => '有効なメールアドレスを入力してください';

  @override
  String get security => 'セキュリティ';

  @override
  String get passwordHintAtLeast10 => '10文字以上';

  @override
  String get passwordMin10 => 'パスワードは10文字以上である必要があります';

  @override
  String get iAgreeTo => '同意します：';

  @override
  String get termsOfService => '利用規約';

  @override
  String get and => 'および';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get passwordIsRequired => 'パスワードは必須です';

  @override
  String get passwordsDoNotMatch => 'パスワードが一致しません';

  @override
  String get pleaseSelectDob => '生年月日を選択してください。';

  @override
  String get pleaseSelectCountry => '国を選択してください。';

  @override
  String get pleaseSelectCity => '都市を選択してください。';

  @override
  String get pleaseEnterValidPhone => '有効な電話番号を入力してください。';

  @override
  String get mustAcceptTerms => '利用規約に同意する必要があります。';

  @override
  String get mustBeAtLeast18 => '登録するには18歳以上である必要があります。';

  @override
  String get agreeToTerms => '利用規約およびプライバシーポリシーに同意します';

  @override
  String get createAccountButton => 'アカウント作成';

  @override
  String get alreadyHaveAccount => 'すでにアカウントをお持ちですか？';

  @override
  String get emailVerifiedSuccessPleaseLogin => 'メール確認が完了しました。ログインしてください。';

  @override
  String get pleaseVerifyEmailToContinue => '続行するにはメールを確認してください。';

  @override
  String get requestVerificationCodeTitle => '確認コードをリクエスト';

  @override
  String get requestVerificationInstructions =>
      'メールアドレスまたはユーザー名を入力してください。\n該当アカウントのメールに新しい確認コードを送信します。';

  @override
  String get emailOrUsername => 'メールまたはユーザー名';

  @override
  String get sendCode => 'コードを送信';

  @override
  String get ifAccountExistsCodeSent => 'アカウントが存在する場合、コードを送信しました。';

  @override
  String get failedToSendVerificationCode => '確認コードの送信に失敗しました。';

  @override
  String get verifyYourEmailTitle => 'メールを確認';

  @override
  String get verificationCodeSentInfo => 'このアカウントのメールに確認コードを送信しました。';

  @override
  String emailVerificationInstructions(Object identifier) {
    return 'このアカウントのメールに送信された6桁コードを入力してください:\n$identifier';
  }

  @override
  String get verificationCodeLabel => '確認コード';

  @override
  String get sendingEllipsis => '送信中...';

  @override
  String get resendCode => 'コードを再送信';

  @override
  String get enter6DigitCodeError => '6桁のコードを入力してください。';

  @override
  String get verifyingEllipsis => '確認中...';

  @override
  String get verify => '確認';

  @override
  String get invalidOrExpiredCodeTryResending => 'コードが無効または期限切れです。再送信してください。';

  @override
  String bookingTitle(Object id) {
    return '予約 #$id';
  }

  @override
  String get invalidBookingIdForChat => 'チャット用の予約IDが無効です。';

  @override
  String get invalidBookingIdForCall => '通話用の予約IDが無効です。';

  @override
  String get unableToLoadContactInfo => '連絡先情報を読み込めません。予約が有効か確認してください。';

  @override
  String noPhoneNumberAvailableForName(Object name) {
    return '$name の電話番号がありません。';
  }

  @override
  String get deviceCannotPlaceCalls => 'この端末では電話をかけられません。';

  @override
  String get cancelBookingDialogTitle => '予約をキャンセル';

  @override
  String get cancelBookingDialogBody =>
      'この予約を本当にキャンセルしますか？\n\n注意: 提供者がすでに承認し、7分以上（ただし約40分未満）経過している場合、規約によりペナルティが適用される可能性があります。';

  @override
  String get yesCancel => 'はい、キャンセル';

  @override
  String get failedToCancelBooking => '予約のキャンセルに失敗しました。';

  @override
  String bookingCancelledPenaltyApplied(Object amount) {
    return '予約をキャンセルしました。$amount のペナルティが適用されました。';
  }

  @override
  String get bookingCancelledSuccessfully => '予約をキャンセルしました。';

  @override
  String get failedToConfirmCompletion => '完了の確認に失敗しました。もう一度お試しください。';

  @override
  String get bothSidesConfirmedCompletedPayoutReleased =>
      '両者が確認しました。予約は完了としてマークされ、支払いが解放されました。';

  @override
  String get youConfirmedCompletionWaitingForProvider =>
      '完了を確認しました。提供者の確認を待っています。';

  @override
  String get youConfirmedCompletionWaitingForUser =>
      '完了を確認しました。ユーザーの確認を待っています。';

  @override
  String get statusUnknown => '不明';

  @override
  String get statusAccepted => '承認済み';

  @override
  String get statusInProgress => '進行中';

  @override
  String get statusCompleted => '完了';

  @override
  String get statusCancelled => 'キャンセル';

  @override
  String get paymentPaid => '支払い済み';

  @override
  String get paymentPending => '保留';

  @override
  String get paymentFailed => '失敗';

  @override
  String bookingAcceptedBy(Object name) {
    return '$name が予約を承認しました';
  }

  @override
  String get whenLabel => '日時';

  @override
  String atTime(Object time) {
    return '$time に';
  }

  @override
  String get userLabel => 'ユーザー';

  @override
  String get providerLabel => '提供者';

  @override
  String get estimatedPriceLabel => '見積もり価格';

  @override
  String get offeredPaidLabel => '提示 / 支払い';

  @override
  String get distanceLabel => '距離';

  @override
  String distanceMiles(Object miles) {
    return '$miles マイル';
  }

  @override
  String get acceptedAtLabel => '承認時刻';

  @override
  String get cancelledAtLabel => 'キャンセル時刻';

  @override
  String get cancelledByLabel => 'キャンセル者';

  @override
  String penaltyAppliedLabel(Object amount) {
    return '適用されたペナルティ: $amount';
  }

  @override
  String get userConfirmedLabel => 'ユーザー確認';

  @override
  String get providerConfirmedLabel => '提供者確認';

  @override
  String get payoutReleasedLabel => '支払い解放';

  @override
  String get yesLower => 'はい';

  @override
  String get noLower => 'いいえ';

  @override
  String get chat => 'チャット';

  @override
  String get call => '通話';

  @override
  String get actions => '操作';

  @override
  String get confirmCompletion => '完了を確認';

  @override
  String get noFurtherActionsForBooking => 'この予約で実行できる操作はこれ以上ありません。';

  @override
  String freeCancellationEndsIn(Object time) {
    return '無料キャンセル終了まで $time';
  }

  @override
  String get earlyFreeCancellationEndedWarning =>
      '早期の無料キャンセル期間は終了しました。承認後約40分までは、遅いキャンセルにペナルティが発生する場合があります。';

  @override
  String get cancelBooking => '予約をキャンセル';

  @override
  String get cancelBookingNoPenalty => '予約をキャンセル（ペナルティなし）';

  @override
  String get cancelBookingPenaltyMayApply => '予約をキャンセル（ペナルティの可能性）';

  @override
  String get cancellationPolicyInfo =>
      '提供者の承認後最初の7分間はペナルティなしでキャンセルできます。また必要であれば、約40分後にもペナルティなしでキャンセルできます。その間は規約によりペナルティが適用される場合があります。';

  @override
  String ratingLine(Object rating, int reviewCount) {
    String _temp0 = intl.Intl.pluralLogic(
      reviewCount,
      locale: localeName,
      other: 'レビュー$reviewCount件',
      one: 'レビュー1件',
    );
    return '評価: $rating（$_temp0）';
  }

  @override
  String get proofOfSkillsPortfolio => 'スキルの証明（ポートフォリオ）';

  @override
  String get noPortfolioPostsAvailable => 'ポートフォリオ投稿がありません。';

  @override
  String get bookingLocation => '予約場所';

  @override
  String get location => '場所';

  @override
  String get latitude => '緯度';

  @override
  String get longitude => '経度';

  @override
  String get mapWillAppearWhenCoordinatesValid => '座標が有効な場合、ここに地図が表示されます。';

  @override
  String chatForBookingTitle(Object id) {
    return '予約 #$id のチャット';
  }

  @override
  String get unableToStartChat =>
      'チャットを開始できません。チャットは予約が承認済み・進行中、または直近1日以内に完了した場合のみ利用できます。';

  @override
  String get invalidChatThreadFromServer => 'サーバーから無効なチャットスレッドが返されました。';

  @override
  String get messageNotSentPolicy =>
      'メッセージは送信されませんでした。注: チャットで電話番号やメールアドレスを共有することは禁止されています。';

  @override
  String get unknown => '不明';

  @override
  String get typeMessageHint => 'サポートへのメッセージを入力...';

  @override
  String get uploadProfilePicture => 'プロフィール写真をアップロード';

  @override
  String get currentProfilePicture => '現在のプロフィール写真';

  @override
  String get newPicturePreview => '新しい写真のプレビュー';

  @override
  String get chooseImage => '画像を選択';

  @override
  String get upload => 'アップロード';

  @override
  String get noImageBytesFoundWeb => '画像データが見つかりません（Web）。';

  @override
  String get pleasePickAnImageFirst => 'まず画像を選択してください。';

  @override
  String get uploadFailedCheckServerLogs =>
      'アップロードに失敗しました。サーバーログ / トークンを確認してください。';

  @override
  String get profilePictureUploadedSuccessfully => 'プロフィール写真をアップロードしました！';

  @override
  String errorWithValue(Object error) {
    return 'エラー: $error';
  }

  @override
  String get tapToChangeProfilePicture => 'タップしてプロフィール写真を変更';

  @override
  String usernameValue(Object username) {
    return 'ユーザー名: $username';
  }

  @override
  String roleValue(Object role) {
    return '役割: $role';
  }

  @override
  String get dateOfBirthYyyyMmDd => '生年月日（YYYY-MM-DD）';

  @override
  String get saveProfile => 'プロフィールを保存';

  @override
  String get failedToSaveProfile => 'プロフィールの保存に失敗しました。もう一度お試しください。';

  @override
  String get profileUpdated => 'プロフィールが更新されました。';

  @override
  String get completeYourProviderProfile => '提供者プロフィールを完成させてください';

  @override
  String get completeProviderProfileBody =>
      '仕事を受けて収益を得るには、提供者プロフィールを完成させてください。';

  @override
  String get setupProfileNow => 'プロフィールを今すぐ設定';

  @override
  String get doItLater => '後で行う';

  @override
  String get bookingTimerPenaltyPeriodActive => 'ペナルティ期間中';

  @override
  String get bookingTimerFreeCancellationPeriod => '無料キャンセル期間';

  @override
  String bookingTimerTimeRemaining(Object time) {
    return '残り時間: $time';
  }

  @override
  String get bookingTimerCancellingNowPenalty => '今キャンセルすると10%のペナルティが発生します。';

  @override
  String get bookingTimerCancelNoPenalty => 'ペナルティなしでキャンセルできます。';

  @override
  String get myReviewsTitle => '自分のレビュー';

  @override
  String get failedToLoadReviews => 'レビューの読み込みに失敗しました。';

  @override
  String get noReviewsYet => 'まだレビューを投稿していません。';

  @override
  String providerWithName(Object name) {
    return '提供者: $name';
  }

  @override
  String get providerGeneric => '提供者';

  @override
  String ratingWithValue(Object rating) {
    return '評価: $rating';
  }

  @override
  String get nearbyOpenJobsTitle => '近くのオープンジョブ';

  @override
  String get failedToLoadOpenJobsHint =>
      'オープンジョブを読み込めませんでした。\n位置が設定され available=true の提供者プロフィールがあることを確認してください。';

  @override
  String errorLoadingJobsWithValue(Object error) {
    return 'ジョブ読み込みエラー: $error';
  }

  @override
  String get noOpenJobsFoundNearbyTitle => '近くにオープンジョブがありません';

  @override
  String get noOpenJobsFoundNearbyBody =>
      '確認してください:\n- 提供者の位置を設定している\n- 利用可能になっている\n- ユーザーが予約を作成して支払っている';

  @override
  String currencyLabel(Object symbol) {
    return '通貨: $symbol';
  }

  @override
  String pricesShownInCurrency(Object symbol, Object country) {
    return '価格は $symbol（$country）で表示';
  }

  @override
  String jobTitleWithId(Object id) {
    return 'ジョブ #$id';
  }

  @override
  String serviceLine(Object service) {
    return 'サービス: $service';
  }

  @override
  String whenLine(Object date, Object time) {
    return '日時: $date $time';
  }

  @override
  String priceLine(Object price) {
    return '価格: $price';
  }

  @override
  String get acceptJob => 'ジョブを承諾';

  @override
  String get failedToAcceptJob => 'ジョブの承諾に失敗しました。';

  @override
  String get jobAcceptedSuccessfully => 'ジョブを承諾しました。';

  @override
  String get newServiceRequestTitle => '新しいサービス依頼';

  @override
  String get reviewAlreadySubmitted => 'Review submitted ✓';

  @override
  String get offeredPriceLabel => '提示価格';

  @override
  String get offeredPriceHint => '例: 25.00';

  @override
  String get enterValidPrice => '有効な価格を入力してください';

  @override
  String get bookAndPay => '予約して支払う';

  @override
  String bookAndPayAmount(Object amount) {
    return '予約して支払う $amount';
  }

  @override
  String get haircutService => 'ヘアカット';

  @override
  String get stylingService => 'スタイリング';

  @override
  String get timeLabel => '時間:';

  @override
  String get notesLabel => 'メモ';

  @override
  String get requestCreatedAndPaidBroadcast => '依頼が作成され支払いが完了しました。提供者に通知します。';

  @override
  String locationLatLng(Object lat, Object lng) {
    return '場所: $lat, $lng';
  }

  @override
  String get paymentMethodsTitle => '支払い方法';

  @override
  String get paymentPreferencesInfo =>
      'これらの設定は端末にローカル保存されます。実際の支払いはStripe/他のゲートウェイで安全に処理されます。';

  @override
  String get preferredMethodLabel => '希望の方法（国によりローカル決済が選択されます）';

  @override
  String get methodVisaMastercard => 'Visa/Mastercard';

  @override
  String get methodMobileMoney => 'モバイルマネー（Momo/Paystack/アフリカ）';

  @override
  String get methodPaypal => 'PayPal';

  @override
  String get methodApplePayGooglePay => 'Apple Pay/Google Pay';

  @override
  String get methodWeChatPay => 'WeChat Pay（中国）';

  @override
  String get methodAlipay => 'Alipay（中国）';

  @override
  String get methodUnionPay => 'UnionPay（中国）';

  @override
  String get mobileMoneyNumberLabel => 'モバイルマネー番号';

  @override
  String get wechatAlipayIdLabel => 'WeChat/Alipay ID';

  @override
  String get cardLast4DigitsLabel => 'カード下4桁';

  @override
  String get paypalEmailLabel => 'PayPalメール';

  @override
  String get applePayEnabledOnDevice => 'この端末でApple Payが有効';

  @override
  String get savePaymentPreferences => '支払い設定を保存';

  @override
  String get paymentPrefsSavedInfo =>
      '支払い設定をローカルに保存しました。実際の課金は後でStripe/他のゲートウェイで処理されます。';

  @override
  String get failedToLoadImage => '画像の読み込みに失敗しました';

  @override
  String get earningsTitle => '収益';

  @override
  String get couldNotLoadEarningsSummary => '収益サマリーを読み込めませんでした。';

  @override
  String get noData => 'データがありません。';

  @override
  String get retry => '再試行';

  @override
  String get summaryTitle => 'サマリー';

  @override
  String get totalLabel => '合計';

  @override
  String get pendingLabel => '保留中';

  @override
  String get paidLabel => '支払い済み';

  @override
  String get pdfReportTitle => 'PDFレポート';

  @override
  String get periodLabel => '期間';

  @override
  String get periodThisMonth => '今月';

  @override
  String get periodLastMonth => '先月';

  @override
  String get periodYtd => '年初から現在まで';

  @override
  String get periodAllTime => '全期間';

  @override
  String get couldNotDownloadPdfReport => 'PDFレポートをダウンロードできませんでした。';

  @override
  String couldNotOpenPdfWithValue(Object error) {
    return 'PDFを開けませんでした: $error';
  }

  @override
  String get savingFilesNotSupportedWeb => 'Webでは現在ファイル保存がサポートされていません。';

  @override
  String savedToDocumentsIosWithPath(Object path) {
    return 'Documents（iOS）に保存:\n$path';
  }

  @override
  String savedToFilesWithPath(Object path) {
    return 'ファイルに保存:\n$path';
  }

  @override
  String get open => '開く';

  @override
  String failedToSavePdfWithValue(Object error) {
    return 'PDFの保存に失敗しました: $error';
  }

  @override
  String get openPdfReport => 'PDFレポートを開く';

  @override
  String get savePdfToDownloads => 'PDFをダウンロードに保存';

  @override
  String get reportWatermarkNote => 'レポートPDFにはStyloriaの透かしが含まれているはずです。';

  @override
  String get referFriendsTitle => '友だちを紹介';

  @override
  String get shareReferralCodeBody =>
      '紹介コードを友だちに共有しましょう。後で、友だちが登録して予約を完了したら報酬を追加できます。';

  @override
  String get yourReferralCodeLabel => 'あなたの紹介コード:';

  @override
  String get copy => 'コピー';

  @override
  String referralCodeCopiedWithCode(Object code) {
    return '紹介コードをコピーしました: $code';
  }

  @override
  String get navHome => 'ホーム';

  @override
  String get navBookings => '予約';

  @override
  String get navNotifications => '通知';

  @override
  String get navAccount => 'アカウント';

  @override
  String get welcome => 'ようこそ';

  @override
  String welcomeName(Object name) {
    return 'ようこそ、$name';
  }

  @override
  String get toggleThemeTooltip => 'ライト/ダークモード切替';

  @override
  String loggedInAs(Object role) {
    return 'ログイン中: $role';
  }

  @override
  String locationWithValue(Object value) {
    return '場所: $value';
  }

  @override
  String get homeTagline => 'リアルタイム予約と信頼できる提供者で、あなたのグルーミング体験を変えましょう。';

  @override
  String get manageProviderProfile => '提供者プロフィールを管理';

  @override
  String get browseOpenJobs => 'オープンジョブを見る';

  @override
  String get quickActions => 'クイック操作';

  @override
  String get newBooking => '新しい予約';

  @override
  String notificationsWithUnread(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '未読$count件',
      one: '未読1件',
    );
    return '通知（$_temp0）';
  }

  @override
  String get liveLocationTrackingTitle => 'ライブ位置追跡';

  @override
  String get live => 'ライブ';

  @override
  String get locationServicesDisabled => '位置情報サービスが無効です。';

  @override
  String get locationPermissionDenied => '位置情報の権限が拒否されました。';

  @override
  String get locationPermissionPermanentlyDenied =>
      '位置情報の権限が恒久的に拒否されています。設定で有効にしてください。';

  @override
  String failedToGetLocationWithValue(Object error) {
    return '位置情報を取得できませんでした: $error';
  }

  @override
  String get youProvider => 'あなた（提供者）';

  @override
  String get youCustomer => 'あなた（顧客）';

  @override
  String get customer => '顧客';

  @override
  String get bookingDetails => '予約詳細';

  @override
  String get navigate => 'ナビ';

  @override
  String get failedToLoadNotifications => '通知の読み込みに失敗しました。';

  @override
  String get failedToMarkAsRead => '既読にできませんでした';

  @override
  String get noNotificationsYet => '通知はまだありません。';

  @override
  String get markRead => '既読にする';

  @override
  String get providerKycTitle => '提供者の本人確認（KYC）';

  @override
  String get logoutTooltip => 'ログアウト';

  @override
  String statusLabel(Object status) {
    return 'ステータス: $status';
  }

  @override
  String rejectedWithNotes(Object notes) {
    return '却下: $notes';
  }

  @override
  String get kycInstructions => '提供者機能を利用するには、本人確認のために身分証と自撮り写真をアップロードしてください。';

  @override
  String get idFrontRequired => '身分証（表・必須）';

  @override
  String get selectIdFront => '身分証（表）を選択';

  @override
  String get idBackRequired => '身分証（裏・必須）';

  @override
  String get selectIdBackRequired => '身分証（裏）を選択';

  @override
  String get selfieRequired => '自撮り（必須）';

  @override
  String get selectSelfie => '自撮りを選択';

  @override
  String get takeSelfie => '自撮りを撮影';

  @override
  String get errorUploadAllRequired => '身分証（表）、身分証（裏）、自撮り写真をアップロードしてください。';

  @override
  String failedSubmitKycCode(Object code) {
    return 'KYCの送信に失敗しました（コード $code）。';
  }

  @override
  String submittedCurrentStatus(Object status) {
    return '送信しました。現在のステータス: $status';
  }

  @override
  String get unknownStatus => '不明';

  @override
  String get submitKyc => 'KYCを送信';

  @override
  String get verificationMayTakeTimeNote =>
      '注: 確認には時間がかかる場合があります。承認後に提供者機能を利用できます。';

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
  String get enterVerificationCodeTitle => '確認コードを入力';

  @override
  String otpSentToUsername(Object username) {
    return '「$username」に関連付けられた電話番号へ6桁のコードを送信しました。\n';
  }

  @override
  String get sixDigitCodeLabel => '6桁コード';

  @override
  String get enterSixDigitCodeValidation => '6桁のコードを入力してください';

  @override
  String get otpInvalidOrExpired => 'コードが無効、または期限切れです。';

  @override
  String get failedLoadUserInfoAfterVerification => '確認後にユーザー情報を読み込めませんでした。';

  @override
  String get chatWithSupportTitle => 'サポートとチャット';

  @override
  String get unableStartSupportChat => 'サポートチャットを開始できません。';

  @override
  String get invalidSupportThreadReturned => 'サーバーから無効なサポートスレッドが返されました。';

  @override
  String get noMessagesYet => 'まだメッセージがありません。会話を始めましょう！';

  @override
  String get supportDefaultName => 'サポート';

  @override
  String get aboutPoliciesTitle => '概要とポリシー';

  @override
  String get newBookingTitle => '新規予約';

  @override
  String get appointmentDetailsTitle => '予約の詳細';

  @override
  String get pickDate => '日付を選択';

  @override
  String get pickTime => '時間を選択';

  @override
  String get serviceTypeTitle => 'サービス種別';

  @override
  String get serviceDropdownLabel => 'サービス';

  @override
  String get serviceHaircutLabel => 'カット';

  @override
  String get serviceBraidsLabel => '編み込み';

  @override
  String get serviceShaveLabel => 'シェービング';

  @override
  String get serviceHairColoringLabel => 'ヘアカラー';

  @override
  String get serviceManicureLabel => 'マニキュア';

  @override
  String get servicePedicureLabel => 'ペディキュア';

  @override
  String get serviceNailArtLabel => 'ネイルアート';

  @override
  String get serviceMakeupLabel => 'メイク';

  @override
  String get serviceFacialLabel => 'フェイシャル';

  @override
  String get serviceWaxingLabel => 'ワックス脱毛';

  @override
  String get serviceMassageLabel => 'マッサージ';

  @override
  String get serviceTattooLabel => 'Tattoo';

  @override
  String get serviceHairStylingLabel => 'ヘアスタイリング';

  @override
  String get serviceHairTreatmentLabel => 'ヘアトリートメント';

  @override
  String get serviceHairExtensionsLabel => 'エクステ';

  @override
  String get serviceOtherServicesLabel => 'その他のサービス';

  @override
  String get notesForProviderOptionalLabel => '担当者へのメモ（任意）';

  @override
  String get locationTitle => '場所';

  @override
  String get latitudeLabel => '緯度';

  @override
  String get longitudeLabel => '経度';

  @override
  String get requiredField => '必須';

  @override
  String get useMyCurrentLocation => '現在地を使用';

  @override
  String pricesShownIn(Object symbol, Object country) {
    return '表示通貨: $symbol（$country）';
  }

  @override
  String get chooseTimeLaterThanCurrent => '現在時刻より後の時間を選択してください。';

  @override
  String get pleasePickDateAndTime => '日付と時間を選択してください。';

  @override
  String get locationUpdatedFromGps => 'GPSから位置情報を更新しました。';

  @override
  String failedToGetLocation(Object error) {
    return '位置情報の取得に失敗しました: $error';
  }

  @override
  String bookingCreatedChoosePrice(Object id) {
    return '予約を作成しました！ID: $id • 価格オプションを選択してください。';
  }

  @override
  String get failedToCreateBooking => '予約の作成に失敗しました。';

  @override
  String get paymentsNotSupportedLong =>
      'このプラットフォームでは支払いがサポートされていません。Android、iOS、macOS、またはWebで実行して支払いをテストしてください。';

  @override
  String get noBookingToConfirm => '確定する予約がありません。先に予約を作成してください。';

  @override
  String get pleaseChoosePriceOption => '価格オプションを選択してください。';

  @override
  String get failedCreatePaymentTryAgain => 'サーバーで支払いの作成に失敗しました。もう一度お試しください。';

  @override
  String paymentSuccessfulMessage(Object bookingId, Object paid) {
    return '支払いが完了しました！\n予約 #$bookingId • 支払額: $paid\nリクエストは近くの提供者に表示されます。';
  }

  @override
  String get paymentSucceededButFailedUpdate => '支払いは成功しましたが、サーバーで予約更新に失敗しました。';

  @override
  String paymentCancelledOrFailed(Object reason) {
    return '支払いがキャンセルまたは失敗しました: $reason';
  }

  @override
  String unexpectedPaymentError(Object error) {
    return '予期しない支払いエラー: $error';
  }

  @override
  String get createBookingButton => '予約を作成';

  @override
  String get chooseYourPriceOptionTitle => '価格オプションを選択';

  @override
  String transportationCostLabel(Object cost) {
    return '交通費: $cost';
  }

  @override
  String get budgetTierTitle => 'BUDGET';

  @override
  String get standardTierTitle => 'STANDARD';

  @override
  String get priorityTierTitle => 'PRIORITY';

  @override
  String get budgetTierDescription => '近くの提供者の中で最もお得';

  @override
  String get standardTierDescription => '価格と空き状況のおすすめバランス';

  @override
  String get priorityTierDescription => 'より早く優良提供者を呼び込むプレミアムオプション';

  @override
  String get naShort => 'N/A';

  @override
  String get priceBreakdownTitle => '料金内訳';

  @override
  String get servicePriceLabel => 'サービス料金';

  @override
  String get transportationLabel => '交通';

  @override
  String serviceFeeLabel(Object percent) {
    return 'サービス手数料（$percent%）';
  }

  @override
  String allPricesIn(Object currency, Object country) {
    return 'すべての価格: $currency（$country）';
  }

  @override
  String get userCountryPlaceholder => 'ユーザーの国';

  @override
  String get totalToPayTitle => '支払い合計';

  @override
  String get includesServiceTransportation => 'サービス＋交通費込み';

  @override
  String get confirmAndPay => '確定して支払う';

  @override
  String get howPricingWorksTitle => '価格の仕組み';

  @override
  String get howPricingWorksBullets =>
      '• Budget: 近くで最もお得\n• Standard: 推奨デフォルト\n• Priority: 承認を早めるプレミアム\n• 交通費は合計に含まれます';

  @override
  String get myBookingsTitle => '自分の予約';

  @override
  String get myAssignedJobsTitle => '割り当てられた仕事';

  @override
  String get pleaseCompleteProviderProfileFirst => '先に提供者プロフィールを完了してください。';

  @override
  String get failedToLoadBookings => '予約の読み込みに失敗しました。';

  @override
  String get profileSetupRequiredTitle => 'プロフィール設定が必要です';

  @override
  String get profileSetupRequiredBody =>
      '割り当てられた仕事と収益を表示する前に、提供者プロフィールを完了する必要があります。';

  @override
  String get later => '後で';

  @override
  String get setupNow => '今すぐ設定';

  @override
  String get noBookingsFound => '予約が見つかりません。';

  @override
  String get findNearbyOpenJobs => '近くの公開案件を探す';

  @override
  String get pay => '支払う';

  @override
  String get rate => '評価';

  @override
  String bookingNumber(Object id) {
    return '予約 #$id';
  }

  @override
  String whenOn(Object date) {
    return '日時: $date';
  }

  @override
  String whenAt(Object date, Object time) {
    return '日時: $date $time';
  }

  @override
  String providerLine(Object name) {
    return '提供者: $name';
  }

  @override
  String userLine(Object name) {
    return 'ユーザー: $name';
  }

  @override
  String estimatedPriceLine(Object price) {
    return '見積価格: $price';
  }

  @override
  String paymentLine(Object status) {
    return '支払い: $status';
  }

  @override
  String get paymentUnpaid => '未払い';

  @override
  String get paymentUnknown => '不明';

  @override
  String get confirmPaymentTitle => '支払いを確認';

  @override
  String confirmPaymentBody(Object amount) {
    return '$amount を支払ってこの予約を確定しますか？';
  }

  @override
  String get yesPay => 'はい、支払う';

  @override
  String get failedToCreatePaymentIntent => '支払いインテントの作成に失敗しました。';

  @override
  String get paymentSuccessfulShort => '支払いが完了しました。';

  @override
  String get paymentSucceededButFailedUpdateBooking =>
      '支払いは成功しましたが、サーバーで予約更新に失敗しました。';

  @override
  String paymentCancelledOrFailedReason(Object reason) {
    return '支払いがキャンセルまたは失敗しました: $reason';
  }

  @override
  String unexpectedPaymentErrorReason(Object error) {
    return '予期しない支払いエラー: $error';
  }

  @override
  String rateProviderTitle(Object providerName) {
    return '$providerName を評価';
  }

  @override
  String get selectRatingHelp => '評価を選択してください（1 = 悪い、5 = 最高）:';

  @override
  String get commentsOptionalLabel => 'コメント（任意）';

  @override
  String get submit => '送信';

  @override
  String get reviewSubmitted => 'レビューを送信しました。';

  @override
  String get failedSubmitReview => 'レビューの送信に失敗しました。';

  @override
  String failedToLoadProfile(Object error) {
    return 'プロフィールの読み込みに失敗しました: $error';
  }

  @override
  String profileSavedSuccess(Object action) {
    return 'プロフィールを$actionしました！';
  }

  @override
  String genericError(Object error) {
    return 'エラー: $error';
  }

  @override
  String get locationPermissionDeniedEnableInSettings =>
      '位置情報の権限が拒否されました。設定で有効にしてください。';

  @override
  String get locationPermissionPermanentlyDeniedEnableInAppSettings =>
      '位置情報の権限が恒久的に拒否されています。アプリ設定で有効にしてください。';

  @override
  String errorGettingLocation(Object error) {
    return '位置情報の取得エラー: $error';
  }

  @override
  String get pleaseEnterAddress => '住所を入力してください';

  @override
  String get locationUpdatedFromAddress => '住所から位置情報を更新しました';

  @override
  String get couldNotFindLocationForAddress => 'この住所の位置情報が見つかりませんでした';

  @override
  String errorConvertingAddress(Object error) {
    return '住所変換エラー: $error';
  }

  @override
  String get portfolioUnavailableCompleteKycFirst =>
      'ポートフォリオを利用できません。提供者の場合は先にKYC認証を完了してください。';

  @override
  String failedToLoadPortfolio(Object error) {
    return 'ポートフォリオの読み込みに失敗しました: $error';
  }

  @override
  String get addPhoto => '写真を追加';

  @override
  String get addVideo => '動画を追加';

  @override
  String get addPost => '投稿を追加';

  @override
  String get captionOptionalTitle => 'キャプション（任意）';

  @override
  String get captionHintExample => '例：「お客様へのノットレスブレイズ」';

  @override
  String get skip => 'スキップ';

  @override
  String get save => '保存';

  @override
  String get failedToCreatePortfolioPost => 'ポートフォリオ投稿の作成に失敗しました。';

  @override
  String get uploadFailedMediaUpload => 'アップロードに失敗しました（メディア）。';

  @override
  String uploadFailed(Object error) {
    return 'アップロードに失敗しました: $error';
  }

  @override
  String get deletePostTitle => '投稿を削除しますか？';

  @override
  String get deletePostBody => 'ポートフォリオから投稿が削除されます。';

  @override
  String get delete => '削除';

  @override
  String get deleteFailed => '削除に失敗しました。';

  @override
  String deleteFailedWithError(Object error) {
    return '削除に失敗しました: $error';
  }

  @override
  String get portfolioTitle => 'ポートフォリオ';

  @override
  String get noPortfolioPostsYetHelpText =>
      'ポートフォリオ投稿はまだありません。作品の写真/動画を追加して、スキルへの信頼を高めましょう。';

  @override
  String get setupProviderProfileTitle => '提供者プロフィールの設定';

  @override
  String get providerProfileTitle => '提供者プロフィール';

  @override
  String get welcomeToStyloriaTitle => 'Styloriaへようこそ！';

  @override
  String get completeProviderProfileToStartEarning =>
      '提供者プロフィールを完成させて、仕事を受けて収益を得ましょう。';

  @override
  String reviewCountLabel(int count) {
    return '（$count件のレビュー）';
  }

  @override
  String get topRatedChip => '高評価';

  @override
  String get bioLabel => '自己紹介 / 説明';

  @override
  String get bioHint => 'スキルや経験をお客様に伝えましょう...';

  @override
  String get pleaseEnterBio => '自己紹介を入力してください';

  @override
  String bioMinLength(int min) {
    return '自己紹介は最低$min文字必要です';
  }

  @override
  String get yourLocationTitle => '現在地';

  @override
  String get locationHelpMatchNearbyClients => '位置情報は近くのお客様とのマッチングに役立ちます';

  @override
  String get locationHelpUpdateToFindJobs => '別のエリアで仕事を探すには位置情報を更新してください';

  @override
  String get useMyCurrentLocationTitle => '現在地を使用';

  @override
  String get gpsSubtitle => 'GPSで自動的に位置情報を取得';

  @override
  String get orLabel => 'または';

  @override
  String get enterYourAddressTitle => '住所を入力';

  @override
  String get fullAddressLabel => '住所（全文）';

  @override
  String get fullAddressHint => '例：123 Main St, Accra, Ghana';

  @override
  String get find => '検索';

  @override
  String get addressHelpText => '住所（通り/都市/国）を入力してください';

  @override
  String get coordinatesAutoFilledTitle => '座標（自動入力）';

  @override
  String get servicePricingTitle => 'サービス料金';

  @override
  String get servicePricingHelp =>
      '各サービスの料金を設定してください。提供できないサービスは「未提供」をチェックしてください。';

  @override
  String get serviceHeader => 'サービス';

  @override
  String get priceHeader => '料金';

  @override
  String get notOfferedHeader => '未提供';

  @override
  String get priceHint => '0.00';

  @override
  String get providerHowPricingWorksTitle => '料金の仕組み：';

  @override
  String get providerHowPricingWorksBody =>
      '• あなたの価格はサービス料金です\n• 交通費 = ユーザー通貨の80%/km\n• ユーザーは近くの提供者に基づく3つの選択肢を見ます:\n  - Budget: 最低価格\n  - Standard: 平均価格\n  - Priority: 最高価格';

  @override
  String get availableForBookingsTitle => '予約受付中';

  @override
  String get availableOnHelp => '✓ 近くのお客様の検索結果に表示されます';

  @override
  String get availableOffHelp => '✗ 新しい仕事のオファーを受け取りません';

  @override
  String get completeSetupStartEarning => '設定を完了して収益を開始';

  @override
  String get updateProfile => 'プロフィールを更新';

  @override
  String get skipForNow => '今はスキップ';

  @override
  String get paymentsNotSupportedShort =>
      'Payments are not supported on this platform. Please use Android, iOS, macOS, or Web.';

  @override
  String get genericContact => '連絡先';

  @override
  String get genericProvider => '提供者';

  @override
  String get genericNotAvailable => '該当なし';

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
  String get reviewSelectRatingPrompt => '評価（1〜5）を選択してください。';

  @override
  String get reviewCommentOptionalLabel => 'コメント（任意）';

  @override
  String get genericCancel => 'キャンセル';

  @override
  String get genericSubmit => '送信';

  @override
  String get reviewSubmitFailed => 'レビューの送信に失敗しました。';

  @override
  String get rateThisService => 'このサービスを評価';

  @override
  String get tipLeaveTitle => 'チップを渡す';

  @override
  String get tipChooseAmountPrompt => 'チップ金額を選ぶか、カスタム金額を入力してください。';

  @override
  String get tipNoTip => 'チップなし';

  @override
  String get tipCustomAmountLabel => 'カスタムチップ金額';

  @override
  String get genericContinue => '続行';

  @override
  String get tipSkipped => 'チップをスキップしました。';

  @override
  String get tipFailedToSaveChoice => 'チップの選択を保存できませんでした。';

  @override
  String get tipFailedToCreatePayment => 'チップ支払いを作成できませんでした。';

  @override
  String get tipPaidSuccessfully => 'チップの支払いが完了しました。ありがとうございます！';

  @override
  String get tipPaidButUpdateFailed => 'チップの支払いは成功しましたが、予約の更新に失敗しました。';

  @override
  String tipCancelledOrFailed(Object message) {
    return 'チップがキャンセル/失敗しました：$message';
  }

  @override
  String tipUnexpectedError(Object error) {
    return '予期しないチップエラー：$error';
  }

  @override
  String get tipAlreadyPaidLabel => 'チップは支払い済みです';

  @override
  String get tipSkippedLabel => 'チップをスキップ';

  @override
  String get tipLeaveButton => 'チップを渡す';

  @override
  String get walletTitle => 'ウォレット';

  @override
  String get walletTooltip => 'ウォレット';

  @override
  String get payoutSettingsTitle => '振込設定';

  @override
  String get payoutSettingsTooltip => '振込設定';

  @override
  String get walletNoWalletYet => 'ウォレットはまだありません。仕事を完了すると収益が反映されます。';

  @override
  String get walletCurrencyFieldLabel => '通貨';

  @override
  String walletAvailableLine(Object amount, Object currency) {
    return '利用可能: $amount $currency';
  }

  @override
  String walletPendingLine(Object amount, Object currency) {
    return '保留中: $amount $currency';
  }

  @override
  String get walletCashOutInstant => '即時出金';

  @override
  String get walletCashOutFailed => '出金に失敗しました。';

  @override
  String walletCashOutSentTransfer(Object transferId) {
    return '出金を送信しました。送金: $transferId';
  }

  @override
  String get walletTransactionsTitle => '取引履歴';

  @override
  String get walletNoTransactionsYet => '取引はまだありません。';

  @override
  String get payoutAutoPayoutsTitle => '自動振込';

  @override
  String get payoutAutoPayoutsSubtitle => '選択したスケジュールで自動的に振り込みます。';

  @override
  String get payoutDayUtcLabel => '振込曜日(UTC)';

  @override
  String get payoutHourUtcLabel => '振込時間(UTC)';

  @override
  String get payoutMinimumAmountLabel => '自動振込の最小金額';

  @override
  String get payoutMinimumAmountHelper => '利用可能残高がこの金額以上の場合のみ自動振込が実行されます。';

  @override
  String get payoutInstantCashOutEnabledTitle => '即時出金を有効にする';

  @override
  String get payoutInstantCashOutEnabledSubtitle =>
      '「即時出金」ボタンを許可します（手数料がかかります）。';

  @override
  String get payoutSettingsSaved => '振込設定を保存しました。';

  @override
  String get payoutSettingsSaveFailed => '振込設定の保存に失敗しました。';

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
