class PremiumProduct {
  const PremiumProduct({
    required this.productId,
    required this.title,
    required this.description,
    required this.localizedPrice,
    required this.currencyCode,
  });

  final String productId;
  final String title;
  final String description;
  final String localizedPrice; // e.g. "₹499"
  final String currencyCode; // e.g. "INR"
}
