import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/provider/payment_provider.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class TopUpConfirmedScreen extends StatefulWidget {
  final String sessionId;
  const TopUpConfirmedScreen({super.key, required this.sessionId});

  @override
  State<TopUpConfirmedScreen> createState() => _TopUpConfirmedScreenState();
}

class _TopUpConfirmedScreenState extends State<TopUpConfirmedScreen> {
  bool _isLoading = true;
  bool _success = false;
  double _newBalance = 0.0;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _confirm();
  }

  Future<void> _confirm() async {
    try {
      final provider = context.read<PaymentProvider>();
      final success = await provider.confirmTopUp(widget.sessionId);
      if (mounted) {
        setState(() {
          _success    = success;
          _newBalance = provider.wallet?.balance ?? 0.0;
          _error      = success ? '' : provider.errorMessage;
          _isLoading  = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error     = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(color: AppColors.orangeprimary),
              const SizedBox(height: 20),
              Text(l.confirmingPayment, style: TextStyle(color: context.textSecondary)),
            ],
          ),
        ),
      );
    }

    if (!_success) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 64),
              const SizedBox(height: 16),
              Text(l.confirmationFailed, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(_error, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l.goBack),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: context.bgWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: AppColors.adminSuccessBG,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle_outline, color: AppColors.adminSuccessText, size: 40),
            ),
            const SizedBox(height: 24),
            Text(
              l.topUpSuccess,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: context.textPrimary),
            ),
            const SizedBox(height: 8),
            Text(
              l.walletHasBeenCharged,
              style: TextStyle(fontSize: 14, color: context.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.walletCardBg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.amberWarningBg, width: 1.5),
              ),
              child: Column(
                children: [
                  Text(
                    l.currentBalance,
                    style: TextStyle(fontSize: 13, color: context.textSecondary),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${l.ils}${_newBalance.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.orangeprimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: ElevatedButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.myWallet,
              (r) => r.settings.name == Routes.home,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.orangeprimary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            child: Text(l.backToWallet, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
