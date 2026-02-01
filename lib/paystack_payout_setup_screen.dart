// lib/paystack_payout_setup_screen.dart

import 'package:flutter/material.dart';
import 'api_client.dart';

class PaystackPayoutSetupScreen extends StatefulWidget {
  const PaystackPayoutSetupScreen({super.key});

  @override
  State<PaystackPayoutSetupScreen> createState() => _PaystackPayoutSetupScreenState();
}

class _PaystackPayoutSetupScreenState extends State<PaystackPayoutSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  
  bool _loading = false;
  bool _loadingBanks = true;
  bool _resolvingAccount = false;
  
  List<Map<String, dynamic>>? _banks;
  Map<String, dynamic>? _selectedBank;
  String? _userCountry;
  String? _currency;
  
  final _accountNumberController = TextEditingController();
  String? _resolvedAccountName;
  String? _resolveError;

  @override
  void initState() {
    super.initState();
    _loadUserCountryAndBanks();
  }

  @override
  void dispose() {
    _accountNumberController.dispose();
    super.dispose();
  }

  Future<void> _loadUserCountryAndBanks() async {
    setState(() => _loadingBanks = true);

    try {
      final userData = await ApiClient.getCurrentUser();
      final country = userData?['country_name']?.toString() ?? 'Ghana';
      _userCountry = country;
      
      // Map country to currency
      final currencyMap = {
        'ghana': 'GHS',
        'nigeria': 'NGN',
        'south africa': 'ZAR',
        'kenya': 'KES',
        'côte d\'ivoire': 'XOF',
        'cote d\'ivoire': 'XOF',
        'ivory coast': 'XOF',
      };
      
      _currency = currencyMap[country.toLowerCase()] ?? 'GHS';

      // Load banks
      final banks = await ApiClient.getPaystackBanks(
        country: country.toLowerCase(),
        currency: _currency,
      );
      
      setState(() {
        _banks = banks?.map((b) => Map<String, dynamic>.from(b as Map)).toList();
        _loadingBanks = false;
      });
    } catch (e) {
      setState(() => _loadingBanks = false);
      debugPrint('Error loading banks: $e');
    }
  }

  Future<void> _resolveAccount() async {
    if (_selectedBank == null || _accountNumberController.text.length < 10) {
      return;
    }

    setState(() {
      _resolvingAccount = true;
      _resolvedAccountName = null;
      _resolveError = null;
    });

    try {
      final result = await ApiClient.resolvePaystackAccount(
        accountNumber: _accountNumberController.text.trim(),
        bankCode: _selectedBank!['code'].toString(),
      );

      if (result != null && result['success'] == true) {
        setState(() {
          _resolvedAccountName = result['account_name']?.toString();
          _resolvingAccount = false;
        });
      } else {
        setState(() {
          _resolveError = result?['detail']?.toString() ?? 'Could not verify account';
          _resolvingAccount = false;
        });
      }
    } catch (e) {
      setState(() {
        _resolveError = 'Error verifying account';
        _resolvingAccount = false;
      });
    }
  }

  Future<void> _savePayoutSettings() async {
    if (!_formKey.currentState!.validate()) return;
    if (_resolvedAccountName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please verify your account number first')),
      );
      return;
    }

    setState(() => _loading = true);

    try {
      final result = await ApiClient.updateProviderPayoutSettings({
        'payout_gateway': 'paystack',
        'paystack_bank_code': _selectedBank!['code'].toString(),
        'paystack_bank_name': _selectedBank!['name'].toString(),
        'paystack_account_number': _accountNumberController.text.trim(),
        'paystack_account_name': _resolvedAccountName,
        'paystack_currency': _currency,
        'paystack_recipient_code': '', // Will be created on first payout
      });

      if (!mounted) return;

      if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Payout settings saved successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop(true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to save payout settings')),
        );
        setState(() => _loading = false);
      }
    } catch (e) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.paystackSetupTitle),
        backgroundColor: Colors.green.shade600,
        foregroundColor: Colors.white,
      ),
      body: _loadingBanks
          ? const Center(child: CircularProgressIndicator())
          : _banks == null || _banks!.isEmpty
              ? _buildNoBanksView()
              : _buildForm(),
    );
  }

  Widget _buildNoBanksView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              l10n.paystackNoBanksAvailable(_userCountry ?? 'your country'),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Paystack supports: Ghana, Nigeria, South Africa, Kenya, Côte d\'Ivoire',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _loadUserCountryAndBanks,
              child: Text(l10n.paystackRetry),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Country & Currency Info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade50, Colors.green.shade100],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.location_on, color: Colors.green.shade700),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _userCountry ?? 'Unknown',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade800,
                          ),
                        ),
                        Text(
                          'Currency: $_currency',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.green.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.green.shade600,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Paystack',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Bank Selection
            Text(
              l10n.paystackSelectBank,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<Map<String, dynamic>>(
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.account_balance),
                hintText: l10n.payoutSelectBank,
              ),
              value: _selectedBank,
              isExpanded: true,
              items: _banks!.map((bank) {
                return DropdownMenuItem(
                  value: bank,
                  child: Text(
                    bank['name']?.toString() ?? '',
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedBank = value;
                  _resolvedAccountName = null;
                  _resolveError = null;
                });
              },
              validator: (value) => value == null ? 'Please select a bank' : null,
            ),
            const SizedBox(height: 20),

            // Account Number
            Text(
              l10n.paystackAccountNumber,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _accountNumberController,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.numbers),
                hintText: l10n.payoutAccountNumberHint,
                suffixIcon: _resolvingAccount
                    ? const Padding(
                        padding: EdgeInsets.all(12),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : IconButton(
                        icon: Icon(Icons.verified, color: Colors.green.shade600),
                        onPressed: _selectedBank != null ? _resolveAccount : null,
                        tooltip: l10n.paystackVerifyAccount,
                      ),
              ),
              keyboardType: TextInputType.number,
              maxLength: 15,
              onChanged: (value) {
                if (value.length >= 10 && _selectedBank != null) {
                  _resolveAccount();
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter account number';
                }
                if (value.length < 10) {
                  return 'Account number must be at least 10 digits';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),

            // Resolved Account Name
            if (_resolvedAccountName != null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.shade300, width: 2),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.check_circle, color: Colors.green.shade700),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.paystackAccountVerified,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green.shade600,
                            ),
                          ),
                          Text(
                            _resolvedAccountName!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.green.shade800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            if (_resolveError != null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.shade300),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, color: Colors.red.shade600),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _resolveError!,
                        style: TextStyle(color: Colors.red.shade700),
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 32),

            // Save Button
            ElevatedButton(
              onPressed: _loading || _resolvedAccountName == null ? null : _savePayoutSettings,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                disabledBackgroundColor: Colors.grey.shade300,
              ),
              child: _loading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : Text(
                      l10n.paystackSavePayoutAccount,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
            ),

            const SizedBox(height: 16),

            // Info Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, color: Colors.blue.shade700, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      l10n.paystackPayoutsInfo,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}