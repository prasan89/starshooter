import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:star_shooter/analytics/analytics_service.dart';
import 'package:star_shooter/core/theme/app_colors.dart';
import 'package:star_shooter/core/theme/app_spacing.dart';
import 'package:star_shooter/core/theme/app_text_styles.dart';
import 'package:star_shooter/core/widgets/cosmic_button.dart';
import 'package:star_shooter/core/widgets/cosmic_card.dart';
import 'package:star_shooter/data/billing/billing_notifier.dart';
import 'package:star_shooter/domain/models/premium_product.dart';

// ── Main screen ───────────────────────────────────────────────────────────────

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeCtrl;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fade = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<BillingNotifier>().initialize();
      context.read<AnalyticsService>().premiumScreenViewed();
      _fadeCtrl.forward();
    });
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final billing = context.watch<BillingNotifier>();
    return Scaffold(
      backgroundColor: AppColors.background,
      body: FadeTransition(
        opacity: _fade,
        child: Stack(
          fit: StackFit.expand,
          children: [
            const _CosmicBackground(),
            SafeArea(
              child: Column(
                children: [
                  _TopBar(),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                      ),
                      children: [
                        const SizedBox(height: AppSpacing.md),
                        const _PremiumHeader(),
                        const SizedBox(height: AppSpacing.xl),
                        const _BenefitsList(),
                        const SizedBox(height: AppSpacing.xl),
                        _PurchaseSection(billing: billing),
                        const SizedBox(height: AppSpacing.xxl),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Purchase section (state router) ──────────────────────────────────────────

class _PurchaseSection extends StatelessWidget {
  const _PurchaseSection({required this.billing});
  final BillingNotifier billing;

  @override
  Widget build(BuildContext context) {
    return switch (billing.uiState) {
      BillingUiState.loading => const _LoadingState(),
      BillingUiState.alreadyOwned => const _AlreadyOwnedState(),
      BillingUiState.success => const _SuccessState(),
      BillingUiState.restored => const _RestoredState(),
      BillingUiState.pending => const _PendingState(),
      BillingUiState.unavailable => _UnavailableState(
          message: billing.errorMessage,
          onRetry: () => billing.initialize(),
        ),
      BillingUiState.error => _ErrorState(
          message: billing.errorMessage,
          onRetry: () => billing.initialize(),
        ),
      BillingUiState.available => _AvailableState(
          product: billing.product!,
          onPurchase: () => billing.purchase(),
          onRestore: () => billing.restore(),
        ),
    };
  }
}

// ── State widgets ─────────────────────────────────────────────────────────────

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return CosmicCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: AppSpacing.md),
          const CircularProgressIndicator(
            color: AppColors.starFilled,
            strokeWidth: 2.5,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Loading Premium...',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}

class _AlreadyOwnedState extends StatelessWidget {
  const _AlreadyOwnedState();

  @override
  Widget build(BuildContext context) {
    return CosmicCard(
      glow: true,
      glowColor: AppColors.starFilled,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: AppSpacing.md),
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.shimmerBase,
              boxShadow: [
                BoxShadow(
                  color: AppColors.starFilled.withAlpha(100),
                  blurRadius: 24,
                  spreadRadius: 6,
                ),
              ],
            ),
            child: const Icon(
              Icons.workspace_premium_rounded,
              color: AppColors.starFilled,
              size: 36,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'PREMIUM ACTIVE',
            style: AppTextStyles.headlineMedium.copyWith(
              color: AppColors.starFilled,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'You already have unlimited gameplay.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}

class _SuccessState extends StatefulWidget {
  const _SuccessState();

  @override
  State<_SuccessState> createState() => _SuccessStateState();
}

class _SuccessStateState extends State<_SuccessState>
    with SingleTickerProviderStateMixin {
  late AnimationController _burstCtrl;
  late Animation<double> _burst;

  @override
  void initState() {
    super.initState();
    _burstCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _burst = CurvedAnimation(parent: _burstCtrl, curve: Curves.elasticOut);
    _burstCtrl.forward();
  }

  @override
  void dispose() {
    _burstCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CosmicCard(
      glow: true,
      glowColor: AppColors.starFilled,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _burst,
                child: const Icon(
                  Icons.star_rounded,
                  color: AppColors.starFilled,
                  size: 36,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              ScaleTransition(
                scale: _burst,
                child: const Icon(
                  Icons.star_rounded,
                  color: AppColors.starFilled,
                  size: 48,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              ScaleTransition(
                scale: _burst,
                child: const Icon(
                  Icons.star_rounded,
                  color: AppColors.starFilled,
                  size: 36,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'PREMIUM UNLOCKED',
            style: AppTextStyles.headlineMedium.copyWith(
              color: AppColors.starFilled,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Unlimited gameplay is now active.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}

class _RestoredState extends StatelessWidget {
  const _RestoredState();

  @override
  Widget build(BuildContext context) {
    return CosmicCard(
      glow: true,
      glowColor: AppColors.success,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: AppSpacing.md),
          const Icon(
            Icons.check_circle_rounded,
            color: AppColors.success,
            size: 48,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'PURCHASE RESTORED',
            style: AppTextStyles.headlineMedium.copyWith(
              color: AppColors.success,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Your premium access has been restored.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}

class _PendingState extends StatelessWidget {
  const _PendingState();

  @override
  Widget build(BuildContext context) {
    return const CosmicCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: AppSpacing.md),
          CircularProgressIndicator(
            color: AppColors.primary,
            strokeWidth: 2.5,
          ),
          SizedBox(height: AppSpacing.md),
          Text(
            'Purchase pending...',
            style: AppTextStyles.titleMedium,
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            'Google Play is processing your purchase.',
            style: AppTextStyles.bodySmall,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}

class _UnavailableState extends StatelessWidget {
  const _UnavailableState({this.message, required this.onRetry});
  final String? message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return CosmicCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: AppSpacing.md),
          Icon(
            Icons.warning_amber_rounded,
            color: AppColors.starFilled.withAlpha(200),
            size: 44,
          ),
          const SizedBox(height: AppSpacing.md),
          const Text(
            'Premium Unavailable',
            style: AppTextStyles.titleLarge,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            message ?? 'Please try again later.',
            style: AppTextStyles.bodySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          CosmicButton(
            label: 'Try Again',
            icon: Icons.refresh_rounded,
            onPressed: onRetry,
            variant: CosmicButtonVariant.secondary,
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({this.message, required this.onRetry});
  final String? message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return CosmicCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: AppSpacing.md),
          Icon(
            Icons.error_outline_rounded,
            color: AppColors.error.withAlpha(180),
            size: 44,
          ),
          const SizedBox(height: AppSpacing.md),
          const Text(
            'Something went wrong',
            style: AppTextStyles.titleLarge,
          ),
          const SizedBox(height: AppSpacing.sm),
          const Text(
            'We could not complete the request. Please try again.',
            style: AppTextStyles.bodySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: CosmicButton(
                  label: 'Return',
                  onPressed: () => context.pop(),
                  variant: CosmicButtonVariant.secondary,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: CosmicButton(
                  label: 'Try Again',
                  icon: Icons.refresh_rounded,
                  onPressed: onRetry,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}

class _AvailableState extends StatelessWidget {
  const _AvailableState({
    required this.product,
    required this.onPurchase,
    required this.onRestore,
  });
  final PremiumProduct product;
  final VoidCallback onPurchase;
  final VoidCallback onRestore;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Price card
        CosmicCard(
          glow: true,
          glowColor: AppColors.starFilled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.title, style: AppTextStyles.titleLarge),
              const SizedBox(height: AppSpacing.xs),
              Text(
                product.description,
                style: AppTextStyles.bodySmall,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                product.localizedPrice,
                style: AppTextStyles.displayMedium.copyWith(
                  color: AppColors.starFilled,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              const Text(
                'One-time purchase • No recurring fees',
                style: AppTextStyles.bodySmall,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        // Purchase button
        CosmicButton(
          label: 'UNLOCK FOR ${product.localizedPrice}',
          icon: Icons.bolt_rounded,
          onPressed: onPurchase,
        ),
        const SizedBox(height: AppSpacing.md),
        // Restore link
        Center(
          child: TextButton(
            onPressed: onRestore,
            child: Text(
              'Already purchased? Restore',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Background, top bar, header, benefits ─────────────────────────────────────

class _CosmicBackground extends StatelessWidget {
  const _CosmicBackground();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.deepBackground,
            AppColors.background,
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: IconButton(
          icon: const Icon(Icons.close_rounded),
          color: AppColors.textSecondary,
          onPressed: () => context.pop(),
          tooltip: 'Close',
        ),
      ),
    );
  }
}

class _PremiumHeader extends StatelessWidget {
  const _PremiumHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.shimmerBase,
            boxShadow: [
              BoxShadow(
                color: AppColors.starFilled.withAlpha(80),
                blurRadius: 24,
                spreadRadius: 4,
              ),
            ],
          ),
          child: const Icon(
            Icons.workspace_premium_rounded,
            color: AppColors.starFilled,
            size: 44,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.starFilled, AppColors.world4GradientEnd],
          ).createShader(bounds),
          child: Text(
            'STAR SHOOTER\nPREMIUM',
            textAlign: TextAlign.center,
            style: AppTextStyles.displayMedium.copyWith(
              color: Colors.white,
              letterSpacing: 2,
              height: 1.1,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Unlock the full cosmic experience',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _BenefitsList extends StatelessWidget {
  const _BenefitsList();

  static const _benefits = [
    (
      Icons.all_inclusive_rounded,
      'Unlimited Attempts',
      'Play as many levels as you want, any time.',
    ),
    (
      Icons.hourglass_disabled_rounded,
      'No Daily Limits',
      'Never wait for a daily refill — always keep playing.',
    ),
    (
      Icons.block_rounded,
      'No Ads',
      'Enjoy a completely ad-free experience.',
    ),
    (
      Icons.rocket_launch_rounded,
      'Future Premium Content',
      'Be the first to access new worlds and features.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: _benefits
          .map(
            (b) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _BenefitRow(
                icon: b.$1,
                title: b.$2,
                subtitle: b.$3,
              ),
            ),
          )
          .toList(),
    );
  }
}

class _BenefitRow extends StatelessWidget {
  const _BenefitRow({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return CosmicCard(
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppColors.buttonGradientStart,
                  AppColors.buttonGradientEnd,
                ],
              ),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.titleMedium),
                const SizedBox(height: 2),
                Text(subtitle, style: AppTextStyles.bodySmall),
              ],
            ),
          ),
          const Icon(
            Icons.check_circle_rounded,
            color: AppColors.success,
            size: 20,
          ),
        ],
      ),
    );
  }
}
