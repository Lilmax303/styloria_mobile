// lib/provider_payout_settings_screen.dart

import 'package:flutter/material.dart';
import 'api_client.dart';
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';
import 'utils/datetime_helper.dart';
import 'africa_countries.dart';
import 'currency_helper.dart';
import 'package:country_picker/country_picker.dart';
import 'africa_iso2.dart';
import 'mobile_networks.dart';
import 'african_banks.dart';

class ProviderPayoutSettingsScreen extends StatefulWidget {
  const ProviderPayoutSettingsScreen({super.key});

  @override
  State<ProviderPayoutSettingsScreen> createState() => _ProviderPayoutSettingsScreenState();
}

class _ProviderPayoutSettingsScreenState extends State<ProviderPayoutSettingsScreen> {
  bool _loading = true;
  bool _saving = false;

  AppLocalizations get l10n => AppLocalizations.of(context);

  bool _autoEnabled = true;
  bool _instantEnabled = true;
  String _payoutFrequency = 'weekly';
  int _weekday = 1;
  int _hourUtc = 2;
  final _minAmountCtrl = TextEditingController(text: "0.00");
  
  bool _isAfricaProvider = false;
  bool _isPaystackProvider = false;
  String _providerCountry = '';
  String _fwMethod = 'bank';
  String _lockedFwCurrency = 'USD';
  
  // Full name (used for both bank and mobile money)
  final _fwFullNameCtrl = TextEditingController();
  
  // Bank fields
  final _fwBankCodeCtrl = TextEditingController();
  final _fwBankNameCtrl = TextEditingController();
  final _fwAccountNumberCtrl = TextEditingController();
  AfricanBank? _selectedBank;
  List<AfricanBank> _availableBanks = [];
  
  // Mobile Money fields
  String _momoDialCode = '+233';
  String _momoFlag = '🇬🇭';
  final _fwPhoneCtrl = TextEditingController();
  String _selectedMobileNetwork = '';
  List<MobileNetwork> _availableMobileNetworks = [];
  
  // Other fields
  final _fwBeneficiaryCtrl = TextEditingController();
  final _fwZipCtrl = TextEditingController();

  // Paystack fields
  List<dynamic> _paystackBanks = [];
  bool _loadingPaystackBanks = false;
  String? _selectedPaystackBankCode;  // Use bank code instead of Map
  final _paystackAccountNumberCtrl = TextEditingController();
  bool _resolvingAccount = false;
  String? _resolvedAccountName;
  String? _resolveError;
  bool _paystackAccountVerified = false;

  // Instant payout info
  int? _instantPayoutLimit;
  int? _instantPayoutsRemaining;
  String? _nextScheduledPayout;

  static const List<_PayoutDayOption> _allowedPayoutDays = [
    _PayoutDayOption(1, 'Tuesday'),
    _PayoutDayOption(3, 'Thursday'),
    _PayoutDayOption(4, 'Friday'),
  ];

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _minAmountCtrl.dispose();
    _fwFullNameCtrl.dispose();
    _fwBankCodeCtrl.dispose();
    _fwBankNameCtrl.dispose();
    _fwAccountNumberCtrl.dispose();
    _fwPhoneCtrl.dispose();
    _fwBeneficiaryCtrl.dispose();
    _fwZipCtrl.dispose();
    _paystackAccountNumberCtrl.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final me = await ApiClient.getCurrentUser();
    _providerCountry = me?['country_name']?.toString() ?? '';
    _isAfricaProvider = isAfricanCountryName(_providerCountry);
    _isPaystackProvider = ApiClient.isPaystackCountry(_providerCountry);
    
    // Load available banks and mobile networks for the country
    _availableBanks = getBanksForCountry(_providerCountry);
    _availableMobileNetworks = getMobileNetworksForCountry(_providerCountry);
    
    final data = await ApiClient.getProviderPayoutSettings();
    if (!mounted) return;

    // Load Paystack banks if in Paystack country
    if (_isPaystackProvider) {
      _loadPaystackBanks();
    }

