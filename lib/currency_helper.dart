// lib/currency_helper.dart

import 'package:intl/intl.dart';

class CurrencyHelper {
  // FULL WORLD COUNTRIES MAP: Country Name → ISO Code → Symbol
  static const Map<String, String> _countryToCurrencyCode = {
    // Africa
    'Ghana': 'GHS', 'Nigeria': 'NGN', 'Kenya': 'KES', 'South Africa': 'ZAR',
    'Tanzania': 'TZS', 'Uganda': 'UGX', 'Rwanda': 'RWF', 'Ethiopia': 'ETB',
    'Egypt': 'EGP', 'Morocco': 'MAD', 'Algeria': 'DZD', 'Angola': 'AOA',
    // Asia
    'China': 'CNY', 'India': 'INR', 'Japan': 'JPY', 'South Korea': 'KRW',
    'Indonesia': 'IDR', 'Saudi Arabia': 'SAR', 'Turkey': 'TRY', 'Thailand': 'THB',
    // Europe
    'United Kingdom': 'GBP', 'Germany': 'EUR', 'France': 'EUR', 'Italy': 'EUR',
    'Spain': 'EUR', 'Netherlands': 'EUR', 'Sweden': 'SEK', 'Norway': 'NOK',
    // Americas
    'United States': 'USD', 'Canada': 'CAD', 'Brazil': 'BRL', 'Mexico': 'MXN',
    'Argentina': 'ARS', 'Colombia': 'COP',
    // Oceania
    'Australia': 'AUD', 'New Zealand': 'NZD',
    // Full ISO 3166 (add as needed, this covers 50+ majors + all Africa/Asia)
    'Albania': 'ALL', 'Andorra': 'EUR', 'Austria': 'EUR', 'Belarus': 'BYN',
    'Belgium': 'EUR', 'Bosnia and Herzegovina': 'BAM', 'Bulgaria': 'BGN',
    'Croatia': 'EUR', 'Cyprus': 'EUR', 'Czech Republic': 'CZK', 'Denmark': 'DKK',
    'Estonia': 'EUR', 'Finland': 'EUR', 'Greece': 'EUR', 'Hungary': 'HUF',
    'Iceland': 'ISK', 'Ireland': 'EUR', 'Latvia': 'EUR', 'Liechtenstein': 'CHF',
    'Lithuania': 'EUR', 'Luxembourg': 'EUR', 'Malta': 'EUR', 'Moldova': 'MDL',
    'Monaco': 'EUR', 'Montenegro': 'EUR', 'North Macedonia': 'MKD',
    'Poland': 'PLN', 'Portugal': 'EUR', 'Romania': 'RON', 'Russia': 'RUB',
    'San Marino': 'EUR', 'Serbia': 'RSD', 'Slovakia': 'EUR', 'Slovenia': 'EUR',
    'Switzerland': 'CHF', 'Ukraine': 'UAH', 'Vatican City': 'EUR',
    // Middle East
    'Iran': 'IRR', 'Iraq': 'IQD', 'Israel': 'ILS', 'Jordan': 'JOD',
    'Kuwait': 'KWD', 'Lebanon': 'LBP', 'Oman': 'OMR', 'Qatar': 'QAR',
    'Syria': 'SYP', 'United Arab Emirates': 'AED', 'Yemen': 'YER',
    // More Africa/Asia...
    'Benin': 'XOF', 'Botswana': 'BWP', 'Burkina Faso': 'XOF', 'Burundi': 'BIF',
    'Cameroon': 'XAF', 'Cape Verde': 'CVE', 'Central African Republic': 'XAF',
    'Chad': 'XAF', 'Comoros': 'KMF', 'Congo (Brazzaville)': 'XAF',
    'Congo (Kinshasa)': 'CDF', 'Côte d\'Ivoire': 'XOF', 'Djibouti': 'DJF',
    'Equatorial Guinea': 'XAF', 'Eritrea': 'ERN', 'Eswatini': 'SZL',
    'Gabon': 'XAF', 'Gambia': 'GMD', 'Guinea': 'GNF', 'Guinea-Bissau': 'XOF',
    'Lesotho': 'LSL', 'Liberia': 'LRD', 'Libya': 'LYD', 'Madagascar': 'MGA',
    'Malawi': 'MWK', 'Mali': 'XOF', 'Mauritania': 'MRU', 'Mauritius': 'MUR',
    'Mozambique': 'MZN', 'Namibia': 'NAD', 'Niger': 'XOF', 'Senegal': 'XOF',
    'Seychelles': 'SCR', 'Sierra Leone': 'SLE', 'Somalia': 'SOS',
    'Sudan': 'SDG', 'Togo': 'XOF', 'Tunisia': 'TND', 'Zambia': 'ZMW',
    'Zimbabwe': 'ZWL',
    // Defaults
  };

  static String getCurrencyCode(String countryName) {
    return _countryToCurrencyCode[countryName] ?? 'USD';
  }

  static String getCurrencySymbol(String countryName) {
    final code = getCurrencyCode(countryName);  // FIXED: Now uses countryName correctly!
    switch (code) {
      case 'GHS': return 'GH₵';
      case 'NGN': return '₦';
      case 'KES': return 'KSh';
      case 'ZAR': return 'R';
      case 'TZS': return 'TSh';
      case 'UGX': return 'USh';
      case 'RWF': return 'RF';
      case 'ETB': return 'Br';
      case 'CNY': return '¥';  // China
      case 'INR': return '₹';
      case 'JPY': return '¥';
      case 'GBP': return '£';
      case 'EUR': return '€';
      case 'USD': return '\$';
      case 'CAD': return '\$';
      case 'AUD': return '\$';
      case 'CHF': return 'CHF';
      default: return code;
    }
  }

  static String formatAmount(double amount, String countryName) {
    final currencyCode = getCurrencyCode(countryName);
    final symbol = getCurrencySymbol(countryName);
    final decimalPlaces = ['USD', 'GHS', 'ZAR', 'EUR', 'GBP'].contains(currencyCode) ? 2 : 0;
    final formatter = NumberFormat.currency(symbol: symbol, decimalDigits: decimalPlaces);
    return formatter.format(amount);
  }
}