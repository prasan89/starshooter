import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:star_shooter/core/navigation/app_routes.dart';
import 'package:star_shooter/core/theme/app_colors.dart';
import 'package:star_shooter/core/theme/app_spacing.dart';
import 'package:star_shooter/core/theme/app_text_styles.dart';
import 'package:star_shooter/core/widgets/cosmic_button.dart';
import 'package:star_shooter/game/level/level_catalog.dart';
import 'package:star_shooter/game/level/level_objective.dart';

/// Full-screen failure overlay shown when the player runs out of moves without
/// meeting the level objective.
///
/// Encouraging in tone — shows the player how close they came and invites a
/// retry.  Animates: slide-in from bottom (400 ms), title/content fade-in
/// (200 ms delay), buttons fade-in (600 ms delay).
class FailureScreen extends StatefulWidget {
  const FailureScreen({
    super.key,
    required this.levelId,
    required this.score,
    required this.objectiveProgress,
    required this.objectiveTarget,
    required this.objectiveDescription,
    required this.bestScore,
    required this.shotsUsed,
  });

  final int levelId;
  final int score;
  final int objectiveProgress;
  final int objectiveTarget;
  final String objectiveDescription;
  final int bestScore;
  final int shotsUsed;

  @override
  State<FailureScreen> createState() => _FailureScreenState();
}