    if (data != null) {
      _autoEnabled = data['auto_payout_enabled'] == true;
      _instantEnabled = data['instant_payout_enabled'] == true;
      _payoutFrequency = data['payout_frequency']?.toString() ?? 'weekly';
      
      final parsedWeekday = int.tryParse(data['payout_weekday']?.toString() ?? '1') ?? 1;
      if ([1, 3, 4].contains(parsedWeekday)) {
        _weekday = parsedWeekday;
      } else {
        _weekday = 1;
      }

      _hourUtc = int.tryParse(data['payout_hour_utc']?.toString() ?? '2') ?? 2;
      _fwMethod = (data['flutterwave_method']?.toString().trim().isNotEmpty == true)
          ? data['flutterwave_method'].toString().trim()
          : 'bank';
      
      // Load full name
      _fwFullNameCtrl.text = data['flutterwave_full_name']?.toString() ?? '';
      
      // Load bank details
      _fwBankCodeCtrl.text = data['flutterwave_bank_code']?.toString() ?? '';
      _fwBankNameCtrl.text = data['flutterwave_bank_name']?.toString() ?? '';
      _fwAccountNumberCtrl.text = data['flutterwave_account_number']?.toString() ?? '';
      
      // Try to match saved bank to dropdown
      final savedBankCode = data['flutterwave_bank_code']?.toString() ?? '';
      if (savedBankCode.isNotEmpty && _availableBanks.isNotEmpty) {
        _selectedBank = _availableBanks.where((b) => b.code == savedBankCode).firstOrNull;
      }
      
      // Load mobile money details
      _fwPhoneCtrl.text = data['flutterwave_phone_number']?.toString() ?? '';
      _selectedMobileNetwork = data['flutterwave_mobile_network']?.toString() ?? '';

      // Normalize: match loaded value to available networks (case-insensitive)
      if (_selectedMobileNetwork.isNotEmpty && _availableMobileNetworks.isNotEmpty) {
        final match = _availableMobileNetworks.where(
          (n) => n.code.toLowerCase() == _selectedMobileNetwork.toLowerCase()
        ).firstOrNull;
        _selectedMobileNetwork = match?.code ?? '';
      }
      
      final savedDial = (data['flutterwave_country_code'] ?? '').toString().trim();
      if (savedDial.isNotEmpty) _momoDialCode = savedDial;

      // Load Paystack fields
      _paystackAccountNumberCtrl.text = data['paystack_account_number']?.toString() ?? '';
      final savedPaystackBankCode = data['paystack_bank_code']?.toString() ?? '';
      _resolvedAccountName = data['paystack_account_name']?.toString();
      
      // Mark as verified if we have saved account details
      if (_paystackAccountNumberCtrl.text.isNotEmpty && 
          savedPaystackBankCode.isNotEmpty &&
          _resolvedAccountName != null && 
          _resolvedAccountName!.isNotEmpty) {
        _paystackAccountVerified = true;
        _selectedPaystackBankCode = savedPaystackBankCode;
      }
      
      // Other fields
      _fwBeneficiaryCtrl.text = data['flutterwave_beneficiary_id']?.toString() ?? '';
      _fwZipCtrl.text = data['flutterwave_zip_code']?.toString() ?? '';

      // Instant payout info
      _instantPayoutLimit = int.tryParse(data['instant_payout_limit']?.toString() ?? '');
      _instantPayoutsRemaining = int.tryParse(data['instant_payouts_remaining']?.toString() ?? '');
      _nextScheduledPayout = data['next_scheduled_payout']?.toString();
    }

    // Lock currency to provider country currency
    _lockedFwCurrency = CurrencyHelper.getCurrencyCode(_providerCountry);

    // Default full name (if empty)
    if (_fwFullNameCtrl.text.trim().isEmpty) {
      final first = (me?['first_name'] ?? '').toString().trim();
      final last = (me?['last_name'] ?? '').toString().trim();
      final full = ('$first $last').trim();
      if (full.isNotEmpty) _fwFullNameCtrl.text = full;
    }

