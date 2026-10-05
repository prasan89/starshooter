enum PurchaseStatus {
  purchased, // valid, owned
  pending, // payment processing
  cancelled, // user cancelled
  error, // something went wrong
  restored, // purchase recovered
}

class PurchaseResult {
  const PurchaseResult({
    required this.status,
    this.productId,
    this.errorMessage,
  });

  final PurchaseStatus status;
  final String? productId;
  final String? errorMessage;

  bool get isOwned =>
      status == PurchaseStatus.purchased || status == PurchaseStatus.restored;
}
