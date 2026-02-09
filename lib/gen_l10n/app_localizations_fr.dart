// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Styloria';

  @override
  String get account => 'Compte';

  @override
  String get profile => 'Profil';

  @override
  String get myBookings => 'Mes réservations';

  @override
  String get openJobs => 'Offres ouvertes';

  @override
  String get earnings => 'Gains';

  @override
  String get paymentMethods => 'Moyens de paiement';

  @override
  String get referFriends => 'Parrainer des amis';

  @override
  String get language => 'Langue';

  @override
  String get settings => 'Paramètres';

  @override
  String get darkMode => 'Mode sombre';

  @override
  String get systemDefault => 'Par défaut (système)';

  @override
  String get languageUpdated => 'Langue mise à jour';

  @override
  String get languageSetToSystemDefault =>
      'Langue définie sur celle du système';

  @override
  String get helpAndSupport => 'Aide et support';

  @override
  String get chatWithCustomerService => 'Discuter avec le service client';

  @override
  String get aboutAndPolicies => 'À propos et politiques';

  @override
  String get viewUserPoliciesAndAgreements =>
      'Voir les politiques et accords utilisateurs';

  @override
  String get logOut => 'Se déconnecter';

  @override
  String get deleteAccount => 'Supprimer le compte';

  @override
  String get deleteAccountSubtitle => 'Cette action est irréversible';

  @override
  String get deleteAccountTitle => 'Supprimer le compte';

  @override
  String get deleteAccountConfirmBody =>
      'Êtes-vous sûr de vouloir supprimer votre compte ?\n\nCette action vous déconnectera et vous pourriez perdre l’accès définitivement.';

  @override
  String get no => 'Non';

  @override
  String get yesDelete => 'Oui, supprimer';

  @override
  String get deleteAccountSheetTitle =>
      'Nous sommes désolés de vous voir partir.';

  @override
  String get deleteAccountSheetPrompt =>
      'Pouvez-vous nous dire pourquoi ? (Sélectionnez tout ce qui s’applique)';

  @override
  String get deleteAccountSelectAtLeastOneReason =>
      'Veuillez sélectionner au moins une raison.';

  @override
  String get tellUsMoreOptional => 'Dites-nous en plus (facultatif)';

  @override
  String get suggestionsToImproveOptional =>
      'Suggestions d’amélioration (facultatif)';

  @override
  String get deleteMyAccount => 'Supprimer mon compte';

  @override
  String get cancel => 'Annuler';

  @override
  String get failedToDeleteAccount =>
      'Échec de la suppression du compte. Veuillez réessayer.';

  @override
  String get choosePreferredLanguage => 'Choisissez votre langue préférée';

  @override
  String get noteSomeTextMayStillAppearInEnglish =>
      'Remarque : ceci change la langue de l’application. Certains textes peuvent encore apparaître en anglais jusqu’à l’ajout des traductions.';

  @override
  String languageSetToName(Object name) {
    return 'Langue définie sur $name';
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
  String get confirmPassword => 'Confirmer le mot de passe';

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
  String get deletionReason1 => 'Je n’ai plus besoin de Styloria';

  @override
  String get deletionReason2 =>
      'J’ai eu des difficultés à vérifier mon compte (e-mail/KYC)';

  @override
  String get deletionReason3 =>
      'Je n’ai pas trouvé de services/prestataires près de chez moi';

  @override
  String get deletionReason4 =>
      'Les prix ou frais étaient trop élevés / peu clairs';

  @override
  String get deletionReason5 =>
      'L’application était confuse / difficile à utiliser';

  @override
  String get deletionReason6 => 'Bugs ou problèmes de performance';

  @override
  String get deletionReason7 => 'Problèmes de paiement/remboursement';

  @override
  String get deletionReason8 =>
      'Mauvaise expérience avec un prestataire/utilisateur';

  @override
  String get deletionReason9 =>
      'Préoccupations liées à la confidentialité ou à la sécurité';

  @override
  String get deletionReason10 => 'J’ai créé ce compte par erreur';

  @override
  String get deletionReason11 => 'Je passe à une autre plateforme';

  @override
  String get deletionReason12 => 'Autre';

  @override
  String get loginWelcomeTitle => 'Bienvenue sur Styloria';

  @override
  String get loginWelcomeSubtitle =>
      'Connectez-vous pour gérer vos réservations et services.';

  @override
  String get loginFailedToLoadUserInfo =>
      'Connexion réussie mais impossible de charger les informations utilisateur.';

  @override
  String get username => 'Nom d’utilisateur';

  @override
  String get password => 'Mot de passe';

  @override
  String get required => 'Requis';

  @override
  String get login => 'Se connecter';

  @override
  String get createNewAccount => 'Créer un nouveau compte';

  @override
  String get requestEmailVerificationCode =>
      'Demander un code de vérification e-mail';

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
  String get pleaseEnterAddress => 'Veuillez saisir une adresse';

  @override
  String get locationUpdatedFromAddress =>
      'Position mise à jour depuis l’adresse';

  @override
  String get myCustomerRating => 'Ma note client';

  @override
  String get outOf5 => '/ 5.0';

  @override
  String reviewsFromProviders(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'avis',
      one: 'avis',
    );
    return '$count $_temp0 des prestataires';
  }

  @override
  String get failedToLoadReputation =>
      'Échec du chargement des données de réputation';

  @override
  String get somethingWentWrong => 'Une erreur s\'est produite';

  @override
  String get retry => 'Réessayer';

  @override
  String weDetectedYoureIn(String country) {
    return '📍 Nous avons détecté que vous êtes en $country. Veuillez sélectionner votre pays ci-dessous.';
  }

  @override
  String get locationMarkedAsOther =>
      'Localisation marquée comme \"Autre\" - vous pouvez continuer l\'inscription';

  @override
  String get createAccountTitle => 'Créer un compte';

  @override
  String get joinStyloria => 'Rejoindre Styloria';

  @override
  String get registerSubtitle =>
      'Créez un compte pour réserver des services ou devenir prestataire';

  @override
  String get iWantTo => 'Je veux :';

  @override
  String get bookServices => 'Réserver des services';

  @override
  String get provideServices => 'Proposer des services';

  @override
  String get personalInformation => 'Informations personnelles';

  @override
  String get firstName => 'Prénom';

  @override
  String get lastName => 'Nom';

  @override
  String get selectDateOfBirth => 'Sélectionner la date de naissance';

  @override
  String get phoneNumber => 'Numéro de téléphone';

  @override
  String get pleaseEnterPhoneNumber => 'Veuillez saisir un numéro de téléphone';

  @override
  String get accountInformation => 'Informations du compte';

  @override
  String get chooseUniqueUsernameHint =>
      'Choisissez un nom d’utilisateur unique';

  @override
  String get youAreCurrentlyUnavailable =>
      'Vous êtes actuellement indisponible';

  @override
  String get toBrowseAndAcceptJobsEnableAvailability =>
      'Pour parcourir et accepter les demandes d\'emploi à proximité, vous devez vous définir comme disponible pour les réservations.';

  @override
  String get goToProfileSettings => 'Aller aux paramètres du profil';

  @override
  String get tipToggleAvailableForBookings =>
      'Conseil : Activez \"Disponible pour les réservations\" dans votre profil de prestataire pour commencer à recevoir des demandes d\'emploi.';

  @override
  String requestedBy(String name) {
    return 'Demandé par : $name';
  }

  @override
  String locationLabel(String address) {
    return 'Emplacement : $address';
  }

  @override
  String get email => 'E-mail';

  @override
  String get emailHint => 'votre@email.com';

  @override
  String get enterValidEmail => 'Saisissez un e-mail valide';

  @override
  String get security => 'Sécurité';

  @override
  String get passwordHintAtLeast10 => 'Au moins 10 caractères';

  @override
  String get passwordMin10 =>
      'Le mot de passe doit contenir au moins 10 caractères';

  @override
  String get iAgreeTo => 'J\'accepte les ';

  @override
  String get termsOfService => 'Conditions d\'utilisation';

  @override
  String get and => 'et';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get passwordIsRequired => 'Le mot de passe est requis';

  @override
  String get passwordsDoNotMatch => 'Les mots de passe ne correspondent pas';

  @override
  String get pleaseSelectDob =>
      'Veuillez sélectionner votre date de naissance.';

  @override
  String get pleaseSelectCountry => 'Veuillez sélectionner votre pays.';

  @override
  String get pleaseSelectCity => 'Veuillez sélectionner votre ville.';

  @override
  String get pleaseEnterValidPhone =>
      'Veuillez saisir un numéro de téléphone valide.';

  @override
  String get mustAcceptTerms =>
      'Vous devez accepter les conditions d’utilisation.';

  @override
  String get mustBeAtLeast18 =>
      'Vous devez avoir au moins 18 ans pour vous inscrire.';

  @override
  String get agreeToTerms =>
      'J’accepte les Conditions d’utilisation et la Politique de confidentialité';

  @override
  String get createAccountButton => 'Créer un compte';

  @override
  String get alreadyHaveAccount => 'Vous avez déjà un compte ?';

  @override
  String get emailVerifiedSuccessPleaseLogin =>
      'E-mail vérifié avec succès. Veuillez vous connecter.';

  @override
  String get pleaseVerifyEmailToContinue =>
      'Veuillez vérifier votre e-mail pour continuer.';

  @override
  String get requestVerificationCodeTitle => 'Demander un code de vérification';

  @override
  String get requestVerificationInstructions =>
      'Saisissez votre e-mail ou votre nom d’utilisateur.\nNous enverrons un nouveau code de vérification à l’e-mail associé.';

  @override
  String get emailOrUsername => 'E-mail ou nom d’utilisateur';

  @override
  String get sendCode => 'Envoyer le code';

  @override
  String get ifAccountExistsCodeSent =>
      'Si ce compte existe, un code a été envoyé.';

  @override
  String get failedToSendVerificationCode =>
      'Échec de l’envoi du code de vérification.';

  @override
  String get verifyYourEmailTitle => 'Vérifiez votre e-mail';

  @override
  String get verificationCodeSentInfo =>
      'Un code de vérification a été envoyé à l’e-mail associé à ce compte.';

  @override
  String emailVerificationInstructions(Object identifier) {
    return 'Saisissez le code à 6 chiffres envoyé à l’e-mail de ce compte :\n$identifier';
  }

  @override
  String get verificationCodeLabel => 'Code de vérification';

  @override
  String get sendingEllipsis => 'Envoi...';

  @override
  String get resendCode => 'Renvoyer le code';

  @override
  String get enter6DigitCodeError => 'Saisissez le code à 6 chiffres.';

  @override
  String get verifyingEllipsis => 'Vérification...';

  @override
  String get verify => 'Vérifier';

  @override
  String get invalidOrExpiredCodeTryResending =>
      'Code invalide ou expiré. Essayez de le renvoyer.';

  @override
  String bookingTitle(Object id) {
    return 'Réservation n°$id';
  }

  @override
  String get invalidBookingIdForChat =>
      'ID de réservation invalide pour le chat.';

  @override
  String get invalidBookingIdForCall =>
      'ID de réservation invalide pour l\'appel.';

  @override
  String get unableToLoadContactInfo =>
      'Impossible de charger les informations de contact. Assurez-vous que la réservation est active.';

  @override
  String noPhoneNumberAvailableForName(Object name) {
    return 'Aucun numéro de téléphone disponible pour $name.';
  }

  @override
  String get deviceCannotPlaceCalls =>
      'Cet appareil ne peut pas passer d\'appels téléphoniques.';

  @override
  String get cancelBookingDialogTitle => 'Annuler la réservation';

  @override
  String get cancelBookingDialogBody =>
      'Voulez-vous vraiment annuler cette réservation ?\n\nRemarque : si le prestataire a déjà accepté et que plus de 7 minutes se sont écoulées (mais moins d’environ 40 minutes), une pénalité peut être appliquée selon les règles.';

  @override
  String get yesCancel => 'Oui, annuler';

  @override
  String get failedToCancelBooking =>
      'Échec de l’annulation de la réservation.';

  @override
  String bookingCancelledPenaltyApplied(Object amount) {
    return 'Réservation annulée. Une pénalité de $amount a été appliquée.';
  }

  @override
  String get bookingCancelledSuccessfully => 'Réservation annulée avec succès.';

  @override
  String get failedToConfirmCompletion =>
      'Impossible de confirmer la fin. Veuillez réessayer.';

  @override
  String get bothSidesConfirmedCompletedPayoutReleased =>
      'Les deux parties ont confirmé. La réservation est marquée comme terminée et le paiement a été débloqué.';

  @override
  String get youConfirmedCompletionWaitingForProvider =>
      'Vous avez confirmé la fin. En attente de la confirmation du prestataire.';

  @override
  String get youConfirmedCompletionWaitingForUser =>
      'Vous avez confirmé la fin. En attente de la confirmation de l’utilisateur.';

  @override
  String get statusUnknown => 'inconnu';

  @override
  String get statusAccepted => 'accepté';

  @override
  String get statusInProgress => 'en cours';

  @override
  String get statusCompleted => 'terminé';

  @override
  String get statusCancelled => 'annulé';

  @override
  String get paymentPaid => 'payé';

  @override
  String get paymentPending => 'en attente';

  @override
  String get paymentFailed => 'échoué';

  @override
  String bookingAcceptedBy(Object name) {
    return 'Réservation acceptée par $name';
  }

  @override
  String get whenLabel => 'Quand';

  @override
  String atTime(Object time) {
    return 'à $time';
  }

  @override
  String get userLabel => 'Utilisateur';

  @override
  String get providerLabel => 'Prestataire';

  @override
  String get estimatedPriceLabel => 'Prix estimé';

  @override
  String get offeredPaidLabel => 'Proposé / payé';

  @override
  String get distanceLabel => 'Distance';

  @override
  String distanceMiles(Object miles) {
    return '$miles miles';
  }

  @override
  String get acceptedAtLabel => 'Acceptée à';

  @override
  String get cancelledAtLabel => 'Annulée à';

  @override
  String get cancelledByLabel => 'Annulée par';

  @override
  String penaltyAppliedLabel(Object amount) {
    return 'Pénalité appliquée : $amount';
  }

  @override
  String get userConfirmedLabel => 'Utilisateur a confirmé';

  @override
  String get providerConfirmedLabel => 'Prestataire a confirmé';

  @override
  String get payoutReleasedLabel => 'Paiement débloqué';

  @override
  String get yesLower => 'oui';

  @override
  String get noLower => 'non';

  @override
  String get chat => 'Chat';

  @override
  String get call => 'Appeler';

  @override
  String get actions => 'Actions';

  @override
  String get confirmCompletion => 'Confirmer la fin';

  @override
  String get noFurtherActionsForBooking =>
      'Aucune autre action disponible pour cette réservation.';

  @override
  String freeCancellationEndsIn(Object time) {
    return 'L’annulation gratuite se termine dans $time';
  }

  @override
  String get earlyFreeCancellationEndedWarning =>
      'La période d’annulation gratuite initiale est terminée. Jusqu’à environ 40 minutes après l’acceptation, les annulations tardives peuvent entraîner une pénalité.';

  @override
  String get cancelBooking => 'Annuler la réservation';

  @override
  String get cancelBookingNoPenalty => 'Annuler la réservation (sans pénalité)';

  @override
  String get cancelBookingPenaltyMayApply =>
      'Annuler la réservation (pénalité possible)';

  @override
  String get cancellationPolicyInfo =>
      'Vous pouvez annuler sans pénalité pendant les 7 premières minutes après l’acceptation du prestataire, puis à nouveau après environ 40 minutes si nécessaire. Entre ces moments, une pénalité peut être appliquée selon les règles.';

  @override
  String ratingLine(Object rating, int reviewCount) {
    String _temp0 = intl.Intl.pluralLogic(
      reviewCount,
      locale: localeName,
      other: '$reviewCount avis',
      one: '1 avis',
    );
    return 'Note : $rating ($_temp0)';
  }

  @override
  String get proofOfSkillsPortfolio => 'Preuves de compétences (Portfolio)';

  @override
  String get noPortfolioPostsAvailable =>
      'Aucun contenu de portfolio disponible.';

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
  String get bookingLocation => 'Lieu de la réservation';

  @override
  String get location => 'Localisation';

  @override
  String get latitude => 'Latitude';

  @override
  String get longitude => 'Longitude';

  @override
  String get mapWillAppearWhenCoordinatesValid =>
      'La carte s’affichera ici lorsque les coordonnées seront valides.';

  @override
  String chatForBookingTitle(Object id) {
    return 'Chat pour la réservation n°$id';
  }

  @override
  String get unableToStartChat =>
      'Impossible de démarrer le chat. Le chat est disponible uniquement lorsque la réservation est acceptée, en cours, ou terminée dans la dernière journée.';

  @override
  String get invalidChatThreadFromServer =>
      'Fil de discussion invalide renvoyé par le serveur.';

  @override
  String get messageNotSentPolicy =>
      'Message non envoyé. Remarque : le partage de numéros de téléphone ou d’e-mails n’est pas autorisé dans le chat.';

  @override
  String get unknown => 'Inconnu';

  @override
  String get typeMessageHint => 'Écrivez un message à l’assistance...';

  @override
  String get uploadProfilePicture => 'Téléverser une photo de profil';

  @override
  String get currentProfilePicture => 'Photo de profil actuelle';

  @override
  String get newPicturePreview => 'Aperçu de la nouvelle photo';

  @override
  String get chooseImage => 'Choisir une image';

  @override
  String get upload => 'Téléverser';

  @override
  String get noImageBytesFoundWeb => 'Aucun octet d’image trouvé (web).';

  @override
  String get pleasePickAnImageFirst => 'Veuillez d’abord choisir une image.';

  @override
  String get uploadFailedCheckServerLogs =>
      'Échec du téléversement. Vérifiez les logs du serveur / le token.';

  @override
  String get profilePictureUploadedSuccessfully =>
      'Photo de profil téléversée avec succès !';

  @override
  String errorWithValue(Object error) {
    return 'Erreur : $error';
  }

  @override
  String get tapToChangeProfilePicture =>
      'Appuyez pour changer la photo de profil';

  @override
  String usernameValue(Object username) {
    return 'Nom d’utilisateur : $username';
  }

  @override
  String roleValue(Object role) {
    return 'Rôle : $role';
  }

  @override
  String get dateOfBirthYyyyMmDd => 'Date de naissance (AAAA-MM-JJ)';

  @override
  String get saveProfile => 'Enregistrer le profil';

  @override
  String get failedToSaveProfile =>
      'Échec de l’enregistrement du profil. Veuillez réessayer.';

  @override
  String get profileUpdated => 'Profil mis à jour.';

  @override
  String get completeYourProviderProfile =>
      'Complétez votre profil prestataire';

  @override
  String get completeProviderProfileBody =>
      'Pour commencer à accepter des missions et gagner de l’argent, complétez votre profil prestataire.';

  @override
  String get setupProfileNow => 'Configurer le profil maintenant';

  @override
  String get doItLater => 'Le faire plus tard';

  @override
  String get bookingTimerPenaltyPeriodActive => 'Période de pénalité active';

  @override
  String get bookingTimerFreeCancellationPeriod =>
      'Période d’annulation gratuite';

  @override
  String bookingTimerTimeRemaining(Object time) {
    return 'Temps restant : $time';
  }

  @override
  String get bookingTimerCancellingNowPenalty =>
      'Annuler maintenant entraînera une pénalité de 10 %.';

  @override
  String get bookingTimerCancelNoPenalty =>
      'Vous pouvez annuler sans pénalité.';

  @override
  String get myReviewsTitle => 'Mes avis';

  @override
  String get failedToLoadReviews => 'Échec du chargement des avis.';

  @override
  String get noReviewsYet => 'Vous n’avez encore laissé aucun avis.';

  @override
  String providerWithName(Object name) {
    return 'Prestataire : $name';
  }

  @override
  String get providerGeneric => 'Prestataire';

  @override
  String ratingWithValue(Object rating) {
    return 'Note : $rating';
  }

  @override
  String get nearbyOpenJobsTitle => 'Missions disponibles à proximité';

  @override
  String get failedToLoadOpenJobsHint =>
      'Impossible de charger les missions disponibles.\nAssurez-vous d’avoir un profil prestataire avec une position définie et available=true.';

  @override
  String errorLoadingJobsWithValue(Object error) {
    return 'Erreur lors du chargement des missions : $error';
  }

  @override
  String get noOpenJobsFoundNearbyTitle =>
      'Aucune mission disponible à proximité';

  @override
  String get noOpenJobsFoundNearbyBody =>
      'Assurez-vous que :\n- Vous avez défini votre position prestataire\n- Vous êtes marqué comme disponible\n- Les utilisateurs ont créé et payé des réservations';

  @override
  String currencyLabel(Object symbol) {
    return 'Devise : $symbol';
  }

  @override
  String pricesShownInCurrency(Object symbol, Object country) {
    return 'Prix affichés en $symbol ($country)';
  }

  @override
  String jobTitleWithId(Object id) {
    return 'Mission n°$id';
  }

  @override
  String serviceLine(Object service) {
    return 'Service : $service';
  }

  @override
  String whenLine(Object date, Object time) {
    return 'Quand : $date $time';
  }

  @override
  String priceLine(Object price) {
    return 'Prix : $price';
  }

  @override
  String get acceptJob => 'Accepter la mission';

  @override
  String get failedToAcceptJob => 'Échec de l’acceptation de la mission.';

  @override
  String get jobAcceptedSuccessfully => 'Mission acceptée avec succès.';

  @override
  String get newServiceRequestTitle => 'Nouvelle demande de service';

  @override
  String get reviewAlreadySubmitted => 'Review submitted ✓';

  @override
  String get offeredPriceLabel => 'Prix proposé';

  @override
  String get offeredPriceHint => 'ex. 25.00';

  @override
  String get enterValidPrice => 'Entrez un prix valide';

  @override
  String get bookAndPay => 'Réserver et payer';

  @override
  String bookAndPayAmount(Object amount) {
    return 'Réserver et payer $amount';
  }

  @override
  String get haircutService => 'Coupe';

  @override
  String get stylingService => 'Coiffage';

  @override
  String get timeLabel => 'Heure :';

  @override
  String get notesLabel => 'Notes';

  @override
  String get requestCreatedAndPaidBroadcast =>
      'Demande créée et payée ! Diffusée aux prestataires.';

  @override
  String locationLatLng(Object lat, Object lng) {
    return 'Position : $lat, $lng';
  }

  @override
  String get paymentMethodsTitle => 'Moyens de paiement';

  @override
  String get paymentPreferencesInfo =>
      'Ces préférences sont stockées localement sur votre appareil. Les paiements réels sont traités de manière sécurisée via Stripe/autres passerelles.';

  @override
  String get preferredMethodLabel =>
      'Méthode préférée (passerelle locale sélectionnée selon le pays)';

  @override
  String get methodVisaMastercard => 'Visa/Mastercard';

  @override
  String get methodMobileMoney => 'Mobile Money (Momo/Paystack/Afrique)';

  @override
  String get methodPaypal => 'PayPal';

  @override
  String get methodApplePayGooglePay => 'Apple Pay/Google Pay';

  @override
  String get methodWeChatPay => 'WeChat Pay (Chine)';

  @override
  String get methodAlipay => 'Alipay (Chine)';

  @override
  String get methodUnionPay => 'Carte UnionPay (Chine)';

  @override
  String get mobileMoneyNumberLabel => 'Numéro Mobile Money';

  @override
  String get wechatAlipayIdLabel => 'ID WeChat/Alipay';

  @override
  String get cardLast4DigitsLabel => '4 derniers chiffres de la carte';

  @override
  String get paypalEmailLabel => 'E-mail PayPal';

  @override
  String get applePayEnabledOnDevice => 'Apple Pay activé sur cet appareil';

  @override
  String get savePaymentPreferences =>
      'Enregistrer les préférences de paiement';

  @override
  String get paymentPrefsSavedInfo =>
      'Préférences de paiement enregistrées localement. Le paiement réel sera géré via Stripe/autres passerelles plus tard.';

  @override
  String get failedToLoadImage => 'Échec du chargement de l’image';

  @override
  String get earningsTitle => 'Gains';

  @override
  String get couldNotLoadEarningsSummary =>
      'Impossible de charger le récapitulatif des gains.';

  @override
  String get noData => 'Aucune donnée.';

  @override
  String get summaryTitle => 'Récapitulatif';

  @override
  String get totalLabel => 'Total';

  @override
  String get pendingLabel => 'En attente';

  @override
  String get paidLabel => 'Payé';

  @override
  String get pdfReportTitle => 'Rapport PDF';

  @override
  String get periodLabel => 'Période';

  @override
  String get periodThisMonth => 'Ce mois-ci';

  @override
  String get periodLastMonth => 'Le mois dernier';

  @override
  String get periodYtd => 'Depuis le début de l’année';

  @override
  String get periodAllTime => 'Tout le temps';

  @override
  String get couldNotDownloadPdfReport =>
      'Impossible de télécharger le rapport PDF.';

  @override
  String couldNotOpenPdfWithValue(Object error) {
    return 'Impossible d’ouvrir le PDF : $error';
  }

  @override
  String get savingFilesNotSupportedWeb =>
      'L’enregistrement de fichiers n’est pas pris en charge sur le Web pour le moment.';

  @override
  String savedToDocumentsIosWithPath(Object path) {
    return 'Enregistré dans Documents (iOS) :\n$path';
  }

  @override
  String savedToFilesWithPath(Object path) {
    return 'Enregistré dans les fichiers :\n$path';
  }

  @override
  String get open => 'Ouvrir';

  @override
  String failedToSavePdfWithValue(Object error) {
    return 'Échec de l’enregistrement du PDF : $error';
  }

  @override
  String get openPdfReport => 'Ouvrir le rapport PDF';

  @override
  String get savePdfToDownloads => 'Enregistrer le PDF dans Téléchargements';

  @override
  String get reportWatermarkNote =>
      'Le PDF du rapport doit inclure le filigrane Styloria.';

  @override
  String get referFriendsTitle => 'Parrainer des amis';

  @override
  String get shareReferralCodeBody =>
      'Partagez votre code de parrainage avec vos amis. Plus tard, vous pourrez ajouter des récompenses lorsqu’ils s’inscrivent et terminent des réservations.';

  @override
  String get yourReferralCodeLabel => 'Votre code de parrainage :';

  @override
  String get copy => 'Copier';

  @override
  String referralCodeCopiedWithCode(Object code) {
    return 'Code de parrainage copié : $code';
  }

  @override
  String get navHome => 'Accueil';

  @override
  String get navBookings => 'Réservations';

  @override
  String get navNotifications => 'Notifications';

  @override
  String get navAccount => 'Compte';

  @override
  String get welcome => 'Bienvenue';

  @override
  String welcomeName(Object name) {
    return 'Bienvenue, $name';
  }

  @override
  String get toggleThemeTooltip => 'Basculer mode clair/sombre';

  @override
  String loggedInAs(Object role) {
    return 'Connecté en tant que : $role';
  }

  @override
  String locationWithValue(Object value) {
    return 'Localisation : $value';
  }

  @override
  String get homeTagline =>
      'Transformez votre expérience de grooming avec des réservations en temps réel et des prestataires de confiance.';

  @override
  String get manageProviderProfile => 'Gérer le profil prestataire';

  @override
  String get browseOpenJobs => 'Parcourir les missions ouvertes';

  @override
  String get quickActions => 'Actions rapides';

  @override
  String get newBooking => 'Nouvelle réservation';

  @override
  String notificationsWithUnread(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count non lues',
      one: '1 non lue',
    );
    return 'Notifications ($_temp0)';
  }

  @override
  String get liveLocationTrackingTitle => 'Suivi de localisation en direct';

  @override
  String get live => 'En direct';

  @override
  String get locationServicesDisabled =>
      'Les services de localisation sont désactivés.';

  @override
  String get locationPermissionDenied =>
      'Autorisation de localisation refusée.';

  @override
  String get locationPermissionPermanentlyDenied =>
      'Autorisation de localisation refusée définitivement. Veuillez l’activer dans les paramètres.';

  @override
  String failedToGetLocationWithValue(Object error) {
    return 'Impossible d’obtenir la localisation : $error';
  }

  @override
  String get youProvider => 'Vous (prestataire)';

  @override
  String get youCustomer => 'Vous (client)';

  @override
  String get customer => 'Client';

  @override
  String get bookingDetails => 'Détails de la réservation';

  @override
  String get navigate => 'Itinéraire';

  @override
  String get failedToLoadNotifications =>
      'Échec du chargement des notifications.';

  @override
  String get failedToMarkAsRead => 'Échec du marquage comme lu';

  @override
  String get noNotificationsYet => 'Aucune notification pour le moment.';

  @override
  String get markRead => 'Marquer comme lu';

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
  String get providerKycTitle => 'Vérification du prestataire (KYC)';

  @override
  String get logoutTooltip => 'Se déconnecter';

  @override
  String statusLabel(Object status) {
    return 'Statut : $status';
  }

  @override
  String rejectedWithNotes(Object notes) {
    return 'Rejeté : $notes';
  }

  @override
  String get kycInstructions =>
      'Pour accéder aux fonctionnalités prestataire, téléversez votre pièce d\'identité et un selfie pour vérification.';

  @override
  String get idFrontRequired => 'Recto de la pièce (obligatoire)';

  @override
  String get selectIdFront => 'Sélectionner le recto';

  @override
  String get idBackRequired => 'Verso de la pièce (obligatoire)';

  @override
  String get selectIdBackRequired => 'Sélectionner le verso';

  @override
  String get selfieRequired => 'Selfie (obligatoire)';

  @override
  String get selectSelfie => 'Sélectionner un selfie';

  @override
  String get takeSelfie => 'Prendre un selfie';

  @override
  String get errorUploadAllRequired =>
      'Veuillez téléverser la pièce (recto), la pièce (verso) et un selfie.';

  @override
  String failedSubmitKycCode(Object code) {
    return 'Échec de l\'envoi du KYC (code $code).';
  }

  @override
  String submittedCurrentStatus(Object status) {
    return 'Envoyé. Statut actuel : $status';
  }

  @override
  String get unknownStatus => 'inconnu';

  @override
  String get submitKyc => 'Envoyer le KYC';

  @override
  String get verificationMayTakeTimeNote =>
      'Remarque : la vérification peut prendre du temps. Vous pourrez accéder aux fonctionnalités prestataire une fois approuvé.';

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
  String get enterVerificationCodeTitle => 'Saisir le code de vérification';

  @override
  String otpSentToUsername(Object username) {
    return 'Nous avons envoyé un code à 6 chiffres au numéro de téléphone\nassocié à \"$username\".';
  }

  @override
  String get sixDigitCodeLabel => 'Code à 6 chiffres';

  @override
  String get enterSixDigitCodeValidation => 'Saisissez le code à 6 chiffres';

  @override
  String get otpInvalidOrExpired => 'Code invalide ou expiré.';

  @override
  String get failedLoadUserInfoAfterVerification =>
      'Impossible de charger les informations utilisateur après vérification.';

  @override
  String get chatWithSupportTitle => 'Discuter avec l’assistance';

  @override
  String get unableStartSupportChat =>
      'Impossible de démarrer le chat d’assistance.';

  @override
  String get invalidSupportThreadReturned =>
      'Fil de discussion d’assistance invalide renvoyé par le serveur.';

  @override
  String get noMessagesYet =>
      'Aucun message pour le moment. Commencez une conversation !';

  @override
  String get supportDefaultName => 'Assistance';

  @override
  String get aboutPoliciesTitle => 'À propos & politique';

  @override
  String get newBookingTitle => 'Nouvelle réservation';

  @override
  String get appointmentDetailsTitle => 'Détails du rendez-vous';

  @override
  String get pickDate => 'Choisir une date';

  @override
  String get pickTime => 'Choisir une heure';

  @override
  String get serviceTypeTitle => 'Type de service';

  @override
  String get serviceDropdownLabel => 'Service';

  @override
  String get serviceHaircutLabel => 'Coupe';

  @override
  String get serviceBraidsLabel => 'Tresses';

  @override
  String get serviceShaveLabel => 'Rasage';

  @override
  String get serviceHairColoringLabel => 'Coloration';

  @override
  String get serviceManicureLabel => 'Manucure';

  @override
  String get servicePedicureLabel => 'Pédicure';

  @override
  String get serviceNailArtLabel => 'Nail art';

  @override
  String get serviceMakeupLabel => 'Maquillage';

  @override
  String get serviceFacialLabel => 'Soin du visage';

  @override
  String get serviceWaxingLabel => 'Épilation';

  @override
  String get serviceMassageLabel => 'Massage';

  @override
  String get serviceTattooLabel => 'Tattoo';

  @override
  String get serviceHairStylingLabel => 'Coiffage';

  @override
  String get serviceHairTreatmentLabel => 'Soin des cheveux';

  @override
  String get serviceHairExtensionsLabel => 'Extensions';

  @override
  String get serviceOtherServicesLabel => 'Autres services';

  @override
  String get notesForProviderOptionalLabel =>
      'Notes pour votre prestataire (facultatif)';

  @override
  String get locationTitle => 'Localisation';

  @override
  String get latitudeLabel => 'Latitude';

  @override
  String get longitudeLabel => 'Longitude';

  @override
  String get requiredField => 'Obligatoire';

  @override
  String get useMyCurrentLocation => 'Utiliser ma position actuelle';

  @override
  String pricesShownIn(Object symbol, Object country) {
    return 'Prix affichés en $symbol ($country)';
  }

  @override
  String get chooseTimeLaterThanCurrent =>
      'Veuillez choisir une heure ultérieure à l’heure actuelle.';

  @override
  String get pleasePickDateAndTime => 'Veuillez choisir la date et l’heure.';

  @override
  String get locationUpdatedFromGps => 'Position mise à jour via GPS.';

  @override
  String failedToGetLocation(Object error) {
    return 'Impossible d’obtenir la position : $error';
  }

  @override
  String bookingCreatedChoosePrice(Object id) {
    return 'Réservation créée ! ID : $id • Choisissez votre option de prix.';
  }

  @override
  String get failedToCreateBooking => 'Échec de la création de la réservation.';

  @override
  String get paymentsNotSupportedLong =>
      'Les paiements ne sont pas pris en charge sur cette plateforme. Veuillez exécuter l’application sur Android, iOS, macOS ou Web pour tester les paiements.';

  @override
  String get noBookingToConfirm =>
      'Aucune réservation à confirmer. Veuillez d’abord créer une réservation.';

  @override
  String get pleaseChoosePriceOption => 'Veuillez choisir une option de prix.';

  @override
  String get failedCreatePaymentTryAgain =>
      'Échec de la création du paiement côté serveur. Veuillez réessayer.';

  @override
  String paymentSuccessfulMessage(Object bookingId, Object paid) {
    return 'Paiement réussi !\nRéservation #$bookingId • Payé : $paid\nVotre demande est maintenant visible pour les prestataires à proximité.';
  }

  @override
  String get paymentSucceededButFailedUpdate =>
      'Paiement réussi, mais échec de la mise à jour de la réservation côté serveur.';

  @override
  String paymentCancelledOrFailed(Object reason) {
    return 'Paiement annulé ou échoué : $reason';
  }

  @override
  String unexpectedPaymentError(Object error) {
    return 'Erreur de paiement inattendue : $error';
  }

  @override
  String get createBookingButton => 'Créer la réservation';

  @override
  String get chooseYourPriceOptionTitle => 'Choisissez votre option de prix';

  @override
  String transportationCostLabel(Object cost) {
    return 'Coût de transport : $cost';
  }

  @override
  String get budgetTierTitle => 'ÉCONOMIQUE';

  @override
  String get standardTierTitle => 'STANDARD';

  @override
  String get priorityTierTitle => 'PRIORITAIRE';

  @override
  String get budgetTierDescription =>
      'Meilleur rapport qualité-prix près de chez vous';

  @override
  String get standardTierDescription =>
      'Équilibre recommandé entre prix et disponibilité';

  @override
  String get priorityTierDescription =>
      'Option premium pour attirer plus vite les meilleurs prestataires';

  @override
  String get naShort => 'N/D';

  @override
  String get priceBreakdownTitle => 'Détail du prix';

  @override
  String get servicePriceLabel => 'Prix du service';

  @override
  String get transportationLabel => 'Transport';

  @override
  String serviceFeeLabel(Object percent) {
    return 'Frais de service ($percent%)';
  }

  @override
  String allPricesIn(Object currency, Object country) {
    return 'Tous les prix en $currency ($country)';
  }

  @override
  String get userCountryPlaceholder => 'Pays de l’utilisateur';

  @override
  String get totalToPayTitle => 'Total à payer';

  @override
  String get includesServiceTransportation => 'Inclut service + transport';

  @override
  String get confirmAndPay => 'Confirmer et payer';

  @override
  String get howPricingWorksTitle => 'Fonctionnement des prix';

  @override
  String get howPricingWorksBullets =>
      '• Économique : meilleur rapport qualité-prix à proximité\n• Standard : option recommandée\n• Prioritaire : option premium pour accélérer l’acceptation\n• Le transport est inclus dans le total';

  @override
  String get myBookingsTitle => 'Mes réservations';

  @override
  String get myAssignedJobsTitle => 'Mes missions attribuées';

  @override
  String get pleaseCompleteProviderProfileFirst =>
      'Veuillez d’abord compléter votre profil prestataire.';

  @override
  String get failedToLoadBookings => 'Échec du chargement des réservations.';

  @override
  String get profileSetupRequiredTitle => 'Configuration du profil requise';

  @override
  String get profileSetupRequiredBody =>
      'Vous devez compléter votre profil prestataire avant de pouvoir voir les missions attribuées et les gains.';

  @override
  String get later => 'Plus tard';

  @override
  String get setupNow => 'Configurer maintenant';

  @override
  String get noBookingsFound => 'Aucune réservation trouvée.';

  @override
  String get findNearbyOpenJobs => 'Trouver des missions ouvertes à proximité';

  @override
  String get pay => 'Payer';

  @override
  String get rate => 'Noter';

  @override
  String bookingNumber(Object id) {
    return 'Réservation #$id';
  }

  @override
  String whenOn(Object date) {
    return 'Quand : $date';
  }

  @override
  String whenAt(Object date, Object time) {
    return 'Quand : $date à $time';
  }

  @override
  String providerLine(Object name) {
    return 'Prestataire : $name';
  }

  @override
  String userLine(Object name) {
    return 'Utilisateur : $name';
  }

  @override
  String estimatedPriceLine(Object price) {
    return 'Prix estimé : $price';
  }

  @override
  String paymentLine(Object status) {
    return 'Paiement : $status';
  }

  @override
  String get paymentUnpaid => 'non payé';

  @override
  String get paymentUnknown => 'inconnu';

  @override
  String get confirmPaymentTitle => 'Confirmer le paiement';

  @override
  String confirmPaymentBody(Object amount) {
    return 'Payer $amount pour confirmer cette réservation ?';
  }

  @override
  String get yesPay => 'Oui, payer';

  @override
  String get failedToCreatePaymentIntent =>
      'Échec de la création de l’intention de paiement.';

  @override
  String get paymentSuccessfulShort => 'Paiement réussi.';

  @override
  String get paymentSucceededButFailedUpdateBooking =>
      'Paiement réussi, mais échec de la mise à jour de la réservation côté serveur.';

  @override
  String paymentCancelledOrFailedReason(Object reason) {
    return 'Paiement annulé ou échoué : $reason';
  }

  @override
  String unexpectedPaymentErrorReason(Object error) {
    return 'Erreur de paiement inattendue : $error';
  }

  @override
  String rateProviderTitle(Object providerName) {
    return 'Noter $providerName';
  }

  @override
  String get selectRatingHelp =>
      'Sélectionnez une note (1 = mauvais, 5 = excellent) :';

  @override
  String get commentsOptionalLabel => 'Commentaires (facultatif)';

  @override
  String get submit => 'Envoyer';

  @override
  String get reviewSubmitted => 'Avis envoyé.';

  @override
  String get failedSubmitReview => 'Échec de l’envoi de l’avis.';

  @override
  String failedToLoadProfile(Object error) {
    return 'Échec du chargement du profil : $error';
  }

  @override
  String profileSavedSuccess(Object action) {
    return 'Profil $action avec succès !';
  }

  @override
  String genericError(Object error) {
    return 'Erreur : $error';
  }

  @override
  String get locationPermissionDeniedEnableInSettings =>
      'Autorisation de localisation refusée. Veuillez l’activer dans les paramètres.';

  @override
  String get locationPermissionPermanentlyDeniedEnableInAppSettings =>
      'Autorisation de localisation refusée définitivement. Veuillez l’activer dans les paramètres de l’application.';

  @override
  String errorGettingLocation(Object error) {
    return 'Erreur lors de l’obtention de la position : $error';
  }

  @override
  String get couldNotFindLocationForAddress =>
      'Impossible de trouver la position pour cette adresse';

  @override
  String errorConvertingAddress(Object error) {
    return 'Erreur de conversion de l’adresse : $error';
  }

  @override
  String get portfolioUnavailableCompleteKycFirst =>
      'Portfolio indisponible. Si vous êtes prestataire, terminez d’abord la vérification KYC.';

  @override
  String failedToLoadPortfolio(Object error) {
    return 'Échec du chargement du portfolio : $error';
  }

  @override
  String get addPhoto => 'Ajouter une photo';

  @override
  String get addVideo => 'Ajouter une vidéo';

  @override
  String get addPost => 'Ajouter une publication';

  @override
  String get captionOptionalTitle => 'Légende (facultatif)';

  @override
  String get captionHintExample => 'ex. « Tresses knotless sur cliente »';

  @override
  String get skip => 'Ignorer';

  @override
  String get save => 'Enregistrer';

  @override
  String get failedToCreatePortfolioPost =>
      'Impossible de créer la publication du portfolio.';

  @override
  String get uploadFailedMediaUpload =>
      'Échec de l’envoi (téléversement du média).';

  @override
  String uploadFailed(Object error) {
    return 'Échec de l’envoi : $error';
  }

  @override
  String get deletePostTitle => 'Supprimer la publication ?';

  @override
  String get deletePostBody =>
      'Cela supprimera la publication de votre portfolio.';

  @override
  String get delete => 'Supprimer';

  @override
  String get deleteFailed => 'Échec de la suppression.';

  @override
  String deleteFailedWithError(Object error) {
    return 'Échec de la suppression : $error';
  }

  @override
  String get portfolioTitle => 'Portfolio';

  @override
  String get noPortfolioPostsYetHelpText =>
      'Aucune publication pour l’instant. Ajoutez des photos/vidéos de votre travail pour aider les clients à faire confiance à vos compétences.';

  @override
  String get setupProviderProfileTitle => 'Configurer le profil prestataire';

  @override
  String get providerProfileTitle => 'Profil prestataire';

  @override
  String get welcomeToStyloriaTitle => 'Bienvenue sur Styloria !';

  @override
  String get completeProviderProfileToStartEarning =>
      'Complétez votre profil prestataire pour commencer à accepter des missions et gagner de l’argent.';

  @override
  String reviewCountLabel(int count) {
    return '($count avis)';
  }

  @override
  String get topRatedChip => 'Très bien noté';

  @override
  String get bioLabel => 'Bio / Description';

  @override
  String get bioHint =>
      'Parlez aux clients de vos compétences et de votre expérience...';

  @override
  String get pleaseEnterBio => 'Veuillez saisir une bio';

  @override
  String bioMinLength(int min) {
    return 'La bio doit contenir au moins $min caractères';
  }

  @override
  String get yourLocationTitle => 'Votre localisation';

  @override
  String get locationHelpMatchNearbyClients =>
      'Votre localisation nous aide à vous associer à des clients proches';

  @override
  String get locationHelpUpdateToFindJobs =>
      'Mettez à jour votre localisation pour trouver des missions dans d’autres zones';

  @override
  String get useMyCurrentLocationTitle => 'Utiliser ma position actuelle';

  @override
  String get gpsSubtitle => 'Obtenir automatiquement la position via GPS';

  @override
  String get orLabel => 'OU';

  @override
  String get enterYourAddressTitle => 'Saisissez votre adresse';

  @override
  String get fullAddressLabel => 'Adresse complète';

  @override
  String get fullAddressHint => 'ex. 123 Main St, Accra, Ghana';

  @override
  String get find => 'Rechercher';

  @override
  String get addressHelpText => 'Saisissez votre rue, ville et pays';

  @override
  String get coordinatesAutoFilledTitle =>
      'Coordonnées (remplies automatiquement)';

  @override
  String get servicePricingTitle => 'Tarification des services';

  @override
  String get servicePricingHelp =>
      'Définissez votre prix pour chaque service. Cochez « Non proposé » pour les services que vous ne pouvez pas fournir.';

  @override
  String get serviceHeader => 'Service';

  @override
  String get priceHeader => 'Prix';

  @override
  String get notOfferedHeader => 'Non proposé';

  @override
  String get priceHint => '0,00';

  @override
  String get providerHowPricingWorksTitle =>
      'Comment fonctionne la tarification :';

  @override
  String get providerHowPricingWorksBody =>
      '• Votre prix correspond au montant que vous facturez pour le service\n• Coût de transport = 80% de la devise de l’utilisateur par km\n• Les utilisateurs voient 3 options selon les prestataires à proximité :\n  - Économique : prix le plus bas\n  - Standard : prix moyen\n  - Prioritaire : prix le plus élevé';

  @override
  String get availableForBookingsTitle => 'Disponible pour les réservations';

  @override
  String get availableOnHelp =>
      '✓ Vous apparaîtrez dans les résultats de recherche pour les clients à proximité';

  @override
  String get availableOffHelp => '✗ Vous ne recevrez pas de nouvelles offres';

  @override
  String get completeSetupStartEarning =>
      'Terminer la configuration et commencer à gagner';

  @override
  String get updateProfile => 'Mettre à jour le profil';

  @override
  String get skipForNow => 'Ignorer pour l’instant';

  @override
  String get paymentsNotSupportedShort =>
      'Payments are not supported on this platform. Please use Android, iOS, macOS, or Web.';

  @override
  String get genericContact => 'Contact';

  @override
  String get genericProvider => 'Prestataire';

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
  String get detectingYourLocation => 'Detecting your location...';

  @override
  String locationConfirmed(String country) {
    return '✓ Localisation confirmée : $country';
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
  String get reviewSelectRatingPrompt => 'Sélectionnez une note (de 1 à 5).';

  @override
  String get reviewCommentOptionalLabel => 'Commentaire (facultatif)';

  @override
  String get genericCancel => 'Annuler';

  @override
  String get genericSubmit => 'Envoyer';

  @override
  String get reviewSubmitFailed => 'Échec de l’envoi de l’avis.';

  @override
  String get rateThisService => 'Noter ce service';

  @override
  String get tipLeaveTitle => 'Laisser un pourboire';

  @override
  String get tipChooseAmountPrompt =>
      'Choisissez un montant de pourboire ou saisissez un montant personnalisé.';

  @override
  String get tipNoTip => 'Pas de pourboire';

  @override
  String get tipCustomAmountLabel => 'Montant du pourboire personnalisé';

  @override
  String get genericContinue => 'Continuer';

  @override
  String get tipSkipped => 'Pourboire ignoré.';

  @override
  String get tipFailedToSaveChoice =>
      'Impossible d’enregistrer votre choix de pourboire.';

  @override
  String get tipFailedToCreatePayment =>
      'Impossible de créer le paiement du pourboire.';

  @override
  String get tipPaidSuccessfully => 'Pourboire payé avec succès. Merci !';

  @override
  String get tipPaidButUpdateFailed =>
      'Le paiement du pourboire a réussi, mais la mise à jour de la réservation a échoué.';

  @override
  String tipCancelledOrFailed(Object message) {
    return 'Pourboire annulé/échoué : $message';
  }

  @override
  String tipUnexpectedError(Object error) {
    return 'Erreur de pourboire inattendue : $error';
  }

  @override
  String get tipAlreadyPaidLabel => 'Pourboire déjà payé';

  @override
  String get tipSkippedLabel => 'Pourboire ignoré';

  @override
  String get tipLeaveButton => 'Laisser un pourboire';

  @override
  String get walletTitle => 'Portefeuille';

  @override
  String get walletTooltip => 'Portefeuille';

  @override
  String get payoutSettingsTitle => 'Paramètres de paiement';

  @override
  String get payoutSettingsTooltip => 'Paramètres de paiement';

  @override
  String get walletNoWalletYet =>
      'Aucun portefeuille pour le moment. Terminez des missions pour gagner.';

  @override
  String get walletCurrencyFieldLabel => 'Devise';

  @override
  String walletAvailableLine(Object amount, Object currency) {
    return 'Disponible : $amount $currency';
  }

  @override
  String walletPendingLine(Object amount, Object currency) {
    return 'En attente : $amount $currency';
  }

  @override
  String get walletCashOutInstant => 'Retirer (instantané)';

  @override
  String get walletCashOutFailed => 'Échec du retrait.';

  @override
  String walletCashOutSentTransfer(Object transferId) {
    return 'Retrait envoyé. Virement : $transferId';
  }

  @override
  String get walletTransactionsTitle => 'Transactions';

  @override
  String get walletNoTransactionsYet => 'Aucune transaction pour le moment.';

  @override
  String get payoutAutoPayoutsTitle => 'Paiements automatiques';

  @override
  String get payoutAutoPayoutsSubtitle =>
      'Envoyer automatiquement les paiements selon votre planning.';

  @override
  String get payoutDayUtcLabel => 'Jour de paiement (UTC)';

  @override
  String get payoutHourUtcLabel => 'Heure de paiement (UTC)';

  @override
  String get payoutMinimumAmountLabel =>
      'Montant minimum du paiement automatique';

  @override
  String get payoutMinimumAmountHelper =>
      'Le paiement automatique s’exécute seulement si le solde disponible ≥ ce montant.';

  @override
  String get payoutInstantCashOutEnabledTitle => 'Retrait instantané activé';

  @override
  String get payoutInstantCashOutEnabledSubtitle =>
      'Autoriser le bouton « Retirer » (des frais s’appliquent).';

  @override
  String get payoutSettingsSaved => 'Paramètres de paiement enregistrés.';

  @override
  String get payoutSettingsSaveFailed =>
      'Impossible d’enregistrer les paramètres de paiement.';

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
  String get signOut => 'Se déconnecter';

  @override
  String get kycIdFrontPhoto => 'Photo recto de la pièce d\'identité';

  @override
  String get kycIdFrontMessage =>
      'Prenez une photo du recto de votre carte d\'identité';

  @override
  String get kycIdBackPhoto => 'Photo verso de la pièce d\'identité';

  @override
  String get kycIdBackMessage =>
      'Prenez une photo du verso de votre carte d\'identité';

  @override
  String get kycCamera => 'Caméra';

  @override
  String get kycGallery => 'Galerie';

  @override
  String get kycChooseSource => 'Choisir la source :';

  @override
  String get kycFailedCaptureImage => 'Échec de la capture de l\'image';

  @override
  String get kycFailedCaptureSelfie => 'Échec de la capture du selfie';

  @override
  String get kycCameraNotAvailable => 'Caméra non disponible';

  @override
  String get kycCameraNotAvailableMessage =>
      'La caméra n\'est pas disponible. Souhaitez-vous sélectionner une image de votre galerie à la place ?';

  @override
  String get kycUseGallery => 'Utiliser la galerie';

  @override
  String get kycDocumentsLocked =>
      'Les documents sont verrouillés en attente d\'examen. Vous ne pouvez pas effectuer de modifications tant que la vérification n\'est pas terminée.';

  @override
  String get kycVerificationSubmittedSuccessfully =>
      'Vérification soumise avec succès';

  @override
  String get kycVerificationSubmitted => 'Vérification soumise';

  @override
  String get kycThankYouSubmitting =>
      'Merci d\'avoir soumis vos documents de vérification !';

  @override
  String get kycWhatHappensNext => 'Que se passe-t-il ensuite :';

  @override
  String get kycReviewTime =>
      'Notre équipe examinera vos documents dans les 24 à 48 heures';

  @override
  String get kycEmailNotification =>
      'Vous recevrez un e-mail une fois votre vérification terminée';

  @override
  String get kycCheckEmail =>
      'Consultez votre e-mail pour les mises à jour sur l\'état de votre vérification';

  @override
  String get kycLocked =>
      'Vos documents sont maintenant verrouillés et ne peuvent pas être modifiés pendant l\'examen';

  @override
  String get kycRecommendSignOut =>
      'Nous vous recommandons de vous déconnecter et de revenir plus tard pour votre résultat de vérification.';

  @override
  String get kycStaySignedIn => 'Rester connecté';

  @override
  String get kycVerificationPending => 'Vérification en attente';

  @override
  String get kycVerificationPendingSubtitle =>
      'Vos documents sont en cours d\'examen';

  @override
  String get kycVerificationApproved => 'Vérification approuvée';

  @override
  String get kycVerificationApprovedSubtitle =>
      'Vous pouvez maintenant accéder à toutes les fonctionnalités du fournisseur';

  @override
  String get kycVerificationRejected => 'Vérification rejetée';

  @override
  String get kycVerificationRejectedSubtitle =>
      'Veuillez consulter les notes ci-dessous et soumettre à nouveau';

  @override
  String get kycVerificationRequired => 'Vérification requise';

  @override
  String get kycVerificationRequiredSubtitle =>
      'Complétez la vérification pour accéder aux fonctionnalités du fournisseur';

  @override
  String get kycReviewNotes => 'Notes d\'examen';

  @override
  String get kycIdCardFront => 'Carte d\'identité (Recto)';

  @override
  String get kycIdCardBack => 'Carte d\'identité (Verso)';

  @override
  String get kycVerificationSelfie => 'Selfie de vérification';

  @override
  String get kycButtonLocked => 'Verrouillé';

  @override
  String get kycCaptureIdFront => 'Capturer le recto de la pièce d\'identité';

  @override
  String get kycCaptureIdBack => 'Capturer le verso de la pièce d\'identité';

  @override
  String get kycDocumentsLockedButton => 'Documents verrouillés';

  @override
  String get kycTipsTitle => '📸 Conseils pour de bonnes photos :';

  @override
  String get kycTipGoodLighting => '• Utilisez un bon éclairage';

  @override
  String get kycTipFlatCard =>
      '• Placez la carte d\'identité sur une surface plane';

  @override
  String get kycTipReadableText =>
      '• Assurez-vous que tout le texte est lisible';

  @override
  String get kycTipFaceCamera =>
      '• Regardez directement la caméra pour le selfie';

  @override
  String get kycTipAvoidGlare => '• Évitez les reflets ou les ombres';

  @override
  String get kycFailedSubmitVerification =>
      'Échec de la soumission de la vérification';

  @override
  String get paystackSetupTitle => 'Configurer le compte de paiement';

  @override
  String get paystackVerifying => 'Vérification en cours...';

  @override
  String get paystackVerificationSuccess =>
      'Paramètres de paiement enregistrés avec succès !';

  @override
  String get paystackVerificationFailed =>
      'Échec de l\'enregistrement des paramètres de paiement';

  @override
  String get paystackSelectBank => 'Sélectionnez votre banque';

  @override
  String get paystackAccountNumber => 'Numéro de compte';

  @override
  String get paystackVerifyAccount => 'Vérifier le compte';

  @override
  String get paystackAccountVerified => 'Compte vérifié';

  @override
  String get paystackSavePayoutAccount => 'Enregistrer le compte de paiement';

  @override
  String paystackNoBanksAvailable(Object country) {
    return 'Aucune banque disponible pour $country';
  }

  @override
  String get paystackRetry => 'Réessayer';

  @override
  String get paystackPayoutsInfo =>
      'Vos gains seront envoyés sur ce compte. Les paiements sont traités dans les 24 heures.';

  @override
  String get paystackConnected => 'Compte : connecté';

  @override
  String get paystackNotConnected => 'Compte : non connecté';

  @override
  String get paystackDetailsSubmitted => 'Détails soumis :';

  @override
  String get paystackPayoutsEnabled => 'Paiements activés :';

  @override
  String get paystackYes => 'oui';

  @override
  String get paystackNo => 'non';

  @override
  String get paystackFinishSetup => 'Terminer la configuration Stripe';

  @override
  String get paystackConnectStripe => 'Connecter Stripe';

  @override
  String get paystackOpenDashboard => 'Ouvrir le tableau de bord Stripe';

  @override
  String get paystackMustFinishSetup =>
      'Vous devez terminer la configuration Stripe avant de pouvoir retirer des fonds.';

  @override
  String get paystackPayouts => 'Paiements Paystack';

  @override
  String get paystackAddBankDetails =>
      'Ajoutez vos coordonnées bancaires dans les paramètres de paiement pour recevoir des paiements via Paystack.';

  @override
  String get paystackOpenSettings => 'Ouvrir les paramètres de paiement';

  @override
  String payoutPaystackForCountry(Object country) {
    return 'Paiements via Paystack pour $country';
  }

  @override
  String payoutFlutterwaveForCountry(Object country) {
    return 'Les paiements sont traités via Flutterwave pour $country';
  }

  @override
  String get payoutStripeConnect => 'Stripe Connect';

  @override
  String get payoutBankAccountDetails => 'Coordonnées bancaires';

  @override
  String get payoutAccountHolderName => 'Nom du titulaire du compte';

  @override
  String get payoutAccountHolderNameHint =>
      'Entrez le nom tel qu\'il apparaît sur votre compte bancaire';

  @override
  String get payoutSelectBank => 'Sélectionner la banque *';

  @override
  String get payoutBankName => 'Nom de la banque *';

  @override
  String get payoutBankNameManual => 'Nom de la banque (manuel)';

  @override
  String get payoutBankNameHint => 'ex. GCB Bank, Ecobank';

  @override
  String get payoutBankCode => 'Code bancaire *';

  @override
  String get payoutBankCodeManual => 'Code bancaire (manuel)';

  @override
  String get payoutBankCodeHint => 'Code bancaire Flutterwave';

  @override
  String get payoutBankCodeHelper =>
      'Contactez le support si vous n\'êtes pas sûr du code bancaire';

  @override
  String get payoutAccountNumber => 'Numéro de compte *';

  @override
  String get payoutAccountNumberHint =>
      'Entrez votre numéro de compte bancaire';

  @override
  String get payoutMobileMoney => 'Mobile Money';

  @override
  String get payoutFullName => 'Nom complet (tel qu\'enregistré) *';

  @override
  String get payoutFullNameHint =>
      'Nom enregistré sur votre compte mobile money';

  @override
  String get payoutMobileNetwork => 'Réseau mobile *';

  @override
  String get payoutSelectNetwork => 'Sélectionnez votre réseau mobile';

  @override
  String get payoutMobileNetworkHint => 'ex. MTN, Vodafone, Airtel';

  @override
  String get payoutCountryCode => 'Code pays';

  @override
  String get payoutMobileMoneyNumber => 'Numéro mobile money *';

  @override
  String get payoutMobileMoneyNumberHint => 'ex. 0541234567';

  @override
  String get payoutZipCode => 'Code postal';

  @override
  String get payoutZipCodeHint => 'Si requis par votre réseau';

  @override
  String get payoutMethod => 'Méthode de paiement';

  @override
  String get payoutBankTransfer => 'Virement bancaire';

  @override
  String get payoutCurrency => 'Devise';

  @override
  String payoutCurrencyLocked(Object country) {
    return 'Verrouillé à la devise de $country';
  }

  @override
  String get payoutBeneficiaryId => 'ID du bénéficiaire';

  @override
  String get payoutBeneficiaryIdHint =>
      'Facultatif - pour les virements récurrents';

  @override
  String get payoutSchedule => 'Calendrier de paiement';

  @override
  String get payoutFrequency => 'Fréquence de paiement';

  @override
  String get payoutFrequencyWeekly => 'Hebdomadaire';

  @override
  String get payoutFrequencyMonthly => 'Mensuel (le 1er de chaque mois)';

  @override
  String get payoutDayHelper => 'Disponible : Mardi, Jeudi, Vendredi';

  @override
  String get payoutMonthlyInfo =>
      'Les paiements mensuels sont traités le 1er de chaque mois.';

  @override
  String get payoutInstantCashout => 'Retrait instantané';

  @override
  String get payoutInstantCashoutInfo =>
      '• Retraits instantanés illimités disponibles\n• Frais de 5 % appliqués aux retraits instantanés\n• Les paiements programmés n\'ont pas de frais';

  @override
  String get payoutNextScheduled => 'Prochain paiement programmé';

  @override
  String payoutYourLocalTime(Object timezone) {
    return 'Votre heure locale ($timezone)';
  }

  @override
  String get payoutAmountToCashOut => 'Montant à retirer';

  @override
  String payoutMinMaxRange(Object min, Object max) {
    return 'Min : $min - Max : $max';
  }

  @override
  String get payoutMaxButton => 'MAX';

  @override
  String get payoutCashOutNow => 'Retirer (Instantané)';

  @override
  String get payoutAvailableBalance => 'Solde disponible';

  @override
  String get payoutPendingFunds => 'En attente';

  @override
  String get payoutPendingInfo =>
      'Les fonds en attente seront disponibles après la période de retenue';

  @override
  String get payoutLifetimeEarnings => 'Gains totaux';

  @override
  String get payoutTotalCashedOut => 'Total retiré';

  @override
  String get payoutUnlimitedCashouts => 'Illimité';

  @override
  String get mainHello => 'Bonjour';

  @override
  String get mainViewProfile => 'Voir le profil';

  @override
  String get mainBookings => 'Réservations';

  @override
  String get mainNotifications => 'Notifications';

  @override
  String get mainReferral => 'Parrainage';

  @override
  String get mainSettings => 'Paramètres';

  @override
  String get mainHelp => 'Aide';

  @override
  String get mainWallet => 'Portefeuille';

  @override
  String get mainEarnings => 'Gains';

  @override
  String get mainOpenJobs => 'Emplois ouverts';

  @override
  String get mainAssignedJobs => 'Emplois assignés';

  @override
  String get mainMyReputation => 'Ma réputation';

  @override
  String get reputationTitle => 'Ma réputation';

  @override
  String get reputationYourCustomerRating => 'Votre évaluation client';

  @override
  String reputationBasedOnReviews(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'avis',
      one: 'avis',
    );
    return 'Basé sur $count $_temp0';
  }

  @override
  String get reputationExcellentCustomer => '⭐ Client excellent';

  @override
  String get reputationGreatCustomer => '👍 Excellent client';

  @override
  String get reputationGoodCustomer => '✓ Bon client';

  @override
  String get reputationAverage => 'Moyen';

  @override
  String get reputationNeedsImprovement => 'À améliorer';

  @override
  String get reputationNoRatingYet => 'Pas encore d\'évaluation';

  @override
  String get reputationWhatProvidersSay =>
      'Ce que les fournisseurs disent de vous';

  @override
  String get reputationNoReviews => 'Pas encore d\'avis';

  @override
  String get reputationNoReviewsHelp =>
      'Terminez des réservations pour bâtir votre réputation !\nLes fournisseurs vous évalueront après avoir terminé les services.';

  @override
  String reputationShowMore(int count) {
    return 'Afficher plus ($count de plus)';
  }

  @override
  String get reputationShowLess => 'Afficher moins';

  @override
  String get reputationJustNow => 'À l\'instant';

  @override
  String reputationMinutesAgo(int minutes) {
    return 'Il y a $minutes min';
  }

  @override
  String reputationHoursAgo(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'heures',
      one: 'heure',
    );
    return 'Il y a $hours $_temp0';
  }

  @override
  String reputationDaysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'jours',
      one: 'jour',
    );
    return 'Il y a $days $_temp0';
  }

  @override
  String reputationWeeksAgo(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: 'semaines',
      one: 'semaine',
    );
    return 'Il y a $weeks $_temp0';
  }

  @override
  String reputationMonthsAgo(int months) {
    return 'Il y a $months mois';
  }

  @override
  String reputationYearsAgo(int years) {
    String _temp0 = intl.Intl.pluralLogic(
      years,
      locale: localeName,
      other: 'ans',
      one: 'an',
    );
    return 'Il y a $years $_temp0';
  }

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsNoNotifications => 'Pas encore de notifications.';
}
