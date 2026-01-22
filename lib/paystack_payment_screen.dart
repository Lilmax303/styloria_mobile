// lib/paystack_payment_screen.dart

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'api_client.dart';
import 'gen_l10n/app_localizations.dart';

class PaystackPaymentScreen extends StatefulWidget {
  final int bookingId;
  final double amount;
  final String currency;
  final String? description;

  const PaystackPaymentScreen({
    super.key,
    required this.bookingId,
    required this.amount,
    required this.currency,
    this.description,
  });

  @override
  State<PaystackPaymentScreen> createState() => _PaystackPaymentScreenState();
}

class _PaystackPaymentScreenState extends State<PaystackPaymentScreen> {
  bool _loading = true;
  String? _error;
  String? _authorizationUrl;
  String? _reference;
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _initializePayment();
  }

  Future<void> _initializePayment() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final result = await ApiClient.createPaystackCheckout(
        serviceRequestId: widget.bookingId,
        amount: widget.amount,
      );

      if (result == null) {
        setState(() {
          _error = 'Failed to initialize payment. Please try again.';
          _loading = false;
        });
        return;
      }

      if (result['authorization_url'] != null) {
        setState(() {
          _authorizationUrl = result['authorization_url'] as String;
          _reference = result['reference'] as String?;
          _loading = false;
        });
        _setupWebView();
      } else {
        setState(() {
          _error = result['detail']?.toString() ?? 'Payment initialization failed';
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
        _loading = false;
      });
    }
  }

  void _setupWebView() {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            debugPrint('Paystack page started: $url');
          },
          onPageFinished: (url) {
            debugPrint('Paystack page finished: $url');
          },
          onNavigationRequest: (request) {
            final url = request.url;
            debugPrint('Paystack navigation: $url');

            // Check for callback URL or deep link
            if (url.contains('styloria://') || 
                url.contains('payment-return') ||
                url.contains('/paystack/callback')) {
              _handlePaymentCallback(url);
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
          onWebResourceError: (error) {
            debugPrint('Paystack WebView error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(_authorizationUrl!));
  }

  Future<void> _handlePaymentCallback(String url) async {
    setState(() => _loading = true);

    // Extract reference from URL
    final uri = Uri.parse(url);
    final reference = uri.queryParameters['reference'] ?? 
                      uri.queryParameters['trxref'] ?? 
                      _reference;

    if (reference == null || reference.isEmpty) {
      setState(() {
        _error = 'Payment reference not found';
        _loading = false;
      });
      return;
    }

    // Verify with backend
    final result = await ApiClient.verifyPaystackPayment(reference: reference);

    if (!mounted) return;

    if (result != null && result['verified'] == true) {
      _showSuccessAndClose();
    } else {
      setState(() {
        _error = result?['detail']?.toString() ?? 'Payment verification failed';
        _loading = false;
      });
    }
  }

  void _handlePaymentCancelled() {
    Navigator.of(context).pop({'success': false, 'cancelled': true});
  }

  void _showSuccessAndClose() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check_circle, color: Colors.green.shade600, size: 28),
            ),
            const SizedBox(width: 12),
            const Text('Payment Successful'),
          ],
        ),
        content: Text(
          'Your payment of ${widget.currency} ${widget.amount.toStringAsFixed(2)} was successful.',
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop({'success': true, 'reference': _reference}); // Close screen
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay ${widget.currency} ${widget.amount.toStringAsFixed(2)}'),
        backgroundColor: Colors.green.shade600,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => _showCancelDialog(),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                shape: BoxShape.circle,
              ),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade600),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              _authorizationUrl == null ? 'Initializing payment...' : 'Verifying payment...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.error_outline, size: 48, color: Colors.red.shade600),
              ),
              const SizedBox(height: 24),
              Text(
                'Payment Error',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                _error!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: _initializePayment,
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.of(context).pop({'success': false}),
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
      );
    }

    if (_authorizationUrl != null) {
      return WebViewWidget(controller: _webViewController);
    }

    return const Center(child: Text('Unable to load payment page'));
  }

  void _showCancelDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Cancel Payment?'),
        content: const Text('Are you sure you want to cancel this payment?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('No, Continue'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop({'success': false, 'cancelled': true});
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }
}