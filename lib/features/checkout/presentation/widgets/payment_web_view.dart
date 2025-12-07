import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/common/widgets/custom_snackbar_widget.dart';
import '../../../../core/l10n/translation/app_localizations.dart';
import '../../../../core/routes/route_names.dart';

class PaymentWebViewScreen extends StatefulWidget {
  final String url;
  const PaymentWebViewScreen({super.key, required this.url});

  @override
  State<PaymentWebViewScreen> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            if (url.contains("allOrders")) {
              _handlePaymentSuccess();
            } else if (url.contains("failed") || url.contains("cancel")) {
              _handlePaymentFailure();
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  void _handlePaymentSuccess() {
    showCustomSnackBar(context, "Payment successful", isError: false);
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.thanksPage, (route) => false);
  }

  void _handlePaymentFailure() {
    showCustomSnackBar(context, "Payment failed", isError: true);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(local.completePayment)),
      body: WebViewWidget(controller: _controller),
    );
  }
}
