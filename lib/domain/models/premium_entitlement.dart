class PremiumEntitlement {
  const PremiumEntitlement({required this.isPremium});

  final bool isPremium;

  static const free = PremiumEntitlement(isPremium: false);
  static const premium = PremiumEntitlement(isPremium: true);
}
