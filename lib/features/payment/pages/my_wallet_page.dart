import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uni_ride_application/core/provider/payment_provider.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/features/payment/widgets/transaction_tile.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class MyWalletPage extends StatefulWidget {
  const MyWalletPage({super.key});

  @override
  State<MyWalletPage> createState() => _MyWalletPageState();
}

class _MyWalletPageState extends State<MyWalletPage> {
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PaymentProvider>().fetchWalletBalance();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: context.bgColor,
      appBar: AppBar(
        backgroundColor: context.appBarBg,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: context.textPrimary),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.myWallet, style: AppStyle.paymentTitle(context)),
            Text(l10n.transactionHistory, style: AppStyle.paymentSubtitle(context)),
          ],
        ),
        titleSpacing: 0,
      ),
      body: Consumer<PaymentProvider>(
        builder: (context, provider, _) {
          if (provider.walletState == PaymentState.loading && provider.wallet == null) {
            return const Center(child: CircularProgressIndicator(color: AppColors.orangeprimary));
          }

          if (provider.walletState == PaymentState.error && provider.wallet == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(provider.errorMessage, style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => provider.fetchWalletBalance(),
                    child: Text(AppLocalizations.of(context)!.retry),
                  ),
                ],
              ),
            );
          }

          final wallet = provider.wallet;

          return RefreshIndicator(
            onRefresh: () => provider.fetchWalletBalance(),
            color: AppColors.orangeprimary,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: _buildWalletBalanceCard(context, l10n, wallet?.balance ?? 0.0),
                  ),
                  _buildSearchAndFilters(l10n),
                  Container(
                    color: context.bgColor,
                    constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.5),
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                    child: Column(
                      children: [
                        _buildTransactionList(l10n, provider),
                        const SizedBox(height: 32),
                        _buildPoweredBy(l10n),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWalletBalanceCard(BuildContext context, AppLocalizations l10n, double balance) {
    const textColor = Colors.white;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.orangeprimary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.orangeprimary.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.currentBalance,
                style: AppStyle.accountQuestionStyle.copyWith(
                  color: textColor.withValues(alpha: 0.9),
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: textColor.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.account_balance_wallet_outlined,
                  color: textColor,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: l10n.ils,
                  style: AppStyle.walletBalanceStyle.copyWith(fontSize: 24, color: textColor),
                ),
                TextSpan(
                  text: balance.toStringAsFixed(2),
                  style: AppStyle.walletBalanceStyle.copyWith(color: textColor),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          InkWell(
            onTap: () {
              _showTopUpDialog(context);
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: textColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: textColor, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    l10n.topUpWallet,
                    style: AppStyle.lablestyle.copyWith(
                      color: textColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showTopUpDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.bgCard,
        title: Text(AppLocalizations.of(context)!.topUpWallet, style: TextStyle(color: context.textPrimary)),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: TextStyle(color: context.textPrimary),
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.enterAmountILS,
            hintStyle: TextStyle(color: context.textHint),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(AppLocalizations.of(context)!.cancel, style: TextStyle(color: context.textSecondary))),
          ElevatedButton(
            onPressed: () async {
              final amount = double.tryParse(controller.text);
              if (amount != null && amount > 0) {
                Navigator.pop(ctx);
                final paymentProvider = context.read<PaymentProvider>();
                final session = await paymentProvider.startTopUp(amount: amount);
                if (!context.mounted) return;
                if (session == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(paymentProvider.errorMessage), backgroundColor: Colors.red),
                  );
                  return;
                }
                final uri = Uri.parse(session.checkoutUrl);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                } else if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Could not open payment page'), backgroundColor: Colors.red),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.orangeprimary),
            child: Text(AppLocalizations.of(context)!.topUpAction, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters(AppLocalizations l10n) {
    return Container(
      decoration: BoxDecoration(
        color: context.bgSubtle,
        border: Border(
          top: BorderSide(color: context.borderColor, width: 0.61),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: context.bgSubtle,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: context.borderColor, width: 0.61),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: context.textHint, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: l10n.searchTransactions,
                            hintStyle: AppStyle.accountQuestionStyle.copyWith(
                              color: context.textHint,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  color: context.bgSubtle,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: context.borderColor, width: 0.61),
                ),
                child: Icon(Icons.filter_alt_outlined, color: context.textPrimary, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildTab(l10n.allTabs, 0),
                _buildTab(l10n.paymentsTabs, 1),
                _buildTab(l10n.refundsTabs, 2),
                _buildTab(l10n.topUpsTabs, 3),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    final isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() => _selectedTabIndex = index);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.orangeprimary : context.bgSubtle,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: AppStyle.lablestyle.copyWith(
            fontSize: 14,
            color: isSelected ? Colors.white : context.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionList(AppLocalizations l10n, PaymentProvider provider) {
    final wallet = provider.wallet;
    if (wallet == null || wallet.transactions.isEmpty) {
      return Center(child: Text(l10n.noTripsFound)); // Reusing localization or use a generic one
    }

    // Filter transactions based on tab
    final filtered = wallet.transactions.where((t) {
      if (_selectedTabIndex == 1) return t.type == 'Payment';
      if (_selectedTabIndex == 2) return t.type == 'Refund';
      if (_selectedTabIndex == 3) return t.type == 'Recharge';
      return true;
    }).toList();

    return Column(
      children: filtered.map((t) {
        TransactionType type;
        if (t.type == 'Payment') {
          type = TransactionType.payment;
        } else if (t.type == 'Recharge') {
          type = TransactionType.topUp;
        } else {
          type = TransactionType.refund;
        }

        return TransactionTile(
          title: t.title,
          subtitle: t.subTitle,
          dateTime: t.createdAt.split('T').first, // Simple format for now
          amount: '${t.amount > 0 ? "+" : ""}${l10n.ils}${t.amount.abs().toStringAsFixed(2)}',
          status: t.status.toLowerCase(),
          type: type,
        );
      }).toList(),
    );
  }

  Widget _buildPoweredBy(AppLocalizations l10n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: AppColors.orangeprimary,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              "P",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          "${l10n.poweredBy} ${l10n.ptukEngineering}",
          style: AppStyle.accountQuestionStyle.copyWith(
            color: context.textHint,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
