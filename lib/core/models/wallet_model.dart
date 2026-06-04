class WalletModel {
  final int walletId;
  final double balance;
  final List<TransactionModel> transactions;

  const WalletModel({
    required this.walletId,
    required this.balance,
    required this.transactions,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      walletId: (json['walletId'] ?? 0).toInt(),
      balance: (json['balance'] ?? 0).toDouble(),
      transactions: (json['transactions'] as List? ?? [])
          .map((e) => TransactionModel.fromJson(e))
          .toList(),
    );
  }
}

class TransactionModel {
  final String title;
  final String subTitle;
  final String type;
  final double amount;
  final String createdAt;
  final String status;

  const TransactionModel({
    required this.title,
    required this.subTitle,
    required this.type,
    required this.amount,
    required this.createdAt,
    required this.status,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      title: json['title'] ?? '',
      subTitle: json['subTitle'] ?? '',
      type: json['type'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      createdAt: json['createdAt'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
