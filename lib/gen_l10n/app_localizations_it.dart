// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Styloria';

  @override
  String get account => 'Account';

  @override
  String get profile => 'Profilo';

  @override
  String get myBookings => 'Le mie prenotazioni';

  @override
  String get openJobs => 'Lavori aperti';

  @override
  String get earnings => 'Guadagni';

  @override
  String get paymentMethods => 'Metodi di pagamento';

  @override
  String get referFriends => 'Invita amici';

  @override
  String get language => 'Lingua';

  @override
  String get settings => 'Impostazioni';

  @override
  String get darkMode => 'Modalità scura';

  @override
  String get systemDefault => 'Predefinito di sistema';

  @override
  String get languageUpdated => 'Lingua aggiornata';

  @override
  String get languageSetToSystemDefault =>
      'Lingua impostata su quella di sistema';

  @override
  String get helpAndSupport => 'Aiuto e supporto';

  @override
  String get chatWithCustomerService => 'Chat con il servizio clienti';

  @override
  String get aboutAndPolicies => 'Info e policy';

  @override
  String get viewUserPoliciesAndAgreements =>
      'Visualizza policy e accordi utente';

  @override
  String get logOut => 'Esci';

  @override
  String get deleteAccount => 'Elimina account';

  @override
  String get deleteAccountSubtitle => 'Questa azione non può essere annullata';

  @override
  String get deleteAccountTitle => 'Elimina account';

  @override
  String get deleteAccountConfirmBody =>
      'Sei sicuro di voler eliminare il tuo account?\n\nQuesta azione ti disconnetterà e potresti perdere l’accesso in modo permanente.';

  @override
  String get no => 'No';

  @override
  String get yesDelete => 'Sì, elimina';

  @override
  String get deleteAccountSheetTitle => 'Ci dispiace vederti andare via.';

  @override
  String get deleteAccountSheetPrompt =>
      'Puoi dirci perché? (Seleziona tutte le opzioni pertinenti)';

  @override
  String get deleteAccountSelectAtLeastOneReason =>
      'Seleziona almeno un motivo.';

  @override
  String get tellUsMoreOptional => 'Dicci di più (opzionale)';

  @override
  String get suggestionsToImproveOptional =>
      'Suggerimenti per migliorare (opzionale)';

  @override
  String get deleteMyAccount => 'Elimina il mio account';

  @override
  String get cancel => 'Annulla';

  @override
  String get failedToDeleteAccount =>
      'Impossibile eliminare l’account. Riprova.';

  @override
  String get choosePreferredLanguage => 'Scegli la lingua preferita';

  @override
  String get noteSomeTextMayStillAppearInEnglish =>
      'Nota: questo cambia la lingua dell’app. Alcuni testi potrebbero ancora apparire in inglese finché non vengono aggiunte le traduzioni.';

  @override
  String languageSetToName(Object name) {
    return 'Lingua impostata su $name';
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
  String get confirmPassword => 'Conferma password';

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
  String get deletionReason1 => 'Non ho più bisogno di Styloria';

  @override
  String get deletionReason2 =>
      'Ho avuto problemi a verificare l’account (email/KYC)';

  @override
  String get deletionReason3 => 'Non ho trovato servizi/provider vicino a me';

  @override
  String get deletionReason4 =>
      'Prezzi o commissioni troppo alti / poco chiari';

  @override
  String get deletionReason5 => 'L’app era confusa / difficile da usare';

  @override
  String get deletionReason6 => 'Bug o problemi di prestazioni';

  @override
  String get deletionReason7 => 'Problemi di pagamento/rimborso';

  @override
  String get deletionReason8 => 'Brutta esperienza con un provider/utente';

  @override
  String get deletionReason9 => 'Dubbi su privacy o sicurezza';

  @override
  String get deletionReason10 => 'Ho creato questo account per errore';

  @override
  String get deletionReason11 => 'Sto passando a un’altra piattaforma';

  @override
  String get deletionReason12 => 'Altro';

  @override
  String get loginWelcomeTitle => 'Benvenuto su Styloria';

  @override
  String get loginWelcomeSubtitle =>
      'Accedi per gestire prenotazioni e servizi.';

  @override
  String get loginFailedToLoadUserInfo =>
      'Accesso riuscito ma impossibile caricare le informazioni utente.';

  @override
  String get username => 'Nome utente';

  @override
  String get password => 'Password';

  @override
  String get required => 'Obbligatorio';

  @override
  String get login => 'Accedi';

  @override
  String get createNewAccount => 'Crea un nuovo account';

  @override
  String get requestEmailVerificationCode =>
      'Richiedi codice di verifica email';

  @override
  String get createAccountTitle => 'Crea account';

  @override
  String get joinStyloria => 'Unisciti a Styloria';

  @override
  String get registerSubtitle =>
      'Crea un account per prenotare servizi o diventare provider';

  @override
  String get iWantTo => 'Voglio:';

  @override
  String get bookServices => 'Prenotare servizi';

  @override
  String get provideServices => 'Offrire servizi';

  @override
  String get personalInformation => 'Informazioni personali';

  @override
  String get firstName => 'Nome';

  @override
  String get lastName => 'Cognome';

  @override
  String get selectDateOfBirth => 'Seleziona data di nascita';

  @override
  String get phoneNumber => 'Numero di telefono';

  @override
  String get pleaseEnterPhoneNumber => 'Inserisci un numero di telefono';

  @override
  String get accountInformation => 'Informazioni account';

  @override
  String get chooseUniqueUsernameHint => 'Scegli un nome utente unico';

  @override
  String get youAreCurrentlyUnavailable => 'Al momento non sei disponibile';

  @override
  String get toBrowseAndAcceptJobsEnableAvailability =>
      'Per sfogliare e accettare richieste di lavoro nelle vicinanze, devi impostarti come disponibile per le prenotazioni.';

  @override
  String get goToProfileSettings => 'Vai alle impostazioni del profilo';

  @override
  String get tipToggleAvailableForBookings =>
      'Suggerimento: Attiva \"Disponibile per prenotazioni\" nel tuo profilo fornitore per iniziare a ricevere richieste di lavoro.';

  @override
  String requestedBy(String name) {
    return 'Richiesto da: $name';
  }

  @override
  String locationLabel(String address) {
    return 'Posizione: $address';
  }

  @override
  String get email => 'Email';

  @override
  String get emailHint => 'your@email.com';

  @override
  String get enterValidEmail => 'Inserisci un’email valida';

  @override
  String get security => 'Sicurezza';

  @override
  String get passwordHintAtLeast10 => 'Almeno 10 caratteri';

  @override
  String get passwordMin10 => 'La password deve contenere almeno 10 caratteri';

  @override
  String get iAgreeTo => 'Accetto i ';

  @override
  String get termsOfService => 'Termini di servizio';

  @override
  String get and => 'e';

  @override
  String get privacyPolicy => 'Informativa sulla privacy';

  @override
  String get passwordIsRequired => 'La password è obbligatoria';

  @override
  String get passwordsDoNotMatch => 'Le password non corrispondono';

  @override
  String get pleaseSelectDob => 'Seleziona la data di nascita.';

  @override
  String get pleaseSelectCountry => 'Seleziona il paese.';

  @override
  String get pleaseSelectCity => 'Seleziona la città.';

  @override
  String get pleaseEnterValidPhone => 'Inserisci un numero di telefono valido.';

  @override
  String get mustAcceptTerms => 'Devi accettare i termini e le condizioni.';

  @override
  String get mustBeAtLeast18 => 'Devi avere almeno 18 anni per registrarti.';

  @override
  String get agreeToTerms =>
      'Accetto i Termini di servizio e l’Informativa sulla privacy';

  @override
  String get createAccountButton => 'Crea account';

  @override
  String get alreadyHaveAccount => 'Hai già un account?';

  @override
  String get emailVerifiedSuccessPleaseLogin =>
      'Email verificata con successo. Effettua l’accesso.';

  @override
  String get pleaseVerifyEmailToContinue =>
      'Verifica la tua email per continuare.';

  @override
  String get requestVerificationCodeTitle => 'Richiedi codice di verifica';

  @override
  String get requestVerificationInstructions =>
      'Inserisci la tua email o il nome utente.\nInvieremo un nuovo codice di verifica all’email di questo account.';

  @override
  String get emailOrUsername => 'Email o nome utente';

  @override
  String get sendCode => 'Invia codice';

  @override
  String get ifAccountExistsCodeSent =>
      'Se l’account esiste, un codice è stato inviato.';

  @override
  String get failedToSendVerificationCode =>
      'Invio del codice di verifica non riuscito.';

  @override
  String get verifyYourEmailTitle => 'Verifica la tua email';

  @override
  String get verificationCodeSentInfo =>
      'È stato inviato un codice di verifica all’email di questo account.';

  @override
  String emailVerificationInstructions(Object identifier) {
    return 'Inserisci il codice a 6 cifre inviato all’email di questo account:\n$identifier';
  }

  @override
  String get verificationCodeLabel => 'Codice di verifica';

  @override
  String get sendingEllipsis => 'Invio in corso...';

  @override
  String get resendCode => 'Reinvia codice';

  @override
  String get enter6DigitCodeError => 'Inserisci il codice a 6 cifre.';

  @override
  String get verifyingEllipsis => 'Verifica in corso...';

  @override
  String get verify => 'Verifica';

  @override
  String get invalidOrExpiredCodeTryResending =>
      'Codice non valido o scaduto. Prova a reinviare.';

  @override
  String bookingTitle(Object id) {
    return 'Prenotazione #$id';
  }

  @override
  String get invalidBookingIdForChat =>
      'ID prenotazione non valido per la chat.';

  @override
  String get invalidBookingIdForCall =>
      'ID prenotazione non valido per la chiamata.';

  @override
  String get unableToLoadContactInfo =>
      'Impossibile caricare le informazioni di contatto. Assicurati che la prenotazione sia attiva.';

  @override
  String noPhoneNumberAvailableForName(Object name) {
    return 'Nessun numero di telefono disponibile per $name.';
  }

  @override
  String get deviceCannotPlaceCalls =>
      'Questo dispositivo non può effettuare chiamate telefoniche.';

  @override
  String get cancelBookingDialogTitle => 'Annulla prenotazione';

  @override
  String get cancelBookingDialogBody =>
      'Vuoi davvero annullare questa prenotazione?\n\nNota: se il fornitore ha già accettato e sono passati più di 7 minuti (ma meno di circa 40 minuti), potrebbe essere applicata una penale secondo le regole.';

  @override
  String get yesCancel => 'Sì, annulla';

  @override
  String get failedToCancelBooking => 'Impossibile annullare la prenotazione.';

  @override
  String bookingCancelledPenaltyApplied(Object amount) {
    return 'Prenotazione annullata. È stata applicata una penale di $amount.';
  }

  @override
  String get bookingCancelledSuccessfully =>
      'Prenotazione annullata con successo.';

  @override
  String get failedToConfirmCompletion =>
      'Impossibile confermare il completamento. Riprova.';

  @override
  String get bothSidesConfirmedCompletedPayoutReleased =>
      'Entrambe le parti hanno confermato. La prenotazione è stata segnata come completata e il pagamento è stato rilasciato.';

  @override
  String get youConfirmedCompletionWaitingForProvider =>
      'Hai confermato il completamento. In attesa della conferma del fornitore.';

  @override
  String get youConfirmedCompletionWaitingForUser =>
      'Hai confermato il completamento. In attesa della conferma dell’utente.';

  @override
  String get statusUnknown => 'sconosciuto';

  @override
  String get statusAccepted => 'accettata';

  @override
  String get statusInProgress => 'in corso';

  @override
  String get statusCompleted => 'completata';

  @override
  String get statusCancelled => 'annullata';

  @override
  String get paymentPaid => 'pagato';

  @override
  String get paymentPending => 'in attesa';

  @override
  String get paymentFailed => 'non riuscito';

  @override
  String bookingAcceptedBy(Object name) {
    return 'Prenotazione accettata da $name';
  }

  @override
  String get whenLabel => 'Quando';

  @override
  String atTime(Object time) {
    return 'alle $time';
  }

  @override
  String get userLabel => 'Utente';

  @override
  String get providerLabel => 'Fornitore';

  @override
  String get estimatedPriceLabel => 'Prezzo stimato';

  @override
  String get offeredPaidLabel => 'Offerto / pagato';

  @override
  String get distanceLabel => 'Distanza';

  @override
  String distanceMiles(Object miles) {
    return '$miles miglia';
  }

  @override
  String get acceptedAtLabel => 'Accettata il';

  @override
  String get cancelledAtLabel => 'Annullata il';

  @override
  String get cancelledByLabel => 'Annullata da';

  @override
  String penaltyAppliedLabel(Object amount) {
    return 'Penale applicata: $amount';
  }

  @override
  String get userConfirmedLabel => 'Utente confermato';

  @override
  String get providerConfirmedLabel => 'Fornitore confermato';

  @override
  String get payoutReleasedLabel => 'Pagamento rilasciato';

  @override
  String get yesLower => 'sì';

  @override
  String get noLower => 'no';

  @override
  String get chat => 'Chat';

  @override
  String get call => 'Chiama';

  @override
  String get actions => 'Azioni';

  @override
  String get confirmCompletion => 'Conferma completamento';

  @override
  String get noFurtherActionsForBooking =>
      'Nessuna ulteriore azione disponibile per questa prenotazione.';

  @override
  String freeCancellationEndsIn(Object time) {
    return 'La cancellazione gratuita termina tra $time';
  }

  @override
  String get earlyFreeCancellationEndedWarning =>
      'La cancellazione gratuita iniziale è terminata. Fino a circa 40 minuti dopo l’accettazione, le cancellazioni tardive potrebbero comportare una penale.';

  @override
  String get cancelBooking => 'Annulla prenotazione';

  @override
  String get cancelBookingNoPenalty => 'Annulla prenotazione (senza penale)';

  @override
  String get cancelBookingPenaltyMayApply =>
      'Annulla prenotazione (penale possibile)';

  @override
  String get cancellationPolicyInfo =>
      'Puoi annullare senza penale nei primi 7 minuti dopo l’accettazione del fornitore e di nuovo dopo circa 40 minuti se necessario. Tra questi momenti, potrebbe essere applicata una penale secondo le regole.';

  @override
  String ratingLine(Object rating, int reviewCount) {
    String _temp0 = intl.Intl.pluralLogic(
      reviewCount,
      locale: localeName,
      other: '$reviewCount recensioni',
      one: '1 recensione',
    );
    return 'Valutazione: $rating ($_temp0)';
  }

  @override
  String get proofOfSkillsPortfolio => 'Prova delle competenze (Portfolio)';

  @override
  String get noPortfolioPostsAvailable =>
      'Nessun contenuto del portfolio disponibile.';

  @override
  String get bookingLocation => 'Posizione della prenotazione';

  @override
  String get location => 'Posizione';

  @override
  String get latitude => 'Latitudine';

  @override
  String get longitude => 'Longitudine';

  @override
  String get mapWillAppearWhenCoordinatesValid =>
      'La mappa apparirà qui quando le coordinate saranno valide.';

  @override
  String chatForBookingTitle(Object id) {
    return 'Chat per la prenotazione #$id';
  }

  @override
  String get unableToStartChat =>
      'Impossibile avviare la chat. La chat è disponibile solo quando la prenotazione è accettata, in corso o completata nelle ultime 24 ore.';

  @override
  String get invalidChatThreadFromServer =>
      'Thread di chat non valido restituito dal server.';

  @override
  String get messageNotSentPolicy =>
      'Messaggio non inviato. Nota: non è consentito condividere numeri di telefono o email nella chat.';

  @override
  String get unknown => 'Sconosciuto';

  @override
  String get typeMessageHint => 'Scrivi un messaggio all’assistenza...';

  @override
  String get uploadProfilePicture => 'Carica foto profilo';

  @override
  String get currentProfilePicture => 'Foto profilo attuale';

  @override
  String get newPicturePreview => 'Anteprima nuova foto';

  @override
  String get chooseImage => 'Scegli immagine';

  @override
  String get upload => 'Carica';

  @override
  String get noImageBytesFoundWeb => 'Byte immagine non trovati (web).';

  @override
  String get pleasePickAnImageFirst => 'Seleziona prima un’immagine.';

  @override
  String get uploadFailedCheckServerLogs =>
      'Caricamento non riuscito. Controlla i log del server / token.';

  @override
  String get profilePictureUploadedSuccessfully =>
      'Foto profilo caricata con successo!';

  @override
  String errorWithValue(Object error) {
    return 'Errore: $error';
  }

  @override
  String get tapToChangeProfilePicture => 'Tocca per cambiare la foto profilo';

  @override
  String usernameValue(Object username) {
    return 'Nome utente: $username';
  }

  @override
  String roleValue(Object role) {
    return 'Ruolo: $role';
  }

  @override
  String get dateOfBirthYyyyMmDd => 'Data di nascita (YYYY-MM-DD)';

  @override
  String get saveProfile => 'Salva profilo';

  @override
  String get failedToSaveProfile => 'Impossibile salvare il profilo. Riprova.';

  @override
  String get profileUpdated => 'Profilo aggiornato.';

  @override
  String get completeYourProviderProfile => 'Completa il tuo profilo fornitore';

  @override
  String get completeProviderProfileBody =>
      'Per iniziare ad accettare lavori e guadagnare, completa il tuo profilo fornitore.';

  @override
  String get setupProfileNow => 'Configura profilo ora';

  @override
  String get doItLater => 'Più tardi';

  @override
  String get bookingTimerPenaltyPeriodActive => 'Periodo di penale attivo';

  @override
  String get bookingTimerFreeCancellationPeriod =>
      'Periodo di cancellazione gratuita';

  @override
  String bookingTimerTimeRemaining(Object time) {
    return 'Tempo rimanente: $time';
  }

  @override
  String get bookingTimerCancellingNowPenalty =>
      'Annullare ora comporterà una penale del 10%.';

  @override
  String get bookingTimerCancelNoPenalty => 'Puoi annullare senza penale.';

  @override
  String get myReviewsTitle => 'Le mie recensioni';

  @override
  String get failedToLoadReviews => 'Impossibile caricare le recensioni.';

  @override
  String get noReviewsYet => 'Non hai ancora lasciato recensioni.';

  @override
  String providerWithName(Object name) {
    return 'Fornitore: $name';
  }

  @override
  String get providerGeneric => 'Fornitore';

  @override
  String ratingWithValue(Object rating) {
    return 'Valutazione: $rating';
  }

  @override
  String get nearbyOpenJobsTitle => 'Lavori aperti nelle vicinanze';

  @override
  String get failedToLoadOpenJobsHint =>
      'Impossibile caricare i lavori aperti.\nAssicurati di avere un profilo fornitore con posizione impostata e available=true.';

  @override
  String errorLoadingJobsWithValue(Object error) {
    return 'Errore nel caricamento dei lavori: $error';
  }

  @override
  String get noOpenJobsFoundNearbyTitle =>
      'Nessun lavoro aperto trovato nelle vicinanze';

  @override
  String get noOpenJobsFoundNearbyBody =>
      'Assicurati che:\n- Hai impostato la posizione del fornitore\n- Sei contrassegnato come disponibile\n- Gli utenti hanno creato e pagato le prenotazioni';

  @override
  String currencyLabel(Object symbol) {
    return 'Valuta: $symbol';
  }

  @override
  String pricesShownInCurrency(Object symbol, Object country) {
    return 'Prezzi mostrati in $symbol ($country)';
  }

  @override
  String jobTitleWithId(Object id) {
    return 'Lavoro #$id';
  }

  @override
  String serviceLine(Object service) {
    return 'Servizio: $service';
  }

  @override
  String whenLine(Object date, Object time) {
    return 'Quando: $date $time';
  }

  @override
  String priceLine(Object price) {
    return 'Prezzo: $price';
  }

  @override
  String get acceptJob => 'Accetta lavoro';

  @override
  String get failedToAcceptJob => 'Impossibile accettare il lavoro.';

  @override
  String get jobAcceptedSuccessfully => 'Lavoro accettato con successo.';

  @override
  String get newServiceRequestTitle => 'Nuova richiesta di servizio';

  @override
  String get reviewAlreadySubmitted => 'Review submitted ✓';

  @override
  String get offeredPriceLabel => 'Prezzo offerto';

  @override
  String get offeredPriceHint => 'es. 25.00';

  @override
  String get enterValidPrice => 'Inserisci un prezzo valido';

  @override
  String get bookAndPay => 'Prenota e paga';

  @override
  String bookAndPayAmount(Object amount) {
    return 'Prenota e paga $amount';
  }

  @override
  String get haircutService => 'Taglio';

  @override
  String get stylingService => 'Styling';

  @override
  String get timeLabel => 'Ora:';

  @override
  String get notesLabel => 'Note';

  @override
  String get requestCreatedAndPaidBroadcast =>
      'Richiesta creata e pagata! Inviata ai fornitori.';

  @override
  String locationLatLng(Object lat, Object lng) {
    return 'Posizione: $lat, $lng';
  }

  @override
  String get paymentMethodsTitle => 'Metodi di pagamento';

  @override
  String get paymentPreferencesInfo =>
      'Queste preferenze sono memorizzate localmente sul tuo dispositivo. I pagamenti reali vengono elaborati in modo sicuro tramite Stripe/altri gateway.';

  @override
  String get preferredMethodLabel =>
      'Metodo preferito (gateway locale selezionato in base al paese)';

  @override
  String get methodVisaMastercard => 'Visa/Mastercard';

  @override
  String get methodMobileMoney => 'Mobile Money (Momo/Paystack/Africa)';

  @override
  String get methodPaypal => 'PayPal';

  @override
  String get methodApplePayGooglePay => 'Apple Pay/Google Pay';

  @override
  String get methodWeChatPay => 'WeChat Pay (Cina)';

  @override
  String get methodAlipay => 'Alipay (Cina)';

  @override
  String get methodUnionPay => 'Carta UnionPay (Cina)';

  @override
  String get mobileMoneyNumberLabel => 'Numero Mobile Money';

  @override
  String get wechatAlipayIdLabel => 'ID WeChat/Alipay';

  @override
  String get cardLast4DigitsLabel => 'Ultime 4 cifre della carta';

  @override
  String get paypalEmailLabel => 'Email PayPal';

  @override
  String get applePayEnabledOnDevice =>
      'Apple Pay abilitato su questo dispositivo';

  @override
  String get savePaymentPreferences => 'Salva preferenze di pagamento';

  @override
  String get paymentPrefsSavedInfo =>
      'Preferenze di pagamento salvate localmente. L’addebito reale sarà gestito più avanti tramite Stripe/altri gateway.';

  @override
  String get failedToLoadImage => 'Impossibile caricare l’immagine';

  @override
  String get earningsTitle => 'Guadagni';

  @override
  String get couldNotLoadEarningsSummary =>
      'Impossibile caricare il riepilogo dei guadagni.';

  @override
  String get noData => 'Nessun dato.';

  @override
  String get retry => 'Riprova';

  @override
  String get summaryTitle => 'Riepilogo';

  @override
  String get totalLabel => 'Totale';

  @override
  String get pendingLabel => 'In sospeso';

  @override
  String get paidLabel => 'Pagato';

  @override
  String get pdfReportTitle => 'Report PDF';

  @override
  String get periodLabel => 'Periodo';

  @override
  String get periodThisMonth => 'Questo mese';

  @override
  String get periodLastMonth => 'Mese scorso';

  @override
  String get periodYtd => 'Da inizio anno';

  @override
  String get periodAllTime => 'Sempre';

  @override
  String get couldNotDownloadPdfReport =>
      'Impossibile scaricare il report PDF.';

  @override
  String couldNotOpenPdfWithValue(Object error) {
    return 'Impossibile aprire il PDF: $error';
  }

  @override
  String get savingFilesNotSupportedWeb =>
      'Il salvataggio dei file non è supportato sul Web al momento.';

  @override
  String savedToDocumentsIosWithPath(Object path) {
    return 'Salvato in Documents (iOS):\n$path';
  }

  @override
  String savedToFilesWithPath(Object path) {
    return 'Salvato nei file:\n$path';
  }

  @override
  String get open => 'Apri';

  @override
  String failedToSavePdfWithValue(Object error) {
    return 'Impossibile salvare il PDF: $error';
  }

  @override
  String get openPdfReport => 'Apri report PDF';

  @override
  String get savePdfToDownloads => 'Salva PDF in Download';

  @override
  String get reportWatermarkNote =>
      'Il PDF del report dovrebbe includere la filigrana Styloria.';

  @override
  String get referFriendsTitle => 'Invita amici';

  @override
  String get shareReferralCodeBody =>
      'Condividi il tuo codice referral con gli amici. In seguito potrai aggiungere ricompense quando si iscrivono e completano le prenotazioni.';

  @override
  String get yourReferralCodeLabel => 'Il tuo codice referral:';

  @override
  String get copy => 'Copia';

  @override
  String referralCodeCopiedWithCode(Object code) {
    return 'Codice referral copiato: $code';
  }

  @override
  String get navHome => 'Home';

  @override
  String get navBookings => 'Prenotazioni';

  @override
  String get navNotifications => 'Notifiche';

  @override
  String get navAccount => 'Account';

  @override
  String get welcome => 'Benvenuto';

  @override
  String welcomeName(Object name) {
    return 'Benvenuto, $name';
  }

  @override
  String get toggleThemeTooltip => 'Attiva/disattiva modalità chiara/scura';

  @override
  String loggedInAs(Object role) {
    return 'Accesso come: $role';
  }

  @override
  String locationWithValue(Object value) {
    return 'Posizione: $value';
  }

  @override
  String get homeTagline =>
      'Trasforma la tua esperienza di grooming con prenotazioni in tempo reale e fornitori affidabili.';

  @override
  String get manageProviderProfile => 'Gestisci profilo fornitore';

  @override
  String get browseOpenJobs => 'Sfoglia lavori aperti';

  @override
  String get quickActions => 'Azioni rapide';

  @override
  String get newBooking => 'Nuova prenotazione';

  @override
  String notificationsWithUnread(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count non lette',
      one: '1 non letta',
    );
    return 'Notifiche ($_temp0)';
  }

  @override
  String get liveLocationTrackingTitle =>
      'Tracciamento posizione in tempo reale';

  @override
  String get live => 'Live';

  @override
  String get locationServicesDisabled =>
      'I servizi di localizzazione sono disattivati';

  @override
  String get locationPermissionDenied => 'Permesso di localizzazione negato';

  @override
  String get locationPermissionPermanentlyDenied =>
      'Permesso di localizzazione negato in modo permanente';

  @override
  String failedToGetLocationWithValue(Object error) {
    return 'Impossibile ottenere la posizione: $error';
  }

  @override
  String get youProvider => 'Tu (fornitore)';

  @override
  String get youCustomer => 'Tu (cliente)';

  @override
  String get customer => 'Cliente';

  @override
  String get bookingDetails => 'Dettagli prenotazione';

  @override
  String get navigate => 'Naviga';

  @override
  String get failedToLoadNotifications => 'Impossibile caricare le notifiche.';

  @override
  String get failedToMarkAsRead => 'Impossibile contrassegnare come letta';

  @override
  String get noNotificationsYet => 'Nessuna notifica per ora.';

  @override
  String get markRead => 'Segna come letta';

  @override
  String get providerKycTitle => 'Verifica fornitore (KYC)';

  @override
  String get logoutTooltip => 'Disconnetti';

  @override
  String statusLabel(Object status) {
    return 'Stato: $status';
  }

  @override
  String rejectedWithNotes(Object notes) {
    return 'Rifiutato: $notes';
  }

  @override
  String get kycInstructions =>
      'Per accedere alle funzionalità per fornitori, carica il tuo documento e un selfie per la verifica.';

  @override
  String get idFrontRequired => 'Documento fronte (obbligatorio)';

  @override
  String get selectIdFront => 'Seleziona fronte documento';

  @override
  String get idBackRequired => 'Documento retro (obbligatorio)';

  @override
  String get selectIdBackRequired => 'Seleziona retro documento';

  @override
  String get selfieRequired => 'Selfie (obbligatorio)';

  @override
  String get selectSelfie => 'Seleziona selfie';

  @override
  String get takeSelfie => 'Scatta selfie';

  @override
  String get errorUploadAllRequired =>
      'Carica documento (fronte), documento (retro) e un selfie.';

  @override
  String failedSubmitKycCode(Object code) {
    return 'Invio KYC non riuscito (codice $code).';
  }

  @override
  String submittedCurrentStatus(Object status) {
    return 'Inviato. Stato attuale: $status';
  }

  @override
  String get unknownStatus => 'sconosciuto';

  @override
  String get submitKyc => 'Invia KYC';

  @override
  String get verificationMayTakeTimeNote =>
      'Nota: la verifica può richiedere tempo. Potrai accedere alle funzionalità per fornitori una volta approvato.';

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
  String get enterVerificationCodeTitle => 'Inserisci codice di verifica';

  @override
  String otpSentToUsername(Object username) {
    return 'Abbiamo inviato un codice di 6 cifre al numero di telefono\nassociato a \"$username\".';
  }

  @override
  String get sixDigitCodeLabel => 'Codice di 6 cifre';

  @override
  String get enterSixDigitCodeValidation => 'Inserisci il codice di 6 cifre';

  @override
  String get otpInvalidOrExpired => 'Codice non valido o scaduto.';

  @override
  String get failedLoadUserInfoAfterVerification =>
      'Impossibile caricare le informazioni utente dopo la verifica.';

  @override
  String get chatWithSupportTitle => 'Chat con l’assistenza';

  @override
  String get unableStartSupportChat =>
      'Impossibile avviare la chat di assistenza.';

  @override
  String get invalidSupportThreadReturned =>
      'Thread di assistenza non valido restituito dal server.';

  @override
  String get noMessagesYet => 'Nessun messaggio. Inizia una conversazione!';

  @override
  String get supportDefaultName => 'Assistenza';

  @override
  String get aboutPoliciesTitle => 'Informazioni e politiche';

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
    return 'Valuta $providerName';
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
    return 'Impossibile caricare il profilo: $error';
  }

  @override
  String profileSavedSuccess(Object action) {
    return 'Profilo $action con successo!';
  }

  @override
  String genericError(Object error) {
    return 'Errore: $error';
  }

  @override
  String get locationPermissionDeniedEnableInSettings =>
      'Permesso di posizione negato. Abilitalo nelle impostazioni.';

  @override
  String get locationPermissionPermanentlyDeniedEnableInAppSettings =>
      'Permesso di posizione negato in modo permanente. Abilitalo nelle impostazioni dell’app.';

  @override
  String errorGettingLocation(Object error) {
    return 'Errore durante il recupero della posizione: $error';
  }

  @override
  String get pleaseEnterAddress => 'Inserisci un indirizzo';

  @override
  String get locationUpdatedFromAddress =>
      'Posizione aggiornata dall’indirizzo';

  @override
  String get couldNotFindLocationForAddress =>
      'Impossibile trovare la posizione per questo indirizzo';

  @override
  String errorConvertingAddress(Object error) {
    return 'Errore nella conversione dell’indirizzo: $error';
  }

  @override
  String get portfolioUnavailableCompleteKycFirst =>
      'Portfolio non disponibile. Se sei un provider, completa prima la verifica KYC.';

  @override
  String failedToLoadPortfolio(Object error) {
    return 'Impossibile caricare il portfolio: $error';
  }

  @override
  String get addPhoto => 'Aggiungi foto';

  @override
  String get addVideo => 'Aggiungi video';

  @override
  String get addPost => 'Aggiungi post';

  @override
  String get captionOptionalTitle => 'Didascalia (facoltativa)';

  @override
  String get captionHintExample => 'es. “Knotless braids su cliente”';

  @override
  String get skip => 'Salta';

  @override
  String get save => 'Salva';

  @override
  String get failedToCreatePortfolioPost =>
      'Impossibile creare il post del portfolio.';

  @override
  String get uploadFailedMediaUpload =>
      'Caricamento non riuscito (upload media).';

  @override
  String uploadFailed(Object error) {
    return 'Caricamento non riuscito: $error';
  }

  @override
  String get deletePostTitle => 'Eliminare il post?';

  @override
  String get deletePostBody => 'Questo rimuoverà il post dal tuo portfolio.';

  @override
  String get delete => 'Elimina';

  @override
  String get deleteFailed => 'Eliminazione non riuscita.';

  @override
  String deleteFailedWithError(Object error) {
    return 'Eliminazione non riuscita: $error';
  }

  @override
  String get portfolioTitle => 'Portfolio';

  @override
  String get noPortfolioPostsYetHelpText =>
      'Nessun post nel portfolio. Aggiungi foto/video del tuo lavoro per aiutare i clienti a fidarsi delle tue abilità.';

  @override
  String get setupProviderProfileTitle => 'Configura profilo provider';

  @override
  String get providerProfileTitle => 'Profilo provider';

  @override
  String get welcomeToStyloriaTitle => 'Benvenuto su Styloria!';

  @override
  String get completeProviderProfileToStartEarning =>
      'Completa il tuo profilo provider per iniziare ad accettare lavori e guadagnare.';

  @override
  String reviewCountLabel(int count) {
    return '($count recensioni)';
  }

  @override
  String get topRatedChip => 'Top Rated';

  @override
  String get bioLabel => 'Bio / Descrizione';

  @override
  String get bioHint =>
      'Racconta ai clienti le tue competenze e la tua esperienza...';

  @override
  String get pleaseEnterBio => 'Inserisci una bio';

  @override
  String bioMinLength(int min) {
    return 'La bio deve essere lunga almeno $min caratteri';
  }

  @override
  String get yourLocationTitle => 'La tua posizione';

  @override
  String get locationHelpMatchNearbyClients =>
      'La tua posizione ci aiuta ad abbinarti a clienti nelle vicinanze';

  @override
  String get locationHelpUpdateToFindJobs =>
      'Aggiorna la posizione per trovare lavori in altre aree';

  @override
  String get useMyCurrentLocationTitle => 'Usa la mia posizione attuale';

  @override
  String get gpsSubtitle => 'Ottieni la posizione automaticamente tramite GPS';

  @override
  String get orLabel => 'OPPURE';

  @override
  String get enterYourAddressTitle => 'Inserisci il tuo indirizzo';

  @override
  String get fullAddressLabel => 'Indirizzo completo';

  @override
  String get fullAddressHint => 'es. 123 Main St, Accra, Ghana';

  @override
  String get find => 'Trova';

  @override
  String get addressHelpText => 'Inserisci via, città e paese';

  @override
  String get coordinatesAutoFilledTitle =>
      'Coordinate (compilate automaticamente)';

  @override
  String get servicePricingTitle => 'Prezzi dei servizi';

  @override
  String get servicePricingHelp =>
      'Imposta il prezzo per ogni servizio. Seleziona \"Non offerto\" per i servizi che non puoi fornire.';

  @override
  String get serviceHeader => 'Servizio';

  @override
  String get priceHeader => 'Prezzo';

  @override
  String get notOfferedHeader => 'Non offerto';

  @override
  String get priceHint => '0.00';

  @override
  String get providerHowPricingWorksTitle => 'Come funziona la tariffazione:';

  @override
  String get providerHowPricingWorksBody =>
      '• Il tuo prezzo è ciò che addebiti per il servizio\n• Costo trasporto = 80% della valuta dell’utente per km\n• Gli utenti vedono 3 opzioni in base ai provider vicini:\n  - Budget: prezzo più basso\n  - Standard: prezzo medio\n  - Priority: prezzo più alto';

  @override
  String get availableForBookingsTitle => 'Disponibile per prenotazioni';

  @override
  String get availableOnHelp =>
      '✓ Apparirai nei risultati di ricerca per i clienti vicini';

  @override
  String get availableOffHelp => '✗ Non riceverai nuove offerte di lavoro';

  @override
  String get completeSetupStartEarning =>
      'Completa la configurazione e inizia a guadagnare';

  @override
  String get updateProfile => 'Aggiorna profilo';

  @override
  String get skipForNow => 'Salta per ora';

  @override
  String get paymentsNotSupportedShort =>
      'I pagamenti non sono supportati su questa piattaforma. Esegui su Android, iOS, macOS o Web.';

  @override
  String get genericContact => 'Contatto';

  @override
  String get genericProvider => 'Fornitore';

  @override
  String get genericNotAvailable => 'N/D';

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
  String get reviewSelectRatingPrompt =>
      'Seleziona una valutazione (da 1 a 5).';

  @override
  String get reviewCommentOptionalLabel => 'Commento (facoltativo)';

  @override
  String get genericCancel => 'Annulla';

  @override
  String get genericSubmit => 'Invia';

  @override
  String get reviewSubmitFailed => 'Invio recensione non riuscito.';

  @override
  String get rateThisService => 'Valuta questo servizio';

  @override
  String get tipLeaveTitle => 'Lascia una mancia';

  @override
  String get tipChooseAmountPrompt =>
      'Scegli un importo per la mancia o inserisci un importo personalizzato.';

  @override
  String get tipNoTip => 'Nessuna mancia';

  @override
  String get tipCustomAmountLabel => 'Importo mancia personalizzato';

  @override
  String get genericContinue => 'Continua';

  @override
  String get tipSkipped => 'Mancia saltata.';

  @override
  String get tipFailedToSaveChoice =>
      'Impossibile salvare la scelta della mancia.';

  @override
  String get tipFailedToCreatePayment =>
      'Impossibile creare il pagamento della mancia.';

  @override
  String get tipPaidSuccessfully => 'Mancia pagata con successo. Grazie!';

  @override
  String get tipPaidButUpdateFailed =>
      'Pagamento della mancia riuscito, ma aggiornamento della prenotazione non riuscito.';

  @override
  String tipCancelledOrFailed(Object message) {
    return 'Mancia annullata/non riuscita: $message';
  }

  @override
  String tipUnexpectedError(Object error) {
    return 'Errore imprevisto della mancia: $error';
  }

  @override
  String get tipAlreadyPaidLabel => 'Mancia già pagata';

  @override
  String get tipSkippedLabel => 'Mancia saltata';

  @override
  String get tipLeaveButton => 'Lascia una mancia';

  @override
  String get walletTitle => 'Portafoglio';

  @override
  String get walletTooltip => 'Portafoglio';

  @override
  String get payoutSettingsTitle => 'Impostazioni pagamenti';

  @override
  String get payoutSettingsTooltip => 'Impostazioni pagamenti';

  @override
  String get walletNoWalletYet =>
      'Nessun portafoglio ancora. Completa lavori per guadagnare.';

  @override
  String get walletCurrencyFieldLabel => 'Valuta';

  @override
  String walletAvailableLine(Object amount, Object currency) {
    return 'Disponibile: $amount $currency';
  }

  @override
  String walletPendingLine(Object amount, Object currency) {
    return 'In sospeso: $amount $currency';
  }

  @override
  String get walletCashOutInstant => 'Preleva (istantaneo)';

  @override
  String get walletCashOutFailed => 'Prelievo non riuscito.';

  @override
  String walletCashOutSentTransfer(Object transferId) {
    return 'Prelievo inviato. Trasferimento: $transferId';
  }

  @override
  String get walletTransactionsTitle => 'Transazioni';

  @override
  String get walletNoTransactionsYet => 'Nessuna transazione.';

  @override
  String get payoutAutoPayoutsTitle => 'Pagamenti automatici';

  @override
  String get payoutAutoPayoutsSubtitle =>
      'Invia pagamenti automaticamente secondo la pianificazione scelta.';

  @override
  String get payoutDayUtcLabel => 'Giorno di pagamento (UTC)';

  @override
  String get payoutHourUtcLabel => 'Ora di pagamento (UTC)';

  @override
  String get payoutMinimumAmountLabel =>
      'Importo minimo per pagamento automatico';

  @override
  String get payoutMinimumAmountHelper =>
      'Il pagamento automatico viene eseguito solo se il saldo disponibile ≥ questo importo.';

  @override
  String get payoutInstantCashOutEnabledTitle =>
      'Prelievo istantaneo abilitato';

  @override
  String get payoutInstantCashOutEnabledSubtitle =>
      'Consenti il pulsante “Preleva” (si applica una commissione).';

  @override
  String get payoutSettingsSaved => 'Impostazioni pagamenti salvate.';

  @override
  String get payoutSettingsSaveFailed =>
      'Impossibile salvare le impostazioni pagamenti.';
}
