// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Styloria';

  @override
  String get account => '账户';

  @override
  String get profile => '个人资料';

  @override
  String get myBookings => '我的预约';

  @override
  String get openJobs => '开放订单';

  @override
  String get earnings => '收入';

  @override
  String get paymentMethods => '支付方式';

  @override
  String get referFriends => '邀请好友';

  @override
  String get language => '语言';

  @override
  String get settings => '设置';

  @override
  String get darkMode => '深色模式';

  @override
  String get systemDefault => '系统默认';

  @override
  String get languageUpdated => '语言已更新';

  @override
  String get languageSetToSystemDefault => '语言已设置为系统默认';

  @override
  String get helpAndSupport => '帮助与支持';

  @override
  String get chatWithCustomerService => '与客服聊天';

  @override
  String get aboutAndPolicies => '关于与政策';

  @override
  String get viewUserPoliciesAndAgreements => '查看用户政策与协议';

  @override
  String get logOut => '退出登录';

  @override
  String get deleteAccount => '删除账户';

  @override
  String get deleteAccountSubtitle => '此操作无法撤销';

  @override
  String get deleteAccountTitle => '删除账户';

  @override
  String get deleteAccountConfirmBody =>
      '确定要删除你的账户吗？\n\n此操作将使你退出登录，并且你可能会永久失去访问权限。';

  @override
  String get no => '否';

  @override
  String get yesDelete => '是，删除';

  @override
  String get deleteAccountSheetTitle => '很遗憾看到你离开。';

  @override
  String get deleteAccountSheetPrompt => '可以告诉我们原因吗？（可多选）';

  @override
  String get deleteAccountSelectAtLeastOneReason => '请至少选择一个原因。';

  @override
  String get tellUsMoreOptional => '进一步说明（可选）';

  @override
  String get suggestionsToImproveOptional => '改进建议（可选）';

  @override
  String get deleteMyAccount => '删除我的账户';

  @override
  String get cancel => '取消';

  @override
  String get failedToDeleteAccount => '删除账户失败。请重试。';

  @override
  String get choosePreferredLanguage => '选择你的首选语言';

  @override
  String get noteSomeTextMayStillAppearInEnglish =>
      '注意：这将更改应用语言。在添加翻译之前，部分文字可能仍显示为英文。';

  @override
  String languageSetToName(Object name) {
    return '语言已设置为$name';
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
  String get confirmPassword => '确认密码';

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
  String get deletionReason1 => '我不再需要Styloria';

  @override
  String get deletionReason2 => '我在验证账户时遇到问题（邮箱/KYC）';

  @override
  String get deletionReason3 => '我找不到附近的服务/服务商';

  @override
  String get deletionReason4 => '价格或费用过高/不清晰';

  @override
  String get deletionReason5 => '应用令人困惑/难以使用';

  @override
  String get deletionReason6 => 'Bug或性能问题';

  @override
  String get deletionReason7 => '支付/退款问题';

  @override
  String get deletionReason8 => '与服务商/用户的不良体验';

  @override
  String get deletionReason9 => '隐私或安全担忧';

  @override
  String get deletionReason10 => '我误创建了此账户';

  @override
  String get deletionReason11 => '我正在转向其他平台';

  @override
  String get deletionReason12 => '其他';

  @override
  String get loginWelcomeTitle => '欢迎使用 Styloria';

  @override
  String get loginWelcomeSubtitle => '登录以管理你的预约和服务。';

  @override
  String get loginFailedToLoadUserInfo => '登录成功，但无法加载用户信息。';

  @override
  String get username => '用户名';

  @override
  String get password => '密码';

  @override
  String get required => '必填';

  @override
  String get login => '登录';

  @override
  String get createNewAccount => '创建新账户';

  @override
  String get requestEmailVerificationCode => '请求邮箱验证码';

  @override
  String get createAccountTitle => '创建账户';

  @override
  String get joinStyloria => '加入 Styloria';

  @override
  String get registerSubtitle => '创建账户以预约服务或成为服务提供者';

  @override
  String get iWantTo => '我想：';

  @override
  String get bookServices => '预约服务';

  @override
  String get provideServices => '提供服务';

  @override
  String get personalInformation => '个人信息';

  @override
  String get firstName => '名';

  @override
  String get lastName => '姓';

  @override
  String get selectDateOfBirth => '选择出生日期';

  @override
  String get phoneNumber => '电话号码';

  @override
  String get pleaseEnterPhoneNumber => '请输入电话号码';

  @override
  String get accountInformation => '账户信息';

  @override
  String get chooseUniqueUsernameHint => '选择一个唯一的用户名';

  @override
  String get youAreCurrentlyUnavailable => '您目前不可用';

  @override
  String get toBrowseAndAcceptJobsEnableAvailability =>
      '要浏览和接受附近的工作请求，您需要将自己设置为可预约状态。';

  @override
  String get goToProfileSettings => '前往个人资料设置';

  @override
  String get tipToggleAvailableForBookings =>
      '提示：在您的服务提供者个人资料中开启「可接受预约」以开始接收工作请求。';

  @override
  String requestedBy(String name) {
    return '请求者：$name';
  }

  @override
  String locationLabel(String address) {
    return '位置：$address';
  }

  @override
  String get email => '邮箱';

  @override
  String get emailHint => 'your@email.com';

  @override
  String get enterValidEmail => '请输入有效的邮箱';

  @override
  String get security => '安全';

  @override
  String get passwordHintAtLeast10 => '至少10个字符';

  @override
  String get passwordMin10 => '密码必须至少包含10个字符';

  @override
  String get iAgreeTo => '我同意';

  @override
  String get termsOfService => '服务条款';

  @override
  String get and => '和';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get passwordIsRequired => '需要密码';

  @override
  String get passwordsDoNotMatch => '两次密码不一致';

  @override
  String get pleaseSelectDob => '请选择你的出生日期。';

  @override
  String get pleaseSelectCountry => '请选择你的国家。';

  @override
  String get pleaseSelectCity => '请选择你的城市。';

  @override
  String get pleaseEnterValidPhone => '请输入有效的电话号码。';

  @override
  String get mustAcceptTerms => '你必须同意条款与条件。';

  @override
  String get mustBeAtLeast18 => '注册需要年满 18 岁。';

  @override
  String get agreeToTerms => '我同意服务条款和隐私政策';

  @override
  String get createAccountButton => '创建账户';

  @override
  String get alreadyHaveAccount => '已有账户？';

  @override
  String get emailVerifiedSuccessPleaseLogin => '邮箱验证成功。请登录。';

  @override
  String get pleaseVerifyEmailToContinue => '请先验证邮箱以继续。';

  @override
  String get requestVerificationCodeTitle => '请求验证码';

  @override
  String get requestVerificationInstructions =>
      '请输入你的邮箱或用户名。\n我们会向该账户绑定的邮箱发送新的验证码。';

  @override
  String get emailOrUsername => '邮箱或用户名';

  @override
  String get sendCode => '发送验证码';

  @override
  String get ifAccountExistsCodeSent => '如果该账户存在，验证码已发送。';

  @override
  String get failedToSendVerificationCode => '发送验证码失败。';

  @override
  String get verifyYourEmailTitle => '验证你的邮箱';

  @override
  String get verificationCodeSentInfo => '验证码已发送到该账户的邮箱。';

  @override
  String emailVerificationInstructions(Object identifier) {
    return '请输入发送到该账户邮箱的 6 位验证码：\n$identifier';
  }

  @override
  String get verificationCodeLabel => '验证码';

  @override
  String get sendingEllipsis => '发送中...';

  @override
  String get resendCode => '重新发送验证码';

  @override
  String get enter6DigitCodeError => '请输入 6 位验证码。';

  @override
  String get verifyingEllipsis => '验证中...';

  @override
  String get verify => '验证';

  @override
  String get invalidOrExpiredCodeTryResending => '验证码无效或已过期。请尝试重新发送。';

  @override
  String bookingTitle(Object id) {
    return '预约 #$id';
  }

  @override
  String get invalidBookingIdForChat => '用于聊天的预约 ID 无效。';

  @override
  String get invalidBookingIdForCall => '用于通话的预约 ID 无效。';

  @override
  String get unableToLoadContactInfo => '无法加载联系信息。请确认预约处于有效状态。';

  @override
  String noPhoneNumberAvailableForName(Object name) {
    return '无法获取 $name 的电话号码。';
  }

  @override
  String get deviceCannotPlaceCalls => '此设备无法拨打电话。';

  @override
  String get cancelBookingDialogTitle => '取消预约';

  @override
  String get cancelBookingDialogBody =>
      '你确定要取消此预约吗？\n\n注意：如果服务者已接受并且已超过 7 分钟（但少于约 40 分钟），可能会根据规则收取罚金。';

  @override
  String get yesCancel => '是，取消';

  @override
  String get failedToCancelBooking => '取消预约失败。';

  @override
  String bookingCancelledPenaltyApplied(Object amount) {
    return '预约已取消。已收取 $amount 的罚金。';
  }

  @override
  String get bookingCancelledSuccessfully => '预约取消成功。';

  @override
  String get failedToConfirmCompletion => '确认完成失败，请重试。';

  @override
  String get bothSidesConfirmedCompletedPayoutReleased =>
      '双方已确认。预约已标记为完成，款项已释放。';

  @override
  String get youConfirmedCompletionWaitingForProvider => '你已确认完成，正在等待服务者确认。';

  @override
  String get youConfirmedCompletionWaitingForUser => '你已确认完成，正在等待用户确认。';

  @override
  String get statusUnknown => '未知';

  @override
  String get statusAccepted => '已接受';

  @override
  String get statusInProgress => '进行中';

  @override
  String get statusCompleted => '已完成';

  @override
  String get statusCancelled => '已取消';

  @override
  String get paymentPaid => '已支付';

  @override
  String get paymentPending => '待处理';

  @override
  String get paymentFailed => '失败';

  @override
  String bookingAcceptedBy(Object name) {
    return '预约已由 $name 接受';
  }

  @override
  String get whenLabel => '时间';

  @override
  String atTime(Object time) {
    return '$time';
  }

  @override
  String get userLabel => '用户';

  @override
  String get providerLabel => '服务者';

  @override
  String get estimatedPriceLabel => '预估价格';

  @override
  String get offeredPaidLabel => '报价 / 已付';

  @override
  String get distanceLabel => '距离';

  @override
  String distanceMiles(Object miles) {
    return '$miles 英里';
  }

  @override
  String get acceptedAtLabel => '接受时间';

  @override
  String get cancelledAtLabel => '取消时间';

  @override
  String get cancelledByLabel => '取消方';

  @override
  String penaltyAppliedLabel(Object amount) {
    return '已收取罚金：$amount';
  }

  @override
  String get userConfirmedLabel => '用户已确认';

  @override
  String get providerConfirmedLabel => '服务者已确认';

  @override
  String get payoutReleasedLabel => '款项已释放';

  @override
  String get yesLower => '是';

  @override
  String get noLower => '否';

  @override
  String get chat => '聊天';

  @override
  String get call => '拨打电话';

  @override
  String get actions => '操作';

  @override
  String get confirmCompletion => '确认完成';

  @override
  String get noFurtherActionsForBooking => '该预约没有可进行的后续操作。';

  @override
  String freeCancellationEndsIn(Object time) {
    return '免费取消倒计时：$time';
  }

  @override
  String get earlyFreeCancellationEndedWarning =>
      '早期免费取消已结束。在接受后约 40 分钟内，晚取消可能会产生罚金。';

  @override
  String get cancelBooking => '取消预约';

  @override
  String get cancelBookingNoPenalty => '取消预约（无罚金）';

  @override
  String get cancelBookingPenaltyMayApply => '取消预约（可能有罚金）';

  @override
  String get cancellationPolicyInfo =>
      '服务者接受后前 7 分钟内可无罚金取消；如有需要，约 40 分钟后也可无罚金取消。在两者之间取消，可能会按规则收取罚金。';

  @override
  String ratingLine(Object rating, int reviewCount) {
    String _temp0 = intl.Intl.pluralLogic(
      reviewCount,
      locale: localeName,
      other: '$reviewCount 条评价',
      one: '1 条评价',
    );
    return '评分：$rating（$_temp0）';
  }

  @override
  String get proofOfSkillsPortfolio => '技能证明（作品集）';

  @override
  String get noPortfolioPostsAvailable => '暂无作品集内容。';

  @override
  String get bookingLocation => '预约位置';

  @override
  String get location => '位置';

  @override
  String get latitude => '纬度';

  @override
  String get longitude => '经度';

  @override
  String get mapWillAppearWhenCoordinatesValid => '当坐标有效时，地图将显示在此处。';

  @override
  String chatForBookingTitle(Object id) {
    return '预约 #$id 的聊天';
  }

  @override
  String get unableToStartChat => '无法开始聊天。聊天仅在预约被接受、进行中，或在最近一天内完成时可用。';

  @override
  String get invalidChatThreadFromServer => '服务器返回的聊天会话无效。';

  @override
  String get messageNotSentPolicy => '消息未发送。注意：聊天中不允许分享电话号码或邮箱。';

  @override
  String get unknown => '未知';

  @override
  String get typeMessageHint => '输入要发送给支持的消息...';

  @override
  String get uploadProfilePicture => '上传头像';

  @override
  String get currentProfilePicture => '当前头像';

  @override
  String get newPicturePreview => '新头像预览';

  @override
  String get chooseImage => '选择图片';

  @override
  String get upload => '上传';

  @override
  String get noImageBytesFoundWeb => '未找到图片字节（Web）。';

  @override
  String get pleasePickAnImageFirst => '请先选择一张图片。';

  @override
  String get uploadFailedCheckServerLogs => '上传失败。请检查服务器日志 / token。';

  @override
  String get profilePictureUploadedSuccessfully => '头像上传成功！';

  @override
  String errorWithValue(Object error) {
    return '错误：$error';
  }

  @override
  String get tapToChangeProfilePicture => '点击更换头像';

  @override
  String usernameValue(Object username) {
    return '用户名：$username';
  }

  @override
  String roleValue(Object role) {
    return '角色：$role';
  }

  @override
  String get dateOfBirthYyyyMmDd => '出生日期（YYYY-MM-DD）';

  @override
  String get saveProfile => '保存资料';

  @override
  String get failedToSaveProfile => '保存资料失败。请重试。';

  @override
  String get profileUpdated => '资料已更新。';

  @override
  String get completeYourProviderProfile => '完善你的服务者资料';

  @override
  String get completeProviderProfileBody => '要开始接单并赚钱，请先完善你的服务者资料。';

  @override
  String get setupProfileNow => '现在完善资料';

  @override
  String get doItLater => '稍后再说';

  @override
  String get bookingTimerPenaltyPeriodActive => '罚金期已开始';

  @override
  String get bookingTimerFreeCancellationPeriod => '免费取消期';

  @override
  String bookingTimerTimeRemaining(Object time) {
    return '剩余时间：$time';
  }

  @override
  String get bookingTimerCancellingNowPenalty => '现在取消将产生 10% 的罚金。';

  @override
  String get bookingTimerCancelNoPenalty => '你可以无罚金取消。';

  @override
  String get myReviewsTitle => '我的评价';

  @override
  String get failedToLoadReviews => '加载评价失败。';

  @override
  String get noReviewsYet => '你还没有留下任何评价。';

  @override
  String providerWithName(Object name) {
    return '服务者：$name';
  }

  @override
  String get providerGeneric => '服务者';

  @override
  String ratingWithValue(Object rating) {
    return '评分：$rating';
  }

  @override
  String get nearbyOpenJobsTitle => '附近可接订单';

  @override
  String get failedToLoadOpenJobsHint =>
      '加载可接订单失败。\n请确保你有服务者资料、已设置位置且 available=true。';

  @override
  String errorLoadingJobsWithValue(Object error) {
    return '加载订单出错：$error';
  }

  @override
  String get noOpenJobsFoundNearbyTitle => '附近没有可接订单';

  @override
  String get noOpenJobsFoundNearbyBody =>
      '请确认：\n- 你已设置服务者位置\n- 你已标记为可接单\n- 用户已创建并支付预约';

  @override
  String currencyLabel(Object symbol) {
    return '货币：$symbol';
  }

  @override
  String pricesShownInCurrency(Object symbol, Object country) {
    return '价格以 $symbol（$country）显示';
  }

  @override
  String jobTitleWithId(Object id) {
    return '订单 #$id';
  }

  @override
  String serviceLine(Object service) {
    return '服务：$service';
  }

  @override
  String whenLine(Object date, Object time) {
    return '时间：$date $time';
  }

  @override
  String priceLine(Object price) {
    return '价格：$price';
  }

  @override
  String get acceptJob => '接单';

  @override
  String get failedToAcceptJob => '接单失败。';

  @override
  String get jobAcceptedSuccessfully => '接单成功。';

  @override
  String get newServiceRequestTitle => '新建服务请求';

  @override
  String get reviewAlreadySubmitted => 'Review submitted ✓';

  @override
  String get offeredPriceLabel => '出价';

  @override
  String get offeredPriceHint => '例如 25.00';

  @override
  String get enterValidPrice => '请输入有效价格';

  @override
  String get bookAndPay => '预约并支付';

  @override
  String bookAndPayAmount(Object amount) {
    return '预约并支付 $amount';
  }

  @override
  String get haircutService => '理发';

  @override
  String get stylingService => '造型';

  @override
  String get timeLabel => '时间：';

  @override
  String get notesLabel => '备注';

  @override
  String get requestCreatedAndPaidBroadcast => '请求已创建并支付！已向服务者广播。';

  @override
  String locationLatLng(Object lat, Object lng) {
    return '位置：$lat, $lng';
  }

  @override
  String get paymentMethodsTitle => '支付方式';

  @override
  String get paymentPreferencesInfo =>
      '这些偏好设置保存在你的设备本地。实际支付将通过 Stripe/其他网关安全处理。';

  @override
  String get preferredMethodLabel => '首选方式（根据国家选择本地网关）';

  @override
  String get methodVisaMastercard => 'Visa/Mastercard';

  @override
  String get methodMobileMoney => '移动支付（Momo/Paystack/非洲）';

  @override
  String get methodPaypal => 'PayPal';

  @override
  String get methodApplePayGooglePay => 'Apple Pay/Google Pay';

  @override
  String get methodWeChatPay => '微信支付（中国）';

  @override
  String get methodAlipay => '支付宝（中国）';

  @override
  String get methodUnionPay => '银联卡（中国）';

  @override
  String get mobileMoneyNumberLabel => '移动支付号码';

  @override
  String get wechatAlipayIdLabel => '微信/支付宝 ID';

  @override
  String get cardLast4DigitsLabel => '卡号后四位';

  @override
  String get paypalEmailLabel => 'PayPal 邮箱';

  @override
  String get applePayEnabledOnDevice => '此设备已启用 Apple Pay';

  @override
  String get savePaymentPreferences => '保存支付偏好';

  @override
  String get paymentPrefsSavedInfo => '支付偏好已保存到本地。实际扣款稍后由 Stripe/其他网关处理。';

  @override
  String get failedToLoadImage => '图片加载失败';

  @override
  String get earningsTitle => '收益';

  @override
  String get couldNotLoadEarningsSummary => '无法加载收益汇总。';

  @override
  String get noData => '暂无数据。';

  @override
  String get retry => '重试';

  @override
  String get summaryTitle => '汇总';

  @override
  String get totalLabel => '合计';

  @override
  String get pendingLabel => '待处理';

  @override
  String get paidLabel => '已支付';

  @override
  String get pdfReportTitle => 'PDF 报告';

  @override
  String get periodLabel => '周期';

  @override
  String get periodThisMonth => '本月';

  @override
  String get periodLastMonth => '上月';

  @override
  String get periodYtd => '年初至今';

  @override
  String get periodAllTime => '全部时间';

  @override
  String get couldNotDownloadPdfReport => '无法下载 PDF 报告。';

  @override
  String couldNotOpenPdfWithValue(Object error) {
    return '无法打开 PDF：$error';
  }

  @override
  String get savingFilesNotSupportedWeb => 'Web 端暂不支持保存文件。';

  @override
  String savedToDocumentsIosWithPath(Object path) {
    return '已保存到 Documents（iOS）：\n$path';
  }

  @override
  String savedToFilesWithPath(Object path) {
    return '已保存到文件：\n$path';
  }

  @override
  String get open => '打开';

  @override
  String failedToSavePdfWithValue(Object error) {
    return '保存 PDF 失败：$error';
  }

  @override
  String get openPdfReport => '打开 PDF 报告';

  @override
  String get savePdfToDownloads => '保存 PDF 到下载';

  @override
  String get reportWatermarkNote => '报告 PDF 应包含 Styloria 水印。';

  @override
  String get referFriendsTitle => '邀请好友';

  @override
  String get shareReferralCodeBody => '把你的邀请码分享给好友。之后你可以在他们注册并完成预约后添加奖励。';

  @override
  String get yourReferralCodeLabel => '你的邀请码：';

  @override
  String get copy => '复制';

  @override
  String referralCodeCopiedWithCode(Object code) {
    return '邀请码已复制：$code';
  }

  @override
  String get navHome => '首页';

  @override
  String get navBookings => '预约';

  @override
  String get navNotifications => '通知';

  @override
  String get navAccount => '账户';

  @override
  String get welcome => '欢迎';

  @override
  String welcomeName(Object name) {
    return '欢迎，$name';
  }

  @override
  String get toggleThemeTooltip => '切换浅色/深色模式';

  @override
  String loggedInAs(Object role) {
    return '登录身份：$role';
  }

  @override
  String locationWithValue(Object value) {
    return '位置：$value';
  }

  @override
  String get homeTagline => '通过实时预约与可信服务者，升级你的护理体验。';

  @override
  String get manageProviderProfile => '管理服务者资料';

  @override
  String get browseOpenJobs => '浏览可接订单';

  @override
  String get quickActions => '快捷操作';

  @override
  String get newBooking => '新建预约';

  @override
  String notificationsWithUnread(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 条未读',
      one: '1 条未读',
    );
    return '通知（$_temp0）';
  }

  @override
  String get liveLocationTrackingTitle => '实时位置追踪';

  @override
  String get live => '实时';

  @override
  String get locationServicesDisabled => '定位服务已关闭。';

  @override
  String get locationPermissionDenied => '定位权限被拒绝。';

  @override
  String get locationPermissionPermanentlyDenied => '定位权限被永久拒绝。请在设置中启用。';

  @override
  String failedToGetLocationWithValue(Object error) {
    return '获取位置失败：$error';
  }

  @override
  String get youProvider => '你（服务者）';

  @override
  String get youCustomer => '你（客户）';

  @override
  String get customer => '客户';

  @override
  String get bookingDetails => '预约详情';

  @override
  String get navigate => '导航';

  @override
  String get failedToLoadNotifications => '加载通知失败。';

  @override
  String get failedToMarkAsRead => '标记为已读失败';

  @override
  String get noNotificationsYet => '暂无通知。';

  @override
  String get markRead => '标记已读';

  @override
  String get providerKycTitle => '服务者认证（KYC）';

  @override
  String get logoutTooltip => '退出登录';

  @override
  String statusLabel(Object status) {
    return '状态：$status';
  }

  @override
  String rejectedWithNotes(Object notes) {
    return '已拒绝：$notes';
  }

  @override
  String get kycInstructions => '要使用服务者功能，请上传身份证件和自拍照进行验证。';

  @override
  String get idFrontRequired => '身份证正面（必填）';

  @override
  String get selectIdFront => '选择身份证正面';

  @override
  String get idBackRequired => '身份证背面（必填）';

  @override
  String get selectIdBackRequired => '选择身份证背面';

  @override
  String get selfieRequired => '自拍（必填）';

  @override
  String get selectSelfie => '选择自拍';

  @override
  String get takeSelfie => '拍摄自拍';

  @override
  String get errorUploadAllRequired => '请上传身份证（正面）、身份证（背面）和一张自拍照。';

  @override
  String failedSubmitKycCode(Object code) {
    return '提交 KYC 失败（代码 $code）。';
  }

  @override
  String submittedCurrentStatus(Object status) {
    return '已提交。当前状态：$status';
  }

  @override
  String get unknownStatus => '未知';

  @override
  String get submitKyc => '提交 KYC';

  @override
  String get verificationMayTakeTimeNote => '注意：验证可能需要一些时间。通过后即可使用服务者功能。';

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
  String get enterVerificationCodeTitle => '输入验证码';

  @override
  String otpSentToUsername(Object username) {
    return '我们已向与“$username”关联的手机号发送了 6 位验证码。\n';
  }

  @override
  String get sixDigitCodeLabel => '6 位验证码';

  @override
  String get enterSixDigitCodeValidation => '请输入 6 位验证码';

  @override
  String get otpInvalidOrExpired => '验证码无效或已过期。';

  @override
  String get failedLoadUserInfoAfterVerification => '验证后加载用户信息失败。';

  @override
  String get chatWithSupportTitle => '联系支持';

  @override
  String get unableStartSupportChat => '无法开始支持聊天。';

  @override
  String get invalidSupportThreadReturned => '服务器返回的支持会话无效。';

  @override
  String get noMessagesYet => '还没有消息。开始对话吧！';

  @override
  String get supportDefaultName => '支持';

  @override
  String get aboutPoliciesTitle => '关于与政策';

  @override
  String get newBookingTitle => '新建预约';

  @override
  String get appointmentDetailsTitle => '预约详情';

  @override
  String get pickDate => '选择日期';

  @override
  String get pickTime => '选择时间';

  @override
  String get serviceTypeTitle => '服务类型';

  @override
  String get serviceDropdownLabel => '服务';

  @override
  String get serviceHaircutLabel => '理发';

  @override
  String get serviceBraidsLabel => '编发';

  @override
  String get serviceShaveLabel => '剃须';

  @override
  String get serviceHairColoringLabel => '染发';

  @override
  String get serviceManicureLabel => '美甲';

  @override
  String get servicePedicureLabel => '修脚';

  @override
  String get serviceNailArtLabel => '美甲彩绘';

  @override
  String get serviceMakeupLabel => '化妆';

  @override
  String get serviceFacialLabel => '面部护理';

  @override
  String get serviceWaxingLabel => '脱毛';

  @override
  String get serviceMassageLabel => '按摩';

  @override
  String get serviceTattooLabel => 'Tattoo';

  @override
  String get serviceHairStylingLabel => '发型造型';

  @override
  String get serviceHairTreatmentLabel => '头发护理';

  @override
  String get serviceHairExtensionsLabel => '接发';

  @override
  String get serviceOtherServicesLabel => '其他服务';

  @override
  String get notesForProviderOptionalLabel => '给服务者的备注（可选）';

  @override
  String get locationTitle => '位置';

  @override
  String get latitudeLabel => '纬度';

  @override
  String get longitudeLabel => '经度';

  @override
  String get requiredField => '必填';

  @override
  String get useMyCurrentLocation => '使用我的当前位置';

  @override
  String pricesShownIn(Object symbol, Object country) {
    return '价格以 $symbol 显示（$country）';
  }

  @override
  String get chooseTimeLaterThanCurrent => '请选择晚于当前时间的时间。';

  @override
  String get pleasePickDateAndTime => '请选择日期和时间。';

  @override
  String get locationUpdatedFromGps => '已通过 GPS 更新位置。';

  @override
  String failedToGetLocation(Object error) {
    return '获取位置失败：$error';
  }

  @override
  String bookingCreatedChoosePrice(Object id) {
    return '预约已创建！ID：$id • 请选择价格选项。';
  }

  @override
  String get failedToCreateBooking => '创建预约失败。';

  @override
  String get paymentsNotSupportedLong =>
      '此平台不支持支付。请在 Android、iOS、macOS 或 Web 上运行应用以测试真实支付。';

  @override
  String get noBookingToConfirm => '没有可确认的预约。请先创建预约。';

  @override
  String get pleaseChoosePriceOption => '请选择一个价格选项。';

  @override
  String get failedCreatePaymentTryAgain => '服务器创建支付失败。请重试。';

  @override
  String paymentSuccessfulMessage(Object bookingId, Object paid) {
    return '支付成功！\n预约 #$bookingId • 已支付：$paid\n你的请求现在对附近的服务者可见。';
  }

  @override
  String get paymentSucceededButFailedUpdate => '支付成功，但更新预约到服务器失败。';

  @override
  String paymentCancelledOrFailed(Object reason) {
    return '支付已取消或失败：$reason';
  }

  @override
  String unexpectedPaymentError(Object error) {
    return '意外的支付错误：$error';
  }

  @override
  String get createBookingButton => '创建预约';

  @override
  String get chooseYourPriceOptionTitle => '选择你的价格选项';

  @override
  String transportationCostLabel(Object cost) {
    return '交通费用：$cost';
  }

  @override
  String get budgetTierTitle => '经济';

  @override
  String get standardTierTitle => '标准';

  @override
  String get priorityTierTitle => '优先';

  @override
  String get budgetTierDescription => '附近服务者中最划算';

  @override
  String get standardTierDescription => '价格与可用性的推荐平衡';

  @override
  String get priorityTierDescription => '高级选项，更快吸引优质服务者';

  @override
  String get naShort => '不适用';

  @override
  String get priceBreakdownTitle => '价格明细';

  @override
  String get servicePriceLabel => '服务费用';

  @override
  String get transportationLabel => '交通';

  @override
  String serviceFeeLabel(Object percent) {
    return '服务费（$percent%）';
  }

  @override
  String allPricesIn(Object currency, Object country) {
    return '所有价格以 $currency（$country）计';
  }

  @override
  String get userCountryPlaceholder => '用户国家/地区';

  @override
  String get totalToPayTitle => '应付总额';

  @override
  String get includesServiceTransportation => '包含服务 + 交通';

  @override
  String get confirmAndPay => '确认并支付';

  @override
  String get howPricingWorksTitle => '定价说明';

  @override
  String get howPricingWorksBullets =>
      '• 经济：附近最划算\n• 标准：推荐默认\n• 优先：高级选项，加快接单\n• 交通费用已包含在总价中';

  @override
  String get myBookingsTitle => '我的预约';

  @override
  String get myAssignedJobsTitle => '我被分配的工作';

  @override
  String get pleaseCompleteProviderProfileFirst => '请先完成你的服务者资料。';

  @override
  String get failedToLoadBookings => '加载预约失败。';

  @override
  String get profileSetupRequiredTitle => '需要完善资料';

  @override
  String get profileSetupRequiredBody => '在查看已分配工作和收益之前，你需要先完善服务者资料。';

  @override
  String get later => '稍后';

  @override
  String get setupNow => '现在设置';

  @override
  String get noBookingsFound => '未找到预约。';

  @override
  String get findNearbyOpenJobs => '查找附近的公开工作';

  @override
  String get pay => '支付';

  @override
  String get rate => '评价';

  @override
  String bookingNumber(Object id) {
    return '预约 #$id';
  }

  @override
  String whenOn(Object date) {
    return '时间：$date';
  }

  @override
  String whenAt(Object date, Object time) {
    return '时间：$date $time';
  }

  @override
  String providerLine(Object name) {
    return '服务者：$name';
  }

  @override
  String userLine(Object name) {
    return '用户：$name';
  }

  @override
  String estimatedPriceLine(Object price) {
    return '预估价格：$price';
  }

  @override
  String paymentLine(Object status) {
    return '支付：$status';
  }

  @override
  String get paymentUnpaid => '未支付';

  @override
  String get paymentUnknown => '未知';

  @override
  String get confirmPaymentTitle => '确认支付';

  @override
  String confirmPaymentBody(Object amount) {
    return '支付 $amount 以确认该预约？';
  }

  @override
  String get yesPay => '是，支付';

  @override
  String get failedToCreatePaymentIntent => '创建支付意图失败。';

  @override
  String get paymentSuccessfulShort => '支付成功。';

  @override
  String get paymentSucceededButFailedUpdateBooking => '支付成功，但更新预约到服务器失败。';

  @override
  String paymentCancelledOrFailedReason(Object reason) {
    return '支付已取消或失败：$reason';
  }

  @override
  String unexpectedPaymentErrorReason(Object error) {
    return '意外的支付错误：$error';
  }

  @override
  String rateProviderTitle(Object providerName) {
    return '为$providerName评分';
  }

  @override
  String get selectRatingHelp => '选择评分（1 = 差，5 = 优）：';

  @override
  String get commentsOptionalLabel => '评论（可选）';

  @override
  String get submit => '提交';

  @override
  String get reviewSubmitted => '评价已提交。';

  @override
  String get failedSubmitReview => '提交评价失败。';

  @override
  String failedToLoadProfile(Object error) {
    return '加载资料失败：$error';
  }

  @override
  String profileSavedSuccess(Object action) {
    return '资料$action成功！';
  }

  @override
  String genericError(Object error) {
    return '错误：$error';
  }

  @override
  String get locationPermissionDeniedEnableInSettings => '定位权限被拒绝。请在设置中启用。';

  @override
  String get locationPermissionPermanentlyDeniedEnableInAppSettings =>
      '定位权限被永久拒绝。请在应用设置中启用。';

  @override
  String errorGettingLocation(Object error) {
    return '获取位置出错：$error';
  }

  @override
  String get pleaseEnterAddress => '请输入地址';

  @override
  String get locationUpdatedFromAddress => '已根据地址更新位置';

  @override
  String get couldNotFindLocationForAddress => '无法找到该地址的位置';

  @override
  String errorConvertingAddress(Object error) {
    return '转换地址出错：$error';
  }

  @override
  String get portfolioUnavailableCompleteKycFirst =>
      '作品集不可用。如果你是服务者，请先完成 KYC 认证。';

  @override
  String failedToLoadPortfolio(Object error) {
    return '加载作品集失败：$error';
  }

  @override
  String get addPhoto => '添加照片';

  @override
  String get addVideo => '添加视频';

  @override
  String get addPost => '添加作品';

  @override
  String get captionOptionalTitle => '说明（可选）';

  @override
  String get captionHintExample => '例如：“给客户做的无结编发”';

  @override
  String get skip => '跳过';

  @override
  String get save => '保存';

  @override
  String get failedToCreatePortfolioPost => '创建作品集条目失败。';

  @override
  String get uploadFailedMediaUpload => '上传失败（媒体上传）。';

  @override
  String uploadFailed(Object error) {
    return '上传失败：$error';
  }

  @override
  String get deletePostTitle => '删除该作品？';

  @override
  String get deletePostBody => '这将从你的作品集中移除该作品。';

  @override
  String get delete => '删除';

  @override
  String get deleteFailed => '删除失败。';

  @override
  String deleteFailedWithError(Object error) {
    return '删除失败：$error';
  }

  @override
  String get portfolioTitle => '作品集';

  @override
  String get noPortfolioPostsYetHelpText => '还没有作品。添加你的工作照片/视频，帮助客户更信任你的技能。';

  @override
  String get setupProviderProfileTitle => '设置服务者资料';

  @override
  String get providerProfileTitle => '服务者资料';

  @override
  String get welcomeToStyloriaTitle => '欢迎来到 Styloria！';

  @override
  String get completeProviderProfileToStartEarning => '完善你的服务者资料，开始接单并赚钱。';

  @override
  String reviewCountLabel(int count) {
    return '（$count 条评价）';
  }

  @override
  String get topRatedChip => '高评分';

  @override
  String get bioLabel => '简介 / 描述';

  @override
  String get bioHint => '向客户介绍你的技能与经验...';

  @override
  String get pleaseEnterBio => '请输入简介';

  @override
  String bioMinLength(int min) {
    return '简介至少需要 $min 个字符';
  }

  @override
  String get yourLocationTitle => '你的位置';

  @override
  String get locationHelpMatchNearbyClients => '你的位置有助于匹配附近客户';

  @override
  String get locationHelpUpdateToFindJobs => '更新位置以在不同区域寻找工作';

  @override
  String get useMyCurrentLocationTitle => '使用我的当前位置';

  @override
  String get gpsSubtitle => '通过 GPS 自动获取位置';

  @override
  String get orLabel => '或';

  @override
  String get enterYourAddressTitle => '输入你的地址';

  @override
  String get fullAddressLabel => '完整地址';

  @override
  String get fullAddressHint => '例如：123 Main St, Accra, Ghana';

  @override
  String get find => '查找';

  @override
  String get addressHelpText => '输入街道、城市和国家/地区';

  @override
  String get coordinatesAutoFilledTitle => '坐标（自动填写）';

  @override
  String get servicePricingTitle => '服务定价';

  @override
  String get servicePricingHelp => '为每项服务设置价格。无法提供的服务请勾选“未提供”。';

  @override
  String get serviceHeader => '服务';

  @override
  String get priceHeader => '价格';

  @override
  String get notOfferedHeader => '未提供';

  @override
  String get priceHint => '0.00';

  @override
  String get providerHowPricingWorksTitle => '定价说明：';

  @override
  String get providerHowPricingWorksBody =>
      '• 你的价格是你对该服务收取的费用\n• 交通费用 = 用户币种的 80% / 公里\n• 用户会根据附近服务者看到 3 个选项：\n  - 经济：最低价\n  - 标准：平均价\n  - 优先：最高价';

  @override
  String get availableForBookingsTitle => '可接受预约';

  @override
  String get availableOnHelp => '✓ 你会出现在附近客户的搜索结果中';

  @override
  String get availableOffHelp => '✗ 你将不会收到新的工作邀约';

  @override
  String get completeSetupStartEarning => '完成设置并开始赚钱';

  @override
  String get updateProfile => '更新资料';

  @override
  String get skipForNow => '暂时跳过';

  @override
  String get paymentsNotSupportedShort =>
      'Payments are not supported on this platform. Please use Android, iOS, macOS, or Web.';

  @override
  String get genericContact => '联系人';

  @override
  String get genericProvider => '服务提供者';

  @override
  String get genericNotAvailable => '无';

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
  String get reviewSelectRatingPrompt => '请选择评分（1 到 5）。';

  @override
  String get reviewCommentOptionalLabel => '评论（可选）';

  @override
  String get genericCancel => '取消';

  @override
  String get genericSubmit => '提交';

  @override
  String get reviewSubmitFailed => '评价提交失败。';

  @override
  String get rateThisService => '评价此服务';

  @override
  String get tipLeaveTitle => '打赏小费';

  @override
  String get tipChooseAmountPrompt => '选择小费金额，或输入自定义金额。';

  @override
  String get tipNoTip => '不打赏';

  @override
  String get tipCustomAmountLabel => '自定义小费金额';

  @override
  String get genericContinue => '继续';

  @override
  String get tipSkipped => '已跳过小费。';

  @override
  String get tipFailedToSaveChoice => '无法保存小费选择。';

  @override
  String get tipFailedToCreatePayment => '无法创建小费支付。';

  @override
  String get tipPaidSuccessfully => '小费支付成功。谢谢！';

  @override
  String get tipPaidButUpdateFailed => '小费支付成功，但更新订单失败。';

  @override
  String tipCancelledOrFailed(Object message) {
    return '小费已取消/失败：$message';
  }

  @override
  String tipUnexpectedError(Object error) {
    return '小费发生意外错误：$error';
  }

  @override
  String get tipAlreadyPaidLabel => '小费已支付';

  @override
  String get tipSkippedLabel => '已跳过小费';

  @override
  String get tipLeaveButton => '打赏小费';

  @override
  String get walletTitle => '钱包';

  @override
  String get walletTooltip => '钱包';

  @override
  String get payoutSettingsTitle => '提现设置';

  @override
  String get payoutSettingsTooltip => '提现设置';

  @override
  String get walletNoWalletYet => '暂无钱包。完成订单后即可获得收入。';

  @override
  String get walletCurrencyFieldLabel => '币种';

  @override
  String walletAvailableLine(Object amount, Object currency) {
    return '可用：$amount $currency';
  }

  @override
  String walletPendingLine(Object amount, Object currency) {
    return '待处理：$amount $currency';
  }

  @override
  String get walletCashOutInstant => '立即提现';

  @override
  String get walletCashOutFailed => '提现失败。';

  @override
  String walletCashOutSentTransfer(Object transferId) {
    return '提现已提交。转账：$transferId';
  }

  @override
  String get walletTransactionsTitle => '交易记录';

  @override
  String get walletNoTransactionsYet => '暂无交易记录。';

  @override
  String get payoutAutoPayoutsTitle => '自动提现';

  @override
  String get payoutAutoPayoutsSubtitle => '按您选择的计划自动发起提现。';

  @override
  String get payoutDayUtcLabel => '提现日（UTC）';

  @override
  String get payoutHourUtcLabel => '提现时间（UTC）';

  @override
  String get payoutMinimumAmountLabel => '自动提现最低金额';

  @override
  String get payoutMinimumAmountHelper => '仅当可用余额 ≥ 该金额时才会自动提现。';

  @override
  String get payoutInstantCashOutEnabledTitle => '启用即时提现';

  @override
  String get payoutInstantCashOutEnabledSubtitle => '允许“立即提现”按钮（会收取手续费）。';

  @override
  String get payoutSettingsSaved => '提现设置已保存。';

  @override
  String get payoutSettingsSaveFailed => '保存提现设置失败。';

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
