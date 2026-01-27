// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Styloria';

  @override
  String get account => 'Аккаунт';

  @override
  String get profile => 'Профиль';

  @override
  String get myBookings => 'Мои бронирования';

  @override
  String get openJobs => 'Открытые заявки';

  @override
  String get earnings => 'Заработок';

  @override
  String get paymentMethods => 'Способы оплаты';

  @override
  String get referFriends => 'Пригласить друзей';

  @override
  String get language => 'Язык';

  @override
  String get settings => 'Настройки';

  @override
  String get darkMode => 'Тёмная тема';

  @override
  String get systemDefault => 'По умолчанию (система)';

  @override
  String get languageUpdated => 'Язык обновлён';

  @override
  String get languageSetToSystemDefault => 'Язык установлен как системный';

  @override
  String get helpAndSupport => 'Помощь и поддержка';

  @override
  String get chatWithCustomerService => 'Чат со службой поддержки';

  @override
  String get aboutAndPolicies => 'О приложении и политики';

  @override
  String get viewUserPoliciesAndAgreements =>
      'Просмотр политик и соглашений пользователя';

  @override
  String get logOut => 'Выйти';

  @override
  String get deleteAccount => 'Удалить аккаунт';

  @override
  String get deleteAccountSubtitle => 'Это действие нельзя отменить';

  @override
  String get deleteAccountTitle => 'Удалить аккаунт';

  @override
  String get deleteAccountConfirmBody =>
      'Вы уверены, что хотите удалить аккаунт?\n\nВы выйдете из системы и можете навсегда потерять доступ.';

  @override
  String get no => 'Нет';

  @override
  String get yesDelete => 'Да, удалить';

  @override
  String get deleteAccountSheetTitle => 'Нам жаль, что вы уходите.';

  @override
  String get deleteAccountSheetPrompt =>
      'Почему вы уходите? (выберите все подходящее)';

  @override
  String get deleteAccountSelectAtLeastOneReason =>
      'Выберите хотя бы одну причину.';

  @override
  String get tellUsMoreOptional => 'Расскажите подробнее (необязательно)';

  @override
  String get suggestionsToImproveOptional =>
      'Предложения по улучшению (необязательно)';

  @override
  String get deleteMyAccount => 'Удалить мой аккаунт';

  @override
  String get cancel => 'Отмена';

  @override
  String get failedToDeleteAccount =>
      'Не удалось удалить аккаунт. Попробуйте ещё раз.';

  @override
  String get choosePreferredLanguage => 'Выберите предпочитаемый язык';

  @override
  String get noteSomeTextMayStillAppearInEnglish =>
      'Примечание: это изменит язык приложения. Некоторый текст может оставаться на английском, пока переводы не добавлены.';

  @override
  String languageSetToName(Object name) {
    return 'Язык установлен: $name';
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
  String get confirmPassword => 'Подтвердите пароль';

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
  String get deletionReason1 => 'Мне больше не нужен Styloria';

  @override
  String get deletionReason2 =>
      'Были проблемы с верификацией аккаунта (email/KYC)';

  @override
  String get deletionReason3 => 'Не нашёл(ла) сервисы/провайдеров рядом';

  @override
  String get deletionReason4 =>
      'Цены или комиссии слишком высокие / непонятные';

  @override
  String get deletionReason5 => 'Приложение было неудобным / сложным';

  @override
  String get deletionReason6 => 'Ошибки или проблемы с производительностью';

  @override
  String get deletionReason7 => 'Проблемы с оплатой/возвратом';

  @override
  String get deletionReason8 => 'Плохой опыт с провайдером/пользователем';

  @override
  String get deletionReason9 =>
      'Опасения по поводу конфиденциальности или безопасности';

  @override
  String get deletionReason10 => 'Я создал(а) аккаунт по ошибке';

  @override
  String get deletionReason11 => 'Перехожу на другую платформу';

  @override
  String get deletionReason12 => 'Другое';

  @override
  String get loginWelcomeTitle => 'Добро пожаловать в Styloria';

  @override
  String get loginWelcomeSubtitle =>
      'Войдите, чтобы управлять бронированиями и услугами.';

  @override
  String get loginFailedToLoadUserInfo =>
      'Вход выполнен, но не удалось загрузить данные пользователя.';

  @override
  String get username => 'Имя пользователя';

  @override
  String get password => 'Пароль';

  @override
  String get required => 'Обязательно';

  @override
  String get login => 'Войти';

  @override
  String get createNewAccount => 'Создать новый аккаунт';

  @override
  String get requestEmailVerificationCode =>
      'Запросить код подтверждения e-mail';

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
  String get pleaseEnterAddress => 'Введите адрес';

  @override
  String get locationUpdatedFromAddress => 'Местоположение обновлено по адресу';

  @override
  String get createAccountTitle => 'Создать аккаунт';

  @override
  String get joinStyloria => 'Присоединиться к Styloria';

  @override
  String get registerSubtitle =>
      'Создайте аккаунт, чтобы бронировать услуги или стать провайдером';

  @override
  String get iWantTo => 'Я хочу:';

  @override
  String get bookServices => 'Бронировать услуги';

  @override
  String get provideServices => 'Предоставлять услуги';

  @override
  String get personalInformation => 'Личная информация';

  @override
  String get firstName => 'Имя';

  @override
  String get lastName => 'Фамилия';

  @override
  String get selectDateOfBirth => 'Выберите дату рождения';

  @override
  String get phoneNumber => 'Номер телефона';

  @override
  String get pleaseEnterPhoneNumber => 'Введите номер телефона';

  @override
  String get accountInformation => 'Данные аккаунта';

  @override
  String get chooseUniqueUsernameHint => 'Выберите уникальное имя пользователя';

  @override
  String get youAreCurrentlyUnavailable => 'Вы сейчас недоступны';

  @override
  String get toBrowseAndAcceptJobsEnableAvailability =>
      'Чтобы просматривать и принимать запросы на работу поблизости, вам нужно установить статус доступности для бронирований.';

  @override
  String get goToProfileSettings => 'Перейти к настройкам профиля';

  @override
  String get tipToggleAvailableForBookings =>
      'Совет: Включите «Доступен для бронирований» в профиле поставщика услуг, чтобы начать получать запросы на работу.';

  @override
  String requestedBy(String name) {
    return 'Запросил: $name';
  }

  @override
  String locationLabel(String address) {
    return 'Местоположение: $address';
  }

  @override
  String get email => 'E-mail';

  @override
  String get emailHint => 'your@email.com';

  @override
  String get enterValidEmail => 'Введите корректный email';

  @override
  String get security => 'Безопасность';

  @override
  String get passwordHintAtLeast10 => 'Минимум 10 символов';

  @override
  String get passwordMin10 => 'Пароль должен содержать не менее 10 символов';

  @override
  String get iAgreeTo => 'Я соглашаюсь с ';

  @override
  String get termsOfService => 'Условиями использования';

  @override
  String get and => 'и';

  @override
  String get privacyPolicy => 'Политикой конфиденциальности';

  @override
  String get passwordIsRequired => 'Пароль обязателен';

  @override
  String get passwordsDoNotMatch => 'Пароли не совпадают';

  @override
  String get pleaseSelectDob => 'Пожалуйста, выберите дату рождения.';

  @override
  String get pleaseSelectCountry => 'Пожалуйста, выберите страну.';

  @override
  String get pleaseSelectCity => 'Пожалуйста, выберите город.';

  @override
  String get pleaseEnterValidPhone =>
      'Пожалуйста, введите корректный номер телефона.';

  @override
  String get mustAcceptTerms => 'Необходимо принять условия.';

  @override
  String get mustBeAtLeast18 =>
      'Для регистрации вам должно быть не менее 18 лет.';

  @override
  String get agreeToTerms =>
      'Я согласен(на) с Условиями обслуживания и Политикой конфиденциальности';

  @override
  String get createAccountButton => 'Создать аккаунт';

  @override
  String get alreadyHaveAccount => 'Уже есть аккаунт?';

  @override
  String get emailVerifiedSuccessPleaseLogin =>
      'Email успешно подтверждён. Пожалуйста, войдите.';

  @override
  String get pleaseVerifyEmailToContinue =>
      'Подтвердите email, чтобы продолжить.';

  @override
  String get requestVerificationCodeTitle => 'Запросить код подтверждения';

  @override
  String get requestVerificationInstructions =>
      'Введите email или имя пользователя.\nМы отправим новый код подтверждения на email этого аккаунта.';

  @override
  String get emailOrUsername => 'Email или имя пользователя';

  @override
  String get sendCode => 'Отправить код';

  @override
  String get ifAccountExistsCodeSent =>
      'Если аккаунт существует, код был отправлен.';

  @override
  String get failedToSendVerificationCode =>
      'Не удалось отправить код подтверждения.';

  @override
  String get verifyYourEmailTitle => 'Подтвердите ваш email';

  @override
  String get verificationCodeSentInfo =>
      'Код подтверждения отправлен на email этого аккаунта.';

  @override
  String emailVerificationInstructions(Object identifier) {
    return 'Введите 6-значный код, отправленный на email этого аккаунта:\n$identifier';
  }

  @override
  String get verificationCodeLabel => 'Код подтверждения';

  @override
  String get sendingEllipsis => 'Отправка...';

  @override
  String get resendCode => 'Отправить код ещё раз';

  @override
  String get enter6DigitCodeError => 'Введите 6-значный код.';

  @override
  String get verifyingEllipsis => 'Проверка...';

  @override
  String get verify => 'Подтвердить';

  @override
  String get invalidOrExpiredCodeTryResending =>
      'Код недействителен или истёк. Попробуйте отправить ещё раз.';

  @override
  String bookingTitle(Object id) {
    return 'Бронирование №$id';
  }

  @override
  String get invalidBookingIdForChat => 'Неверный ID бронирования для чата.';

  @override
  String get invalidBookingIdForCall => 'Неверный ID бронирования для звонка.';

  @override
  String get unableToLoadContactInfo =>
      'Не удалось загрузить контактные данные. Убедитесь, что бронирование активно.';

  @override
  String noPhoneNumberAvailableForName(Object name) {
    return 'Нет доступного номера телефона для $name.';
  }

  @override
  String get deviceCannotPlaceCalls =>
      'Это устройство не может совершать телефонные звонки.';

  @override
  String get cancelBookingDialogTitle => 'Отменить бронирование';

  @override
  String get cancelBookingDialogBody =>
      'Вы действительно хотите отменить это бронирование?\n\nПримечание: если исполнитель уже принял заказ и прошло более 7 минут (но меньше примерно 40 минут), может быть применён штраф согласно правилам.';

  @override
  String get yesCancel => 'Да, отменить';

  @override
  String get failedToCancelBooking => 'Не удалось отменить бронирование.';

  @override
  String bookingCancelledPenaltyApplied(Object amount) {
    return 'Бронирование отменено. Применён штраф $amount.';
  }

  @override
  String get bookingCancelledSuccessfully => 'Бронирование успешно отменено.';

  @override
  String get failedToConfirmCompletion =>
      'Не удалось подтвердить завершение. Пожалуйста, попробуйте снова.';

  @override
  String get bothSidesConfirmedCompletedPayoutReleased =>
      'Обе стороны подтвердили. Бронирование отмечено как завершённое, выплата разблокирована.';

  @override
  String get youConfirmedCompletionWaitingForProvider =>
      'Вы подтвердили завершение. Ожидаем подтверждения исполнителя.';

  @override
  String get youConfirmedCompletionWaitingForUser =>
      'Вы подтвердили завершение. Ожидаем подтверждения пользователя.';

  @override
  String get statusUnknown => 'неизвестно';

  @override
  String get statusAccepted => 'принято';

  @override
  String get statusInProgress => 'в процессе';

  @override
  String get statusCompleted => 'завершено';

  @override
  String get statusCancelled => 'отменено';

  @override
  String get paymentPaid => 'оплачено';

  @override
  String get paymentPending => 'в ожидании';

  @override
  String get paymentFailed => 'ошибка';

  @override
  String bookingAcceptedBy(Object name) {
    return 'Бронирование принято: $name';
  }

  @override
  String get whenLabel => 'Когда';

  @override
  String atTime(Object time) {
    return 'в $time';
  }

  @override
  String get userLabel => 'Пользователь';

  @override
  String get providerLabel => 'Исполнитель';

  @override
  String get estimatedPriceLabel => 'Ориентировочная цена';

  @override
  String get offeredPaidLabel => 'Предложено / оплачено';

  @override
  String get distanceLabel => 'Расстояние';

  @override
  String distanceMiles(Object miles) {
    return '$miles миль';
  }

  @override
  String get acceptedAtLabel => 'Принято в';

  @override
  String get cancelledAtLabel => 'Отменено в';

  @override
  String get cancelledByLabel => 'Отменил';

  @override
  String penaltyAppliedLabel(Object amount) {
    return 'Штраф применён: $amount';
  }

  @override
  String get userConfirmedLabel => 'Пользователь подтвердил';

  @override
  String get providerConfirmedLabel => 'Исполнитель подтвердил';

  @override
  String get payoutReleasedLabel => 'Выплата разблокирована';

  @override
  String get yesLower => 'да';

  @override
  String get noLower => 'нет';

  @override
  String get chat => 'Чат';

  @override
  String get call => 'Позвонить';

  @override
  String get actions => 'Действия';

  @override
  String get confirmCompletion => 'Подтвердить завершение';

  @override
  String get noFurtherActionsForBooking =>
      'Для этого бронирования больше нет доступных действий.';

  @override
  String freeCancellationEndsIn(Object time) {
    return 'Бесплатная отмена закончится через $time';
  }

  @override
  String get earlyFreeCancellationEndedWarning =>
      'Период ранней бесплатной отмены завершён. До примерно 40 минут после принятия поздняя отмена может привести к штрафу.';

  @override
  String get cancelBooking => 'Отменить бронирование';

  @override
  String get cancelBookingNoPenalty => 'Отменить бронирование (без штрафа)';

  @override
  String get cancelBookingPenaltyMayApply =>
      'Отменить бронирование (возможен штраф)';

  @override
  String get cancellationPolicyInfo =>
      'Вы можете отменить без штрафа в первые 7 минут после принятия исполнителем, а также снова примерно через 40 минут при необходимости. Между этими периодами может применяться штраф согласно правилам.';

  @override
  String ratingLine(Object rating, int reviewCount) {
    String _temp0 = intl.Intl.pluralLogic(
      reviewCount,
      locale: localeName,
      other: '$reviewCount отзывов',
      many: '$reviewCount отзывов',
      few: '$reviewCount отзыва',
      one: '1 отзыв',
    );
    return 'Рейтинг: $rating ($_temp0)';
  }

  @override
  String get proofOfSkillsPortfolio => 'Подтверждение навыков (Портфолио)';

  @override
  String get noPortfolioPostsAvailable => 'Нет доступных работ в портфолио.';

  @override
  String get bookingLocation => 'Место бронирования';

  @override
  String get location => 'Местоположение';

  @override
  String get latitude => 'Широта';

  @override
  String get longitude => 'Долгота';

  @override
  String get mapWillAppearWhenCoordinatesValid =>
      'Карта появится здесь, когда координаты будут корректными.';

  @override
  String chatForBookingTitle(Object id) {
    return 'Чат по бронированию №$id';
  }

  @override
  String get unableToStartChat =>
      'Не удалось начать чат. Чат доступен только когда бронирование принято, в процессе, или завершено в течение последнего дня.';

  @override
  String get invalidChatThreadFromServer =>
      'С сервера получен неверный чат-поток.';

  @override
  String get messageNotSentPolicy =>
      'Сообщение не отправлено. Примечание: делиться телефонами или e-mail в чате запрещено.';

  @override
  String get unknown => 'Неизвестно';

  @override
  String get typeMessageHint => 'Введите сообщение в поддержку...';

  @override
  String get uploadProfilePicture => 'Загрузить фото профиля';

  @override
  String get currentProfilePicture => 'Текущее фото профиля';

  @override
  String get newPicturePreview => 'Предпросмотр нового фото';

  @override
  String get chooseImage => 'Выбрать изображение';

  @override
  String get upload => 'Загрузить';

  @override
  String get noImageBytesFoundWeb => 'Не найдены байты изображения (web).';

  @override
  String get pleasePickAnImageFirst => 'Сначала выберите изображение.';

  @override
  String get uploadFailedCheckServerLogs =>
      'Загрузка не удалась. Проверьте логи сервера / токен.';

  @override
  String get profilePictureUploadedSuccessfully =>
      'Фото профиля успешно загружено!';

  @override
  String errorWithValue(Object error) {
    return 'Ошибка: $error';
  }

  @override
  String get tapToChangeProfilePicture =>
      'Нажмите, чтобы изменить фото профиля';

  @override
  String usernameValue(Object username) {
    return 'Имя пользователя: $username';
  }

  @override
  String roleValue(Object role) {
    return 'Роль: $role';
  }

  @override
  String get dateOfBirthYyyyMmDd => 'Дата рождения (ГГГГ-ММ-ДД)';

  @override
  String get saveProfile => 'Сохранить профиль';

  @override
  String get failedToSaveProfile =>
      'Не удалось сохранить профиль. Попробуйте ещё раз.';

  @override
  String get profileUpdated => 'Профиль обновлён.';

  @override
  String get completeYourProviderProfile => 'Заполните профиль исполнителя';

  @override
  String get completeProviderProfileBody =>
      'Чтобы начать принимать заказы и зарабатывать, заполните профиль исполнителя.';

  @override
  String get setupProfileNow => 'Настроить профиль сейчас';

  @override
  String get doItLater => 'Сделать позже';

  @override
  String get bookingTimerPenaltyPeriodActive => 'Период штрафа активен';

  @override
  String get bookingTimerFreeCancellationPeriod => 'Период бесплатной отмены';

  @override
  String bookingTimerTimeRemaining(Object time) {
    return 'Осталось времени: $time';
  }

  @override
  String get bookingTimerCancellingNowPenalty =>
      'Отмена сейчас приведёт к штрафу 10%.';

  @override
  String get bookingTimerCancelNoPenalty => 'Вы можете отменить без штрафа.';

  @override
  String get myReviewsTitle => 'Мои отзывы';

  @override
  String get failedToLoadReviews => 'Не удалось загрузить отзывы.';

  @override
  String get noReviewsYet => 'Вы ещё не оставили ни одного отзыва.';

  @override
  String providerWithName(Object name) {
    return 'Исполнитель: $name';
  }

  @override
  String get providerGeneric => 'Исполнитель';

  @override
  String ratingWithValue(Object rating) {
    return 'Рейтинг: $rating';
  }

  @override
  String get nearbyOpenJobsTitle => 'Открытые заказы рядом';

  @override
  String get failedToLoadOpenJobsHint =>
      'Не удалось загрузить открытые заказы.\nУбедитесь, что у вас есть профиль исполнителя, задана локация и available=true.';

  @override
  String errorLoadingJobsWithValue(Object error) {
    return 'Ошибка загрузки заказов: $error';
  }

  @override
  String get noOpenJobsFoundNearbyTitle => 'Поблизости нет открытых заказов';

  @override
  String get noOpenJobsFoundNearbyBody =>
      'Убедитесь, что:\n- Вы установили локацию исполнителя\n- Вы отмечены как доступный\n- Пользователи создали и оплатили бронирования';

  @override
  String currencyLabel(Object symbol) {
    return 'Валюта: $symbol';
  }

  @override
  String pricesShownInCurrency(Object symbol, Object country) {
    return 'Цены указаны в $symbol ($country)';
  }

  @override
  String jobTitleWithId(Object id) {
    return 'Заказ №$id';
  }

  @override
  String serviceLine(Object service) {
    return 'Услуга: $service';
  }

  @override
  String whenLine(Object date, Object time) {
    return 'Когда: $date $time';
  }

  @override
  String priceLine(Object price) {
    return 'Цена: $price';
  }

  @override
  String get acceptJob => 'Принять заказ';

  @override
  String get failedToAcceptJob => 'Не удалось принять заказ.';

  @override
  String get jobAcceptedSuccessfully => 'Заказ успешно принят.';

  @override
  String get newServiceRequestTitle => 'Новый запрос услуги';

  @override
  String get reviewAlreadySubmitted => 'Review submitted ✓';

  @override
  String get offeredPriceLabel => 'Предложенная цена';

  @override
  String get offeredPriceHint => 'например 25.00';

  @override
  String get enterValidPrice => 'Введите корректную цену';

  @override
  String get bookAndPay => 'Забронировать и оплатить';

  @override
  String bookAndPayAmount(Object amount) {
    return 'Забронировать и оплатить $amount';
  }

  @override
  String get haircutService => 'Стрижка';

  @override
  String get stylingService => 'Укладка';

  @override
  String get timeLabel => 'Время:';

  @override
  String get notesLabel => 'Заметки';

  @override
  String get requestCreatedAndPaidBroadcast =>
      'Запрос создан и оплачен! Отправлено исполнителям.';

  @override
  String locationLatLng(Object lat, Object lng) {
    return 'Местоположение: $lat, $lng';
  }

  @override
  String get paymentMethodsTitle => 'Способы оплаты';

  @override
  String get paymentPreferencesInfo =>
      'Эти настройки хранятся локально на вашем устройстве. Реальные платежи обрабатываются безопасно через Stripe/другие шлюзы.';

  @override
  String get preferredMethodLabel =>
      'Предпочтительный метод (локальный шлюз выбирается по стране)';

  @override
  String get methodVisaMastercard => 'Visa/Mastercard';

  @override
  String get methodMobileMoney => 'Mobile Money (Momo/Paystack/Africa)';

  @override
  String get methodPaypal => 'PayPal';

  @override
  String get methodApplePayGooglePay => 'Apple Pay/Google Pay';

  @override
  String get methodWeChatPay => 'WeChat Pay (Китай)';

  @override
  String get methodAlipay => 'Alipay (Китай)';

  @override
  String get methodUnionPay => 'UnionPay (Китай)';

  @override
  String get mobileMoneyNumberLabel => 'Номер Mobile Money';

  @override
  String get wechatAlipayIdLabel => 'ID WeChat/Alipay';

  @override
  String get cardLast4DigitsLabel => 'Последние 4 цифры карты';

  @override
  String get paypalEmailLabel => 'Email PayPal';

  @override
  String get applePayEnabledOnDevice => 'Apple Pay включён на этом устройстве';

  @override
  String get savePaymentPreferences => 'Сохранить настройки оплаты';

  @override
  String get paymentPrefsSavedInfo =>
      'Настройки оплаты сохранены локально. Реальное списание будет выполняться через Stripe/другие шлюзы позже.';

  @override
  String get failedToLoadImage => 'Не удалось загрузить изображение';

  @override
  String get earningsTitle => 'Доход';

  @override
  String get couldNotLoadEarningsSummary =>
      'Не удалось загрузить сводку доходов.';

  @override
  String get noData => 'Нет данных.';

  @override
  String get retry => 'Повторить';

  @override
  String get summaryTitle => 'Сводка';

  @override
  String get totalLabel => 'Итого';

  @override
  String get pendingLabel => 'Ожидается';

  @override
  String get paidLabel => 'Оплачено';

  @override
  String get pdfReportTitle => 'PDF-отчёт';

  @override
  String get periodLabel => 'Период';

  @override
  String get periodThisMonth => 'Этот месяц';

  @override
  String get periodLastMonth => 'Прошлый месяц';

  @override
  String get periodYtd => 'С начала года';

  @override
  String get periodAllTime => 'За всё время';

  @override
  String get couldNotDownloadPdfReport => 'Не удалось скачать PDF-отчёт.';

  @override
  String couldNotOpenPdfWithValue(Object error) {
    return 'Не удалось открыть PDF: $error';
  }

  @override
  String get savingFilesNotSupportedWeb =>
      'Сохранение файлов в веб-версии пока не поддерживается.';

  @override
  String savedToDocumentsIosWithPath(Object path) {
    return 'Сохранено в Documents (iOS):\n$path';
  }

  @override
  String savedToFilesWithPath(Object path) {
    return 'Сохранено в файлы:\n$path';
  }

  @override
  String get open => 'Открыть';

  @override
  String failedToSavePdfWithValue(Object error) {
    return 'Не удалось сохранить PDF: $error';
  }

  @override
  String get openPdfReport => 'Открыть PDF-отчёт';

  @override
  String get savePdfToDownloads => 'Сохранить PDF в Загрузки';

  @override
  String get reportWatermarkNote =>
      'PDF-отчёт должен содержать водяной знак Styloria.';

  @override
  String get referFriendsTitle => 'Пригласить друзей';

  @override
  String get shareReferralCodeBody =>
      'Поделитесь своим реферальным кодом с друзьями. Позже вы сможете добавить награды, когда они зарегистрируются и завершат бронирования.';

  @override
  String get yourReferralCodeLabel => 'Ваш реферальный код:';

  @override
  String get copy => 'Копировать';

  @override
  String referralCodeCopiedWithCode(Object code) {
    return 'Реферальный код скопирован: $code';
  }

  @override
  String get navHome => 'Главная';

  @override
  String get navBookings => 'Бронирования';

  @override
  String get navNotifications => 'Уведомления';

  @override
  String get navAccount => 'Аккаунт';

  @override
  String get welcome => 'Добро пожаловать';

  @override
  String welcomeName(Object name) {
    return 'Добро пожаловать, $name';
  }

  @override
  String get toggleThemeTooltip => 'Переключить светлую/тёмную тему';

  @override
  String loggedInAs(Object role) {
    return 'Вы вошли как: $role';
  }

  @override
  String locationWithValue(Object value) {
    return 'Местоположение: $value';
  }

  @override
  String get homeTagline =>
      'Преобразите свой уход с бронированиями в реальном времени и проверенными исполнителями.';

  @override
  String get manageProviderProfile => 'Управление профилем исполнителя';

  @override
  String get browseOpenJobs => 'Просмотреть открытые заказы';

  @override
  String get quickActions => 'Быстрые действия';

  @override
  String get newBooking => 'Новое бронирование';

  @override
  String notificationsWithUnread(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count непрочитано',
      many: '$count непрочитано',
      few: '$count непрочитано',
      one: '1 непрочитано',
    );
    return 'Уведомления ($_temp0)';
  }

  @override
  String get liveLocationTrackingTitle =>
      'Отслеживание локации в реальном времени';

  @override
  String get live => 'Онлайн';

  @override
  String get locationServicesDisabled => 'Службы геолокации отключены.';

  @override
  String get locationPermissionDenied => 'Доступ к геолокации запрещён.';

  @override
  String get locationPermissionPermanentlyDenied =>
      'Доступ к геолокации запрещён навсегда. Включите его в настройках.';

  @override
  String failedToGetLocationWithValue(Object error) {
    return 'Не удалось получить местоположение: $error';
  }

  @override
  String get youProvider => 'Вы (исполнитель)';

  @override
  String get youCustomer => 'Вы (клиент)';

  @override
  String get customer => 'Клиент';

  @override
  String get bookingDetails => 'Детали бронирования';

  @override
  String get navigate => 'Навигация';

  @override
  String get failedToLoadNotifications => 'Не удалось загрузить уведомления.';

  @override
  String get failedToMarkAsRead => 'Не удалось пометить как прочитанное';

  @override
  String get noNotificationsYet => 'Уведомлений пока нет.';

  @override
  String get markRead => 'Пометить прочитанным';

  @override
  String get providerKycTitle => 'Проверка поставщика (KYC)';

  @override
  String get logoutTooltip => 'Выйти';

  @override
  String statusLabel(Object status) {
    return 'Статус: $status';
  }

  @override
  String rejectedWithNotes(Object notes) {
    return 'Отклонено: $notes';
  }

  @override
  String get kycInstructions =>
      'Чтобы получить доступ к функциям поставщика, загрузите удостоверение личности и селфи для проверки.';

  @override
  String get idFrontRequired => 'ID (лицевая сторона, обязательно)';

  @override
  String get selectIdFront => 'Выбрать лицевую сторону';

  @override
  String get idBackRequired => 'ID (обратная сторона, обязательно)';

  @override
  String get selectIdBackRequired => 'Выбрать обратную сторону';

  @override
  String get selfieRequired => 'Селфи (обязательно)';

  @override
  String get selectSelfie => 'Выбрать селфи';

  @override
  String get takeSelfie => 'Сделать селфи';

  @override
  String get errorUploadAllRequired =>
      'Пожалуйста, загрузите ID (лицевая сторона), ID (обратная сторона) и селфи.';

  @override
  String failedSubmitKycCode(Object code) {
    return 'Не удалось отправить KYC (код $code).';
  }

  @override
  String submittedCurrentStatus(Object status) {
    return 'Отправлено. Текущий статус: $status';
  }

  @override
  String get unknownStatus => 'неизвестно';

  @override
  String get submitKyc => 'Отправить KYC';

  @override
  String get verificationMayTakeTimeNote =>
      'Примечание: проверка может занять время. Доступ к функциям поставщика появится после одобрения.';

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
  String get enterVerificationCodeTitle => 'Введите код подтверждения';

  @override
  String otpSentToUsername(Object username) {
    return 'Мы отправили 6-значный код на номер телефона,\nсвязанный с \"$username\".';
  }

  @override
  String get sixDigitCodeLabel => '6-значный код';

  @override
  String get enterSixDigitCodeValidation => 'Введите 6-значный код';

  @override
  String get otpInvalidOrExpired => 'Неверный или истёкший код.';

  @override
  String get failedLoadUserInfoAfterVerification =>
      'Не удалось загрузить данные пользователя после подтверждения.';

  @override
  String get chatWithSupportTitle => 'Чат с поддержкой';

  @override
  String get unableStartSupportChat => 'Не удалось начать чат с поддержкой.';

  @override
  String get invalidSupportThreadReturned =>
      'Сервер вернул некорректный поток поддержки.';

  @override
  String get noMessagesYet => 'Сообщений пока нет. Начните разговор!';

  @override
  String get supportDefaultName => 'Поддержка';

  @override
  String get aboutPoliciesTitle => 'О приложении и политиках';

  @override
  String get newBookingTitle => 'Новая бронь';

  @override
  String get appointmentDetailsTitle => 'Детали встречи';

  @override
  String get pickDate => 'Выбрать дату';

  @override
  String get pickTime => 'Выбрать время';

  @override
  String get serviceTypeTitle => 'Тип услуги';

  @override
  String get serviceDropdownLabel => 'Услуга';

  @override
  String get serviceHaircutLabel => 'Стрижка';

  @override
  String get serviceBraidsLabel => 'Косы';

  @override
  String get serviceShaveLabel => 'Бритьё';

  @override
  String get serviceHairColoringLabel => 'Окрашивание волос';

  @override
  String get serviceManicureLabel => 'Маникюр';

  @override
  String get servicePedicureLabel => 'Педикюр';

  @override
  String get serviceNailArtLabel => 'Дизайн ногтей';

  @override
  String get serviceMakeupLabel => 'Макияж';

  @override
  String get serviceFacialLabel => 'Уход за лицом';

  @override
  String get serviceWaxingLabel => 'Восковая эпиляция';

  @override
  String get serviceMassageLabel => 'Массаж';

  @override
  String get serviceTattooLabel => 'Tattoo';

  @override
  String get serviceHairStylingLabel => 'Укладка';

  @override
  String get serviceHairTreatmentLabel => 'Лечение волос';

  @override
  String get serviceHairExtensionsLabel => 'Наращивание волос';

  @override
  String get serviceOtherServicesLabel => 'Другие услуги';

  @override
  String get notesForProviderOptionalLabel =>
      'Заметки для мастера (необязательно)';

  @override
  String get locationTitle => 'Местоположение';

  @override
  String get latitudeLabel => 'Широта';

  @override
  String get longitudeLabel => 'Долгота';

  @override
  String get requiredField => 'Обязательно';

  @override
  String get useMyCurrentLocation => 'Использовать моё текущее местоположение';

  @override
  String pricesShownIn(Object symbol, Object country) {
    return 'Цены показаны в $symbol ($country)';
  }

  @override
  String get chooseTimeLaterThanCurrent =>
      'Пожалуйста, выберите время позже текущего.';

  @override
  String get pleasePickDateAndTime => 'Пожалуйста, выберите дату и время.';

  @override
  String get locationUpdatedFromGps => 'Местоположение обновлено по GPS.';

  @override
  String failedToGetLocation(Object error) {
    return 'Не удалось получить местоположение: $error';
  }

  @override
  String bookingCreatedChoosePrice(Object id) {
    return 'Бронь создана! ID: $id • Выберите вариант цены.';
  }

  @override
  String get failedToCreateBooking => 'Не удалось создать бронь.';

  @override
  String get paymentsNotSupportedLong =>
      'Платежи не поддерживаются на этой платформе. Запустите приложение на Android, iOS, macOS или Web для теста оплат.';

  @override
  String get noBookingToConfirm =>
      'Нет брони для подтверждения. Сначала создайте бронь.';

  @override
  String get pleaseChoosePriceOption => 'Пожалуйста, выберите вариант цены.';

  @override
  String get failedCreatePaymentTryAgain =>
      'Не удалось создать платёж на сервере. Попробуйте ещё раз.';

  @override
  String paymentSuccessfulMessage(Object bookingId, Object paid) {
    return 'Оплата прошла успешно!\nБронь #$bookingId • Оплачено: $paid\nВаш запрос теперь виден ближайшим мастерам.';
  }

  @override
  String get paymentSucceededButFailedUpdate =>
      'Оплата прошла, но обновить бронь на сервере не удалось.';

  @override
  String paymentCancelledOrFailed(Object reason) {
    return 'Оплата отменена или не удалась: $reason';
  }

  @override
  String unexpectedPaymentError(Object error) {
    return 'Неожиданная ошибка оплаты: $error';
  }

  @override
  String get createBookingButton => 'Создать бронь';

  @override
  String get chooseYourPriceOptionTitle => 'Выберите вариант цены';

  @override
  String transportationCostLabel(Object cost) {
    return 'Стоимость транспорта: $cost';
  }

  @override
  String get budgetTierTitle => 'ЭКОНОМ';

  @override
  String get standardTierTitle => 'СТАНДАРТ';

  @override
  String get priorityTierTitle => 'ПРИОРИТЕТ';

  @override
  String get budgetTierDescription => 'Лучшая цена среди ближайших мастеров';

  @override
  String get standardTierDescription =>
      'Рекомендуемый баланс цены и доступности';

  @override
  String get priorityTierDescription =>
      'Премиум-опция для быстрого привлечения лучших мастеров';

  @override
  String get naShort => 'Н/Д';

  @override
  String get priceBreakdownTitle => 'Разбивка цены';

  @override
  String get servicePriceLabel => 'Стоимость услуги';

  @override
  String get transportationLabel => 'Транспорт';

  @override
  String serviceFeeLabel(Object percent) {
    return 'Сервисный сбор ($percent%)';
  }

  @override
  String allPricesIn(Object currency, Object country) {
    return 'Все цены в $currency ($country)';
  }

  @override
  String get userCountryPlaceholder => 'Страна пользователя';

  @override
  String get totalToPayTitle => 'Итого к оплате';

  @override
  String get includesServiceTransportation => 'Включает услугу + транспорт';

  @override
  String get confirmAndPay => 'Подтвердить и оплатить';

  @override
  String get howPricingWorksTitle => 'Как формируется цена';

  @override
  String get howPricingWorksBullets =>
      '• Эконом: лучшая цена среди ближайших мастеров\n• Стандарт: рекомендуемый вариант\n• Приоритет: премиум-опция для ускорения принятия\n• Транспорт включён в итоговую сумму';

  @override
  String get myBookingsTitle => 'Мои бронирования';

  @override
  String get myAssignedJobsTitle => 'Мои назначенные заказы';

  @override
  String get pleaseCompleteProviderProfileFirst =>
      'Пожалуйста, сначала заполните профиль мастера.';

  @override
  String get failedToLoadBookings => 'Не удалось загрузить бронирования.';

  @override
  String get profileSetupRequiredTitle => 'Требуется настройка профиля';

  @override
  String get profileSetupRequiredBody =>
      'Нужно заполнить профиль мастера, прежде чем вы сможете видеть назначенные заказы и доход.';

  @override
  String get later => 'Позже';

  @override
  String get setupNow => 'Настроить сейчас';

  @override
  String get noBookingsFound => 'Бронирования не найдены.';

  @override
  String get findNearbyOpenJobs => 'Найти открытые заказы рядом';

  @override
  String get pay => 'Оплатить';

  @override
  String get rate => 'Оценить';

  @override
  String bookingNumber(Object id) {
    return 'Бронь #$id';
  }

  @override
  String whenOn(Object date) {
    return 'Когда: $date';
  }

  @override
  String whenAt(Object date, Object time) {
    return 'Когда: $date в $time';
  }

  @override
  String providerLine(Object name) {
    return 'Мастер: $name';
  }

  @override
  String userLine(Object name) {
    return 'Пользователь: $name';
  }

  @override
  String estimatedPriceLine(Object price) {
    return 'Оценочная цена: $price';
  }

  @override
  String paymentLine(Object status) {
    return 'Оплата: $status';
  }

  @override
  String get paymentUnpaid => 'не оплачено';

  @override
  String get paymentUnknown => 'неизвестно';

  @override
  String get confirmPaymentTitle => 'Подтвердить оплату';

  @override
  String confirmPaymentBody(Object amount) {
    return 'Оплатить $amount, чтобы подтвердить эту бронь?';
  }

  @override
  String get yesPay => 'Да, оплатить';

  @override
  String get failedToCreatePaymentIntent => 'Не удалось создать intent оплаты.';

  @override
  String get paymentSuccessfulShort => 'Оплата прошла успешно.';

  @override
  String get paymentSucceededButFailedUpdateBooking =>
      'Оплата прошла, но обновить бронь на сервере не удалось.';

  @override
  String paymentCancelledOrFailedReason(Object reason) {
    return 'Оплата отменена или не удалась: $reason';
  }

  @override
  String unexpectedPaymentErrorReason(Object error) {
    return 'Неожиданная ошибка оплаты: $error';
  }

  @override
  String rateProviderTitle(Object providerName) {
    return 'Оценить $providerName';
  }

  @override
  String get selectRatingHelp => 'Выберите рейтинг (1 = плохо, 5 = отлично):';

  @override
  String get commentsOptionalLabel => 'Комментарий (необязательно)';

  @override
  String get submit => 'Отправить';

  @override
  String get reviewSubmitted => 'Отзыв отправлен.';

  @override
  String get failedSubmitReview => 'Не удалось отправить отзыв.';

  @override
  String failedToLoadProfile(Object error) {
    return 'Не удалось загрузить профиль: $error';
  }

  @override
  String profileSavedSuccess(Object action) {
    return 'Профиль успешно $action!';
  }

  @override
  String genericError(Object error) {
    return 'Ошибка: $error';
  }

  @override
  String get locationPermissionDeniedEnableInSettings =>
      'Доступ к геолокации запрещён. Включите его в настройках.';

  @override
  String get locationPermissionPermanentlyDeniedEnableInAppSettings =>
      'Доступ к геолокации запрещён навсегда. Включите его в настройках приложения.';

  @override
  String errorGettingLocation(Object error) {
    return 'Ошибка при получении местоположения: $error';
  }

  @override
  String get couldNotFindLocationForAddress =>
      'Не удалось найти местоположение для этого адреса';

  @override
  String errorConvertingAddress(Object error) {
    return 'Ошибка при преобразовании адреса: $error';
  }

  @override
  String get portfolioUnavailableCompleteKycFirst =>
      'Портфолио недоступно. Если вы провайдер, сначала пройдите проверку KYC.';

  @override
  String failedToLoadPortfolio(Object error) {
    return 'Не удалось загрузить портфолио: $error';
  }

  @override
  String get addPhoto => 'Добавить фото';

  @override
  String get addVideo => 'Добавить видео';

  @override
  String get addPost => 'Добавить пост';

  @override
  String get captionOptionalTitle => 'Подпись (необязательно)';

  @override
  String get captionHintExample => 'например: «Knotless braids для клиента»';

  @override
  String get skip => 'Пропустить';

  @override
  String get save => 'Сохранить';

  @override
  String get failedToCreatePortfolioPost =>
      'Не удалось создать пост портфолио.';

  @override
  String get uploadFailedMediaUpload => 'Загрузка не удалась (загрузка медиа).';

  @override
  String uploadFailed(Object error) {
    return 'Загрузка не удалась: $error';
  }

  @override
  String get deletePostTitle => 'Удалить пост?';

  @override
  String get deletePostBody => 'Пост будет удалён из вашего портфолио.';

  @override
  String get delete => 'Удалить';

  @override
  String get deleteFailed => 'Удаление не удалось.';

  @override
  String deleteFailedWithError(Object error) {
    return 'Удаление не удалось: $error';
  }

  @override
  String get portfolioTitle => 'Портфолио';

  @override
  String get noPortfolioPostsYetHelpText =>
      'Постов портфолио пока нет. Добавьте фото/видео своей работы, чтобы повысить доверие клиентов.';

  @override
  String get setupProviderProfileTitle => 'Настройка профиля провайдера';

  @override
  String get providerProfileTitle => 'Профиль провайдера';

  @override
  String get welcomeToStyloriaTitle => 'Добро пожаловать в Styloria!';

  @override
  String get completeProviderProfileToStartEarning =>
      'Заполните профиль провайдера, чтобы начать принимать заказы и зарабатывать.';

  @override
  String reviewCountLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'отзыва',
      many: 'отзывов',
      few: 'отзыва',
      one: 'отзыв',
    );
    return '($count $_temp0)';
  }

  @override
  String get topRatedChip => 'Топовый рейтинг';

  @override
  String get bioLabel => 'Био / Описание';

  @override
  String get bioHint => 'Расскажите клиентам о ваших навыках и опыте...';

  @override
  String get pleaseEnterBio => 'Введите био';

  @override
  String bioMinLength(int min) {
    return 'Био должно быть не короче $min символов';
  }

  @override
  String get yourLocationTitle => 'Ваше местоположение';

  @override
  String get locationHelpMatchNearbyClients =>
      'Ваше местоположение помогает подобрать клиентов поблизости';

  @override
  String get locationHelpUpdateToFindJobs =>
      'Обновите местоположение, чтобы искать заказы в других районах';

  @override
  String get useMyCurrentLocationTitle => 'Использовать текущее местоположение';

  @override
  String get gpsSubtitle => 'Получить местоположение автоматически через GPS';

  @override
  String get orLabel => 'ИЛИ';

  @override
  String get enterYourAddressTitle => 'Введите адрес';

  @override
  String get fullAddressLabel => 'Полный адрес';

  @override
  String get fullAddressHint => 'например: 123 Main St, Accra, Ghana';

  @override
  String get find => 'Найти';

  @override
  String get addressHelpText => 'Введите улицу, город и страну';

  @override
  String get coordinatesAutoFilledTitle => 'Координаты (автозаполнение)';

  @override
  String get servicePricingTitle => 'Цены на услуги';

  @override
  String get servicePricingHelp =>
      'Укажите цену для каждой услуги. Отметьте «Не предлагаю» для услуг, которые вы не оказываете.';

  @override
  String get serviceHeader => 'Услуга';

  @override
  String get priceHeader => 'Цена';

  @override
  String get notOfferedHeader => 'Не предлагаю';

  @override
  String get priceHint => '0.00';

  @override
  String get providerHowPricingWorksTitle => 'Как формируется цена:';

  @override
  String get providerHowPricingWorksBody =>
      '• Ваша цена — это стоимость услуги\n• Стоимость транспорта = 80% валюты пользователя за км\n• Пользователь видит 3 варианта по провайдерам рядом:\n  - Бюджет: самая низкая цена\n  - Стандарт: средняя цена\n  - Приоритет: самая высокая цена';

  @override
  String get availableForBookingsTitle => 'Доступен для бронирований';

  @override
  String get availableOnHelp =>
      '✓ Вы будете отображаться в поиске для клиентов поблизости';

  @override
  String get availableOffHelp => '✗ Вы не будете получать новые предложения';

  @override
  String get completeSetupStartEarning =>
      'Завершить настройку и начать зарабатывать';

  @override
  String get updateProfile => 'Обновить профиль';

  @override
  String get skipForNow => 'Пропустить сейчас';

  @override
  String get paymentsNotSupportedShort =>
      'Payments are not supported on this platform. Please use Android, iOS, macOS, or Web.';

  @override
  String get genericContact => 'Контакт';

  @override
  String get genericProvider => 'Исполнитель';

  @override
  String get genericNotAvailable => 'Н/Д';

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
  String get reviewSelectRatingPrompt => 'Выберите оценку (от 1 до 5).';

  @override
  String get reviewCommentOptionalLabel => 'Комментарий (необязательно)';

  @override
  String get genericCancel => 'Отмена';

  @override
  String get genericSubmit => 'Отправить';

  @override
  String get reviewSubmitFailed => 'Не удалось отправить отзыв.';

  @override
  String get rateThisService => 'Оценить услугу';

  @override
  String get tipLeaveTitle => 'Оставить чаевые';

  @override
  String get tipChooseAmountPrompt => 'Выберите сумму чаевых или введите свою.';

  @override
  String get tipNoTip => 'Без чаевых';

  @override
  String get tipCustomAmountLabel => 'Своя сумма чаевых';

  @override
  String get genericContinue => 'Продолжить';

  @override
  String get tipSkipped => 'Чаевые пропущены.';

  @override
  String get tipFailedToSaveChoice => 'Не удалось сохранить выбор чаевых.';

  @override
  String get tipFailedToCreatePayment => 'Не удалось создать оплату чаевых.';

  @override
  String get tipPaidSuccessfully => 'Чаевые успешно оплачены. Спасибо!';

  @override
  String get tipPaidButUpdateFailed =>
      'Оплата чаевых прошла успешно, но обновить бронирование не удалось.';

  @override
  String tipCancelledOrFailed(Object message) {
    return 'Чаевые отменены/не удались: $message';
  }

  @override
  String tipUnexpectedError(Object error) {
    return 'Неожиданная ошибка чаевых: $error';
  }

  @override
  String get tipAlreadyPaidLabel => 'Чаевые уже оплачены';

  @override
  String get tipSkippedLabel => 'Чаевые пропущены';

  @override
  String get tipLeaveButton => 'Оставить чаевые';

  @override
  String get walletTitle => 'Кошелёк';

  @override
  String get walletTooltip => 'Кошелёк';

  @override
  String get payoutSettingsTitle => 'Настройки выплат';

  @override
  String get payoutSettingsTooltip => 'Настройки выплат';

  @override
  String get walletNoWalletYet =>
      'Кошелёк пока отсутствует. Выполните заказы, чтобы заработать.';

  @override
  String get walletCurrencyFieldLabel => 'Валюта';

  @override
  String walletAvailableLine(Object amount, Object currency) {
    return 'Доступно: $amount $currency';
  }

  @override
  String walletPendingLine(Object amount, Object currency) {
    return 'В ожидании: $amount $currency';
  }

  @override
  String get walletCashOutInstant => 'Вывести (мгновенно)';

  @override
  String get walletCashOutFailed => 'Не удалось вывести средства.';

  @override
  String walletCashOutSentTransfer(Object transferId) {
    return 'Запрос на вывод отправлен. Перевод: $transferId';
  }

  @override
  String get walletTransactionsTitle => 'Транзакции';

  @override
  String get walletNoTransactionsYet => 'Транзакций пока нет.';

  @override
  String get payoutAutoPayoutsTitle => 'Автовыплаты';

  @override
  String get payoutAutoPayoutsSubtitle =>
      'Автоматически отправлять выплаты по выбранному расписанию.';

  @override
  String get payoutDayUtcLabel => 'День выплаты (UTC)';

  @override
  String get payoutHourUtcLabel => 'Час выплаты (UTC)';

  @override
  String get payoutMinimumAmountLabel => 'Минимальная сумма для автовыплаты';

  @override
  String get payoutMinimumAmountHelper =>
      'Автовыплата выполняется только если доступный баланс ≥ этой суммы.';

  @override
  String get payoutInstantCashOutEnabledTitle => 'Мгновенный вывод включён';

  @override
  String get payoutInstantCashOutEnabledSubtitle =>
      'Разрешить кнопку «Вывести» (взимается комиссия).';

  @override
  String get payoutSettingsSaved => 'Настройки выплат сохранены.';

  @override
  String get payoutSettingsSaveFailed =>
      'Не удалось сохранить настройки выплат.';

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
