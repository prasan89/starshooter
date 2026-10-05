import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:star_shooter/core/navigation/app_routes.dart';
import 'package:star_shooter/core/theme/app_colors.dart';
import 'package:star_shooter/core/theme/app_spacing.dart';
import 'package:star_shooter/core/theme/app_text_styles.dart';
import 'package:star_shooter/core/widgets/cosmic_button.dart';
import 'package:star_shooter/domain/models/level_progress.dart';
import 'package:star_shooter/features/galaxy/state/galaxy_map_notifier.dart';
import 'package:star_shooter/game/level/level_catalog.dart';

/// Full-screen victory overlay shown when the player completes a level.
///
/// Pushed on top of the gameplay screen via [Navigator.push] / GoRouter.
/// Animates: title fade-in, star reveal (elastic scale), score count-up,
/// buttons slide-up, and new-best badge fade-in.
class VictoryScreen extends StatefulWidget {
  const VictoryScreen({
    super.key,
    required this.levelId,
    required this.score,
    required this.shotsUsed,
    required this.comboLevel,
    required this.starsEarned,
    required this.isNewBest,
    required this.previousBestScore,
    required this.levelProgress,
  });

  final int levelId;
  final int score;
  final int shotsUsed;
  final int comboLevel;
  final int starsEarned;
  final bool isNewBest;
  final int previousBestScore;
  final LevelProgress levelProgress;

  @override
  State<VictoryScreen> createState() => _VictoryScreenState();
}

