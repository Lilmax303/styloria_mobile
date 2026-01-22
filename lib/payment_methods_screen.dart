// lib/payment_methods_screen.dart

import 'package:flutter/material.dart';
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';

import 'api_client.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  bool _loading = true;
  bool _saving = false;

  String _paymentMethod = 'card'; // 'card', 'paypal', 'apple_pay'
  final _cardLast4Controller = TextEditingController();
  final _paypalEmailController = TextEditingController();
  bool _applePayEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  @override
  void dispose() {
    _cardLast4Controller.dispose();
    _paypalEmailController.dispose();
    super.dispose();
  }

  Future<void> _loadPrefs() async {
    final prefs = await ApiClient.getPaymentPreferences();
    if (!mounted) return;

    if (prefs != null) {
      setState(() {
        _paymentMethod = prefs['method']?.toString() ?? 'card';
        _cardLast4Controller.text = prefs['card_last4']?.toString() ?? '';
        _paypalEmailController.text = prefs['paypal_email']?.toString() ?? '';
        _applePayEnabled = prefs['apple_pay_enabled'] == true;
      });
    }
    setState(() => _loading = false);
  }

  Future<void> _savePrefs() async {
    setState(() => _saving = true);

    final prefs = {
      'method': _paymentMethod,
      'card_last4': _cardLast4Controller.text.trim(),
      'paypal_email': _paypalEmailController.text.trim(),
      'apple_pay_enabled': _applePayEnabled,
    };

    await ApiClient.savePaymentPreferences(prefs);

    if (!mounted) return;

    setState(() => _saving = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).paymentPrefsSavedInfo)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.paymentMethodsTitle)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.paymentMethodsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            l10n.paymentPreferencesInfo,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 12),

            DropdownMenu<String>(
              initialSelection: _paymentMethod,
              label: Text(l10n.preferredMethodLabel),
              dropdownMenuEntries: [
                DropdownMenuEntry(value: 'card', label: l10n.methodVisaMastercard),
                DropdownMenuEntry(value: 'mobile_money', label: l10n.methodMobileMoney),
                DropdownMenuEntry(value: 'paypal', label: l10n.methodPaypal),
                DropdownMenuEntry(value: 'apple_pay', label: l10n.methodApplePayGooglePay),
                DropdownMenuEntry(value: 'wechat_pay', label: l10n.methodWeChatPay),
                DropdownMenuEntry(value: 'alipay', label: l10n.methodAlipay),
                DropdownMenuEntry(value: 'unionpay', label: l10n.methodUnionPay),
              ],

              onSelected: (val) => setState(() => _paymentMethod = val!),
            ),

          const SizedBox(height: 12),

           
          // NEW: Conditional fields
          if (_paymentMethod == 'mobile_money') ...[
            TextField(
              decoration: InputDecoration(labelText: l10n.mobileMoneyNumberLabel, border: const OutlineInputBorder()),
            ),
          ] else if (_paymentMethod == 'wechat_pay' || _paymentMethod == 'alipay') ...[
            TextField(decoration: InputDecoration(labelText: l10n.wechatAlipayIdLabel, border: const OutlineInputBorder())),
          ],
          

          if (_paymentMethod == 'card') ...[
            TextField(
              controller: _cardLast4Controller,
              decoration: InputDecoration(
                labelText: l10n.cardLast4DigitsLabel,
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              maxLength: 4,
            ),
          ] else if (_paymentMethod == 'paypal') ...[
            TextField(
              controller: _paypalEmailController,
              decoration: InputDecoration(
                labelText: l10n.paypalEmailLabel,
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ] else if (_paymentMethod == 'apple_pay') ...[
            SwitchListTile(
              title: Text(l10n.applePayEnabledOnDevice),
              value: _applePayEnabled,
              onChanged: (val) {
                setState(() => _applePayEnabled = val);
              },
            ),
          ],

          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: _saving ? null : _savePrefs,
              child: _saving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(l10n.savePaymentPreferences),
            ),
          ),
        ],
      ),
    );
  }
}