    setState(() => _loading = false);
  }


  Future<void> _loadPaystackBanks() async {
    setState(() => _loadingPaystackBanks = true);
    
    final banks = await ApiClient.getPaystackBanks(
      country: _providerCountry.toLowerCase(),
    );
    
    if (!mounted) return;
    
    setState(() {
      // Filter out duplicate bank codes (Paystack API sometimes returns duplicates)
      final seen = <String>{};
      final uniqueBanks = <dynamic>[];
      for (final bank in (banks ?? [])) {
        final code = (bank['code']?.toString() ?? '');
        if (code.isNotEmpty && !seen.contains(code)) {
          seen.add(code);
          uniqueBanks.add(bank);
        }
      }
      _paystackBanks = uniqueBanks;
      _loadingPaystackBanks = false;
      
    });
  }

  /// Returns the selected bank code only if it exists in the loaded banks list
  String? _getValidPaystackBankCode() {
    if (_selectedPaystackBankCode == null || _paystackBanks.isEmpty) {
      return null;
    }
    // Check if the code exists in the loaded banks
    final exists = _paystackBanks.any((b) => 
      b['code']?.toString() == _selectedPaystackBankCode
    );
    return exists ? _selectedPaystackBankCode : null;
  }

  Map<String, dynamic>? get _selectedPaystackBank {
    if (_selectedPaystackBankCode == null || _paystackBanks.isEmpty) return null;
    final match = _paystackBanks.where((b) => 
      b['code']?.toString() == _selectedPaystackBankCode
    ).firstOrNull;
    if (match != null) {
      return Map<String, dynamic>.from(match as Map);
    }
    return null;
  }

  Future<void> _resolvePaystackAccount() async {
    final accountNumber = _paystackAccountNumberCtrl.text.trim();
    if (accountNumber.isEmpty) {
      setState(() {
        _resolveError = 'Please enter account number';
        _resolvedAccountName = null;
        _paystackAccountVerified = false;
      });
      return;
    }
    
    if (_selectedPaystackBankCode == null || _selectedPaystackBankCode!.isEmpty) {
      setState(() {
        _resolveError = 'Please select a bank';
        _resolvedAccountName = null;
        _paystackAccountVerified = false;
      });
      return;
    }
        
    setState(() {
      _resolvingAccount = true;
      _resolveError = null;
    });
    
    final result = await ApiClient.resolvePaystackAccount(
      accountNumber: accountNumber,
      bankCode: _selectedPaystackBankCode!,
    );
    
    if (!mounted) return;
    
    setState(() {
      _resolvingAccount = false;
      if (result != null && result['account_name'] != null) {
        _resolvedAccountName = result['account_name'].toString();
        _paystackAccountVerified = true;
        _resolveError = null;
      } else {
        _resolvedAccountName = null;
        _paystackAccountVerified = false;
        _resolveError = result?['message']?.toString() ?? 
                        'Could not verify account. Please check your details.';
      }
    });
  }

  Future<void> _save() async {
    
    // Validation
    if (_isPaystackProvider) {
      // Paystack validation
      if (_selectedPaystackBankCode == null || _selectedPaystackBankCode!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select your bank')),
        );
        return;
      }
      if (_paystackAccountNumberCtrl.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter your account number')),
        );
        return;
      }
      if (!_paystackAccountVerified || _resolvedAccountName == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please verify your account before saving')),
        );
        return;
      }
    } else if (_isAfricaProvider) {

      // Flutterwave validation (unchanged)
      if (_fwFullNameCtrl.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter your full name')),
        );
        return;
      }
      
      if (_fwMethod == 'bank') {
        if (_fwBankNameCtrl.text.trim().isEmpty && _selectedBank == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please select or enter a bank name')),
          );
          return;
        }
        if (_fwAccountNumberCtrl.text.trim().isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please enter your account number')),
          );
          return;
        }
      } else {
        // Mobile money
        if (_selectedMobileNetwork.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please select your mobile network')),
          );
          return;
        }
        if (_fwPhoneCtrl.text.trim().isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please enter your mobile money number')),
          );
          return;
        }
      }
    }
    
    setState(() => _saving = true);

    final payload = {
      'auto_payout_enabled': _autoEnabled,
      'instant_payout_enabled': _instantEnabled,
      'payout_frequency': _payoutFrequency,
      'payout_weekday': _weekday,
      'payout_hour_utc': _hourUtc,
      'minimum_payout_amount': _minAmountCtrl.text.trim(),
    };

    if (_isPaystackProvider) {
      final selectedBank = _selectedPaystackBank;
      payload['payout_gateway'] = 'paystack';
      payload['paystack_bank_code'] = _selectedPaystackBankCode ?? '';
      payload['paystack_bank_name'] = selectedBank?['name']?.toString() ?? '';
      payload['paystack_account_number'] = _paystackAccountNumberCtrl.text.trim();
      payload['paystack_account_name'] = _resolvedAccountName ?? '';
      payload['paystack_currency'] = _lockedFwCurrency;
    } else if (_isAfricaProvider) {

      // Flutterwave payload (unchanged)
      payload['payout_gateway'] = 'flutterwave';
      payload['flutterwave_method'] = _fwMethod;
      payload['flutterwave_currency'] = _lockedFwCurrency;
      payload['flutterwave_full_name'] = _fwFullNameCtrl.text.trim();
      
      if (_fwMethod == 'bank') {
        // Use selected bank or manual entry
        if (_selectedBank != null) {
          payload['flutterwave_bank_code'] = _selectedBank!.code;
          payload['flutterwave_bank_name'] = _selectedBank!.name;
        } else {
          payload['flutterwave_bank_code'] = _fwBankCodeCtrl.text.trim();
          payload['flutterwave_bank_name'] = _fwBankNameCtrl.text.trim();
        }
        payload['flutterwave_account_number'] = _fwAccountNumberCtrl.text.trim();
        // Clear mobile money fields
        payload['flutterwave_phone_number'] = '';
        payload['flutterwave_mobile_network'] = '';
      } else {
        // Mobile money
        payload['flutterwave_phone_number'] = _fwPhoneCtrl.text.trim();
        payload['flutterwave_mobile_network'] = _selectedMobileNetwork;
        payload['flutterwave_country_code'] = _momoDialCode.trim();
        // Clear bank fields
        payload['flutterwave_bank_code'] = '';
        payload['flutterwave_bank_name'] = '';
        payload['flutterwave_account_number'] = '';
      }
      
      payload['flutterwave_beneficiary_id'] = _fwBeneficiaryCtrl.text.trim();
      payload['flutterwave_zip_code'] = _fwZipCtrl.text.trim();
    }

    final res = await ApiClient.updateProviderPayoutSettings(payload);
    if (!mounted) return;

    setState(() => _saving = false);

    if (res == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.payoutSettingsSaveFailed)));
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.payoutSettingsSaved)));
  }

  Widget _buildPaystackSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Info card
        Card(
          color: Colors.green.shade50,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(Icons.verified, color: Colors.green.shade700),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    l10n.payoutPaystackForCountry(_providerCountry),
                    style: TextStyle(color: Colors.green.shade700),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        
        Text(
          l10n.payoutBankAccountDetails,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        
        // Bank Selection
        if (_loadingPaystackBanks)
          const Center(child: CircularProgressIndicator())
        else if (_paystackBanks.isEmpty)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.warning_amber, color: Colors.orange.shade700),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text('Could not load banks. Please try again later.'),
                ),
                TextButton(
                  onPressed: _loadPaystackBanks,
                  child: const Text('Retry'),
                ),
              ],
            ),
          )
        else
          DropdownButtonFormField<String>(
            value: _getValidPaystackBankCode(),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: l10n.payoutSelectBank,
              prefixIcon: const Icon(Icons.account_balance),
            ),
            items: _paystackBanks.map((bank) {
              final bankMap = Map<String, dynamic>.from(bank as Map);
              final code = bankMap['code']?.toString() ?? '';
              final name = bankMap['name']?.toString() ?? '';
              return DropdownMenuItem(
                value: code,
                child: Text(name),
              );
            }).toList(),
            onChanged: (code) {
              setState(() {
                _selectedPaystackBankCode = code;
                _resolvedAccountName = null;
                _paystackAccountVerified = false;
                _resolveError = null;
              });
            },
          ),
        const SizedBox(height: 16),
        
        // Account Number
        TextField(
          controller: _paystackAccountNumberCtrl,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: l10n.payoutAccountNumber,
            hintText: l10n.payoutAccountNumberHint,
            prefixIcon: const Icon(Icons.numbers),
          ),
          onChanged: (_) {
            setState(() {
              _resolvedAccountName = null;
              _paystackAccountVerified = false;
              _resolveError = null;
            });
          },
        ),
        const SizedBox(height: 12),
        
        // Verify Button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: (_resolvingAccount || _selectedPaystackBankCode == null || _selectedPaystackBankCode!.isEmpty) 
                ? null 
                : _resolvePaystackAccount,
            icon: _resolvingAccount
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.verified_user),
            label: Text(_resolvingAccount ? l10n.paystackVerifying : l10n.paystackVerifyAccount),
          ),
        ),
        const SizedBox(height: 12),
        
        // Verification Result
        if (_resolveError != null)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.red.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.error_outline, color: Colors.red.shade700, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _resolveError!,
                    style: TextStyle(color: Colors.red.shade700, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        
        if (_paystackAccountVerified && _resolvedAccountName != null)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green.shade700, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.paystackAccountVerified,
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _resolvedAccountName!,
                        style: TextStyle(
                          color: Colors.green.shade800,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        
        const Divider(height: 32),
      ],
    );
  }

  Widget _buildBankSection() {
    final hasAvailableBanks = _availableBanks.isNotEmpty;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Full Name
        TextField(
          controller: _fwFullNameCtrl,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: l10n.payoutAccountHolderName,
            hintText: l10n.payoutAccountHolderNameHint,
            prefixIcon: const Icon(Icons.person),
          ),
        ),
        const SizedBox(height: 16),
        
        // Bank Selection
        if (hasAvailableBanks) ...[
          DropdownButtonFormField<AfricanBank>(
            value: _selectedBank,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: l10n.payoutSelectBank,
              prefixIcon: const Icon(Icons.account_balance),
            ),
            items: _availableBanks.map((bank) {
              return DropdownMenuItem(
                value: bank,
                child: Text(bank.name),
              );
            }).toList(),
            onChanged: (bank) {
              setState(() {
                _selectedBank = bank;
                if (bank != null) {
                  _fwBankCodeCtrl.text = bank.code;
                  _fwBankNameCtrl.text = bank.name;
                }
              });
            },
          ),
          const SizedBox(height: 8),
          Text(
            l10n.payoutBankNameManual,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
          ),
          const SizedBox(height: 8),
        ],
        
        // Manual Bank Entry
        TextField(
          controller: _fwBankNameCtrl,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: hasAvailableBanks ? l10n.payoutBankNameManual : l10n.payoutBankName,
            hintText: l10n.payoutBankNameHint,
            prefixIcon: const Icon(Icons.account_balance),
          ),
          onChanged: (_) {
            // Clear dropdown selection if manually entering
            if (_selectedBank != null) {
              setState(() => _selectedBank = null);
            }
          },
        ),
        const SizedBox(height: 12),
        
        TextField(
          controller: _fwBankCodeCtrl,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: hasAvailableBanks ? l10n.payoutBankCodeManual : l10n.payoutBankCode,
            hintText: l10n.payoutBankCodeHint,
            helperText: l10n.payoutBankCodeHelper,
            prefixIcon: const Icon(Icons.code),
          ),
          onChanged: (_) {
            if (_selectedBank != null) {
              setState(() => _selectedBank = null);
            }
          },
        ),
        const SizedBox(height: 12),
        
        // Account Number
        TextField(
          controller: _fwAccountNumberCtrl,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Account Number *',
            hintText: 'Enter your bank account number',
            prefixIcon: Icon(Icons.numbers),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileMoneySection() {
    final hasAvailableNetworks = _availableMobileNetworks.isNotEmpty;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Full Name
        TextField(
          controller: _fwFullNameCtrl,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: l10n.payoutFullName,
            hintText: l10n.payoutFullNameHint,
            prefixIcon: const Icon(Icons.person),
          ),
        ),
        const SizedBox(height: 16),
        
        // Mobile Network Selection
        if (hasAvailableNetworks) ...[
          DropdownButtonFormField<String>(
            value: _selectedMobileNetwork.isNotEmpty &&
                   _availableMobileNetworks.any((n) => n.code == _selectedMobileNetwork)
                ? _selectedMobileNetwork 
                : null,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: l10n.payoutMobileNetwork,
              prefixIcon: const Icon(Icons.phone_android),
            ),
            hint: Text(l10n.payoutSelectNetwork),
            items: _availableMobileNetworks.map((network) {
              return DropdownMenuItem(
                value: network.code,
                child: Text(network.name),
              );
            }).toList(),
            onChanged: (code) {
              setState(() => _selectedMobileNetwork = code ?? '');
            },
          ),
        ] else ...[
          TextField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: l10n.payoutMobileNetwork,
              hintText: l10n.payoutMobileNetworkHint,
              prefixIcon: const Icon(Icons.phone_android),
            ),
            onChanged: (value) {
              setState(() => _selectedMobileNetwork = value.toLowerCase());
            },
          ),
        ],
        const SizedBox(height: 16),
        
        // Country Code Picker
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(4),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            leading: const Icon(Icons.flag),
            title: Text(l10n.payoutCountryCode),
            subtitle: Text('$_momoFlag  $_momoDialCode'),
            trailing: const Icon(Icons.arrow_drop_down),
            onTap: () {
              showCountryPicker(
                context: context,
                countryFilter: africaIso2,
                showPhoneCode: true,
                onSelect: (Country c) {
                  setState(() {
                    _momoDialCode = '+${c.phoneCode}';
                    _momoFlag = c.flagEmoji;
                  });
                },
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        
        // Phone Number
        TextField(
          controller: _fwPhoneCtrl,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: l10n.payoutMobileMoneyNumber,
            hintText: l10n.payoutMobileMoneyNumberHint,
            prefixIcon: const Icon(Icons.phone),
            prefixText: '$_momoDialCode ',
          ),
        ),
        const SizedBox(height: 12),
        
        // ZIP Code (optional for some countries)
        TextField(
          controller: _fwZipCtrl,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: l10n.payoutZipCode,
            hintText: l10n.payoutZipCodeHint,
            prefixIcon: const Icon(Icons.location_on),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.payoutSettingsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Paystack section (Ghana, Nigeria, South Africa, Kenya, Côte d'Ivoire)
          if (_isPaystackProvider) ...[
            _buildPaystackSection(),
          ] else if (_isAfricaProvider) ...[
            // Header
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue.shade700),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Payouts are processed via Flutterwave for $_providerCountry',
                        style: TextStyle(color: Colors.blue.shade700),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Method Selection
            Text(
              l10n.payoutMethod,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            SegmentedButton<String>(
              segments: [
                ButtonSegment(
                  value: 'bank',
                  label: Text(l10n.payoutBankTransfer),
                  icon: Icon(Icons.account_balance),
                ),
                ButtonSegment(
                  value: 'mobile_money',
                  label: Text(l10n.payoutMobileMoney),
                  icon: Icon(Icons.phone_android),
                ),
              ],
              selected: {_fwMethod},
              onSelectionChanged: (selection) {
                setState(() => _fwMethod = selection.first);
              },
            ),
            const SizedBox(height: 16),
            
            // Currency (locked)
            TextFormField(
              initialValue: _lockedFwCurrency,
              enabled: false,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: l10n.payoutCurrency,
                helperText: l10n.payoutCurrencyLocked(_providerCountry),
                prefixIcon: const Icon(Icons.attach_money),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
            ),
            const SizedBox(height: 16),
            
            // Method-specific fields
            if (_fwMethod == 'bank')
              _buildBankSection()
            else
              _buildMobileMoneySection(),
            
            const SizedBox(height: 12),
            
            // Beneficiary ID (optional)
            TextField(
              controller: _fwBeneficiaryCtrl,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: l10n.payoutBeneficiaryId,
                hintText: l10n.payoutBeneficiaryIdHint,
                prefixIcon: const Icon(Icons.badge),
              ),
            ),
            
            const Divider(height: 32),
          ],
          
          // Auto Payout Settings
          Text(
            l10n.payoutSchedule,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          
          SwitchListTile(
            title: Text(l10n.payoutAutoPayoutsTitle),
            subtitle: Text(l10n.payoutAutoPayoutsSubtitle),
            value: _autoEnabled,
            onChanged: (v) => setState(() => _autoEnabled = v),
          ),
          const SizedBox(height: 10),

          // Payout frequency
          DropdownButtonFormField<String>(
            value: _payoutFrequency,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: l10n.payoutFrequency,
              helperText: l10n.payoutAutoPayoutsSubtitle,
            ),
            items: [
              DropdownMenuItem(value: 'weekly', child: Text(l10n.payoutFrequencyWeekly)),
              DropdownMenuItem(value: 'monthly', child: Text(l10n.payoutFrequencyMonthly)),
            ],
            onChanged: _autoEnabled ? (v) => setState(() => _payoutFrequency = v ?? 'weekly') : null,
          ),
          const SizedBox(height: 10),

          // Payout day (weekly only)
          if (_payoutFrequency == 'weekly') ...[
            DropdownButtonFormField<int>(
              value: _weekday,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: l10n.payoutDayUtcLabel,
                helperText: l10n.payoutDayHelper,
              ),
              items: _allowedPayoutDays
                  .map((opt) => DropdownMenuItem(value: opt.value, child: Text(opt.label)))
                  .toList(),
              onChanged: _autoEnabled ? (v) => setState(() => _weekday = v ?? 1) : null,
            ),
            const SizedBox(height: 10),
          ] else ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue.shade700, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      l10n.payoutMonthlyInfo,
                      style: TextStyle(color: Colors.blue.shade700, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],

          // Payout hour
          DropdownButtonFormField<int>(
            value: _hourUtc,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: l10n.payoutHourUtcLabel,
            ),
            items: List.generate(24, (i) => DropdownMenuItem(value: i, child: Text('$i:00 UTC'))),
            onChanged: _autoEnabled ? (v) => setState(() => _hourUtc = v ?? 2) : null,
          ),
          const SizedBox(height: 10),

          // Minimum amount
          TextField(
            controller: _minAmountCtrl,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: l10n.payoutMinimumAmountLabel,
              helperText: l10n.payoutMinimumAmountHelper,
              prefixText: '$_lockedFwCurrency ',
            ),
            enabled: _autoEnabled,
          ),
          const SizedBox(height: 16),

          // Instant Cashout
          Text(
            l10n.payoutInstantCashout,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          
          SwitchListTile(
            title: Text(l10n.payoutInstantCashOutEnabledTitle),
            subtitle: Text(l10n.payoutInstantCashOutEnabledSubtitle),
            value: _instantEnabled,
            onChanged: (v) => setState(() => _instantEnabled = v),
          ),

          // ✅ NEW: Next Scheduled Payout Display
          if (_nextScheduledPayout != null && _nextScheduledPayout!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.schedule, color: Colors.blue.shade700, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.payoutNextScheduled,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.blue.shade800,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          DateTimeHelper.formatDetailedDateTime(_nextScheduledPayout!),
                          style: TextStyle(
                            color: Colors.blue.shade700,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          l10n.payoutYourLocalTime(DateTimeHelper.getTimezoneAbbreviation()),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.blue.shade600,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],

          if (_instantEnabled) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.bolt, color: Colors.amber.shade700, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        l10n.payoutInstantCashout,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.amber.shade800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.payoutInstantCashoutInfo,
                    style: TextStyle(color: Colors.amber.shade900, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 24),
          
          // Save Button
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: _saving ? null : _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
              child: _saving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : Text(l10n.save, style: const TextStyle(fontSize: 16)),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _PayoutDayOption {
  final int value;
  final String label;
  const _PayoutDayOption(this.value, this.label);
}