// lib/mobile_networks.dart

/// Mobile money network options per country
/// Each network has: code (for API), name (display), and country

class MobileNetwork {
  final String code;
  final String name;
  final String countryCode; // ISO 2-letter code

  const MobileNetwork({
    required this.code,
    required this.name,
    required this.countryCode,
  });
}

/// Get mobile networks for a specific country
List<MobileNetwork> getMobileNetworksForCountry(String countryName) {
  final normalized = countryName.toLowerCase().trim();
  
  // Map country names to their networks
  if (normalized.contains('ghana')) {
    return ghanaNetworks;
  } else if (normalized.contains('nigeria')) {
    return nigeriaNetworks;
  } else if (normalized.contains('kenya')) {
    return kenyaNetworks;
  } else if (normalized.contains('uganda')) {
    return ugandaNetworks;
  } else if (normalized.contains('tanzania')) {
    return tanzaniaNetworks;
  } else if (normalized.contains('rwanda')) {
    return rwandaNetworks;
  } else if (normalized.contains('zambia')) {
    return zambiaNetworks;
  } else if (normalized.contains('south africa')) {
    return southAfricaNetworks;
  } else if (normalized.contains('cameroon')) {
    return cameroonNetworks;
  } else if (normalized.contains('ivory coast') || normalized.contains('côte d\'ivoire')) {
    return ivoryCoastNetworks;
  } else if (normalized.contains('senegal')) {
    return senegalNetworks;
  } else if (normalized.contains('mali')) {
    return maliNetworks;
  } else if (normalized.contains('benin')) {
    return beninNetworks;
  } else if (normalized.contains('togo')) {
    return togoNetworks;
  } else if (normalized.contains('burkina faso')) {
    return burkinaFasoNetworks;
  }
  
  // Default: return generic options
  return defaultNetworks;
}

// Ghana Networks
const ghanaNetworks = [
  MobileNetwork(code: 'mtn', name: 'MTN Mobile Money', countryCode: 'GH'),
  MobileNetwork(code: 'vodafone', name: 'Vodafone Cash', countryCode: 'GH'),
  MobileNetwork(code: 'airteltigo', name: 'AirtelTigo Money', countryCode: 'GH'),
];

// Nigeria Networks
const nigeriaNetworks = [
  MobileNetwork(code: 'mtn', name: 'MTN MoMo', countryCode: 'NG'),
  MobileNetwork(code: 'airtel', name: 'Airtel Money', countryCode: 'NG'),
  MobileNetwork(code: 'glo', name: 'Glo Mobile Money', countryCode: 'NG'),
  MobileNetwork(code: '9mobile', name: '9mobile Money', countryCode: 'NG'),
];

// Kenya Networks
const kenyaNetworks = [
  MobileNetwork(code: 'mpesa', name: 'M-Pesa (Safaricom)', countryCode: 'KE'),
  MobileNetwork(code: 'airtel', name: 'Airtel Money', countryCode: 'KE'),
  MobileNetwork(code: 'tkash', name: 'T-Kash (Telkom)', countryCode: 'KE'),
];

// Uganda Networks
const ugandaNetworks = [
  MobileNetwork(code: 'mtn', name: 'MTN Mobile Money', countryCode: 'UG'),
  MobileNetwork(code: 'airtel', name: 'Airtel Money', countryCode: 'UG'),
];

// Tanzania Networks
const tanzaniaNetworks = [
  MobileNetwork(code: 'mpesa', name: 'M-Pesa (Vodacom)', countryCode: 'TZ'),
  MobileNetwork(code: 'tigopesa', name: 'Tigo Pesa', countryCode: 'TZ'),
  MobileNetwork(code: 'airtel', name: 'Airtel Money', countryCode: 'TZ'),
  MobileNetwork(code: 'halopesa', name: 'Halo Pesa', countryCode: 'TZ'),
];

// Rwanda Networks
const rwandaNetworks = [
  MobileNetwork(code: 'mtn', name: 'MTN Mobile Money', countryCode: 'RW'),
  MobileNetwork(code: 'airtel', name: 'Airtel Money', countryCode: 'RW'),
];

// Zambia Networks
const zambiaNetworks = [
  MobileNetwork(code: 'mtn', name: 'MTN Mobile Money', countryCode: 'ZM'),
  MobileNetwork(code: 'airtel', name: 'Airtel Money', countryCode: 'ZM'),
  MobileNetwork(code: 'zamtel', name: 'Zamtel Kwacha', countryCode: 'ZM'),
];

// South Africa Networks
const southAfricaNetworks = [
  MobileNetwork(code: 'vodacom', name: 'Vodacom', countryCode: 'ZA'),
  MobileNetwork(code: 'mtn', name: 'MTN', countryCode: 'ZA'),
  MobileNetwork(code: 'cellc', name: 'Cell C', countryCode: 'ZA'),
];

// Cameroon Networks
const cameroonNetworks = [
  MobileNetwork(code: 'mtn', name: 'MTN Mobile Money', countryCode: 'CM'),
  MobileNetwork(code: 'orange', name: 'Orange Money', countryCode: 'CM'),
];

// Ivory Coast Networks
const ivoryCoastNetworks = [
  MobileNetwork(code: 'mtn', name: 'MTN Mobile Money', countryCode: 'CI'),
  MobileNetwork(code: 'orange', name: 'Orange Money', countryCode: 'CI'),
  MobileNetwork(code: 'moov', name: 'Moov Money', countryCode: 'CI'),
];

// Senegal Networks
const senegalNetworks = [
  MobileNetwork(code: 'orange', name: 'Orange Money', countryCode: 'SN'),
  MobileNetwork(code: 'free', name: 'Free Money', countryCode: 'SN'),
  MobileNetwork(code: 'expresso', name: 'E-Money (Expresso)', countryCode: 'SN'),
];

// Mali Networks
const maliNetworks = [
  MobileNetwork(code: 'orange', name: 'Orange Money', countryCode: 'ML'),
  MobileNetwork(code: 'moov', name: 'Moov Money', countryCode: 'ML'),
];

// Benin Networks
const beninNetworks = [
  MobileNetwork(code: 'mtn', name: 'MTN Mobile Money', countryCode: 'BJ'),
  MobileNetwork(code: 'moov', name: 'Moov Money', countryCode: 'BJ'),
];

// Togo Networks
const togoNetworks = [
  MobileNetwork(code: 'moov', name: 'Moov Money (Flooz)', countryCode: 'TG'),
  MobileNetwork(code: 'tmoney', name: 'T-Money (Togocel)', countryCode: 'TG'),
];

// Burkina Faso Networks
const burkinaFasoNetworks = [
  MobileNetwork(code: 'orange', name: 'Orange Money', countryCode: 'BF'),
  MobileNetwork(code: 'moov', name: 'Moov Money', countryCode: 'BF'),
];

// Default/Generic Networks
const defaultNetworks = [
  MobileNetwork(code: 'mtn', name: 'MTN Mobile Money', countryCode: ''),
  MobileNetwork(code: 'orange', name: 'Orange Money', countryCode: ''),
  MobileNetwork(code: 'airtel', name: 'Airtel Money', countryCode: ''),
  MobileNetwork(code: 'vodafone', name: 'Vodafone Cash', countryCode: ''),
  MobileNetwork(code: 'mpesa', name: 'M-Pesa', countryCode: ''),
];