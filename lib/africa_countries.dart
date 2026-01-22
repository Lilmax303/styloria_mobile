// lib/africa_countries.dart

/// NOTE: your backend currently returns `country_name`.
/// This list matches common English country names. If your app stores
/// different spelling/casing, normalize or switch to ISO codes from backend.
const Set<String> _africanCountries = {
  'Algeria','Angola','Benin','Botswana','Burkina Faso','Burundi','Cabo Verde',
  'Cameroon','Central African Republic','Chad','Comoros','Congo',
  'Democratic Republic of the Congo','Djibouti','Egypt','Equatorial Guinea',
  'Eritrea','Eswatini','Ethiopia','Gabon','Gambia','Ghana','Guinea',
  'Guinea-Bissau',"Côte d’Ivoire","Cote d'Ivoire",'Ivory Coast','Kenya',
  'Lesotho','Liberia','Libya','Madagascar','Malawi','Mali','Mauritania',
  'Mauritius','Morocco','Mozambique','Namibia','Niger','Nigeria','Rwanda',
  'Sao Tome and Principe','Senegal','Seychelles','Sierra Leone','Somalia',
  'South Africa','South Sudan','Sudan','Tanzania','Togo','Tunisia','Uganda',
  'Zambia','Zimbabwe',
};

String _norm(String s) {
  // normalize apostrophes and whitespace, compare case-insensitively
  return s
      .trim()
      .replaceAll('’', "'")
      .replaceAll(RegExp(r'\s+'), ' ')
      .toLowerCase();
}

final Set<String> _africanCountriesNorm = _africanCountries.map(_norm).toSet();

bool isAfricanCountryName(String? countryName) {
  if (countryName == null) return false;
  final n = _norm(countryName);
  if (n.isEmpty) return false;
  return _africanCountriesNorm.contains(n);
}