// lib/african_banks.dart

/// Bank options per country for Flutterwave payouts
/// Each bank has: code (Flutterwave bank code), name (display name)

class AfricanBank {
  final String code;
  final String name;

  const AfricanBank({
    required this.code,
    required this.name,
  });
}

/// Get banks for a specific country
List<AfricanBank> getBanksForCountry(String countryName) {
  final normalized = countryName.toLowerCase().trim();
  
  if (normalized.contains('ghana')) {
    return ghanaBanks;
  } else if (normalized.contains('nigeria')) {
    return nigeriaBanks;
  } else if (normalized.contains('kenya')) {
    return kenyaBanks;
  } else if (normalized.contains('south africa')) {
    return southAfricaBanks;
  } else if (normalized.contains('uganda')) {
    return ugandaBanks;
  } else if (normalized.contains('tanzania')) {
    return tanzaniaBanks;
  }
  
  // Return empty - user will need to enter manually
  return [];
}

// Ghana Banks (Flutterwave codes)
const ghanaBanks = [
  AfricanBank(code: 'GH010100', name: 'Access Bank Ghana'),
  AfricanBank(code: 'GH010200', name: 'Barclays Bank Ghana (ABSA)'),
  AfricanBank(code: 'GH010300', name: 'GCB Bank'),
  AfricanBank(code: 'GH010400', name: 'National Investment Bank'),
  AfricanBank(code: 'GH010500', name: 'Agricultural Development Bank'),
  AfricanBank(code: 'GH010600', name: 'CalBank'),
  AfricanBank(code: 'GH010700', name: 'Ecobank Ghana'),
  AfricanBank(code: 'GH010800', name: 'First Atlantic Bank'),
  AfricanBank(code: 'GH010900', name: 'Fidelity Bank Ghana'),
  AfricanBank(code: 'GH011000', name: 'First National Bank Ghana'),
  AfricanBank(code: 'GH011100', name: 'Guaranty Trust Bank Ghana'),
  AfricanBank(code: 'GH011200', name: 'Prudential Bank'),
  AfricanBank(code: 'GH011300', name: 'Republic Bank Ghana'),
  AfricanBank(code: 'GH011400', name: 'Société Générale Ghana'),
  AfricanBank(code: 'GH011500', name: 'Stanbic Bank Ghana'),
  AfricanBank(code: 'GH011600', name: 'Standard Chartered Bank Ghana'),
  AfricanBank(code: 'GH011700', name: 'United Bank for Africa Ghana'),
  AfricanBank(code: 'GH011800', name: 'Zenith Bank Ghana'),
  AfricanBank(code: 'GH011900', name: 'Bank of Africa Ghana'),
  AfricanBank(code: 'GH012000', name: 'Consolidated Bank Ghana'),
];

// Nigeria Banks (Flutterwave codes)
const nigeriaBanks = [
  AfricanBank(code: '044', name: 'Access Bank'),
  AfricanBank(code: '023', name: 'Citibank Nigeria'),
  AfricanBank(code: '050', name: 'Ecobank Nigeria'),
  AfricanBank(code: '070', name: 'Fidelity Bank'),
  AfricanBank(code: '011', name: 'First Bank of Nigeria'),
  AfricanBank(code: '214', name: 'First City Monument Bank'),
  AfricanBank(code: '058', name: 'Guaranty Trust Bank'),
  AfricanBank(code: '030', name: 'Heritage Bank'),
  AfricanBank(code: '082', name: 'Keystone Bank'),
  AfricanBank(code: '076', name: 'Polaris Bank'),
  AfricanBank(code: '221', name: 'Stanbic IBTC Bank'),
  AfricanBank(code: '068', name: 'Standard Chartered Bank'),
  AfricanBank(code: '232', name: 'Sterling Bank'),
  AfricanBank(code: '033', name: 'United Bank for Africa'),
  AfricanBank(code: '215', name: 'Unity Bank'),
  AfricanBank(code: '035', name: 'Wema Bank'),
  AfricanBank(code: '057', name: 'Zenith Bank'),
];

// Kenya Banks
const kenyaBanks = [
  AfricanBank(code: 'KE001', name: 'Kenya Commercial Bank'),
  AfricanBank(code: 'KE002', name: 'Equity Bank'),
  AfricanBank(code: 'KE003', name: 'Co-operative Bank'),
  AfricanBank(code: 'KE004', name: 'Barclays Bank Kenya (ABSA)'),
  AfricanBank(code: 'KE005', name: 'Standard Chartered Kenya'),
  AfricanBank(code: 'KE006', name: 'Diamond Trust Bank'),
  AfricanBank(code: 'KE007', name: 'I&M Bank'),
  AfricanBank(code: 'KE008', name: 'Stanbic Bank Kenya'),
  AfricanBank(code: 'KE009', name: 'NIC Bank'),
  AfricanBank(code: 'KE010', name: 'Family Bank'),
];

// South Africa Banks
const southAfricaBanks = [
  AfricanBank(code: 'ZA001', name: 'ABSA Bank'),
  AfricanBank(code: 'ZA002', name: 'Capitec Bank'),
  AfricanBank(code: 'ZA003', name: 'First National Bank (FNB)'),
  AfricanBank(code: 'ZA004', name: 'Nedbank'),
  AfricanBank(code: 'ZA005', name: 'Standard Bank'),
  AfricanBank(code: 'ZA006', name: 'African Bank'),
  AfricanBank(code: 'ZA007', name: 'Investec Bank'),
  AfricanBank(code: 'ZA008', name: 'TymeBank'),
  AfricanBank(code: 'ZA009', name: 'Discovery Bank'),
];

// Uganda Banks
const ugandaBanks = [
  AfricanBank(code: 'UG001', name: 'Stanbic Bank Uganda'),
  AfricanBank(code: 'UG002', name: 'Standard Chartered Uganda'),
  AfricanBank(code: 'UG003', name: 'Barclays Bank Uganda (ABSA)'),
  AfricanBank(code: 'UG004', name: 'Centenary Bank'),
  AfricanBank(code: 'UG005', name: 'DFCU Bank'),
  AfricanBank(code: 'UG006', name: 'Equity Bank Uganda'),
  AfricanBank(code: 'UG007', name: 'Bank of Africa Uganda'),
];

// Tanzania Banks
const tanzaniaBanks = [
  AfricanBank(code: 'TZ001', name: 'CRDB Bank'),
  AfricanBank(code: 'TZ002', name: 'NMB Bank'),
  AfricanBank(code: 'TZ003', name: 'Stanbic Bank Tanzania'),
  AfricanBank(code: 'TZ004', name: 'Standard Chartered Tanzania'),
  AfricanBank(code: 'TZ005', name: 'Equity Bank Tanzania'),
  AfricanBank(code: 'TZ006', name: 'Exim Bank Tanzania'),
];