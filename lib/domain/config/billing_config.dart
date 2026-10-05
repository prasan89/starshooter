class BillingConfig {
  const BillingConfig({
    this.premiumProductId = 'star_shooter_premium_lifetime',
  });

  final String premiumProductId;

  static const defaultConfig = BillingConfig();
}