class _FailureScreenState extends State<FailureScreen>
    with TickerProviderStateMixin {
  // ── Screen slide-in ───────────────────────────────────────────────────────
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  // ── Title / content fade ──────────────────────────────────────────────────
  late AnimationController _contentController;
  late Animation<double> _contentOpacity;

  // ── Buttons fade ──────────────────────────────────────────────────────────
  late AnimationController _buttonsController;
  late Animation<double> _buttonsOpacity;
  late Animation<Offset> _buttonsSlide;

  @override
  void initState() {
    super.initState();

    // Screen slides in from slightly below
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOut),
    );

    // Title and content fade-in
    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _contentOpacity = CurvedAnimation(
      parent: _contentController,
      curve: Curves.easeIn,
    );

    // Buttons appear last
    _buttonsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
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

    _runSequence();
  }

  void _runSequence() {
    // t=0: screen slides in
    _slideController.forward();

    // t=200ms: title and content fade in
    Future.delayed(const Duration(milliseconds: 200), () {
      if (!mounted) return;
      _contentController.forward();
    });

    // t=600ms: buttons appear
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      _buttonsController.forward();
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    _contentController.dispose();
    _buttonsController.dispose();
    super.dispose();
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  String _fmt(int n) {
    final s = n.toString();
    final buf = StringBuffer();
    final offset = s.length % 3;
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (i - offset) % 3 == 0) buf.write(',');
      buf.write(s[i]);
    }
    return buf.toString();
  }

  /// Human-readable reason string derived from the objective type.
  String _failureReason(LevelObjective? objective) {
    if (objective == null) return '';
    switch (objective.type) {
      case ObjectiveType.scoreTarget:
        return 'Needed ${_fmt(widget.objectiveTarget)} pts'
            ' — reached ${_fmt(widget.objectiveProgress)}';
      case ObjectiveType.clearStars:
        return '${widget.objectiveTarget} stars needed'
            ' — ${widget.objectiveProgress} cleared';
      case ObjectiveType.clearStarType:
        return '${widget.objectiveTarget} special stars needed'
            ' — ${widget.objectiveProgress} cleared';
      case ObjectiveType.clearSpecial:
        return '${widget.objectiveTarget} obstacles needed'
            ' — ${widget.objectiveProgress} cleared';
    }
  }

  // ── Navigation ─────────────────────────────────────────────────────────────

  void _retry() {
    context.pushReplacement(
      AppRoutes.gameplayPath(widget.levelId.toString()),
    );
  }

  void _goGalaxyMap() {
    context.go(AppRoutes.galaxyMap);
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final levelDef = LevelCatalog.getLevelById(widget.levelId);
    final worldName = levelDef?.worldMeta?.worldName ?? '';
    final objective = levelDef?.objective;

    final progressFraction = widget.objectiveTarget > 0
        ? (widget.objectiveProgress / widget.objectiveTarget).clamp(0.0, 1.0)
        : 0.0;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Cooler deep-space background with red/purple tint
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 0.9,
                colors: [
                  Color(0xFF1A0A1A), // red-purple tint at center
                  Color(0xFF0A0E1A), // deep space at edges
                ],
              ),
            ),
          ),

          // Cosmic star field
          const CustomPaint(painter: _StarFieldPainter()),

          // Dim red ambient glow behind content
          Positioned(
            top: 140,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 360,
                height: 360,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.error.withAlpha(18),
                      Colors.transparent,
                    ],
                    radius: 0.5,
                  ),
                ),
              ),
            ),
          ),

          // Main scrollable content
          SafeArea(
            child: SlideTransition(
              position: _slideAnimation,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.xl,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ── Headline ────────────────────────────────────────────
                    FadeTransition(
                      opacity: _contentOpacity,
                      child: Column(
                        children: [
                          Text(
                            'LEVEL FAILED',
                            style: AppTextStyles.displayLarge.copyWith(
                              color: AppColors.error,
                              letterSpacing: 2,
                              shadows: [
                                Shadow(
                                  color: AppColors.error.withAlpha(120),
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

                    // ── Objective section ───────────────────────────────────
                    FadeTransition(
                      opacity: _contentOpacity,
                      child: _SectionCard(
                        children: [
                          const _SectionLabel(label: 'OBJECTIVE'),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            widget.objectiveDescription,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textPrimary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: AppSpacing.sm),

                          // Progress bar with label
                          Row(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    AppSpacing.radiusFull,
                                  ),
                                  child: LinearProgressIndicator(
                                    value: progressFraction,
                                    backgroundColor:
                                        AppColors.error.withAlpha(30),
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                      AppColors.error,
                                    ),
                                    minHeight: 8,
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Text(
                                '${widget.objectiveProgress} / ${widget.objectiveTarget}',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.error,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: AppSpacing.sm),

                          // Failure reason
                          if (_failureReason(objective).isNotEmpty)
                            Text(
                              _failureReason(objective),
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.md),

                    // ── Divider ─────────────────────────────────────────────
                    FadeTransition(
                      opacity: _contentOpacity,
                      child: Container(
                        height: 1,
                        color: AppColors.surface,
                        margin: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xl,
                        ),
                      ),
                    ),

                    const SizedBox(height: AppSpacing.md),

                    // ── Score / Best ────────────────────────────────────────
                    FadeTransition(
                      opacity: _contentOpacity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _ScoreTile(
                            label: 'SCORE',
                            value: _fmt(widget.score),
                          ),
                          const SizedBox(width: AppSpacing.xl),
                          _ScoreTile(
                            label: 'BEST',
                            value: widget.bestScore > 0
                                ? _fmt(widget.bestScore)
                                : '—',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    // ── Encouragement banner ────────────────────────────────
                    FadeTransition(
                      opacity: _contentOpacity,
                      child: _EncouragementBanner(
                        progress: progressFraction,
                      ),
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    // ── Buttons ─────────────────────────────────────────────
                    SlideTransition(
                      position: _buttonsSlide,
                      child: FadeTransition(
                        opacity: _buttonsOpacity,
                        child: Column(
                          children: [
                            CosmicButton(
                              label: 'RETRY',
                              icon: Icons.replay_rounded,
                              onPressed: _retry,
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            CosmicButton(
                              label: 'GALAXY MAP',
                              icon: Icons.map_outlined,
                              variant: CosmicButtonVariant.secondary,
                              onPressed: _goGalaxyMap,
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
          ),
        ],
      ),
    );
  }
}

// ── Private widgets ────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTextStyles.labelLarge.copyWith(
        color: AppColors.textSecondary,
        letterSpacing: 3,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(
          color: AppColors.error.withAlpha(40),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}

class _ScoreTile extends StatelessWidget {
  const _ScoreTile({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: AppTextStyles.labelLarge.copyWith(
            color: AppColors.textSecondary,
            letterSpacing: 3,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          value,
          style: AppTextStyles.displayLarge.copyWith(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

/// Shows an encouraging message based on how far the player progressed.
class _EncouragementBanner extends StatelessWidget {
  const _EncouragementBanner({required this.progress});
  final double progress; // 0.0 – 1.0

  @override
  Widget build(BuildContext context) {
    final String message;
    if (progress >= 0.9) {
      message = 'So close! One more try and you have it.';
    } else if (progress >= 0.6) {
      message = 'Good effort — you\'re getting there!';
    } else if (progress >= 0.3) {
      message = 'Keep going — every attempt builds skill.';
    } else {
      message = 'The stars await — give it another shot!';
    }

    return Text(
      message,
      style: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.textSecondary,
        fontStyle: FontStyle.italic,
      ),
      textAlign: TextAlign.center,
    );
  }
}

// ── Star field background ──────────────────────────────────────────────────

/// Deterministic pseudo-random star field using an LCG.
///
/// Uses integer arithmetic only — no [dart:math] Random — so the output is
/// identical across platforms and doesn't change on rebuild.
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
