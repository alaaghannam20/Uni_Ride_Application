class CheckoutSessionModel {
  final String sessionId;
  final String checkoutUrl;

  const CheckoutSessionModel({
    required this.sessionId,
    required this.checkoutUrl,
  });

  factory CheckoutSessionModel.fromJson(Map<String, dynamic> json) {
    return CheckoutSessionModel(
      sessionId: json['sessionId'] ?? '',
      checkoutUrl: json['checkoutUrl'] ?? '',
    );
  }
}