class _VictoryScreenState extends State<VictoryScreen>
    with TickerProviderStateMixin {
  // ── Star reveal ────────────────────────────────────────────────────────────
  final List<bool> _starRevealStates = [false, false, false];
  final List<AnimationController> _starControllers = [];
  final List<Animation<double>> _starScaleAnimations = [];

  // ── Title fade ────────────────────────────────────────────────────────────
  late AnimationController _titleController;
  late Animation<double> _titleOpacity;

  // ── Score count-up ────────────────────────────────────────────────────────
  late AnimationController _scoreController;
  late Animation<double> _scoreAnimation;

  // ── Buttons slide-up ──────────────────────────────────────────────────────
  late AnimationController _buttonsController;
  late Animation<double> _buttonsOpacity;
  late Animation<Offset> _buttonsSlide;

  // ── New Best badge fade ───────────────────────────────────────────────────
  late AnimationController _badgeController;
  late Animation<double> _badgeOpacity;

  // ── Derived state ─────────────────────────────────────────────────────────
  late final bool _hasNextLevel;

  @override
  void initState() {
    super.initState();

    final nextLevel = LevelCatalog.getLevelById(widget.levelId + 1);
    _hasNextLevel = nextLevel != null && (widget.levelId + 1) <= 50;

    // --- Title fade-in ---
    _titleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _titleOpacity = CurvedAnimation(
      parent: _titleController,
      curve: Curves.easeIn,
    );
    _titleController.forward();

    // --- Star elastic controllers (3 stars) ---
    for (int i = 0; i < 3; i++) {
      final ctrl = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
      );
      final scale = TweenSequence<double>([
        TweenSequenceItem(
          tween: Tween<double>(begin: 0.0, end: 1.2)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 70,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 1.2, end: 1.0)
              .chain(CurveTween(curve: Curves.elasticOut)),
          weight: 30,
        ),
      ]).animate(ctrl);
      _starControllers.add(ctrl);
      _starScaleAnimations.add(scale);
    }

    // --- Score count-up ---
    _scoreController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _scoreAnimation = CurvedAnimation(
      parent: _scoreController,
      curve: Curves.easeOut,
    );

    // --- Buttons ---
    _buttonsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _buttonsOpacity = CurvedAnimation(
      parent: _buttonsController,
      curve: Curves.easeIn,
    );
    _buttonsSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _buttonsController, curve: Curves.easeOut),
    );

    // --- New Best badge ---
    _badgeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _badgeOpacity = CurvedAnimation(
      parent: _badgeController,
      curve: Curves.easeIn,
    );

    _runSequence();
  }

  void _runSequence() {
    // t=300ms: Star 1
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      setState(() => _starRevealStates[0] = true);
      _starControllers[0].forward();
    });

    // t=600ms: Star 2 (only if earned)
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      if (widget.starsEarned >= 2) {
        setState(() => _starRevealStates[1] = true);
        _starControllers[1].forward();
      }
    });

    // t=900ms: Star 3 (only if earned); also reveal unearned stars
    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      if (widget.starsEarned >= 3) {
        setState(() => _starRevealStates[2] = true);
        _starControllers[2].forward();
      }
      // Unearned stars appear without animation at the same time as last earned
      for (int i = widget.starsEarned; i < 3; i++) {
        if (!_starRevealStates[i]) {
          setState(() => _starRevealStates[i] = true);
          // Jump to scale 1.0 immediately for unearned
          _starControllers[i].value = 1.0;
        }
      }
    });

    // t=1000ms: Score count-up starts
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (!mounted) return;
      _scoreController.forward();
    });

    // t=2200ms: Buttons animate in
    Future.delayed(const Duration(milliseconds: 2200), () {
      if (!mounted) return;
      _buttonsController.forward();
    });

    // t=2500ms: New Best badge (if applicable)
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (!mounted) return;
      if (widget.isNewBest) {
        _badgeController.forward();
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    for (final c in _starControllers) {
      c.dispose();
    }
    _scoreController.dispose();
    _buttonsController.dispose();
    _badgeController.dispose();
    super.dispose();
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  String _formatScore(int n) {
    // Insert commas: 12850 → "12,850"
    final s = n.toString();
    final buf = StringBuffer();
    final offset = s.length % 3;
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (i - offset) % 3 == 0) buf.write(',');
      buf.write(s[i]);
    }
    return buf.toString();
  }

  int get _displayScore => (_scoreAnimation.value * widget.score).round();

  // ── Navigation ─────────────────────────────────────────────────────────────

  void _goNextLevel(BuildContext ctx) {
    context.read<GalaxyMapNotifier>().refresh();
    ctx.pushReplacement(
      AppRoutes.gameplayPath((widget.levelId + 1).toString()),
    );
  }

  void _goGalaxyMap(BuildContext ctx) {
    context.read<GalaxyMapNotifier>().refresh();
    ctx.go(AppRoutes.galaxyMap);
  }

  void _goPlayAgain(BuildContext ctx) {
    ctx.pushReplacement(
      AppRoutes.gameplayPath(widget.levelId.toString()),
    );
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final levelDef = LevelCatalog.getLevelById(widget.levelId);
    final worldName = levelDef?.worldMeta?.worldName ?? '';
    final objective = levelDef?.objective;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Cosmic star field background
          const CustomPaint(painter: _StarFieldPainter()),

          // Radial glow behind the star row
          Positioned(
            top: 160,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.starFilled.withAlpha(20), // ~0.08 alpha
                      Colors.transparent,
                    ],
                    radius: 0.5,
                  ),
                ),
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.xl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ── Headline ──────────────────────────────────────────────
                  FadeTransition(
                    opacity: _titleOpacity,
                    child: Column(
                      children: [
                        Text(
                          'LEVEL COMPLETE',
                          style: AppTextStyles.displayLarge.copyWith(
                            color: AppColors.starFilled,
                            letterSpacing: 2,
                            shadows: [
                              Shadow(
                                color: AppColors.starFilled.withAlpha(120),
                                blurRadius: 16,
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          'Level ${widget.levelId}'
                          '${worldName.isNotEmpty ? ' · $worldName' : ''}',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  // ── Star row ──────────────────────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (i) {
                      final earned = i < widget.starsEarned;
                      final revealed = _starRevealStates[i];
                      if (!revealed) {
                        return const SizedBox(width: 64, height: 64);
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ScaleTransition(
                          scale: _starScaleAnimations[i],
                          child: _StarWidget(earned: earned),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  // ── Score ─────────────────────────────────────────────────
                  Column(
                    children: [
                      Text(
                        'SCORE',
                        style: AppTextStyles.labelLarge.copyWith(
                          color: AppColors.textSecondary,
                          letterSpacing: 3,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      AnimatedBuilder(
                        animation: _scoreAnimation,
                        builder: (_, __) {
                          return Text(
                            _formatScore(_displayScore),
                            style: AppTextStyles.displayLarge.copyWith(
                              fontSize: 40,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      // New Best badge
                      FadeTransition(
                        opacity: _badgeOpacity,
                        child: widget.isNewBest
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.md,
                                  vertical: AppSpacing.xs,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.starFilled.withAlpha(30),
                                  borderRadius: BorderRadius.circular(
                                    AppSpacing.radiusFull,
                                  ),
                                  border: Border.all(
                                    color: AppColors.starFilled.withAlpha(100),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  'NEW BEST!',
                                  style: AppTextStyles.labelLarge.copyWith(
                                    color: AppColors.starFilled,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  // ── Divider ───────────────────────────────────────────────
                  Container(
                    height: 1,
                    color: AppColors.surface,
                    margin: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xl,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  // ── Objective summary ─────────────────────────────────────
                  if (objective != null) ...[
                    _InfoRow(
                      label: 'Objective',
                      value: objective.displayText,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: AppColors.success,
                          size: 18,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          'Complete',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.success,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                  ],

                  // ── Stats ─────────────────────────────────────────────────
                  _InfoRow(
                    label: 'Shots remaining',
                    value: _shotsRemaining(levelDef?.moveLimit).toString(),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _InfoRow(
                    label: 'Best combo',
                    value: 'x${widget.comboLevel}',
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  // ── World Complete banner (when no next level) ─────────────
                  if (!_hasNextLevel) const _WorldCompleteBanner(),

                  const SizedBox(height: AppSpacing.md),

                  // ── Buttons ───────────────────────────────────────────────
                  SlideTransition(
                    position: _buttonsSlide,
                    child: FadeTransition(
                      opacity: _buttonsOpacity,
                      child: Column(
                        children: [
                          if (_hasNextLevel)
                            CosmicButton(
                              label: 'NEXT LEVEL',
                              icon: Icons.arrow_forward_rounded,
                              onPressed: () => _goNextLevel(context),
                            ),
                          if (_hasNextLevel)
                            const SizedBox(height: AppSpacing.sm),
                          CosmicButton(
                            label: 'GALAXY MAP',
                            icon: Icons.map_outlined,
                            variant: CosmicButtonVariant.secondary,
                            onPressed: () => _goGalaxyMap(context),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          CosmicButton(
                            label: 'PLAY AGAIN',
                            icon: Icons.replay_rounded,
                            variant: CosmicButtonVariant.secondary,
                            onPressed: () => _goPlayAgain(context),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  int _shotsRemaining(int? moveLimit) {
    if (moveLimit == null) return 0;
    return (moveLimit - widget.shotsUsed).clamp(0, moveLimit);
  }
}

// ── Private widgets ────────────────────────────────────────────────────────

class _StarWidget extends StatelessWidget {
  const _StarWidget({required this.earned});
  final bool earned;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: earned
          ? BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.starFilled.withAlpha(160),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            )
          : null,
      child: Icon(
        Icons.star_rounded,
        size: 56,
        color: earned ? AppColors.starFilled : AppColors.starEmpty,
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$label: ',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _WorldCompleteBanner extends StatelessWidget {
  const _WorldCompleteBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.starFilled.withAlpha(20),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(
          color: AppColors.starFilled.withAlpha(100),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.starFilled.withAlpha(40),
            blurRadius: 16,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'WORLD COMPLETE ✓',
            style: AppTextStyles.headlineLarge.copyWith(
              color: AppColors.starFilled,
              letterSpacing: 1.5,
              shadows: [
                Shadow(
                  color: AppColors.starFilled.withAlpha(120),
                  blurRadius: 12,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'All available levels completed!',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ── Star field background ──────────────────────────────────────────────────

/// Deterministic pseudo-random star field using an LCG.
///
/// Uses integer arithmetic only — no [dart:math] Random — so the output
/// is identical across platforms and doesn't change on rebuild.
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
