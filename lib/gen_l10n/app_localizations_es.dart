// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Styloria';

  @override
  String get account => 'Cuenta';

  @override
  String get profile => 'Perfil';

  @override
  String get myBookings => 'Mis Reservas';

  @override
  String get openJobs => 'Trabajos Disponibles';

  @override
  String get earnings => 'Ganancias';

  @override
  String get paymentMethods => 'Métodos de pago';

  @override
  String get referFriends => 'Invitar amigos';

  @override
  String get language => 'Idioma';

  @override
  String get settings => 'Configuración';

  @override
  String get darkMode => 'Modo oscuro';

  @override
  String get systemDefault => 'Predeterminado del sistema';

  @override
  String get languageUpdated => 'Idioma actualizado';

  @override
  String get languageSetToSystemDefault =>
      'Idioma configurado como predeterminado del sistema';

  @override
  String get helpAndSupport => 'Ayuda y Soporte';

  @override
  String get chatWithCustomerService => 'Chatear con servicio al cliente';

  @override
  String get aboutAndPolicies => 'Acerca de y Políticas';

  @override
  String get viewUserPoliciesAndAgreements =>
      'Ver políticas y acuerdos del usuario';

  @override
  String get logOut => 'Cerrar sesión';

  @override
  String get deleteAccount => 'Eliminar cuenta';

  @override
  String get deleteAccountSubtitle => 'Esta acción no se puede deshacer';

  @override
  String get deleteAccountTitle => 'Eliminar cuenta';

  @override
  String get deleteAccountConfirmBody =>
      '¿Estás seguro de que deseas eliminar tu cuenta?\n\nEsta acción cerrará tu sesión y podrías perder el acceso permanentemente.';

  @override
  String get no => 'No';

  @override
  String get yesDelete => 'Sí, eliminar';

  @override
  String get deleteAccountSheetTitle => 'Lamentamos verte partir.';

  @override
  String get deleteAccountSheetPrompt =>
      '¿Puedes decirnos por qué? (Selecciona todas las que apliquen)';

  @override
  String get deleteAccountSelectAtLeastOneReason =>
      'Por favor selecciona al menos una razón.';

  @override
  String get tellUsMoreOptional => 'Cuéntanos más (opcional)';

  @override
  String get suggestionsToImproveOptional =>
      'Sugerencias para mejorar (opcional)';

  @override
  String get deleteMyAccount => 'Eliminar mi cuenta';

  @override
  String get cancel => 'Cancelar';

  @override
  String get failedToDeleteAccount =>
      'No se pudo eliminar la cuenta. Por favor intenta de nuevo.';

  @override
  String get choosePreferredLanguage => 'Elige tu idioma preferido';

  @override
  String get noteSomeTextMayStillAppearInEnglish =>
      'Nota: Esto cambia el idioma de la aplicación. Algunos textos pueden seguir apareciendo en inglés hasta que se agreguen las traducciones.';

  @override
  String languageSetToName(Object name) {
    return 'Idioma configurado a $name';
  }

  @override
  String get close => 'Close';

  @override
  String get forgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get forgotPasswordTitle => 'Restablecer tu Contraseña';

  @override
  String get forgotPasswordSubtitle =>
      'Ingresa tu correo electrónico y te enviaremos un código para restablecer tu contraseña.';

  @override
  String get resetPasswordTitle => 'Crear Nueva Contraseña';

  @override
  String get resetPasswordSubtitle =>
      'Ingresa el código enviado a tu correo electrónico y elige una nueva contraseña.';

  @override
  String get sendResetCode => 'Enviar Código de Restablecimiento';

  @override
  String get resetPassword => 'Restablecer Contraseña';

  @override
  String get newPassword => 'Nueva Contraseña';

  @override
  String get confirmPassword => 'Confirmar Contraseña';

  @override
  String get dateOfBirth => 'Fecha de Nacimiento';

  @override
  String get verificationCode => 'Código de Verificación';

  @override
  String get invalidEmail => 'Por favor ingresa un correo electrónico válido';

  @override
  String get invalidCode => 'Por favor ingresa un código válido';

  @override
  String get passwordTooShort =>
      'La contraseña debe tener al menos 8 caracteres';

  @override
  String get changeEmail => 'Usar un correo diferente';

  @override
  String get backToLogin => 'Volver al Inicio de Sesión';

  @override
  String get deletionReason1 => 'Ya no necesito Styloria';

  @override
  String get deletionReason2 =>
      'Tuve problemas para verificar mi cuenta (correo/KYC)';

  @override
  String get deletionReason3 =>
      'No pude encontrar servicios/proveedores cerca de mí';

  @override
  String get deletionReason4 =>
      'Los precios o tarifas eran muy altos / poco claros';

  @override
  String get deletionReason5 => 'La aplicación era confusa / difícil de usar';

  @override
  String get deletionReason6 => 'Errores o problemas de rendimiento';

  @override
  String get deletionReason7 => 'Problemas de pago/reembolso';

  @override
  String get deletionReason8 => 'Mala experiencia con un proveedor/usuario';

  @override
  String get deletionReason9 => 'Preocupaciones de privacidad o seguridad';

  @override
  String get deletionReason10 => 'Creé esta cuenta por error';

  @override
  String get deletionReason11 => 'Me estoy cambiando a otra plataforma';

  @override
  String get deletionReason12 => 'Otro';

  @override
  String get loginWelcomeTitle => 'Bienvenido a Styloria';

  @override
  String get loginWelcomeSubtitle =>
      'Inicia sesión para administrar tus reservas y servicios.';

  @override
  String get loginFailedToLoadUserInfo =>
      'Inicio de sesión exitoso pero no se pudo cargar la información del usuario.';

  @override
  String get username => 'Nombre de usuario';

  @override
  String get password => 'Contraseña';

  @override
  String get required => 'Requerido';

  @override
  String get login => 'Iniciar Sesión';

  @override
  String get createNewAccount => 'Crear una nueva cuenta';

  @override
  String get requestEmailVerificationCode =>
      'Solicitar código de verificación por correo';

  @override
  String get serviceLocationHint =>
      'Ingresa dónde quieres que se realice el servicio. Puede ser diferente a tu ubicación actual.';

  @override
  String get serviceAddressLabel => 'Dirección del Servicio';

  @override
  String get serviceAddressHint => 'ej., Calle Principal 123, Ciudad, País';

  @override
  String get searchAddressTooltip => 'Buscar esta dirección';

  @override
  String get serviceLocationSet => 'Ubicación del servicio establecida';

  @override
  String get coordinatesLabel => 'Coordenadas';

  @override
  String get pleaseEnterAddress => 'Por favor ingresa una dirección';

  @override
  String get locationUpdatedFromAddress =>
      'Ubicación actualizada desde la dirección';

  @override
  String get myCustomerRating => 'Mi Calificación como Cliente';

  @override
  String get outOf5 => '/ 5.0';

  @override
  String reviewsFromProviders(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'reseñas',
      one: 'reseña',
    );
    return '$count $_temp0 de proveedores';
  }

  @override
  String get failedToLoadReputation =>
      'No se pudo cargar los datos de reputación';

  @override
  String get somethingWentWrong => 'Algo salió mal';

  @override
  String get retry => 'Reintentar';

  @override
  String weDetectedYoureIn(String country) {
    return '📍 Detectamos que estás en $country. Por favor selecciona tu país a continuación.';
  }

  @override
  String get locationMarkedAsOther =>
      'Ubicación marcada como \"Otro\" - puedes continuar con el registro';

  @override
  String get createAccountTitle => 'Crear Cuenta';

  @override
  String get joinStyloria => 'Únete a Styloria';

  @override
  String get registerSubtitle =>
      'Crea una cuenta para reservar servicios o convertirte en proveedor';

  @override
  String get iWantTo => 'Quiero:';

  @override
  String get bookServices => 'Reservar Servicios';

  @override
  String get provideServices => 'Ofrecer Servicios';

  @override
  String get personalInformation => 'Información Personal';

  @override
  String get firstName => 'Nombre';

  @override
  String get lastName => 'Apellido';

  @override
  String get selectDateOfBirth => 'Seleccionar Fecha de Nacimiento';

  @override
  String get phoneNumber => 'Número de Teléfono';

  @override
  String get pleaseEnterPhoneNumber =>
      'Por favor ingresa un número de teléfono';

  @override
  String get accountInformation => 'Información de la Cuenta';

  @override
  String get chooseUniqueUsernameHint => 'Elige un nombre de usuario único';

  @override
  String get youAreCurrentlyUnavailable => 'Actualmente No Estás Disponible';

  @override
  String get toBrowseAndAcceptJobsEnableAvailability =>
      'Para explorar y aceptar solicitudes de trabajo cercanas, necesitas establecerte como disponible para reservas.';

  @override
  String get goToProfileSettings => 'Ir a Configuración de Perfil';

  @override
  String get tipToggleAvailableForBookings =>
      'Consejo: Activa \"Disponible para Reservas\" en tu Perfil de Proveedor para comenzar a recibir solicitudes de trabajo.';

  @override
  String requestedBy(String name) {
    return 'Solicitado por: $name';
  }

  @override
  String locationLabel(String address) {
    return 'Ubicación: $address';
  }

  @override
  String get email => 'Correo Electrónico';

  @override
  String get emailHint => 'tu@correo.com';

  @override
  String get enterValidEmail => 'Ingresa un correo electrónico válido';

  @override
  String get security => 'Seguridad';

  @override
  String get passwordHintAtLeast10 => 'Al menos 10 caracteres';

  @override
  String get passwordMin10 => 'La contraseña debe tener al menos 10 caracteres';

  @override
  String get iAgreeTo => 'Acepto los ';

  @override
  String get termsOfService => 'Términos de Servicio';

  @override
  String get and => 'y';

  @override
  String get privacyPolicy => 'Política de Privacidad';

  @override
  String get passwordIsRequired => 'La contraseña es requerida';

  @override
  String get passwordsDoNotMatch => 'Las contraseñas no coinciden';

  @override
  String get pleaseSelectDob => 'Por favor selecciona tu fecha de nacimiento.';

  @override
  String get pleaseSelectCountry => 'Por favor selecciona tu país.';

  @override
  String get pleaseSelectCity => 'Por favor selecciona tu ciudad.';

  @override
  String get pleaseEnterValidPhone =>
      'Por favor ingresa un número de teléfono válido.';

  @override
  String get mustAcceptTerms => 'Debes aceptar los términos y condiciones.';

  @override
  String get mustBeAtLeast18 =>
      'Debes tener al menos 18 años para registrarte.';

  @override
  String get agreeToTerms =>
      'Acepto los Términos de Servicio y la Política de Privacidad';

  @override
  String get createAccountButton => 'Crear Cuenta';

  @override
  String get alreadyHaveAccount => '¿Ya tienes una cuenta?';

  @override
  String get emailVerifiedSuccessPleaseLogin =>
      'Correo verificado exitosamente. Por favor inicia sesión.';

  @override
  String get pleaseVerifyEmailToContinue =>
      'Por favor verifica tu correo para continuar.';

  @override
  String get requestVerificationCodeTitle => 'Solicitar código de verificación';

  @override
  String get requestVerificationInstructions =>
      'Ingresa tu correo electrónico o nombre de usuario.\nEnviaremos un nuevo código de verificación al correo de esa cuenta.';

  @override
  String get emailOrUsername => 'Correo Electrónico o Nombre de Usuario';

  @override
  String get sendCode => 'Enviar código';

  @override
  String get ifAccountExistsCodeSent =>
      'Si esa cuenta existe, se envió un código.';

  @override
  String get failedToSendVerificationCode =>
      'No se pudo enviar el código de verificación.';

  @override
  String get verifyYourEmailTitle => 'Verifica tu correo electrónico';

  @override
  String get verificationCodeSentInfo =>
      'Se envió un código de verificación al correo de esta cuenta.';

  @override
  String emailVerificationInstructions(Object identifier) {
    return 'Ingresa el código de 6 dígitos enviado al correo de esta cuenta:\n$identifier';
  }

  @override
  String get verificationCodeLabel => 'Código de verificación';

  @override
  String get sendingEllipsis => 'Enviando...';

  @override
  String get resendCode => 'Reenviar código';

  @override
  String get enter6DigitCodeError => 'Ingresa el código de 6 dígitos.';

  @override
  String get verifyingEllipsis => 'Verificando...';

  @override
  String get verify => 'Verificar';

  @override
  String get invalidOrExpiredCodeTryResending =>
      'Código inválido o expirado. Intenta reenviarlo.';

  @override
  String bookingTitle(Object id) {
    return 'Reserva #$id';
  }

  @override
  String get invalidBookingIdForChat => 'ID de reserva inválido para chat.';

  @override
  String get invalidBookingIdForCall => 'ID de reserva inválido para llamada.';

  @override
  String get unableToLoadContactInfo =>
      'No se puede cargar la información de contacto. Asegúrate de que la reserva esté activa.';

  @override
  String noPhoneNumberAvailableForName(Object name) {
    return 'No hay número de teléfono disponible para $name.';
  }

  @override
  String get deviceCannotPlaceCalls =>
      'Este dispositivo no puede realizar llamadas telefónicas.';

  @override
  String get cancelBookingDialogTitle => 'Cancelar reserva';

  @override
  String get cancelBookingDialogBody =>
      '¿Realmente deseas cancelar esta reserva?\n\nNota: Si el proveedor ya aceptó y han pasado más de 7 minutos (pero menos de 40 minutos aproximadamente), se puede aplicar una penalización según las reglas.';

  @override
  String get yesCancel => 'Sí, cancelar';

  @override
  String get failedToCancelBooking => 'No se pudo cancelar la reserva.';

  @override
  String bookingCancelledPenaltyApplied(Object amount) {
    return 'Reserva cancelada. Se aplicó una penalización de $amount.';
  }

  @override
  String get bookingCancelledSuccessfully => 'Reserva cancelada exitosamente.';

  @override
  String get failedToConfirmCompletion =>
      'No se pudo confirmar la finalización. Por favor intenta de nuevo.';

  @override
  String get bothSidesConfirmedCompletedPayoutReleased =>
      'Ambas partes confirmaron. Reserva marcada como completada y pago liberado.';

  @override
  String get youConfirmedCompletionWaitingForProvider =>
      'Confirmaste la finalización. Esperando confirmación del proveedor.';

  @override
  String get youConfirmedCompletionWaitingForUser =>
      'Confirmaste la finalización. Esperando confirmación del usuario.';

  @override
  String get statusUnknown => 'desconocido';

  @override
  String get statusAccepted => 'aceptado';

  @override
  String get statusInProgress => 'en progreso';

  @override
  String get statusCompleted => 'completado';

  @override
  String get statusCancelled => 'cancelado';

  @override
  String get paymentPaid => 'pagado';

  @override
  String get paymentPending => 'pendiente';

  @override
  String get paymentFailed => 'fallido';

  @override
  String bookingAcceptedBy(Object name) {
    return 'Reserva aceptada por $name';
  }

  @override
  String get whenLabel => 'Cuándo';

  @override
  String atTime(Object time) {
    return 'a las $time';
  }

  @override
  String get userLabel => 'Usuario';

  @override
  String get providerLabel => 'Proveedor';

  @override
  String get estimatedPriceLabel => 'Precio estimado';

  @override
  String get offeredPaidLabel => 'Ofrecido / pagado';

  @override
  String get distanceLabel => 'Distancia';

  @override
  String distanceMiles(Object miles) {
    return '$miles millas';
  }

  @override
  String get acceptedAtLabel => 'Aceptado a las';

  @override
  String get cancelledAtLabel => 'Cancelado a las';

  @override
  String get cancelledByLabel => 'Cancelado por';

  @override
  String penaltyAppliedLabel(Object amount) {
    return 'Penalización aplicada: $amount';
  }

  @override
  String get userConfirmedLabel => 'Usuario confirmó';

  @override
  String get providerConfirmedLabel => 'Proveedor confirmó';

  @override
  String get payoutReleasedLabel => 'Pago liberado';

  @override
  String get yesLower => 'sí';

  @override
  String get noLower => 'no';

  @override
  String get chat => 'Chat';

  @override
  String get call => 'Llamar';

  @override
  String get actions => 'Acciones';

  @override
  String get confirmCompletion => 'Confirmar finalización';

  @override
  String get noFurtherActionsForBooking =>
      'No hay más acciones disponibles para esta reserva.';

  @override
  String freeCancellationEndsIn(Object time) {
    return 'Cancelación gratuita termina en $time';
  }

  @override
  String get earlyFreeCancellationEndedWarning =>
      'El período de cancelación gratuita temprana ha terminado. Hasta aproximadamente 40 minutos después de la aceptación, las cancelaciones tardías pueden incurrir en una penalización.';

  @override
  String get cancelBooking => 'Cancelar reserva';

  @override
  String get cancelBookingNoPenalty => 'Cancelar reserva (sin penalización)';

  @override
  String get cancelBookingPenaltyMayApply =>
      'Cancelar reserva (puede aplicar penalización)';

  @override
  String get cancellationPolicyInfo =>
      'Puedes cancelar sin penalización en los primeros 7 minutos después de la aceptación del proveedor, y nuevamente después de aproximadamente 40 minutos si es necesario. Entre esos tiempos, se puede aplicar una penalización según las reglas.';

  @override
  String ratingLine(Object rating, int reviewCount) {
    String _temp0 = intl.Intl.pluralLogic(
      reviewCount,
      locale: localeName,
      other: '$reviewCount reseñas',
      one: '1 reseña',
    );
    return 'Calificación: $rating ($_temp0)';
  }

  @override
  String get proofOfSkillsPortfolio => 'Prueba de habilidades (Portafolio)';

  @override
  String get noPortfolioPostsAvailable =>
      'No hay publicaciones de portafolio disponibles.';

  @override
  String get deleteProfilePicture => 'Eliminar Foto de Perfil';

  @override
  String get deleteProfilePictureTitle => 'Eliminar Foto de Perfil';

  @override
  String get deleteProfilePictureConfirmation =>
      '¿Estás seguro de que deseas eliminar tu foto de perfil?';

  @override
  String get profilePictureDeletedSuccessfully =>
      'Foto de perfil eliminada exitosamente.';

  @override
  String get failedToDeleteProfilePicture =>
      'No se pudo eliminar la foto de perfil.';

  @override
  String get bookingLocation => 'Ubicación de la reserva';

  @override
  String get location => 'Ubicación';

  @override
  String get latitude => 'Latitud';

  @override
  String get longitude => 'Longitud';

  @override
  String get mapWillAppearWhenCoordinatesValid =>
      'El mapa aparecerá aquí cuando las coordenadas sean válidas.';

  @override
  String chatForBookingTitle(Object id) {
    return 'Chat para reserva #$id';
  }

  @override
  String get unableToStartChat =>
      'No se puede iniciar el chat. El chat solo está disponible cuando la reserva está aceptada, en progreso, o completada en el último día.';

  @override
  String get invalidChatThreadFromServer =>
      'Hilo de chat inválido devuelto del servidor.';

  @override
  String get messageNotSentPolicy =>
      'Mensaje no enviado. Nota: no está permitido compartir números de teléfono o correos electrónicos, y el chat solo está disponible mientras la reserva esté activa.';

  @override
  String get unknown => 'Desconocido';

  @override
  String get typeMessageHint => 'Escribe un mensaje...';

  @override
  String get uploadProfilePicture => 'Subir Foto de Perfil';

  @override
  String get currentProfilePicture => 'Foto de Perfil Actual';

  @override
  String get newPicturePreview => 'Vista Previa de Nueva Foto';

  @override
  String get chooseImage => 'Elegir Imagen';

  @override
  String get upload => 'Subir';

  @override
  String get noImageBytesFoundWeb => 'No se encontraron bytes de imagen (web).';

  @override
  String get pleasePickAnImageFirst => 'Por favor elige una imagen primero.';

  @override
  String get uploadFailedCheckServerLogs =>
      'Subida fallida. Revisa los registros del servidor / token.';

  @override
  String get profilePictureUploadedSuccessfully =>
      '¡Foto de perfil subida exitosamente!';

  @override
  String errorWithValue(Object error) {
    return 'Error: $error';
  }

  @override
  String get tapToChangeProfilePicture => 'Toca para cambiar la foto de perfil';

  @override
  String usernameValue(Object username) {
    return 'Nombre de usuario: $username';
  }

  @override
  String roleValue(Object role) {
    return 'Rol: $role';
  }

  @override
  String get dateOfBirthYyyyMmDd => 'Fecha de nacimiento (AAAA-MM-DD)';

  @override
  String get saveProfile => 'Guardar Perfil';

  @override
  String get failedToSaveProfile =>
      'No se pudo guardar el perfil. Por favor intenta de nuevo.';

  @override
  String get profileUpdated => 'Perfil actualizado.';

  @override
  String get completeYourProviderProfile => 'Completa tu Perfil de Proveedor';

  @override
  String get completeProviderProfileBody =>
      'Para comenzar a aceptar trabajos y ganar dinero, completa tu perfil de proveedor.';

  @override
  String get setupProfileNow => 'Configurar Perfil Ahora';

  @override
  String get doItLater => 'Hacerlo Después';

  @override
  String get bookingTimerPenaltyPeriodActive =>
      'Período de penalización activo';

  @override
  String get bookingTimerFreeCancellationPeriod =>
      'Período de cancelación gratuita';

  @override
  String bookingTimerTimeRemaining(Object time) {
    return 'Tiempo restante: $time';
  }

  @override
  String get bookingTimerCancellingNowPenalty =>
      'Cancelar ahora incurrirá en una penalización del 10%.';

  @override
  String get bookingTimerCancelNoPenalty => 'Puedes cancelar sin penalización.';

  @override
  String get myReviewsTitle => 'Mis Reseñas';

  @override
  String get failedToLoadReviews => 'No se pudieron cargar las reseñas.';

  @override
  String get noReviewsYet => 'Aún no has dejado ninguna reseña.';

  @override
  String providerWithName(Object name) {
    return 'Proveedor: $name';
  }

  @override
  String get providerGeneric => 'Proveedor';

  @override
  String ratingWithValue(Object rating) {
    return 'Calificación: $rating';
  }

  @override
  String get nearbyOpenJobsTitle => 'Trabajos Disponibles Cercanos';

  @override
  String get failedToLoadOpenJobsHint =>
      'No se pudieron cargar los trabajos disponibles.\nAsegúrate de tener un perfil de proveedor con ubicación establecida y disponible=true.';

  @override
  String errorLoadingJobsWithValue(Object error) {
    return 'Error al cargar trabajos: $error';
  }

  @override
  String get noOpenJobsFoundNearbyTitle =>
      'No se encontraron trabajos disponibles cerca';

  @override
  String get noOpenJobsFoundNearbyBody =>
      'Asegúrate de:\n- Haber establecido tu ubicación de proveedor\n- Estar marcado como disponible\n- Los usuarios hayan creado y pagado reservas';

  @override
  String currencyLabel(Object symbol) {
    return 'Moneda: $symbol';
  }

  @override
  String pricesShownInCurrency(Object symbol, Object country) {
    return 'Precios mostrados en $symbol ($country)';
  }

  @override
  String jobTitleWithId(Object id) {
    return 'Trabajo #$id';
  }

  @override
  String serviceLine(Object service) {
    return 'Servicio: $service';
  }

  @override
  String whenLine(Object date, Object time) {
    return 'Cuándo: $date $time';
  }

  @override
  String priceLine(Object price) {
    return 'Precio: $price';
  }

  @override
  String get acceptJob => 'Aceptar Trabajo';

  @override
  String get failedToAcceptJob => 'No se pudo aceptar el trabajo.';

  @override
  String get jobAcceptedSuccessfully => 'Trabajo aceptado exitosamente.';

  @override
  String get newServiceRequestTitle => 'Nueva Solicitud de Servicio';

  @override
  String get reviewAlreadySubmitted => 'Reseña enviada ✓';

  @override
  String get offeredPriceLabel => 'Precio ofrecido';

  @override
  String get offeredPriceHint => 'ej. 25.00';

  @override
  String get enterValidPrice => 'Ingresa un precio válido';

  @override
  String get bookAndPay => 'Reservar y Pagar';

  @override
  String bookAndPayAmount(Object amount) {
    return 'Reservar y Pagar $amount';
  }

  @override
  String get haircutService => 'Corte de cabello';

  @override
  String get stylingService => 'Peinado';

  @override
  String get timeLabel => 'Hora:';

  @override
  String get notesLabel => 'Notas';

  @override
  String get requestCreatedAndPaidBroadcast =>
      '¡Solicitud creada y pagada! Transmitiendo a proveedores.';

  @override
  String locationLatLng(Object lat, Object lng) {
    return 'Ubicación: $lat, $lng';
  }

  @override
  String get paymentMethodsTitle => 'Métodos de pago';

  @override
  String get paymentPreferencesInfo =>
      'Estas preferencias se almacenan localmente en tu dispositivo. Los pagos reales se procesan de forma segura a través de Stripe/otros gateways.';

  @override
  String get preferredMethodLabel =>
      'Método preferido (gateway local seleccionado por país)';

  @override
  String get methodVisaMastercard => 'Visa/Mastercard';

  @override
  String get methodMobileMoney => 'Dinero Móvil (Momo/Paystack/Africa)';

  @override
  String get methodPaypal => 'PayPal';

  @override
  String get methodApplePayGooglePay => 'Apple Pay/Google Pay';

  @override
  String get methodWeChatPay => 'WeChat Pay (China)';

  @override
  String get methodAlipay => 'Alipay (China)';

  @override
  String get methodUnionPay => 'Tarjeta UnionPay (China)';

  @override
  String get mobileMoneyNumberLabel => 'Número de Dinero Móvil';

  @override
  String get wechatAlipayIdLabel => 'ID de WeChat/Alipay';

  @override
  String get cardLast4DigitsLabel => 'Últimos 4 dígitos de la tarjeta';

  @override
  String get paypalEmailLabel => 'Correo de PayPal';

  @override
  String get applePayEnabledOnDevice =>
      'Apple Pay habilitado en este dispositivo';

  @override
  String get savePaymentPreferences => 'Guardar Preferencias de Pago';

  @override
  String get paymentPrefsSavedInfo =>
      'Preferencias de pago guardadas localmente. El cobro real se maneja a través de Stripe/otros gateways después.';

  @override
  String get failedToLoadImage => 'No se pudo cargar la imagen';

  @override
  String get earningsTitle => 'Ganancias';

  @override
  String get couldNotLoadEarningsSummary =>
      'No se pudo cargar el resumen de ganancias.';

  @override
  String get noData => 'Sin datos.';

  @override
  String get summaryTitle => 'Resumen';

  @override
  String get totalLabel => 'Total';

  @override
  String get pendingLabel => 'Pendiente';

  @override
  String get paidLabel => 'Pagado';

  @override
  String get pdfReportTitle => 'Reporte PDF';

  @override
  String get periodLabel => 'Período';

  @override
  String get periodThisMonth => 'Este mes';

  @override
  String get periodLastMonth => 'Mes pasado';

  @override
  String get periodYtd => 'Año hasta la fecha';

  @override
  String get periodAllTime => 'Todo el tiempo';

  @override
  String get couldNotDownloadPdfReport =>
      'No se pudo descargar el reporte PDF.';

  @override
  String couldNotOpenPdfWithValue(Object error) {
    return 'No se pudo abrir el PDF: $error';
  }

  @override
  String get savingFilesNotSupportedWeb =>
      'Guardar archivos no está soportado en Web en este momento.';

  @override
  String savedToDocumentsIosWithPath(Object path) {
    return 'Guardado en Documentos (iOS):\n$path';
  }

  @override
  String savedToFilesWithPath(Object path) {
    return 'Guardado en archivos:\n$path';
  }

  @override
  String get open => 'Abrir';

  @override
  String failedToSavePdfWithValue(Object error) {
    return 'No se pudo guardar el PDF: $error';
  }

  @override
  String get openPdfReport => 'Abrir reporte PDF';

  @override
  String get savePdfToDownloads => 'Guardar PDF en Descargas';

  @override
  String get reportWatermarkNote =>
      'El reporte PDF debe incluir la marca de agua de Styloria.';

  @override
  String get referFriendsTitle => 'Invitar amigos';

  @override
  String get shareReferralCodeBody =>
      'Comparte tu código de referido con amigos. Más adelante puedes agregar recompensas cuando se registren y completen reservas.';

  @override
  String get yourReferralCodeLabel => 'Tu código de referido:';

  @override
  String get copy => 'Copiar';

  @override
  String referralCodeCopiedWithCode(Object code) {
    return 'Código de referido copiado: $code';
  }

  @override
  String get navHome => 'Inicio';

  @override
  String get navBookings => 'Reservas';

  @override
  String get navNotifications => 'Notificaciones';

  @override
  String get navAccount => 'Cuenta';

  @override
  String get welcome => 'Bienvenido';

  @override
  String welcomeName(Object name) {
    return 'Bienvenido, $name';
  }

  @override
  String get toggleThemeTooltip => 'Cambiar modo claro/oscuro';

  @override
  String loggedInAs(Object role) {
    return 'Conectado como: $role';
  }

  @override
  String locationWithValue(Object value) {
    return 'Ubicación: $value';
  }

  @override
  String get homeTagline =>
      'Transforma tu experiencia de cuidado personal con reservas en tiempo real y proveedores de confianza.';

  @override
  String get manageProviderProfile => 'Administrar Perfil de Proveedor';

  @override
  String get browseOpenJobs => 'Explorar Trabajos Disponibles';

  @override
  String get quickActions => 'Acciones rápidas';

  @override
  String get newBooking => 'Nueva Reserva';

  @override
  String notificationsWithUnread(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sin leer',
      one: '1 sin leer',
    );
    return 'Notificaciones ($_temp0)';
  }

  @override
  String get liveLocationTrackingTitle => 'Seguimiento de Ubicación en Vivo';

  @override
  String get live => 'En vivo';

  @override
  String get locationServicesDisabled =>
      'Los servicios de ubicación están deshabilitados';

  @override
  String get locationPermissionDenied => 'Permiso de ubicación denegado';

  @override
  String get locationPermissionPermanentlyDenied =>
      'Permiso de ubicación denegado permanentemente';

  @override
  String failedToGetLocationWithValue(Object error) {
    return 'No se pudo obtener la ubicación: $error';
  }

  @override
  String get youProvider => 'Tú (Proveedor)';

  @override
  String get youCustomer => 'Tú (Cliente)';

  @override
  String get customer => 'Cliente';

  @override
  String get bookingDetails => 'Detalles de la Reserva';

  @override
  String get navigate => 'Navegar';

  @override
  String get failedToLoadNotifications =>
      'No se pudieron cargar las notificaciones.';

  @override
  String get failedToMarkAsRead => 'No se pudo marcar como leído';

  @override
  String get noNotificationsYet => 'Aún no hay notificaciones.';

  @override
  String get markRead => 'Marcar como leído';

  @override
  String get customerReviewSubmitted => '¡Reseña del cliente enviada!';

  @override
  String get loadingCustomerDetails => 'Cargando detalles del cliente...';

  @override
  String get customerDetails => 'Detalles del Cliente';

  @override
  String get navigateButton => 'Navegar';

  @override
  String get callButton => 'Llamar';

  @override
  String get whatOthersSay => 'Lo que dicen otros';

  @override
  String get showLess => 'Mostrar menos';

  @override
  String showMoreCount(int count) {
    return 'Mostrar más ($count más)';
  }

  @override
  String get todayLabel => 'Hoy';

  @override
  String get yesterdayLabel => 'Ayer';

  @override
  String daysAgoShort(int days) {
    return 'hace $days días';
  }

  @override
  String weeksAgoShort(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: 's',
      one: '',
    );
    return 'hace $weeks semana$_temp0';
  }

  @override
  String providerHasArrived(String name) {
    return '¡$name ha llegado!';
  }

  @override
  String get meetProviderToBeginService =>
      'Por favor, reúnete con tu proveedor para comenzar el servicio';

  @override
  String get locationNotAvailable => 'Ubicación no disponible';

  @override
  String get couldNotOpenMaps => 'No se pudo abrir el mapa';

  @override
  String get cannotMakePhoneCalls =>
      'No se pueden realizar llamadas telefónicas en este dispositivo';

  @override
  String get confirmCompletionWarning =>
      'Solo confirma si el servicio ha sido completamente finalizado. Es posible que no puedas deshacer esto.';

  @override
  String get paymentVerificationTitle => 'Verificación de Pago';

  @override
  String get paymentVerificationMessage =>
      'Después de completar el pago en tu navegador, toca \"Verificar Pago\" para confirmar.';

  @override
  String get verifyPaymentButton => 'Verificar Pago';

  @override
  String get verifyingPayment => 'Verificando pago...';

  @override
  String get couldNotOpenPaymentPage =>
      'No se pudo abrir la página de pago. Por favor, intenta de nuevo.';

  @override
  String get paymentStillProcessing =>
      'El pago aún se está procesando. Por favor, vuelve a verificar en un momento.';

  @override
  String get statusPending => 'Pendiente';

  @override
  String get customerProfile => 'Perfil del Cliente';

  @override
  String get newCustomer => 'Cliente nuevo';

  @override
  String get newCustomerNoReviews =>
      'Este es un cliente nuevo sin reseñas aún.';

  @override
  String get whatOtherProvidersSay => 'Lo que dicen otros proveedores';

  @override
  String get justNow => 'Ahora mismo';

  @override
  String monthsAgoShort(int months) {
    return 'hace ${months}m';
  }

  @override
  String daysAgoShortCompact(int days) {
    return 'hace ${days}d';
  }

  @override
  String hoursAgoShort(int hours) {
    return 'hace ${hours}h';
  }

  @override
  String get generalArea => 'Área General';

  @override
  String get serviceCompleted => 'Servicio completado';

  @override
  String get completedServiceArea => 'Área de servicio completado';

  @override
  String get serviceArea => 'Área de servicio';

  @override
  String get locationHiddenAfterCancellation =>
      'Por tu seguridad, los detalles exactos de la ubicación están ocultos después de la cancelación. Solo se muestra el área general.';

  @override
  String get locationHiddenAfterCompletion =>
      'Por tu seguridad, los detalles exactos de la ubicación están ocultos después de completar el servicio. Solo se muestra el área general.';

  @override
  String get mapMarkerMe => 'Yo';

  @override
  String get mapMarkerOther => 'Otro';

  @override
  String get requestPlaced => 'Solicitud Realizada';

  @override
  String get whenBookingSubmitted => 'Cuándo se envió esta reserva';

  @override
  String yourLocalTimeTimezone(String timezone) {
    return 'Tu hora local ($timezone)';
  }

  @override
  String get bookingTimeline => 'Línea de Tiempo de la Reserva';

  @override
  String get timelineRequestCreated => 'Solicitud Creada';

  @override
  String get timelineAccepted => 'Aceptada';

  @override
  String get timelineInProgress => 'En Progreso';

  @override
  String get timelineCompleted => 'Completada';

  @override
  String get timelineCancelled => 'Cancelada';

  @override
  String get timelinePending => 'Pendiente...';

  @override
  String get viewLess => 'Ver Menos';

  @override
  String viewMoreCount(int count) {
    return 'Ver Más ($count más)';
  }

  @override
  String get paymentRequiredImmediately => '¡Pago Requerido Inmediatamente!';

  @override
  String get paymentReminder => 'Recordatorio de Pago';

  @override
  String hoursRemaining(String hours) {
    return '⏱ ${hours}h restantes';
  }

  @override
  String get serviceAppointment => 'Cita de Servicio';

  @override
  String get todayBadge => 'HOY';

  @override
  String get locationField => 'Ubicación';

  @override
  String get serviceAreaField => 'Área de Servicio';

  @override
  String get requestedField => 'Solicitado';

  @override
  String allTimesInLocalTimezone(String timezone) {
    return 'Todas las horas se muestran en tu zona horaria local ($timezone)';
  }

  @override
  String get completionConfirmed => 'Finalización confirmada';

  @override
  String get rateCustomer => 'Calificar Cliente';

  @override
  String get customerReviewed => 'Cliente calificado';

  @override
  String get failedToSubmitReviewTryAgain =>
      'No se pudo enviar la reseña. Por favor, intenta de nuevo.';

  @override
  String get shareYourExperience => 'Comparte tu experiencia...';

  @override
  String rateRequesterTitle(String name) {
    return 'Calificar a $name';
  }

  @override
  String get howWasExperienceWithCustomer =>
      '¿Cómo fue tu experiencia con este cliente?';

  @override
  String get commentOptional => 'Comentario (opcional)';

  @override
  String get cancelButton => 'Cancelar';

  @override
  String get submitButton => 'Enviar';

  @override
  String get ratingPoor => 'Malo';

  @override
  String get ratingFair => 'Regular';

  @override
  String get ratingGood => 'Bueno';

  @override
  String get ratingVeryGood => 'Muy Bueno';

  @override
  String get ratingExcellent => 'Excelente';

  @override
  String get profileCompletion => 'Completitud del perfil';

  @override
  String get viewProfile => 'Ver Perfil';

  @override
  String get providerKycTitle => 'Verificación de Proveedor (KYC)';

  @override
  String get logoutTooltip => 'Cerrar sesión';

  @override
  String statusLabel(Object status) {
    return 'Estado: $status';
  }

  @override
  String rejectedWithNotes(Object notes) {
    return 'Rechazado: $notes';
  }

  @override
  String get kycInstructions =>
      'Para acceder a las funciones de proveedor, sube tu identificación y una selfie para verificación.';

  @override
  String get idFrontRequired => 'ID Frontal (requerido)';

  @override
  String get selectIdFront => 'Seleccionar ID Frontal';

  @override
  String get idBackRequired => 'ID Trasero (requerido)';

  @override
  String get selectIdBackRequired => 'Seleccionar ID Trasero';

  @override
  String get selfieRequired => 'Selfie (requerido)';

  @override
  String get selectSelfie => 'Seleccionar Selfie';

  @override
  String get takeSelfie => 'Tomar Selfie';

  @override
  String get errorUploadAllRequired =>
      'Por favor sube la ID (frontal), ID (trasero), y una selfie.';

  @override
  String failedSubmitKycCode(Object code) {
    return 'No se pudo enviar KYC (código $code).';
  }

  @override
  String submittedCurrentStatus(Object status) {
    return 'Enviado. Estado actual: $status';
  }

  @override
  String get unknownStatus => 'desconocido';

  @override
  String get submitKyc => 'Enviar KYC';

  @override
  String get verificationMayTakeTimeNote =>
      'Nota: La verificación puede tomar tiempo. Podrás acceder a las funciones de proveedor una vez aprobado.';

  @override
  String get reviewsReceivedTitle => 'Reseñas Recibidas';

  @override
  String get noReviewsYetHelpText =>
      'Aún no hay reseñas. Completa servicios para recibir reseñas de clientes.';

  @override
  String failedToLoadReviewsWithError(Object error) {
    return 'No se pudieron cargar las reseñas: $error';
  }

  @override
  String providerArrivingTitle(Object name) {
    return '$name está en camino';
  }

  @override
  String get etaIsEstimate => '* Tiempo estimado (la ruta real puede variar)';

  @override
  String get enterVerificationCodeTitle => 'Ingresa el Código de Verificación';

  @override
  String otpSentToUsername(Object username) {
    return 'Enviamos un código de 6 dígitos al número de teléfono\nasociado con \"$username\".';
  }

  @override
  String get sixDigitCodeLabel => 'Código de 6 dígitos';

  @override
  String get enterSixDigitCodeValidation => 'Ingresa el código de 6 dígitos';

  @override
  String get otpInvalidOrExpired => 'Código inválido o expirado.';

  @override
  String get failedLoadUserInfoAfterVerification =>
      'No se pudo cargar la información del usuario después de la verificación.';

  @override
  String get chatWithSupportTitle => 'Chatear con Soporte';

  @override
  String get unableStartSupportChat =>
      'No se puede iniciar el chat de soporte.';

  @override
  String get invalidSupportThreadReturned =>
      'Hilo de soporte inválido devuelto del servidor.';

  @override
  String get noMessagesYet => 'Aún no hay mensajes. ¡Inicia una conversación!';

  @override
  String get supportDefaultName => 'Soporte';

  @override
  String get aboutPoliciesTitle => 'Acerca de y Políticas';

  @override
  String get newBookingTitle => 'Nueva Reserva';

  @override
  String get appointmentDetailsTitle => 'Detalles de la cita';

  @override
  String get pickDate => 'Elegir fecha';

  @override
  String get pickTime => 'Elegir hora';

  @override
  String get serviceTypeTitle => 'Tipo de servicio';

  @override
  String get serviceDropdownLabel => 'Servicio';

  @override
  String get serviceHaircutLabel => 'Corte de cabello';

  @override
  String get serviceBraidsLabel => 'Trenzas';

  @override
  String get serviceShaveLabel => 'Afeitado';

  @override
  String get serviceHairColoringLabel => 'Coloración de cabello';

  @override
  String get serviceManicureLabel => 'Manicure';

  @override
  String get servicePedicureLabel => 'Pedicure';

  @override
  String get serviceNailArtLabel => 'Arte de uñas';

  @override
  String get serviceMakeupLabel => 'Maquillaje';

  @override
  String get serviceFacialLabel => 'Tratamiento facial';

  @override
  String get serviceWaxingLabel => 'Depilación';

  @override
  String get serviceMassageLabel => 'Masaje';

  @override
  String get serviceTattooLabel => 'Tatuaje';

  @override
  String get serviceHairStylingLabel => 'Peinado';

  @override
  String get serviceHairTreatmentLabel => 'Tratamiento capilar';

  @override
  String get serviceHairExtensionsLabel => 'Extensiones de cabello';

  @override
  String get serviceOtherServicesLabel => 'Otros servicios';

  @override
  String get notesForProviderOptionalLabel =>
      'Notas para tu proveedor (opcional)';

  @override
  String get locationTitle => 'Ubicación';

  @override
  String get latitudeLabel => 'Latitud';

  @override
  String get longitudeLabel => 'Longitud';

  @override
  String get requiredField => 'Requerido';

  @override
  String get useMyCurrentLocation => 'Usar mi ubicación actual';

  @override
  String pricesShownIn(Object symbol, Object country) {
    return 'Precios mostrados en $symbol ($country)';
  }

  @override
  String get chooseTimeLaterThanCurrent =>
      'Por favor elige una hora posterior a la hora actual.';

  @override
  String get pleasePickDateAndTime => 'Por favor elige fecha y hora.';

  @override
  String get locationUpdatedFromGps => 'Ubicación actualizada desde GPS.';

  @override
  String failedToGetLocation(Object error) {
    return 'No se pudo obtener la ubicación: $error';
  }

  @override
  String bookingCreatedChoosePrice(Object id) {
    return '¡Reserva creada! ID: $id • Elige tu opción de precio.';
  }

  @override
  String get failedToCreateBooking => 'No se pudo crear la reserva.';

  @override
  String get paymentsNotSupportedLong =>
      'Los pagos no están soportados en esta plataforma. Por favor ejecuta la app en Android, iOS, macOS o Web para probar pagos reales.';

  @override
  String get noBookingToConfirm =>
      'No hay reserva para confirmar. Por favor crea una reserva primero.';

  @override
  String get pleaseChoosePriceOption => 'Por favor elige una opción de precio.';

  @override
  String get failedCreatePaymentTryAgain =>
      'No se pudo crear el pago en el servidor. Por favor intenta de nuevo.';

  @override
  String paymentSuccessfulMessage(Object bookingId, Object paid) {
    return '¡Pago exitoso!\nReserva #$bookingId • Pagado: $paid\nTu solicitud ahora es visible para proveedores cercanos.';
  }

  @override
  String get paymentSucceededButFailedUpdate =>
      'El pago fue exitoso, pero no se pudo actualizar la reserva en el servidor.';

  @override
  String paymentCancelledOrFailed(Object reason) {
    return 'Pago cancelado o fallido: $reason';
  }

  @override
  String unexpectedPaymentError(Object error) {
    return 'Error de pago inesperado: $error';
  }

  @override
  String get createBookingButton => 'Crear Reserva';

  @override
  String get chooseYourPriceOptionTitle => 'Elige Tu Opción de Precio';

  @override
  String transportationCostLabel(Object cost) {
    return 'Costo de transporte: $cost';
  }

  @override
  String get budgetTierTitle => 'ECONÓMICO';

  @override
  String get standardTierTitle => 'ESTÁNDAR';

  @override
  String get priorityTierTitle => 'PRIORITARIO';

  @override
  String get budgetTierDescription => 'Mejor valor entre proveedores cercanos';

  @override
  String get standardTierDescription =>
      'Balance recomendado de precio y disponibilidad';

  @override
  String get priorityTierDescription =>
      'Opción premium para atraer proveedores top más rápido';

  @override
  String get naShort => 'N/D';

  @override
  String get priceBreakdownTitle => 'Desglose de Precio';

  @override
  String get servicePriceLabel => 'Precio del Servicio';

  @override
  String get transportationLabel => 'Transporte';

  @override
  String serviceFeeLabel(Object percent) {
    return 'Tarifa de Servicio ($percent%)';
  }

  @override
  String allPricesIn(Object currency, Object country) {
    return 'Todos los precios en $currency ($country)';
  }

  @override
  String get userCountryPlaceholder => 'País del usuario';

  @override
  String get totalToPayTitle => 'Total a Pagar';

  @override
  String get includesServiceTransportation => 'Incluye servicio + transporte';

  @override
  String get confirmAndPay => 'Confirmar y Pagar';

  @override
  String get howPricingWorksTitle => 'Cómo Funciona el Precio';

  @override
  String get howPricingWorksBullets =>
      '• Económico: mejor valor entre proveedores cercanos\n• Estándar: predeterminado recomendado\n• Prioritario: opción premium para acelerar la aceptación\n• El transporte está incluido en el total';

  @override
  String get myBookingsTitle => 'Mis Reservas';

  @override
  String get myAssignedJobsTitle => 'Mis Trabajos Asignados';

  @override
  String get pleaseCompleteProviderProfileFirst =>
      'Por favor completa tu perfil de proveedor primero.';

  @override
  String get failedToLoadBookings => 'Failed to load bookings.';

  @override
  String get profileSetupRequiredTitle => 'Configuración de Perfil Requerida';

  @override
  String get profileSetupRequiredBody =>
      'Necesitas completar tu perfil de proveedor antes de poder ver trabajos asignados y ganancias.';

  @override
  String get later => 'Después';

  @override
  String get setupNow => 'Configurar Ahora';

  @override
  String get noBookingsFound => 'No se encontraron reservas.';

  @override
  String get findNearbyOpenJobs => 'Encontrar Trabajos Disponibles Cercanos';

  @override
  String get pay => 'Pagar';

  @override
  String get rate => 'Calificar';

  @override
  String bookingNumber(Object id) {
    return 'Reserva #$id';
  }

  @override
  String whenOn(Object date) {
    return 'Cuándo: $date';
  }

  @override
  String whenAt(Object date, Object time) {
    return 'Cuándo: $date a las $time';
  }

  @override
  String providerLine(Object name) {
    return 'Proveedor: $name';
  }

  @override
  String userLine(Object name) {
    return 'Usuario: $name';
  }

  @override
  String estimatedPriceLine(Object price) {
    return 'Precio estimado: $price';
  }

  @override
  String paymentLine(Object status) {
    return 'Pago: $status';
  }

  @override
  String get paymentUnpaid => 'no pagado';

  @override
  String get paymentUnknown => 'desconocido';

  @override
  String get confirmPaymentTitle => 'Confirmar pago';

  @override
  String confirmPaymentBody(Object amount) {
    return '¿Pagar $amount para confirmar esta reserva?';
  }

  @override
  String get yesPay => 'Sí, Pagar';

  @override
  String get failedToCreatePaymentIntent =>
      'No se pudo crear la intención de pago.';

  @override
  String get paymentSuccessfulShort => 'Pago exitoso.';

  @override
  String get paymentSucceededButFailedUpdateBooking =>
      'El pago fue exitoso, pero no se pudo actualizar la reserva en el servidor.';

  @override
  String paymentCancelledOrFailedReason(Object reason) {
    return 'Pago cancelado o fallido: $reason';
  }

  @override
  String unexpectedPaymentErrorReason(Object error) {
    return 'Error de pago inesperado: $error';
  }

  @override
  String rateProviderTitle(Object providerName) {
    return 'Calificar a $providerName';
  }

  @override
  String get selectRatingHelp =>
      'Selecciona calificación (1 = pobre, 5 = excelente):';

  @override
  String get commentsOptionalLabel => 'Comentarios (opcional)';

  @override
  String get submit => 'Enviar';

  @override
  String get reviewSubmitted => 'Reseña enviada.';

  @override
  String get failedSubmitReview => 'No se pudo enviar la reseña.';

  @override
  String failedToLoadProfile(Object error) {
    return 'No se pudo cargar el perfil: $error';
  }

  @override
  String profileSavedSuccess(Object action) {
    return '¡Perfil $action exitosamente!';
  }

  @override
  String genericError(Object error) {
    return 'Error: $error';
  }

  @override
  String get locationPermissionDeniedEnableInSettings =>
      'Permiso de ubicación denegado. Por favor habilita en configuración.';

  @override
  String get locationPermissionPermanentlyDeniedEnableInAppSettings =>
      'Permiso de ubicación denegado permanentemente. Por favor habilita en la configuración de la app.';

  @override
  String errorGettingLocation(Object error) {
    return 'Error al obtener ubicación: $error';
  }

  @override
  String get couldNotFindLocationForAddress =>
      'No se pudo encontrar la ubicación para esta dirección';

  @override
  String errorConvertingAddress(Object error) {
    return 'Error al convertir dirección: $error';
  }

  @override
  String get portfolioUnavailableCompleteKycFirst =>
      'Portafolio no disponible. Si eres proveedor, completa la verificación KYC primero.';

  @override
  String failedToLoadPortfolio(Object error) {
    return 'No se pudo cargar el portafolio: $error';
  }

  @override
  String get addPhoto => 'Agregar Foto';

  @override
  String get addVideo => 'Agregar Video';

  @override
  String get addPost => 'Agregar publicación';

  @override
  String get captionOptionalTitle => 'Descripción (opcional)';

  @override
  String get captionHintExample => 'ej., \"Trenzas sin nudos en cliente\"';

  @override
  String get skip => 'Omitir';

  @override
  String get save => 'Guardar';

  @override
  String get failedToCreatePortfolioPost =>
      'No se pudo crear la publicación del portafolio.';

  @override
  String get uploadFailedMediaUpload => 'Subida fallida (subida de medios).';

  @override
  String uploadFailed(Object error) {
    return 'Subida fallida: $error';
  }

  @override
  String get deletePostTitle => '¿Eliminar publicación?';

  @override
  String get deletePostBody =>
      'Esto eliminará la publicación de tu portafolio.';

  @override
  String get delete => 'Eliminar';

  @override
  String get deleteFailed => 'Eliminación fallida.';

  @override
  String deleteFailedWithError(Object error) {
    return 'Eliminación fallida: $error';
  }

  @override
  String get portfolioTitle => 'Portafolio';

  @override
  String get noPortfolioPostsYetHelpText =>
      'Aún no hay publicaciones de portafolio. Agrega fotos/videos de tu trabajo para ayudar a los clientes a confiar en tus habilidades.';

  @override
  String get setupProviderProfileTitle => 'Configurar Perfil de Proveedor';

  @override
  String get providerProfileTitle => 'Perfil de Proveedor';

  @override
  String get welcomeToStyloriaTitle => '¡Bienvenido a Styloria!';

  @override
  String get completeProviderProfileToStartEarning =>
      'Completa tu perfil de proveedor para comenzar a aceptar trabajos y ganar dinero.';

  @override
  String reviewCountLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'reseñas',
      one: 'reseña',
    );
    return '($count $_temp0)';
  }

  @override
  String get topRatedChip => 'Mejor Calificado';

  @override
  String get bioLabel => 'Bio / Descripción';

  @override
  String get bioHint =>
      'Cuéntales a los clientes sobre tus habilidades y experiencia...';

  @override
  String get pleaseEnterBio => 'Por favor ingresa una bio';

  @override
  String bioMinLength(int min) {
    return 'La bio debe tener al menos $min caracteres';
  }

  @override
  String get yourLocationTitle => 'Tu Ubicación';

  @override
  String get locationHelpMatchNearbyClients =>
      'Tu ubicación nos ayuda a conectarte con clientes cercanos';

  @override
  String get locationHelpUpdateToFindJobs =>
      'Actualiza tu ubicación para encontrar trabajos en diferentes áreas';

  @override
  String get useMyCurrentLocationTitle => 'Usar Mi Ubicación Actual';

  @override
  String get gpsSubtitle => 'Obtener ubicación automáticamente usando GPS';

  @override
  String get orLabel => 'O';

  @override
  String get enterYourAddressTitle => 'Ingresa Tu Dirección';

  @override
  String get fullAddressLabel => 'Dirección Completa';

  @override
  String get fullAddressHint => 'ej., Calle Principal 123, Ciudad, País';

  @override
  String get find => 'Buscar';

  @override
  String get addressHelpText => 'Ingresa tu dirección, ciudad y país';

  @override
  String get coordinatesAutoFilledTitle => 'Coordenadas (Auto-completadas)';

  @override
  String get servicePricingTitle => 'Precios de Servicios';

  @override
  String get servicePricingHelp =>
      'Establece tu precio para cada servicio. Marca \"No Ofrecido\" para servicios que no puedes proporcionar.';

  @override
  String get serviceHeader => 'Servicio';

  @override
  String get priceHeader => 'Precio';

  @override
  String get notOfferedHeader => 'No Ofrecido';

  @override
  String get priceHint => '0.00';

  @override
  String get providerHowPricingWorksTitle => 'Cómo Funciona el Precio:';

  @override
  String get providerHowPricingWorksBody =>
      '• Tu precio es lo que cobras por el servicio\n• Costo de transporte = 80% de la moneda del usuario por km\n• Los usuarios ven 3 opciones basadas en proveedores cercanos:\n  - Económico: Precio más bajo entre proveedores cercanos\n  - Estándar: Precio promedio de proveedores cercanos\n  - Prioritario: Precio más alto entre proveedores cercanos';

  @override
  String get availableForBookingsTitle => 'Disponible para Reservas';

  @override
  String get availableOnHelp =>
      '✓ Aparecerás en los resultados de búsqueda para clientes cercanos';

  @override
  String get availableOffHelp => '✗ No recibirás nuevas ofertas de trabajo';

  @override
  String get completeSetupStartEarning =>
      'Completar Configuración y Comenzar a Ganar';

  @override
  String get updateProfile => 'Actualizar Perfil';

  @override
  String get skipForNow => 'Omitir por Ahora';

  @override
  String get paymentsNotSupportedShort =>
      'Los pagos no están soportados en esta plataforma. Por favor usa Android, iOS, macOS o Web.';

  @override
  String get genericContact => 'Contacto';

  @override
  String get genericProvider => 'Proveedor';

  @override
  String get genericNotAvailable => 'N/D';

  @override
  String get showPassword => 'Mostrar contraseña';

  @override
  String get hidePassword => 'Ocultar contraseña';

  @override
  String get tapEyeToShowPassword =>
      'Toca el ícono del ojo para mostrar/ocultar contraseña';

  @override
  String get certificationRequiredTitle => 'Certificación Requerida';

  @override
  String certificationRequiredMessage(Object service) {
    return 'Este servicio requiere una certificación profesional verificada para protegerte a ti y a tus clientes.\n\nLos servicios de masaje requieren prueba de capacitación/licencia en terapia de masaje.';
  }

  @override
  String get certificationPendingTitle => 'Certificación Pendiente de Revisión';

  @override
  String get certificationPendingMessage =>
      'Tu certificación está esperando verificación del administrador. Esto generalmente toma 24-48 horas. Podrás ofrecer este servicio una vez aprobado.';

  @override
  String get certificationExpiredTitle => 'Certificación Expirada';

  @override
  String get certificationExpiredMessage =>
      'Tu certificación ha expirado. Por favor sube una certificación válida y vigente para continuar ofreciendo este servicio.';

  @override
  String get certificationStepsTitle => 'Cómo obtener la certificación:';

  @override
  String get certificationStep1 =>
      '1. Ve a la sección \'Certificaciones y Licencias\' abajo';

  @override
  String get certificationStep2 =>
      '2. Sube tu licencia/certificado de terapia de masaje';

  @override
  String get certificationStep3 =>
      '3. Espera la verificación del administrador (24-48 horas)';

  @override
  String get addCertification => 'Agregar Certificación';

  @override
  String get scrollToCertificationsHint =>
      'Desplázate hacia abajo a la sección de Certificaciones para agregar tu certificación';

  @override
  String get requiresCertificationTooltip =>
      'Este servicio requiere una certificación verificada';

  @override
  String get detectingYourLocation => 'Detectando tu ubicación...';

  @override
  String locationConfirmed(String country) {
    return '✓ Ubicación confirmada: $country';
  }

  @override
  String get refresh => 'Actualizar';

  @override
  String get countryMismatchWarningTitle => 'País diferente seleccionado';

  @override
  String countryMismatchWarningBody(Object country) {
    return 'Detectamos tu ubicación como $country. Si estás viajando o reubicándote, puedes continuar con tu selección. Tu moneda se basará en el país seleccionado.';
  }

  @override
  String get reviewSelectRatingPrompt => 'Selecciona una calificación (1 a 5).';

  @override
  String get reviewCommentOptionalLabel => 'Comentario (opcional)';

  @override
  String get genericCancel => 'Cancelar';

  @override
  String get genericSubmit => 'Enviar';

  @override
  String get reviewSubmitFailed => 'No se pudo enviar la reseña.';

  @override
  String get rateThisService => 'Califica este servicio';

  @override
  String get tipLeaveTitle => 'Dejar una propina';

  @override
  String get tipChooseAmountPrompt =>
      'Elige un monto de propina, o ingresa un monto personalizado.';

  @override
  String get tipNoTip => 'Sin propina';

  @override
  String get tipCustomAmountLabel => 'Monto de propina personalizado';

  @override
  String get genericContinue => 'Continuar';

  @override
  String get tipSkipped => 'Propina omitida.';

  @override
  String get tipFailedToSaveChoice =>
      'No se pudo guardar la elección de propina.';

  @override
  String get tipFailedToCreatePayment => 'No se pudo crear el pago de propina.';

  @override
  String get tipPaidSuccessfully => '¡Propina pagada exitosamente. Gracias!';

  @override
  String get tipPaidButUpdateFailed =>
      'El pago de la propina fue exitoso, pero la actualización de la reserva falló.';

  @override
  String tipCancelledOrFailed(Object message) {
    return 'Propina cancelada/fallida: $message';
  }

  @override
  String tipUnexpectedError(Object error) {
    return 'Error inesperado de propina: $error';
  }

  @override
  String get tipAlreadyPaidLabel => 'Propina ya pagada';

  @override
  String get tipSkippedLabel => 'Propina omitida';

  @override
  String get tipLeaveButton => 'Dejar una propina';

  @override
  String get walletTitle => 'Cartera';

  @override
  String get walletTooltip => 'Cartera';

  @override
  String get payoutSettingsTitle => 'Configuración de Pagos';

  @override
  String get payoutSettingsTooltip => 'Configuración de pagos';

  @override
  String get walletNoWalletYet =>
      'Aún no tienes cartera. Completa trabajos para ganar.';

  @override
  String get walletCurrencyFieldLabel => 'Moneda';

  @override
  String walletAvailableLine(Object amount, Object currency) {
    return 'Disponible: $amount $currency';
  }

  @override
  String walletPendingLine(Object amount, Object currency) {
    return 'Pendiente: $amount $currency';
  }

  @override
  String get walletCashOutInstant => 'Retirar (Instantáneo)';

  @override
  String get walletCashOutFailed => 'Retiro fallido.';

  @override
  String walletCashOutSentTransfer(Object transferId) {
    return 'Retiro enviado. Transferencia: $transferId';
  }

  @override
  String get walletTransactionsTitle => 'Transacciones';

  @override
  String get walletNoTransactionsYet => 'Aún no hay transacciones.';

  @override
  String get payoutAutoPayoutsTitle => 'Pagos automáticos';

  @override
  String get payoutAutoPayoutsSubtitle =>
      'Envía pagos automáticamente en tu horario elegido.';

  @override
  String get payoutDayUtcLabel => 'Día de pago (UTC)';

  @override
  String get payoutHourUtcLabel => 'Hora de pago (UTC)';

  @override
  String get payoutMinimumAmountLabel => 'Monto mínimo de pago automático';

  @override
  String get payoutMinimumAmountHelper =>
      'El pago automático se ejecuta solo si el saldo disponible ≥ este monto.';

  @override
  String get payoutInstantCashOutEnabledTitle =>
      'Retiro instantáneo habilitado';

  @override
  String get payoutInstantCashOutEnabledSubtitle =>
      'Permitir el botón \"Retirar\" (se aplica comisión).';

  @override
  String get payoutSettingsSaved => 'Configuración de pagos guardada.';

  @override
  String get payoutSettingsSaveFailed =>
      'No se pudo guardar la configuración de pagos.';

  @override
  String servicePricingStepIndicator(Object current, Object total) {
    return 'Paso $current de $total';
  }

  @override
  String get serviceSelectionTitle => '¿Qué servicios ofreces?';

  @override
  String get serviceSelectionSubtitle =>
      'Toca para seleccionar los servicios que proporcionas. Puedes cambiar esto en cualquier momento.';

  @override
  String get priceSettingTitle => 'Establece tus precios';

  @override
  String get priceSettingSubtitle =>
      'Ingresa tu precio para cada servicio que seleccionaste.';

  @override
  String get nextButton => 'Siguiente';

  @override
  String get backButton => 'Atrás';

  @override
  String get editServicesLink => 'Editar servicios';

  @override
  String get selectAtLeastOneService =>
      'Por favor selecciona al menos un servicio para continuar.';

  @override
  String get noServicesSelectedYet =>
      'Aún no has seleccionado servicios. Vuelve atrás para seleccionar servicios.';

  @override
  String servicesSelectedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'servicios',
      one: 'servicio',
    );
    return '$count $_temp0 seleccionados';
  }

  @override
  String get certificationRequiredChip => 'Requiere certificación';

  @override
  String get savePrices => 'Guardar Precios';

  @override
  String get onboardingSkip => 'Omitir';

  @override
  String get onboardingGetStarted => 'Comenzar';

  @override
  String get onboardingMaybeLater => 'Quizás Después';

  @override
  String get onboardingEnableLocation => 'Habilitar Ubicación';

  @override
  String get onboardingWelcomeTitle => 'Bienvenido a Styloria';

  @override
  String get onboardingWelcomeSubtitle =>
      'Tu mercado personal de belleza y cuidado personal';

  @override
  String get onboardingWelcomeDescription =>
      'Reserva estilistas profesionales, barberos y expertos en belleza — en cualquier momento, en cualquier lugar.';

  @override
  String get onboardingCustomerTitle => 'Reserva Servicios al Instante';

  @override
  String get onboardingCustomerSubtitle =>
      'Encuentra y reserva servicios de belleza con facilidad';

  @override
  String get onboardingCustomerBullet1 =>
      'Encuentra proveedores verificados cerca de ti';

  @override
  String get onboardingCustomerBullet2 =>
      'Compara precios de forma transparente';

  @override
  String get onboardingCustomerBullet3 => 'Paga de forma segura en la app';

  @override
  String get onboardingCustomerBullet4 =>
      'Rastrea a tu proveedor en tiempo real';

  @override
  String get onboardingProviderTitle => 'Haz Crecer Tu Negocio';

  @override
  String get onboardingProviderSubtitle =>
      'Convierte tus habilidades en ingresos';

  @override
  String get onboardingProviderBullet1 =>
      'Establece tus propios precios y horarios';

  @override
  String get onboardingProviderBullet2 => 'Conéctate con clientes cercanos';

  @override
  String get onboardingProviderBullet3 => 'Construye tu reputación con reseñas';

  @override
  String get onboardingProviderBullet4 => 'Pagos instantáneos a tu cuenta';

  @override
  String get onboardingLocationTitle => 'Habilitar Servicios de Ubicación';

  @override
  String get onboardingLocationSubtitle =>
      'Styloria usa tu ubicación para conectarte con servicios cercanos';

  @override
  String get onboardingLocationBenefit1 =>
      'Encuentra proveedores de servicios cerca de ti';

  @override
  String get onboardingLocationBenefit2 =>
      'Calcula costos de transporte precisos';

  @override
  String get onboardingLocationBenefit3 =>
      'Te conecta con profesionales disponibles';

  @override
  String get onboardingLocationBenefit4 =>
      'Habilita seguimiento en tiempo real durante citas';

  @override
  String get onboardingLocationPrivacyNote =>
      'Tu ubicación solo se usa mientras la app está abierta. Nunca te rastreamos en segundo plano.';

  @override
  String get onboardingLocationEnabled => '¡Ubicación habilitada exitosamente!';

  @override
  String get onboardingLocationDeniedTitle => 'Permiso de Ubicación Denegado';

  @override
  String get onboardingLocationDeniedMessage =>
      'Sin acceso a la ubicación, necesitarás ingresar tu dirección manualmente al reservar servicios. Puedes habilitar la ubicación después en la configuración de tu dispositivo.';

  @override
  String get onboardingContinueWithoutLocation => 'Continuar Sin Ubicación';

  @override
  String get onboardingOpenSettings => 'Abrir Configuración';

  @override
  String get onboardingLocationServicesOffTitle =>
      'Servicios de Ubicación Deshabilitados';

  @override
  String get onboardingLocationServicesOffMessage =>
      'Los servicios de ubicación de tu dispositivo están desactivados. Habilítalos para obtener la experiencia completa de Styloria.';

  @override
  String get onboardingEnableLocationServices =>
      'Habilitar Servicios de Ubicación';

  @override
  String get providerLocationRequiredTitle => 'Ubicación Requerida';

  @override
  String get providerLocationRequiredMessage =>
      'Para aparecer en los resultados de búsqueda y recibir solicitudes de trabajo de clientes cercanos, necesitas habilitar el acceso a la ubicación.';

  @override
  String get providerLocationRequiredBenefitsTitle =>
      'Por qué necesitamos tu ubicación:';

  @override
  String get providerLocationRequiredBenefit1 =>
      '• Aparecer en búsquedas de clientes cercanos';

  @override
  String get providerLocationRequiredBenefit2 =>
      '• Recibir solicitudes de trabajo en tu área';

  @override
  String get providerLocationRequiredBenefit3 =>
      '• Calcular distancias precisas para clientes';

  @override
  String get providerStayUnavailable => 'Permanecer No Disponible';

  @override
  String get providerEnableLocation => 'Habilitar Ubicación';

  @override
  String get providerLocationEnabledNowAvailable =>
      '¡Ubicación habilitada! Ahora estás disponible para reservas.';

  @override
  String get providerLocationPermanentlyDeniedTitle =>
      'Permiso de Ubicación Requerido';

  @override
  String get providerLocationPermanentlyDeniedMessage =>
      'El permiso de ubicación fue denegado permanentemente. Para habilitar la disponibilidad, abre la configuración de tu dispositivo y otorga acceso de ubicación a Styloria.';

  @override
  String get providerOpenSettings => 'Abrir Configuración';

  @override
  String get providerLocationServicesDisabled =>
      'Los servicios de ubicación están deshabilitados en tu dispositivo.';

  @override
  String get providerEnableLocationServices => 'Habilitar';

  @override
  String get providerLocationDeniedCannotBeAvailable =>
      'Acceso a ubicación denegado. No puedes estar disponible para reservas sin habilitar la ubicación.';

  @override
  String get signOut => 'Cerrar sesión';

  @override
  String get kycIdFrontPhoto => 'Foto Frontal del ID';

  @override
  String get kycIdFrontMessage =>
      'Toma una foto del frente de tu tarjeta de identificación';

  @override
  String get kycIdBackPhoto => 'Foto Trasera del ID';

  @override
  String get kycIdBackMessage =>
      'Toma una foto del reverso de tu tarjeta de identificación';

  @override
  String get kycCamera => 'Cámara';

  @override
  String get kycGallery => 'Galería';

  @override
  String get kycChooseSource => 'Elige fuente:';

  @override
  String get kycFailedCaptureImage => 'No se pudo capturar la imagen';

  @override
  String get kycFailedCaptureSelfie => 'No se pudo capturar la selfie';

  @override
  String get kycCameraNotAvailable => 'Cámara no disponible';

  @override
  String get kycCameraNotAvailableMessage =>
      'La cámara no está disponible. ¿Te gustaría seleccionar una imagen de tu galería en su lugar?';

  @override
  String get kycUseGallery => 'Usar Galería';

  @override
  String get kycDocumentsLocked =>
      'Los documentos están bloqueados mientras están pendientes de revisión. No puedes hacer cambios hasta que se complete la verificación.';

  @override
  String get kycVerificationSubmittedSuccessfully =>
      'Verificación enviada exitosamente';

  @override
  String get kycVerificationSubmitted => 'Verificación Enviada';

  @override
  String get kycThankYouSubmitting =>
      '¡Gracias por enviar tus documentos de verificación!';

  @override
  String get kycWhatHappensNext => '¿Qué sucede después:';

  @override
  String get kycReviewTime =>
      'Nuestro equipo revisará tus documentos en 24-48 horas';

  @override
  String get kycEmailNotification =>
      'Recibirás un correo electrónico cuando tu verificación esté completa';

  @override
  String get kycCheckEmail =>
      'Revisa tu correo para actualizaciones sobre el estado de tu verificación';

  @override
  String get kycLocked =>
      'Tus documentos ahora están bloqueados y no pueden cambiarse durante la revisión';

  @override
  String get kycRecommendSignOut =>
      'Te recomendamos cerrar sesión y volver más tarde para ver el resultado de tu verificación.';

  @override
  String get kycStaySignedIn => 'Permanecer Conectado';

  @override
  String get kycVerificationPending => 'Verificación Pendiente';

  @override
  String get kycVerificationPendingSubtitle =>
      'Tus documentos están siendo revisados';

  @override
  String get kycVerificationApproved => 'Verificación Aprobada';

  @override
  String get kycVerificationApprovedSubtitle =>
      'Ahora puedes acceder a todas las funciones de proveedor';

  @override
  String get kycVerificationRejected => 'Verificación Rechazada';

  @override
  String get kycVerificationRejectedSubtitle =>
      'Por favor revisa las notas a continuación y vuelve a enviar';

  @override
  String get kycVerificationRequired => 'Verificación Requerida';

  @override
  String get kycVerificationRequiredSubtitle =>
      'Completa la verificación para acceder a las funciones de proveedor';

  @override
  String get kycReviewNotes => 'Notas de Revisión';

  @override
  String get kycIdCardFront => 'Tarjeta de ID (Frente)';

  @override
  String get kycIdCardBack => 'Tarjeta de ID (Reverso)';

  @override
  String get kycVerificationSelfie => 'Selfie de Verificación';

  @override
  String get kycButtonLocked => 'Bloqueado';

  @override
  String get kycCaptureIdFront => 'Capturar ID Frontal';

  @override
  String get kycCaptureIdBack => 'Capturar ID Trasero';

  @override
  String get kycDocumentsLockedButton => 'Documentos Bloqueados';

  @override
  String get kycTipsTitle => '📸 Consejos para buenas fotos:';

  @override
  String get kycTipGoodLighting => '• Usa buena iluminación';

  @override
  String get kycTipFlatCard =>
      '• Coloca la tarjeta de ID en una superficie plana';

  @override
  String get kycTipReadableText =>
      '• Asegúrate de que todo el texto sea legible';

  @override
  String get kycTipFaceCamera =>
      '• Mira directamente a la cámara para la selfie';

  @override
  String get kycTipAvoidGlare => '• Evita reflejos o sombras';

  @override
  String get kycFailedSubmitVerification => 'No se pudo enviar la verificación';

  @override
  String get paystackSetupTitle => 'Configurar Cuenta de Pago';

  @override
  String get paystackVerifying => 'Verificando...';

  @override
  String get paystackVerificationSuccess =>
      '¡Configuración de pago guardada exitosamente!';

  @override
  String get paystackVerificationFailed =>
      'No se pudo guardar la configuración de pago';

  @override
  String get paystackSelectBank => 'Selecciona Tu Banco';

  @override
  String get paystackAccountNumber => 'Número de Cuenta';

  @override
  String get paystackVerifyAccount => 'Verificar Cuenta';

  @override
  String get paystackAccountVerified => 'Cuenta Verificada';

  @override
  String get paystackSavePayoutAccount => 'Guardar Cuenta de Pago';

  @override
  String paystackNoBanksAvailable(Object country) {
    return 'No hay bancos disponibles para $country';
  }

  @override
  String get paystackRetry => 'Reintentar';

  @override
  String get paystackPayoutsInfo =>
      'Tus ganancias se enviarán a esta cuenta. Los pagos se procesan en 24 horas.';

  @override
  String get paystackConnected => 'Cuenta: conectada';

  @override
  String get paystackNotConnected => 'Cuenta: no conectada';

  @override
  String get paystackDetailsSubmitted => 'Detalles enviados:';

  @override
  String get paystackPayoutsEnabled => 'Pagos habilitados:';

  @override
  String get paystackYes => 'sí';

  @override
  String get paystackNo => 'no';

  @override
  String get paystackFinishSetup => 'Finalizar Configuración de Stripe';

  @override
  String get paystackConnectStripe => 'Conectar Stripe';

  @override
  String get paystackOpenDashboard => 'Abrir Panel de Stripe';

  @override
  String get paystackMustFinishSetup =>
      'Debes finalizar la configuración de Stripe antes de poder retirar.';

  @override
  String get paystackPayouts => 'Pagos de Paystack';

  @override
  String get paystackAddBankDetails =>
      'Agrega los detalles de tu cuenta bancaria en Configuración de Pagos para recibir pagos a través de Paystack.';

  @override
  String get paystackOpenSettings => 'Abrir Configuración de Pagos';

  @override
  String payoutPaystackForCountry(Object country) {
    return 'Pagos a través de Paystack para $country';
  }

  @override
  String payoutFlutterwaveForCountry(Object country) {
    return 'Los pagos se procesan a través de Flutterwave para $country';
  }

  @override
  String get payoutStripeConnect => 'Stripe Connect';

  @override
  String get payoutBankAccountDetails => 'Detalles de Cuenta Bancaria';

  @override
  String get payoutAccountHolderName => 'Nombre del Titular de la Cuenta';

  @override
  String get payoutAccountHolderNameHint =>
      'Ingresa el nombre como aparece en tu cuenta bancaria';

  @override
  String get payoutSelectBank => 'Seleccionar Banco *';

  @override
  String get payoutBankName => 'Nombre del Banco *';

  @override
  String get payoutBankNameManual => 'Nombre del Banco (manual)';

  @override
  String get payoutBankNameHint => 'ej., Banco Santander, BBVA';

  @override
  String get payoutBankCode => 'Código del Banco *';

  @override
  String get payoutBankCodeManual => 'Código del Banco (manual)';

  @override
  String get payoutBankCodeHint => 'Código de banco de Flutterwave';

  @override
  String get payoutBankCodeHelper =>
      'Contacta a soporte si no conoces el código del banco';

  @override
  String get payoutAccountNumber => 'Número de Cuenta *';

  @override
  String get payoutAccountNumberHint => 'Ingresa tu número de cuenta bancaria';

  @override
  String get payoutMobileMoney => 'Dinero Móvil';

  @override
  String get payoutFullName => 'Nombre Completo (como está registrado) *';

  @override
  String get payoutFullNameHint =>
      'Nombre registrado en tu cuenta de dinero móvil';

  @override
  String get payoutMobileNetwork => 'Red Móvil *';

  @override
  String get payoutSelectNetwork => 'Selecciona tu red móvil';

  @override
  String get payoutMobileNetworkHint => 'ej., MTN, Vodafone, Airtel';

  @override
  String get payoutCountryCode => 'Código de País';

  @override
  String get payoutMobileMoneyNumber => 'Número de Dinero Móvil *';

  @override
  String get payoutMobileMoneyNumberHint => 'ej., 0541234567';

  @override
  String get payoutZipCode => 'Código Postal';

  @override
  String get payoutZipCodeHint => 'Si lo requiere tu red';

  @override
  String get payoutMethod => 'Método de Pago';

  @override
  String get payoutBankTransfer => 'Transferencia Bancaria';

  @override
  String get payoutCurrency => 'Moneda';

  @override
  String payoutCurrencyLocked(Object country) {
    return 'Bloqueado a la moneda de $country';
  }

  @override
  String get payoutBeneficiaryId => 'ID de Beneficiario';

  @override
  String get payoutBeneficiaryIdHint =>
      'Opcional - para transferencias recurrentes';

  @override
  String get payoutSchedule => 'Programación de Pagos';

  @override
  String get payoutFrequency => 'Frecuencia de Pago';

  @override
  String get payoutFrequencyWeekly => 'Semanal';

  @override
  String get payoutFrequencyMonthly => 'Mensual (1ro de cada mes)';

  @override
  String get payoutDayHelper => 'Disponible: Martes, Jueves, Viernes';

  @override
  String get payoutMonthlyInfo =>
      'Los pagos mensuales se procesan el 1ro de cada mes.';

  @override
  String get payoutInstantCashout => 'Retiro Instantáneo';

  @override
  String get payoutInstantCashoutInfo =>
      '• Retiros instantáneos ilimitados disponibles\n• Se aplica comisión del 5% a retiros instantáneos\n• Los pagos programados no tienen comisión';

  @override
  String get payoutNextScheduled => 'Próximo Pago Programado';

  @override
  String payoutYourLocalTime(Object timezone) {
    return 'Tu hora local ($timezone)';
  }

  @override
  String get payoutAmountToCashOut => 'Monto a retirar';

  @override
  String payoutMinMaxRange(Object min, Object max) {
    return 'Mín: $min - Máx: $max';
  }

  @override
  String get payoutMaxButton => 'MÁX';

  @override
  String get payoutCashOutNow => 'Retirar (Instantáneo)';

  @override
  String get payoutAvailableBalance => 'Saldo Disponible';

  @override
  String get payoutPendingFunds => 'Pendiente';

  @override
  String get payoutPendingInfo =>
      'Los fondos pendientes estarán disponibles después del período de retención';

  @override
  String get payoutLifetimeEarnings => 'Ganancias Totales';

  @override
  String get payoutTotalCashedOut => 'Total Retirado';

  @override
  String get payoutUnlimitedCashouts => 'Ilimitado';

  @override
  String get mainHello => 'Hola';

  @override
  String get mainViewProfile => 'Ver Perfil';

  @override
  String get mainBookings => 'Reservas';

  @override
  String get mainNotifications => 'Notificaciones';

  @override
  String get mainReferral => 'Referidos';

  @override
  String get mainSettings => 'Configuración';

  @override
  String get mainHelp => 'Ayuda';

  @override
  String get mainWallet => 'Cartera';

  @override
  String get mainEarnings => 'Ganancias';

  @override
  String get mainOpenJobs => 'Trabajos Disponibles';

  @override
  String get mainAssignedJobs => 'Trabajos Asignados';

  @override
  String get mainMyReputation => 'Mi Reputación';

  @override
  String get reputationTitle => 'Mi Reputación';

  @override
  String get reputationYourCustomerRating => 'Tu Calificación como Cliente';

  @override
  String reputationBasedOnReviews(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'reseñas',
      one: 'reseña',
    );
    return 'Basado en $count $_temp0';
  }

  @override
  String get reputationExcellentCustomer => '⭐ Cliente Excelente';

  @override
  String get reputationGreatCustomer => '👍 Gran Cliente';

  @override
  String get reputationGoodCustomer => '✓ Buen Cliente';

  @override
  String get reputationAverage => 'Promedio';

  @override
  String get reputationNeedsImprovement => 'Necesita Mejorar';

  @override
  String get reputationNoRatingYet => 'Sin Calificación Aún';

  @override
  String get reputationWhatProvidersSay =>
      'Lo Que Dicen los Proveedores Sobre Ti';

  @override
  String get reputationNoReviews => 'Sin Reseñas Aún';

  @override
  String get reputationNoReviewsHelp =>
      '¡Completa reservas para construir tu reputación!\nLos proveedores te calificarán después de completar servicios.';

  @override
  String reputationShowMore(int count) {
    return 'Mostrar Más ($count más)';
  }

  @override
  String get reputationShowLess => 'Mostrar Menos';

  @override
  String get reputationJustNow => 'Ahora mismo';

  @override
  String reputationMinutesAgo(int minutes) {
    return 'hace $minutes min';
  }

  @override
  String reputationHoursAgo(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'horas',
      one: 'hora',
    );
    return 'hace $hours $_temp0';
  }

  @override
  String reputationDaysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'días',
      one: 'día',
    );
    return 'hace $days $_temp0';
  }

  @override
  String reputationWeeksAgo(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: 'semanas',
      one: 'semana',
    );
    return 'hace $weeks $_temp0';
  }

  @override
  String reputationMonthsAgo(int months) {
    String _temp0 = intl.Intl.pluralLogic(
      months,
      locale: localeName,
      other: 'meses',
      one: 'mes',
    );
    return 'hace $months $_temp0';
  }

  @override
  String reputationYearsAgo(int years) {
    String _temp0 = intl.Intl.pluralLogic(
      years,
      locale: localeName,
      other: 'años',
      one: 'año',
    );
    return 'hace $years $_temp0';
  }

  @override
  String get notificationsTitle => 'Notificaciones';

  @override
  String get notificationsNoNotifications => 'Aún no hay notificaciones.';
}
