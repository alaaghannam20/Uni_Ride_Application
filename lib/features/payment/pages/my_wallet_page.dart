import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
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
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.greyDark),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.myWallet, style: AppStyle.paymentTitleStyle),
            Text(l10n.transactionHistory, style: AppStyle.paymentSubtitleStyle),
          ],
        ),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: _buildWalletBalanceCard(context, l10n),
            ),
            _buildSearchAndFilters(l10n),
            Container(
              color: AppColors.greyBackground,
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
              child: Column(
                children: [
                  _buildTransactionList(l10n),
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
  }

  Widget _buildWalletBalanceCard(BuildContext context, AppLocalizations l10n) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.orangeprimary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.orangeprimary.withOpacity(0.3),
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
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.account_balance_wallet_outlined,
                  color: Colors.white,
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
                  style: AppStyle.walletBalanceStyle.copyWith(fontSize: 24),
                ),
                TextSpan(
                  text: '245.50',
                  style: AppStyle.walletBalanceStyle,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          InkWell(
            onTap: () {
              // Handle Top up
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add, color: Colors.white, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    l10n.topUpWallet,
                    style: AppStyle.lablestyle.copyWith(
                      color: Colors.white,
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

  Widget _buildSearchAndFilters(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.greyBackground,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: AppColors.greyHint, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: l10n.searchTransactions,
                            hintStyle: AppStyle.accountQuestionStyle.copyWith(
                              color: AppColors.greyHint,
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
                  color: AppColors.greyBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.filter_alt_outlined, color: AppColors.greyDark, size: 20),
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
          color: isSelected ? AppColors.orangeprimary : AppColors.greyBackground,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: AppStyle.lablestyle.copyWith(
            fontSize: 14,
            color: isSelected ? Colors.white : AppColors.greySecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionList(AppLocalizations l10n) {
    // Dummy data based on the provided images
    final transactions = [
      TransactionTile(
        title: l10n.tripPayment,
        subtitle: "PTUK University → City Center",
        dateTime: "2026-04-11 • 14:30",
        amount: "-${l10n.ils}8",
        status: "completed",
        type: TransactionType.payment,
      ),
      TransactionTile(
        title: l10n.walletTopUp,
        subtitle: "Credit Card ****4532",
        dateTime: "2026-04-10 • 10:15",
        amount: "+${l10n.ils}100",
        status: "completed",
        type: TransactionType.topUp,
      ),
      TransactionTile(
        title: l10n.tripPayment,
        subtitle: "City Center → Rafidia Street",
        dateTime: "2026-04-10 • 09:45",
        amount: "-${l10n.ils}10",
        status: "completed",
        type: TransactionType.payment,
      ),
      TransactionTile(
        title: l10n.tripCancellationRefund,
        subtitle: "PTUK University → Main Square",
        dateTime: "2026-04-09 • 18:20",
        amount: "+${l10n.ils}8",
        status: "completed",
        type: TransactionType.refund,
      ),
    ];

    return Column(
      children: transactions,
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
          child: const Center(
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
            color: AppColors.greyHint,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
