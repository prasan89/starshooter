import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:star_shooter/core/navigation/app_routes.dart';
import 'package:star_shooter/core/theme/app_colors.dart';
import 'package:star_shooter/core/theme/app_spacing.dart';
import 'package:star_shooter/core/theme/app_text_styles.dart';
import 'package:star_shooter/core/widgets/cosmic_button.dart';
import 'package:star_shooter/core/widgets/cosmic_card.dart';

/// Full-screen "Daily Mission Complete" screen shown when the player has
/// used all their free daily plays.
///
/// NOT an aggressive paywall — it fits the game's cosmic aesthetic and
/// presents the premium upgrade as a feature announcement.
class DailyLimitScreen extends StatefulWidget {
  const DailyLimitScreen({super.key, required this.dailyLimit});

  final int dailyLimit;

  @override
  State<DailyLimitScreen> createState() => _DailyLimitScreenState();
}

class _DailyLimitScreenState extends State<DailyLimitScreen>
    with TickerProviderStateMixin {
  // ── Entrance animations ────────────────────────────────────────────────────

  late AnimationController _fadeController;
  late Animation<double> _fadeOpacity;

  late AnimationController _titleController;
  late Animation<double> _titleScale;

  late AnimationController _contentController;
  late Animation<Offset> _contentSlide;
  late Animation<double> _contentOpacity;

  // ── Static computed values ─────────────────────────────────────────────────

  late final String _resetLabel;

  @override
  void initState() {
    super.initState();

    // Compute reset label once — no live timer.
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day + 1);
    final remaining = midnight.difference(now);
    if (remaining.inHours > 0) {
      _resetLabel = 'Resets in ${remaining.inHours}h';
    } else {
      _resetLabel = 'Resets soon';
    }

    // --- Full-screen fade in ---
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeOpacity = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    // --- Title scale ---
    _titleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _titleScale = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _titleController, curve: Curves.easeOut),
    );

    // --- Content slide up ---
    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _contentSlide = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeOut),
    );
    _contentOpacity = CurvedAnimation(
      parent: _contentController,
      curve: Curves.easeIn,
    );

    // Kick off all animations together.
    _fadeController.forward();
    _titleController.forward();
    _contentController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  // ── Navigation ─────────────────────────────────────────────────────────────

  void _goGalaxyMap() => context.go(AppRoutes.galaxyMap);

  void _goPremium() => context.go(AppRoutes.premium);

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          context.go(AppRoutes.galaxyMap);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: FadeTransition(
          opacity: _fadeOpacity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Cosmic star field background
              const CustomPaint(painter: _StarFieldPainter()),

              // Subtle purple radial tint — adds depth without being busy
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.topCenter,
                      radius: 1.2,
                      colors: [
                        const Color(0xFF3B1D8A).withAlpha(40),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              // Main scrollable content
              SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.xl,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ── Title ──────────────────────────────────────────────
                      ScaleTransition(
                        scale: _titleScale,
                        child: Column(
                          children: [
                            Text(
                              'DAILY MISSION',
                              style: AppTextStyles.displayMedium.copyWith(
                                color: AppColors.starFilled,
                                letterSpacing: 3,
                                shadows: [
                                  Shadow(
                                    color: AppColors.starFilled.withAlpha(140),
                                    blurRadius: 20,
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'COMPLETE',
                              style: AppTextStyles.displayLarge.copyWith(
                                color: AppColors.starFilled,
                                letterSpacing: 4,
                                fontWeight: FontWeight.w800,
                                shadows: [
                                  Shadow(
                                    color: AppColors.starFilled.withAlpha(160),
                                    blurRadius: 24,
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppSpacing.lg),

                      // ── Subtitle ───────────────────────────────────────────
                      SlideTransition(
                        position: _contentSlide,
                        child: FadeTransition(
                          opacity: _contentOpacity,
                          child: Column(
                            children: [
                              Text(
                                "You've used all ${widget.dailyLimit} free plays\nfor today.",
                                style: AppTextStyles.bodyLarge.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                                textAlign: TextAlign.center,
                              ),

                              const SizedBox(height: AppSpacing.lg),

                              // ── Attempt indicator card ─────────────────────
                              CosmicCard(
                                borderColor: AppColors.starFilled.withAlpha(60),
                                backgroundColor: AppColors.surface,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.lg,
                                  vertical: AppSpacing.md,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ...List.generate(widget.dailyLimit,
                                            (i) {
                                          return const Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 3,
                                            ),
                                            child: Icon(
                                              Icons.bolt_rounded,
                                              color: AppColors.starFilled,
                                              size: 28,
                                            ),
                                          );
                                        }),
                                        const SizedBox(width: AppSpacing.sm),
                                        Text(
                                          '${widget.dailyLimit} / ${widget.dailyLimit}',
                                          style: AppTextStyles.titleMedium
                                              .copyWith(
                                            color: AppColors.starFilled,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: AppSpacing.sm),
                                    Text(
                                      'Come back tomorrow for ${widget.dailyLimit} more plays',
                                      style: AppTextStyles.bodyMedium.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: AppSpacing.xs),
                                    Text(
                                      _resetLabel,
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color: AppColors.textDisabled,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: AppSpacing.xl),

                              // ── Divider ────────────────────────────────────
                              Container(
                                height: 1,
                                color: AppColors.shimmerBase,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.xl,
                                ),
                              ),

                              const SizedBox(height: AppSpacing.xl),

                              // ── Premium feature section ────────────────────
                              const _PremiumSection(),

                              const SizedBox(height: AppSpacing.xl),

                              // ── Action buttons ─────────────────────────────
                              CosmicButton(
                                label: 'VIEW PREMIUM',
                                icon: Icons.bolt_rounded,
                                variant: CosmicButtonVariant.secondary,
                                onPressed: _goPremium,
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              CosmicButton(
                                label: 'RETURN TO GALAXY',
                                icon: Icons.map_outlined,
                                variant: CosmicButtonVariant.text,
                                onPressed: _goGalaxyMap,
                              ),

                              const SizedBox(height: AppSpacing.xl),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Premium feature section ────────────────────────────────────────────────

/// Presents the premium upgrade as a feature announcement, not a pushy ad.
class _PremiumSection extends StatelessWidget {
  const _PremiumSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.auto_awesome_rounded,
              color: AppColors.secondary,
              size: 20,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'UNLIMITED PLAY',
              style: AppTextStyles.headlineMedium.copyWith(
                color: AppColors.secondary,
                letterSpacing: 2,
                shadows: [
                  Shadow(
                    color: AppColors.secondary.withAlpha(100),
                    blurRadius: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Play without daily limits.\nStar power, always on.',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// ── Star field background ──────────────────────────────────────────────────

/// Deterministic 60-dot star field — identical to the one in [VictoryScreen].
///
/// Uses integer LCG arithmetic (no [dart:math] Random) so the layout is
/// stable across rebuilds and platforms.
class _StarFieldPainter extends CustomPainter {
  const _StarFieldPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFFFFFFFF).withAlpha(100);

    int state = 0xDEADBEEF;

    int next() {
      state = (state * 1664525 + 1013904223) & 0xFFFFFFFF;
      return state;
    }

    double nf() => (next() & 0xFFFF) / 65535.0;

    for (int i = 0; i < 60; i++) {
      final x = nf() * size.width;
      final y = nf() * size.height;
      final radius = i % 3 == 0 ? 1.5 : 0.8;
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(_StarFieldPainter oldDelegate) => false;
}
