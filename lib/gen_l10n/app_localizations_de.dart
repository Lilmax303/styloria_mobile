// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Styloria';

  @override
  String get account => 'Konto';

  @override
  String get profile => 'Profil';

  @override
  String get myBookings => 'Meine Buchungen';

  @override
  String get openJobs => 'Offene Jobs';

  @override
  String get earnings => 'Einnahmen';

  @override
  String get paymentMethods => 'Zahlungsmethoden';

  @override
  String get referFriends => 'Freunde einladen';

  @override
  String get language => 'Sprache';

  @override
  String get settings => 'Einstellungen';

  @override
  String get darkMode => 'Dunkelmodus';

  @override
  String get systemDefault => 'Systemstandard';

  @override
  String get languageUpdated => 'Sprache aktualisiert';

  @override
  String get languageSetToSystemDefault => 'Sprache auf Systemstandard gesetzt';

  @override
  String get helpAndSupport => 'Hilfe & Support';

  @override
  String get chatWithCustomerService => 'Mit dem Kundenservice chatten';

  @override
  String get aboutAndPolicies => 'Info & Richtlinien';

  @override
  String get viewUserPoliciesAndAgreements =>
      'Richtlinien und Vereinbarungen anzeigen';

  @override
  String get logOut => 'Abmelden';

  @override
  String get deleteAccount => 'Konto löschen';

  @override
  String get deleteAccountSubtitle =>
      'Diese Aktion kann nicht rückgängig gemacht werden';

  @override
  String get deleteAccountTitle => 'Konto löschen';

  @override
  String get deleteAccountConfirmBody =>
      'Möchten Sie Ihr Konto wirklich löschen?\n\nDiese Aktion meldet Sie ab und Sie können dauerhaft den Zugriff verlieren.';

  @override
  String get no => 'Nein';

  @override
  String get yesDelete => 'Ja, löschen';

  @override
  String get deleteAccountSheetTitle => 'Schade, dass Sie gehen.';

  @override
  String get deleteAccountSheetPrompt =>
      'Können Sie uns sagen warum? (Alle zutreffenden auswählen)';

  @override
  String get deleteAccountSelectAtLeastOneReason =>
      'Bitte wählen Sie mindestens einen Grund aus.';

  @override
  String get tellUsMoreOptional => 'Erzählen Sie uns mehr (optional)';

  @override
  String get suggestionsToImproveOptional =>
      'Vorschläge zur Verbesserung (optional)';

  @override
  String get deleteMyAccount => 'Mein Konto löschen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get failedToDeleteAccount =>
      'Konto konnte nicht gelöscht werden. Bitte versuchen Sie es erneut.';

  @override
  String get choosePreferredLanguage => 'Bevorzugte Sprache auswählen';

  @override
  String get noteSomeTextMayStillAppearInEnglish =>
      'Hinweis: Dies ändert die App-Sprache. Einige Texte können weiterhin auf Englisch erscheinen, bis Übersetzungen hinzugefügt wurden.';

  @override
  String languageSetToName(Object name) {
    return 'Sprache auf $name gesetzt';
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
  String get confirmPassword => 'Passwort bestätigen';

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
  String get deletionReason1 => 'Ich brauche Styloria nicht mehr';

  @override
  String get deletionReason2 =>
      'Probleme bei der Kontoverifizierung (E-Mail/KYC)';

  @override
  String get deletionReason3 =>
      'Keine Services/Anbieter in meiner Nähe gefunden';

  @override
  String get deletionReason4 => 'Preise oder Gebühren waren zu hoch / unklar';

  @override
  String get deletionReason5 => 'Die App war verwirrend / schwer zu bedienen';

  @override
  String get deletionReason6 => 'Bugs oder Leistungsprobleme';

  @override
  String get deletionReason7 => 'Zahlungs-/Rückerstattungsprobleme';

  @override
  String get deletionReason8 => 'Schlechte Erfahrung mit einem Anbieter/Nutzer';

  @override
  String get deletionReason9 => 'Datenschutz- oder Sicherheitsbedenken';

  @override
  String get deletionReason10 => 'Ich habe dieses Konto aus Versehen erstellt';

  @override
  String get deletionReason11 => 'Ich wechsle zu einer anderen Plattform';

  @override
  String get deletionReason12 => 'Sonstiges';

  @override
  String get loginWelcomeTitle => 'Willkommen bei Styloria';

  @override
  String get loginWelcomeSubtitle =>
      'Melden Sie sich an, um Ihre Buchungen und Services zu verwalten.';

  @override
  String get loginFailedToLoadUserInfo =>
      'Login erfolgreich, aber Benutzerinfos konnten nicht geladen werden.';

  @override
  String get username => 'Benutzername';

  @override
  String get password => 'Passwort';

  @override
  String get required => 'Erforderlich';

  @override
  String get login => 'Anmelden';

  @override
  String get createNewAccount => 'Neues Konto erstellen';

  @override
  String get requestEmailVerificationCode =>
      'E-Mail-Bestätigungscode anfordern';

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
  String get pleaseEnterAddress => 'Bitte eine Adresse eingeben';

  @override
  String get locationUpdatedFromAddress =>
      'Standort anhand der Adresse aktualisiert';

  @override
  String get createAccountTitle => 'Konto erstellen';

  @override
  String get joinStyloria => 'Styloria beitreten';

  @override
  String get registerSubtitle =>
      'Erstellen Sie ein Konto, um Services zu buchen oder Anbieter zu werden';

  @override
  String get iWantTo => 'Ich möchte:';

  @override
  String get bookServices => 'Services buchen';

  @override
  String get provideServices => 'Services anbieten';

  @override
  String get personalInformation => 'Persönliche Informationen';

  @override
  String get firstName => 'Vorname';

  @override
  String get lastName => 'Nachname';

  @override
  String get selectDateOfBirth => 'Geburtsdatum auswählen';

  @override
  String get phoneNumber => 'Telefonnummer';

  @override
  String get pleaseEnterPhoneNumber => 'Bitte Telefonnummer eingeben';

  @override
  String get accountInformation => 'Kontoinformationen';

  @override
  String get chooseUniqueUsernameHint =>
      'Wählen Sie einen eindeutigen Benutzernamen';

  @override
  String get youAreCurrentlyUnavailable => 'Sie sind derzeit nicht verfügbar';

  @override
  String get toBrowseAndAcceptJobsEnableAvailability =>
      'Um Auftragsanfragen in der Nähe zu durchsuchen und anzunehmen, müssen Sie sich als buchbar einstellen.';

  @override
  String get goToProfileSettings => 'Zu den Profileinstellungen';

  @override
  String get tipToggleAvailableForBookings =>
      'Tipp: Schalten Sie \"Für Buchungen verfügbar\" in Ihrem Anbieterprofil ein, um Auftragsanfragen zu erhalten.';

  @override
  String requestedBy(String name) {
    return 'Angefragt von: $name';
  }

  @override
  String locationLabel(String address) {
    return 'Standort: $address';
  }

  @override
  String get email => 'E-Mail';

  @override
  String get emailHint => 'your@email.com';

  @override
  String get enterValidEmail => 'Gültige E-Mail eingeben';

  @override
  String get security => 'Sicherheit';

  @override
  String get passwordHintAtLeast10 => 'Mindestens 10 Zeichen';

  @override
  String get passwordMin10 =>
      'Das Passwort muss mindestens 10 Zeichen lang sein';

  @override
  String get iAgreeTo => 'Ich stimme den ';

  @override
  String get termsOfService => 'Nutzungsbedingungen';

  @override
  String get and => 'und';

  @override
  String get privacyPolicy => 'Datenschutzrichtlinie';

  @override
  String get passwordIsRequired => 'Passwort ist erforderlich';

  @override
  String get passwordsDoNotMatch => 'Passwörter stimmen nicht überein';

  @override
  String get pleaseSelectDob => 'Bitte wählen Sie Ihr Geburtsdatum.';

  @override
  String get pleaseSelectCountry => 'Bitte wählen Sie Ihr Land.';

  @override
  String get pleaseSelectCity => 'Bitte wählen Sie Ihre Stadt.';

  @override
  String get pleaseEnterValidPhone =>
      'Bitte geben Sie eine gültige Telefonnummer ein.';

  @override
  String get mustAcceptTerms => 'Sie müssen die Bedingungen akzeptieren.';

  @override
  String get mustBeAtLeast18 =>
      'Sie müssen mindestens 18 Jahre alt sein, um sich zu registrieren.';

  @override
  String get agreeToTerms =>
      'Ich stimme den Nutzungsbedingungen und der Datenschutzrichtlinie zu';

  @override
  String get createAccountButton => 'Konto erstellen';

  @override
  String get alreadyHaveAccount => 'Haben Sie bereits ein Konto?';

  @override
  String get emailVerifiedSuccessPleaseLogin =>
      'E-Mail erfolgreich verifiziert. Bitte anmelden.';

  @override
  String get pleaseVerifyEmailToContinue =>
      'Bitte verifizieren Sie Ihre E-Mail, um fortzufahren.';

  @override
  String get requestVerificationCodeTitle => 'Bestätigungscode anfordern';

  @override
  String get requestVerificationInstructions =>
      'Geben Sie Ihre E-Mail oder Ihren Benutzernamen ein.\nWir senden einen neuen Bestätigungscode an die E-Mail dieses Kontos.';

  @override
  String get emailOrUsername => 'E-Mail oder Benutzername';

  @override
  String get sendCode => 'Code senden';

  @override
  String get ifAccountExistsCodeSent =>
      'Wenn das Konto existiert, wurde ein Code gesendet.';

  @override
  String get failedToSendVerificationCode =>
      'Bestätigungscode konnte nicht gesendet werden.';

  @override
  String get verifyYourEmailTitle => 'E-Mail verifizieren';

  @override
  String get verificationCodeSentInfo =>
      'Ein Bestätigungscode wurde an die E-Mail dieses Kontos gesendet.';

  @override
  String emailVerificationInstructions(Object identifier) {
    return 'Geben Sie den 6-stelligen Code ein, der an die E-Mail dieses Kontos gesendet wurde:\n$identifier';
  }

  @override
  String get verificationCodeLabel => 'Bestätigungscode';

  @override
  String get sendingEllipsis => 'Senden...';

  @override
  String get resendCode => 'Code erneut senden';

  @override
  String get enter6DigitCodeError => 'Geben Sie den 6-stelligen Code ein.';

  @override
  String get verifyingEllipsis => 'Prüfen...';

  @override
  String get verify => 'Bestätigen';

  @override
  String get invalidOrExpiredCodeTryResending =>
      'Ungültiger oder abgelaufener Code. Versuchen Sie, ihn erneut zu senden.';

  @override
  String bookingTitle(Object id) {
    return 'Buchung #$id';
  }

  @override
  String get invalidBookingIdForChat => 'Ungültige Buchungs-ID für den Chat.';

  @override
  String get invalidBookingIdForCall => 'Ungültige Buchungs-ID für den Anruf.';

  @override
  String get unableToLoadContactInfo =>
      'Kontaktinformationen konnten nicht geladen werden. Stelle sicher, dass die Buchung aktiv ist.';

  @override
  String noPhoneNumberAvailableForName(Object name) {
    return 'Keine Telefonnummer verfügbar für $name.';
  }

  @override
  String get deviceCannotPlaceCalls =>
      'Dieses Gerät kann keine Telefonanrufe tätigen.';

  @override
  String get cancelBookingDialogTitle => 'Buchung stornieren';

  @override
  String get cancelBookingDialogBody =>
      'Möchtest du diese Buchung wirklich stornieren?\n\nHinweis: Wenn der Anbieter bereits angenommen hat und mehr als 7 Minuten vergangen sind (aber weniger als ca. 40 Minuten), kann gemäß den Regeln eine Strafe/Gebühr anfallen.';

  @override
  String get yesCancel => 'Ja, stornieren';

  @override
  String get failedToCancelBooking => 'Buchung konnte nicht storniert werden.';

  @override
  String bookingCancelledPenaltyApplied(Object amount) {
    return 'Buchung storniert. Eine Strafe in Höhe von $amount wurde angewendet.';
  }

  @override
  String get bookingCancelledSuccessfully => 'Buchung erfolgreich storniert.';

  @override
  String get failedToConfirmCompletion =>
      'Abschluss konnte nicht bestätigt werden. Bitte versuche es erneut.';

  @override
  String get bothSidesConfirmedCompletedPayoutReleased =>
      'Beide Seiten haben bestätigt. Die Buchung wurde als abgeschlossen markiert und die Auszahlung freigegeben.';

  @override
  String get youConfirmedCompletionWaitingForProvider =>
      'Du hast den Abschluss bestätigt. Warten auf Bestätigung des Anbieters.';

  @override
  String get youConfirmedCompletionWaitingForUser =>
      'Du hast den Abschluss bestätigt. Warten auf Bestätigung des Nutzers.';

  @override
  String get statusUnknown => 'unbekannt';

  @override
  String get statusAccepted => 'angenommen';

  @override
  String get statusInProgress => 'in Arbeit';

  @override
  String get statusCompleted => 'abgeschlossen';

  @override
  String get statusCancelled => 'storniert';

  @override
  String get paymentPaid => 'bezahlt';

  @override
  String get paymentPending => 'ausstehend';

  @override
  String get paymentFailed => 'fehlgeschlagen';

  @override
  String bookingAcceptedBy(Object name) {
    return 'Buchung angenommen von $name';
  }

  @override
  String get whenLabel => 'Wann';

  @override
  String atTime(Object time) {
    return 'um $time';
  }

  @override
  String get userLabel => 'Nutzer';

  @override
  String get providerLabel => 'Anbieter';

  @override
  String get estimatedPriceLabel => 'Geschätzter Preis';

  @override
  String get offeredPaidLabel => 'Angeboten / bezahlt';

  @override
  String get distanceLabel => 'Entfernung';

  @override
  String distanceMiles(Object miles) {
    return '$miles Meilen';
  }

  @override
  String get acceptedAtLabel => 'Angenommen um';

  @override
  String get cancelledAtLabel => 'Storniert um';

  @override
  String get cancelledByLabel => 'Storniert von';

  @override
  String penaltyAppliedLabel(Object amount) {
    return 'Strafe angewendet: $amount';
  }

  @override
  String get userConfirmedLabel => 'Nutzer bestätigt';

  @override
  String get providerConfirmedLabel => 'Anbieter bestätigt';

  @override
  String get payoutReleasedLabel => 'Auszahlung freigegeben';

  @override
  String get yesLower => 'ja';

  @override
  String get noLower => 'nein';

  @override
  String get chat => 'Chat';

  @override
  String get call => 'Anrufen';

  @override
  String get actions => 'Aktionen';

  @override
  String get confirmCompletion => 'Abschluss bestätigen';

  @override
  String get noFurtherActionsForBooking =>
      'Für diese Buchung sind keine weiteren Aktionen verfügbar.';

  @override
  String freeCancellationEndsIn(Object time) {
    return 'Kostenlose Stornierung endet in $time';
  }

  @override
  String get earlyFreeCancellationEndedWarning =>
      'Die frühe kostenlose Stornierung ist beendet. Bis etwa 40 Minuten nach Annahme können späte Stornierungen eine Strafe verursachen.';

  @override
  String get cancelBooking => 'Buchung stornieren';

  @override
  String get cancelBookingNoPenalty => 'Buchung stornieren (ohne Strafe)';

  @override
  String get cancelBookingPenaltyMayApply =>
      'Buchung stornieren (Strafe möglich)';

  @override
  String get cancellationPolicyInfo =>
      'Du kannst in den ersten 7 Minuten nach Annahme durch den Anbieter ohne Strafe stornieren und bei Bedarf erneut nach etwa 40 Minuten. Dazwischen kann gemäß den Regeln eine Strafe anfallen.';

  @override
  String ratingLine(Object rating, int reviewCount) {
    String _temp0 = intl.Intl.pluralLogic(
      reviewCount,
      locale: localeName,
      other: '$reviewCount Bewertungen',
      one: '1 Bewertung',
    );
    return 'Bewertung: $rating ($_temp0)';
  }

  @override
  String get proofOfSkillsPortfolio => 'Nachweis der Fähigkeiten (Portfolio)';

  @override
  String get noPortfolioPostsAvailable => 'Keine Portfolio-Beiträge verfügbar.';

  @override
  String get bookingLocation => 'Buchungsort';

  @override
  String get location => 'Ort';

  @override
  String get latitude => 'Breitengrad';

  @override
  String get longitude => 'Längengrad';

  @override
  String get mapWillAppearWhenCoordinatesValid =>
      'Die Karte wird hier angezeigt, wenn die Koordinaten gültig sind.';

  @override
  String chatForBookingTitle(Object id) {
    return 'Chat für Buchung #$id';
  }

  @override
  String get unableToStartChat =>
      'Chat konnte nicht gestartet werden. Chat ist nur verfügbar, wenn die Buchung angenommen, in Arbeit oder innerhalb des letzten Tages abgeschlossen wurde.';

  @override
  String get invalidChatThreadFromServer =>
      'Ungültiger Chat-Thread vom Server zurückgegeben.';

  @override
  String get messageNotSentPolicy =>
      'Nachricht nicht gesendet. Hinweis: Das Teilen von Telefonnummern oder E-Mails ist im Chat nicht erlaubt.';

  @override
  String get unknown => 'Unbekannt';

  @override
  String get typeMessageHint => 'Nachricht an den Support schreiben...';

  @override
  String get uploadProfilePicture => 'Profilbild hochladen';

  @override
  String get currentProfilePicture => 'Aktuelles Profilbild';

  @override
  String get newPicturePreview => 'Vorschau des neuen Bildes';

  @override
  String get chooseImage => 'Bild auswählen';

  @override
  String get upload => 'Hochladen';

  @override
  String get noImageBytesFoundWeb => 'Keine Bild-Bytes gefunden (Web).';

  @override
  String get pleasePickAnImageFirst => 'Bitte wähle zuerst ein Bild aus.';

  @override
  String get uploadFailedCheckServerLogs =>
      'Upload fehlgeschlagen. Server-Logs / Token prüfen.';

  @override
  String get profilePictureUploadedSuccessfully =>
      'Profilbild erfolgreich hochgeladen!';

  @override
  String errorWithValue(Object error) {
    return 'Fehler: $error';
  }

  @override
  String get tapToChangeProfilePicture => 'Tippe, um das Profilbild zu ändern';

  @override
  String usernameValue(Object username) {
    return 'Benutzername: $username';
  }

  @override
  String roleValue(Object role) {
    return 'Rolle: $role';
  }

  @override
  String get dateOfBirthYyyyMmDd => 'Geburtsdatum (YYYY-MM-DD)';

  @override
  String get saveProfile => 'Profil speichern';

  @override
  String get failedToSaveProfile =>
      'Profil konnte nicht gespeichert werden. Bitte versuche es erneut.';

  @override
  String get profileUpdated => 'Profil aktualisiert.';

  @override
  String get completeYourProviderProfile =>
      'Vervollständige dein Anbieterprofil';

  @override
  String get completeProviderProfileBody =>
      'Um Jobs anzunehmen und Geld zu verdienen, vervollständige dein Anbieterprofil.';

  @override
  String get setupProfileNow => 'Profil jetzt einrichten';

  @override
  String get doItLater => 'Später';

  @override
  String get bookingTimerPenaltyPeriodActive => 'Strafzeit aktiv';

  @override
  String get bookingTimerFreeCancellationPeriod =>
      'Kostenlose Stornierungszeit';

  @override
  String bookingTimerTimeRemaining(Object time) {
    return 'Verbleibende Zeit: $time';
  }

  @override
  String get bookingTimerCancellingNowPenalty =>
      'Wenn du jetzt stornierst, fällt eine Strafe von 10 % an.';

  @override
  String get bookingTimerCancelNoPenalty => 'Du kannst ohne Strafe stornieren.';

  @override
  String get myReviewsTitle => 'Meine Bewertungen';

  @override
  String get failedToLoadReviews => 'Bewertungen konnten nicht geladen werden.';

  @override
  String get noReviewsYet => 'Du hast noch keine Bewertungen abgegeben.';

  @override
  String providerWithName(Object name) {
    return 'Anbieter: $name';
  }

  @override
  String get providerGeneric => 'Anbieter';

  @override
  String ratingWithValue(Object rating) {
    return 'Bewertung: $rating';
  }

  @override
  String get nearbyOpenJobsTitle => 'Offene Jobs in der Nähe';

  @override
  String get failedToLoadOpenJobsHint =>
      'Offene Jobs konnten nicht geladen werden.\nStelle sicher, dass du ein Anbieterprofil mit gesetzter Position und available=true hast.';

  @override
  String errorLoadingJobsWithValue(Object error) {
    return 'Fehler beim Laden der Jobs: $error';
  }

  @override
  String get noOpenJobsFoundNearbyTitle =>
      'Keine offenen Jobs in der Nähe gefunden';

  @override
  String get noOpenJobsFoundNearbyBody =>
      'Stelle sicher:\n- Du hast deinen Anbieter-Standort gesetzt\n- Du bist als verfügbar markiert\n- Nutzer haben Buchungen erstellt und bezahlt';

  @override
  String currencyLabel(Object symbol) {
    return 'Währung: $symbol';
  }

  @override
  String pricesShownInCurrency(Object symbol, Object country) {
    return 'Preise angezeigt in $symbol ($country)';
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
    return 'Wann: $date $time';
  }

  @override
  String priceLine(Object price) {
    return 'Preis: $price';
  }

  @override
  String get acceptJob => 'Job annehmen';

  @override
  String get failedToAcceptJob => 'Job konnte nicht angenommen werden.';

  @override
  String get jobAcceptedSuccessfully => 'Job erfolgreich angenommen.';

  @override
  String get newServiceRequestTitle => 'Neue Service-Anfrage';

  @override
  String get reviewAlreadySubmitted => 'Review submitted ✓';

  @override
  String get offeredPriceLabel => 'Angebotener Preis';

  @override
  String get offeredPriceHint => 'z. B. 25.00';

  @override
  String get enterValidPrice => 'Gib einen gültigen Preis ein';

  @override
  String get bookAndPay => 'Buchen & bezahlen';

  @override
  String bookAndPayAmount(Object amount) {
    return 'Buchen & bezahlen $amount';
  }

  @override
  String get haircutService => 'Haarschnitt';

  @override
  String get stylingService => 'Styling';

  @override
  String get timeLabel => 'Zeit:';

  @override
  String get notesLabel => 'Notizen';

  @override
  String get requestCreatedAndPaidBroadcast =>
      'Anfrage erstellt & bezahlt! An Anbieter gesendet.';

  @override
  String locationLatLng(Object lat, Object lng) {
    return 'Standort: $lat, $lng';
  }

  @override
  String get paymentMethodsTitle => 'Zahlungsmethoden';

  @override
  String get paymentPreferencesInfo =>
      'Diese Einstellungen werden lokal auf deinem Gerät gespeichert. Echte Zahlungen werden sicher über Stripe/andere Gateways verarbeitet.';

  @override
  String get preferredMethodLabel =>
      'Bevorzugte Methode (lokales Gateway wird nach Land gewählt)';

  @override
  String get methodVisaMastercard => 'Visa/Mastercard';

  @override
  String get methodMobileMoney => 'Mobile Money (Momo/Paystack/Afrika)';

  @override
  String get methodPaypal => 'PayPal';

  @override
  String get methodApplePayGooglePay => 'Apple Pay/Google Pay';

  @override
  String get methodWeChatPay => 'WeChat Pay (China)';

  @override
  String get methodAlipay => 'Alipay (China)';

  @override
  String get methodUnionPay => 'UnionPay-Karte (China)';

  @override
  String get mobileMoneyNumberLabel => 'Mobile-Money-Nummer';

  @override
  String get wechatAlipayIdLabel => 'WeChat/Alipay-ID';

  @override
  String get cardLast4DigitsLabel => 'Letzte 4 Ziffern der Karte';

  @override
  String get paypalEmailLabel => 'PayPal-E-Mail';

  @override
  String get applePayEnabledOnDevice => 'Apple Pay auf diesem Gerät aktiviert';

  @override
  String get savePaymentPreferences => 'Zahlungseinstellungen speichern';

  @override
  String get paymentPrefsSavedInfo =>
      'Zahlungseinstellungen lokal gespeichert. Das tatsächliche Abbuchen erfolgt später über Stripe/andere Gateways.';

  @override
  String get failedToLoadImage => 'Bild konnte nicht geladen werden';

  @override
  String get earningsTitle => 'Einnahmen';

  @override
  String get couldNotLoadEarningsSummary =>
      'Einnahmenübersicht konnte nicht geladen werden.';

  @override
  String get noData => 'Keine Daten.';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get summaryTitle => 'Übersicht';

  @override
  String get totalLabel => 'Gesamt';

  @override
  String get pendingLabel => 'Ausstehend';

  @override
  String get paidLabel => 'Ausgezahlt';

  @override
  String get pdfReportTitle => 'PDF-Bericht';

  @override
  String get periodLabel => 'Zeitraum';

  @override
  String get periodThisMonth => 'Diesen Monat';

  @override
  String get periodLastMonth => 'Letzten Monat';

  @override
  String get periodYtd => 'Seit Jahresbeginn';

  @override
  String get periodAllTime => 'Gesamter Zeitraum';

  @override
  String get couldNotDownloadPdfReport =>
      'PDF-Bericht konnte nicht heruntergeladen werden.';

  @override
  String couldNotOpenPdfWithValue(Object error) {
    return 'PDF konnte nicht geöffnet werden: $error';
  }

  @override
  String get savingFilesNotSupportedWeb =>
      'Dateien speichern wird im Web derzeit nicht unterstützt.';

  @override
  String savedToDocumentsIosWithPath(Object path) {
    return 'In Documents (iOS) gespeichert:\n$path';
  }

  @override
  String savedToFilesWithPath(Object path) {
    return 'In Dateien gespeichert:\n$path';
  }

  @override
  String get open => 'Öffnen';

  @override
  String failedToSavePdfWithValue(Object error) {
    return 'PDF konnte nicht gespeichert werden: $error';
  }

  @override
  String get openPdfReport => 'PDF-Bericht öffnen';

  @override
  String get savePdfToDownloads => 'PDF in Downloads speichern';

  @override
  String get reportWatermarkNote =>
      'Der PDF-Bericht sollte das Styloria-Wasserzeichen enthalten.';

  @override
  String get referFriendsTitle => 'Freunde werben';

  @override
  String get shareReferralCodeBody =>
      'Teile deinen Empfehlungscode mit Freunden. Später kannst du Belohnungen hinzufügen, wenn sie sich anmelden und Buchungen abschließen.';

  @override
  String get yourReferralCodeLabel => 'Dein Empfehlungscode:';

  @override
  String get copy => 'Kopieren';

  @override
  String referralCodeCopiedWithCode(Object code) {
    return 'Empfehlungscode kopiert: $code';
  }

  @override
  String get navHome => 'Home';

  @override
  String get navBookings => 'Buchungen';

  @override
  String get navNotifications => 'Benachrichtigungen';

  @override
  String get navAccount => 'Konto';

  @override
  String get welcome => 'Willkommen';

  @override
  String welcomeName(Object name) {
    return 'Willkommen, $name';
  }

  @override
  String get toggleThemeTooltip => 'Hell/Dunkel-Modus umschalten';

  @override
  String loggedInAs(Object role) {
    return 'Angemeldet als: $role';
  }

  @override
  String locationWithValue(Object value) {
    return 'Standort: $value';
  }

  @override
  String get homeTagline =>
      'Verbessere dein Grooming-Erlebnis mit Echtzeit-Buchungen und vertrauenswürdigen Anbietern.';

  @override
  String get manageProviderProfile => 'Anbieterprofil verwalten';

  @override
  String get browseOpenJobs => 'Offene Jobs durchsuchen';

  @override
  String get quickActions => 'Schnellaktionen';

  @override
  String get newBooking => 'Neue Buchung';

  @override
  String notificationsWithUnread(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ungelesen',
      one: '1 ungelesen',
    );
    return 'Benachrichtigungen ($_temp0)';
  }

  @override
  String get liveLocationTrackingTitle => 'Live-Standortverfolgung';

  @override
  String get live => 'Live';

  @override
  String get locationServicesDisabled => 'Standortdienste sind deaktiviert';

  @override
  String get locationPermissionDenied => 'Standortberechtigung verweigert';

  @override
  String get locationPermissionPermanentlyDenied =>
      'Standortberechtigung dauerhaft verweigert';

  @override
  String failedToGetLocationWithValue(Object error) {
    return 'Standort konnte nicht abgerufen werden: $error';
  }

  @override
  String get youProvider => 'Du (Anbieter)';

  @override
  String get youCustomer => 'Du (Kunde)';

  @override
  String get customer => 'Kunde';

  @override
  String get bookingDetails => 'Buchungsdetails';

  @override
  String get navigate => 'Navigieren';

  @override
  String get failedToLoadNotifications =>
      'Benachrichtigungen konnten nicht geladen werden.';

  @override
  String get failedToMarkAsRead => 'Konnte nicht als gelesen markieren';

  @override
  String get noNotificationsYet => 'Noch keine Benachrichtigungen.';

  @override
  String get markRead => 'Als gelesen markieren';

  @override
  String get providerKycTitle => 'Anbieter-Verifizierung (KYC)';

  @override
  String get logoutTooltip => 'Abmelden';

  @override
  String statusLabel(Object status) {
    return 'Status: $status';
  }

  @override
  String rejectedWithNotes(Object notes) {
    return 'Abgelehnt: $notes';
  }

  @override
  String get kycInstructions =>
      'Um Anbieterfunktionen zu nutzen, laden Sie Ihren Ausweis und ein Selfie zur Verifizierung hoch.';

  @override
  String get idFrontRequired => 'Ausweis Vorderseite (erforderlich)';

  @override
  String get selectIdFront => 'Vorderseite auswählen';

  @override
  String get idBackRequired => 'Ausweis Rückseite (erforderlich)';

  @override
  String get selectIdBackRequired => 'Rückseite auswählen';

  @override
  String get selfieRequired => 'Selfie (erforderlich)';

  @override
  String get selectSelfie => 'Selfie auswählen';

  @override
  String get takeSelfie => 'Selfie aufnehmen';

  @override
  String get errorUploadAllRequired =>
      'Bitte laden Sie Ausweis (Vorderseite), Ausweis (Rückseite) und ein Selfie hoch.';

  @override
  String failedSubmitKycCode(Object code) {
    return 'KYC konnte nicht gesendet werden (Code $code).';
  }

  @override
  String submittedCurrentStatus(Object status) {
    return 'Gesendet. Aktueller Status: $status';
  }

  @override
  String get unknownStatus => 'unbekannt';

  @override
  String get submitKyc => 'KYC senden';

  @override
  String get verificationMayTakeTimeNote =>
      'Hinweis: Die Verifizierung kann einige Zeit dauern. Sie können Anbieterfunktionen nach Genehmigung nutzen.';

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
  String get enterVerificationCodeTitle => 'Bestätigungscode eingeben';

  @override
  String otpSentToUsername(Object username) {
    return 'Wir haben einen 6-stelligen Code an die Telefonnummer\nvon \"$username\" gesendet.';
  }

  @override
  String get sixDigitCodeLabel => '6-stelliger Code';

  @override
  String get enterSixDigitCodeValidation =>
      'Geben Sie den 6-stelligen Code ein';

  @override
  String get otpInvalidOrExpired => 'Ungültiger oder abgelaufener Code.';

  @override
  String get failedLoadUserInfoAfterVerification =>
      'Benutzerinformationen konnten nach der Verifizierung nicht geladen werden.';

  @override
  String get chatWithSupportTitle => 'Chat mit dem Support';

  @override
  String get unableStartSupportChat =>
      'Support-Chat konnte nicht gestartet werden.';

  @override
  String get invalidSupportThreadReturned =>
      'Ungültiger Support-Thread vom Server zurückgegeben.';

  @override
  String get noMessagesYet =>
      'Noch keine Nachrichten. Starten Sie eine Unterhaltung!';

  @override
  String get supportDefaultName => 'Support';

  @override
  String get aboutPoliciesTitle => 'Über uns & Richtlinien';

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
    return '$providerName bewerten';
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
    return 'Profil konnte nicht geladen werden: $error';
  }

  @override
  String profileSavedSuccess(Object action) {
    return 'Profil erfolgreich $action!';
  }

  @override
  String genericError(Object error) {
    return 'Fehler: $error';
  }

  @override
  String get locationPermissionDeniedEnableInSettings =>
      'Standortberechtigung abgelehnt. Bitte in den Einstellungen aktivieren.';

  @override
  String get locationPermissionPermanentlyDeniedEnableInAppSettings =>
      'Standortberechtigung dauerhaft abgelehnt. Bitte in den App-Einstellungen aktivieren.';

  @override
  String errorGettingLocation(Object error) {
    return 'Fehler beim Abrufen des Standorts: $error';
  }

  @override
  String get couldNotFindLocationForAddress =>
      'Standort für diese Adresse konnte nicht gefunden werden';

  @override
  String errorConvertingAddress(Object error) {
    return 'Fehler beim Umwandeln der Adresse: $error';
  }

  @override
  String get portfolioUnavailableCompleteKycFirst =>
      'Portfolio nicht verfügbar. Wenn du Anbieter bist, schließe zuerst die KYC-Verifizierung ab.';

  @override
  String failedToLoadPortfolio(Object error) {
    return 'Portfolio konnte nicht geladen werden: $error';
  }

  @override
  String get addPhoto => 'Foto hinzufügen';

  @override
  String get addVideo => 'Video hinzufügen';

  @override
  String get addPost => 'Beitrag hinzufügen';

  @override
  String get captionOptionalTitle => 'Bildunterschrift (optional)';

  @override
  String get captionHintExample => 'z. B. „Knotless Braids beim Kunden“';

  @override
  String get skip => 'Überspringen';

  @override
  String get save => 'Speichern';

  @override
  String get failedToCreatePortfolioPost =>
      'Portfolio-Beitrag konnte nicht erstellt werden.';

  @override
  String get uploadFailedMediaUpload =>
      'Upload fehlgeschlagen (Medien-Upload).';

  @override
  String uploadFailed(Object error) {
    return 'Upload fehlgeschlagen: $error';
  }

  @override
  String get deletePostTitle => 'Beitrag löschen?';

  @override
  String get deletePostBody =>
      'Dadurch wird der Beitrag aus deinem Portfolio entfernt.';

  @override
  String get delete => 'Löschen';

  @override
  String get deleteFailed => 'Löschen fehlgeschlagen.';

  @override
  String deleteFailedWithError(Object error) {
    return 'Löschen fehlgeschlagen: $error';
  }

  @override
  String get portfolioTitle => 'Portfolio';

  @override
  String get noPortfolioPostsYetHelpText =>
      'Noch keine Portfolio-Beiträge. Füge Fotos/Videos deiner Arbeit hinzu, damit Kunden deinen Fähigkeiten vertrauen.';

  @override
  String get setupProviderProfileTitle => 'Anbieterprofil einrichten';

  @override
  String get providerProfileTitle => 'Anbieterprofil';

  @override
  String get welcomeToStyloriaTitle => 'Willkommen bei Styloria!';

  @override
  String get completeProviderProfileToStartEarning =>
      'Vervollständige dein Anbieterprofil, um Jobs anzunehmen und Geld zu verdienen.';

  @override
  String reviewCountLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Bewertungen',
      one: 'Bewertung',
    );
    return '($count $_temp0)';
  }

  @override
  String get topRatedChip => 'Top bewertet';

  @override
  String get bioLabel => 'Bio / Beschreibung';

  @override
  String get bioHint =>
      'Erzähle Kunden von deinen Fähigkeiten und Erfahrungen...';

  @override
  String get pleaseEnterBio => 'Bitte eine Bio eingeben';

  @override
  String bioMinLength(int min) {
    return 'Die Bio sollte mindestens $min Zeichen haben';
  }

  @override
  String get yourLocationTitle => 'Dein Standort';

  @override
  String get locationHelpMatchNearbyClients =>
      'Dein Standort hilft uns, dich mit Kunden in der Nähe zu verbinden';

  @override
  String get locationHelpUpdateToFindJobs =>
      'Aktualisiere deinen Standort, um Jobs in anderen Bereichen zu finden';

  @override
  String get useMyCurrentLocationTitle => 'Meinen aktuellen Standort verwenden';

  @override
  String get gpsSubtitle => 'Standort automatisch per GPS ermitteln';

  @override
  String get orLabel => 'ODER';

  @override
  String get enterYourAddressTitle => 'Adresse eingeben';

  @override
  String get fullAddressLabel => 'Vollständige Adresse';

  @override
  String get fullAddressHint => 'z. B. 123 Main St, Accra, Ghana';

  @override
  String get find => 'Suchen';

  @override
  String get addressHelpText => 'Straße, Stadt und Land eingeben';

  @override
  String get coordinatesAutoFilledTitle =>
      'Koordinaten (automatisch ausgefüllt)';

  @override
  String get servicePricingTitle => 'Service-Preise';

  @override
  String get servicePricingHelp =>
      'Lege deinen Preis für jeden Service fest. Aktiviere „Nicht angeboten“ für Services, die du nicht anbietest.';

  @override
  String get serviceHeader => 'Service';

  @override
  String get priceHeader => 'Preis';

  @override
  String get notOfferedHeader => 'Nicht angeboten';

  @override
  String get priceHint => '0.00';

  @override
  String get providerHowPricingWorksTitle =>
      'So funktioniert die Preisgestaltung:';

  @override
  String get providerHowPricingWorksBody =>
      '• Dein Preis ist das, was du für den Service berechnest\n• Transportkosten = 80% der Währung des Nutzers pro km\n• Nutzer sehen 3 Optionen basierend auf Anbietern in der Nähe:\n  - Budget: Niedrigster Preis\n  - Standard: Durchschnittspreis\n  - Priority: Höchster Preis';

  @override
  String get availableForBookingsTitle => 'Für Buchungen verfügbar';

  @override
  String get availableOnHelp =>
      '✓ Du erscheinst in Suchergebnissen für Kunden in der Nähe';

  @override
  String get availableOffHelp => '✗ Du erhältst keine neuen Jobangebote';

  @override
  String get completeSetupStartEarning => 'Setup abschließen und verdienen';

  @override
  String get updateProfile => 'Profil aktualisieren';

  @override
  String get skipForNow => 'Vorerst überspringen';

  @override
  String get paymentsNotSupportedShort =>
      'Zahlungen werden auf dieser Plattform nicht unterstützt. Bitte auf Android, iOS, macOS oder Web ausführen.';

  @override
  String get genericContact => 'Kontakt';

  @override
  String get genericProvider => 'Dienstleister';

  @override
  String get genericNotAvailable => 'k. A.';

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
  String get reviewSelectRatingPrompt => 'Wähle eine Bewertung (1 bis 5).';

  @override
  String get reviewCommentOptionalLabel => 'Kommentar (optional)';

  @override
  String get genericCancel => 'Abbrechen';

  @override
  String get genericSubmit => 'Senden';

  @override
  String get reviewSubmitFailed => 'Bewertung konnte nicht gesendet werden.';

  @override
  String get rateThisService => 'Diese Leistung bewerten';

  @override
  String get tipLeaveTitle => 'Trinkgeld geben';

  @override
  String get tipChooseAmountPrompt =>
      'Wähle einen Trinkgeldbetrag oder gib einen eigenen Betrag ein.';

  @override
  String get tipNoTip => 'Kein Trinkgeld';

  @override
  String get tipCustomAmountLabel => 'Eigener Trinkgeldbetrag';

  @override
  String get genericContinue => 'Weiter';

  @override
  String get tipSkipped => 'Trinkgeld übersprungen.';

  @override
  String get tipFailedToSaveChoice =>
      'Trinkgeld-Auswahl konnte nicht gespeichert werden.';

  @override
  String get tipFailedToCreatePayment =>
      'Trinkgeld-Zahlung konnte nicht erstellt werden.';

  @override
  String get tipPaidSuccessfully => 'Trinkgeld erfolgreich bezahlt. Danke!';

  @override
  String get tipPaidButUpdateFailed =>
      'Trinkgeldzahlung erfolgreich, aber die Buchung konnte nicht aktualisiert werden.';

  @override
  String tipCancelledOrFailed(Object message) {
    return 'Trinkgeld abgebrochen/fehlgeschlagen: $message';
  }

  @override
  String tipUnexpectedError(Object error) {
    return 'Unerwarteter Trinkgeld-Fehler: $error';
  }

  @override
  String get tipAlreadyPaidLabel => 'Trinkgeld bereits bezahlt';

  @override
  String get tipSkippedLabel => 'Trinkgeld übersprungen';

  @override
  String get tipLeaveButton => 'Trinkgeld geben';

  @override
  String get walletTitle => 'Wallet';

  @override
  String get walletTooltip => 'Wallet';

  @override
  String get payoutSettingsTitle => 'Auszahlungseinstellungen';

  @override
  String get payoutSettingsTooltip => 'Auszahlungseinstellungen';

  @override
  String get walletNoWalletYet =>
      'Noch kein Wallet. Schließe Jobs ab, um zu verdienen.';

  @override
  String get walletCurrencyFieldLabel => 'Währung';

  @override
  String walletAvailableLine(Object amount, Object currency) {
    return 'Verfügbar: $amount $currency';
  }

  @override
  String walletPendingLine(Object amount, Object currency) {
    return 'Ausstehend: $amount $currency';
  }

  @override
  String get walletCashOutInstant => 'Sofort auszahlen';

  @override
  String get walletCashOutFailed => 'Auszahlung fehlgeschlagen.';

  @override
  String walletCashOutSentTransfer(Object transferId) {
    return 'Auszahlung gesendet. Transfer: $transferId';
  }

  @override
  String get walletTransactionsTitle => 'Transaktionen';

  @override
  String get walletNoTransactionsYet => 'Noch keine Transaktionen.';

  @override
  String get payoutAutoPayoutsTitle => 'Automatische Auszahlungen';

  @override
  String get payoutAutoPayoutsSubtitle =>
      'Auszahlungen automatisch nach deinem Zeitplan senden.';

  @override
  String get payoutDayUtcLabel => 'Auszahlungstag (UTC)';

  @override
  String get payoutHourUtcLabel => 'Auszahlungsstunde (UTC)';

  @override
  String get payoutMinimumAmountLabel =>
      'Mindestbetrag für automatische Auszahlung';

  @override
  String get payoutMinimumAmountHelper =>
      'Automatische Auszahlung nur, wenn der verfügbare Kontostand ≥ diesem Betrag ist.';

  @override
  String get payoutInstantCashOutEnabledTitle => 'Sofortauszahlung aktiviert';

  @override
  String get payoutInstantCashOutEnabledSubtitle =>
      'Die Schaltfläche „Sofort auszahlen“ erlauben (Gebühr fällt an).';

  @override
  String get payoutSettingsSaved => 'Auszahlungseinstellungen gespeichert.';

  @override
  String get payoutSettingsSaveFailed =>
      'Auszahlungseinstellungen konnten nicht gespeichert werden.';

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
