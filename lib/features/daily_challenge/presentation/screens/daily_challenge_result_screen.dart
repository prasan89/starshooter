import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:star_shooter/core/navigation/app_routes.dart';
import 'package:star_shooter/core/theme/app_colors.dart';
import 'package:star_shooter/core/theme/app_spacing.dart';
import 'package:star_shooter/core/theme/app_text_styles.dart';
import 'package:star_shooter/core/widgets/cosmic_button.dart';
import 'package:star_shooter/features/daily_challenge/domain/models/daily_challenge.dart';
import 'package:star_shooter/features/daily_challenge/domain/models/streak_state.dart';
import 'package:intl/intl.dart';

const _kMilestones = [3, 7, 14, 30];

class DailyChallengeResultScreen extends StatefulWidget {
  const DailyChallengeResultScreen({
    super.key,
    required this.challenge,
    required this.score,
    required this.stars,
    required this.newStreak,
  });

  final DailyChallenge challenge;
  final int score;
  final int stars;
  final StreakState newStreak;

  @override
  State<DailyChallengeResultScreen> createState() =>
      _DailyChallengeResultScreenState();
}

class _DailyChallengeResultScreenState extends State<DailyChallengeResultScreen>
    with TickerProviderStateMixin {
  // Stars
  final List<bool> _starVisible = [false, false, false];
  final List<AnimationController> _starCtrls = [];
  final List<Animation<double>> _starScales = [];

  // Score
  late AnimationController _scoreCtrl;
  late Animation<double> _scoreAnim;

  // Streak reveal
  late AnimationController _streakCtrl;
  late Animation<double> _streakAnim;

  // Milestone badge
  late AnimationController _badgeCtrl;
  late Animation<double> _badgeScale;

  // Buttons
  late AnimationController _buttonsCtrl;
  late Animation<double> _buttonsOpacity;
  late Animation<Offset> _buttonsSlide;

  @override
  void initState() {
    super.initState();

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
      _starCtrls.add(ctrl);
      _starScales.add(scale);
    }

    _scoreCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _scoreAnim = CurvedAnimation(parent: _scoreCtrl, curve: Curves.easeOut);

    _streakCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _streakAnim = CurvedAnimation(parent: _streakCtrl, curve: Curves.easeOut);

    _badgeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _badgeScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _badgeCtrl, curve: Curves.elasticOut),
    );

    _buttonsCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _buttonsOpacity =
        CurvedAnimation(parent: _buttonsCtrl, curve: Curves.easeIn);
    _buttonsSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _buttonsCtrl, curve: Curves.easeOut));

    _runSequence();
  }

  void _runSequence() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      setState(() => _starVisible[0] = true);
      _starCtrls[0].forward();
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      if (widget.stars >= 2) {
        setState(() => _starVisible[1] = true);
        _starCtrls[1].forward();
      }
    });
    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      for (int i = widget.stars >= 3 ? 2 : widget.stars; i < 3; i++) {
        if (!_starVisible[i]) {
          setState(() => _starVisible[i] = true);
          _starCtrls[i].value = 1.0;
        }
      }
      if (widget.stars >= 3) {
        setState(() => _starVisible[2] = true);
        _starCtrls[2].forward();
      }
    });
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (!mounted) return;
      _scoreCtrl.forward();
    });
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (!mounted) return;
      _streakCtrl.forward();
    });
    Future.delayed(const Duration(milliseconds: 2300), () {
      if (!mounted) return;
      if (_kMilestones.contains(widget.newStreak.currentStreak)) {
        _badgeCtrl.forward();
      }
    });
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (!mounted) return;
      _buttonsCtrl.forward();
    });
  }

  @override
  void dispose() {
    for (final c in _starCtrls) {
      c.dispose();
    }
    _scoreCtrl.dispose();
    _streakCtrl.dispose();
    _badgeCtrl.dispose();
    _buttonsCtrl.dispose();
    super.dispose();
  }

  String _formatScore(int n) {
    final s = n.toString();
    final buf = StringBuffer();
    final offset = s.length % 3;
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (i - offset) % 3 == 0) buf.write(',');
      buf.write(s[i]);
    }
    return buf.toString();
  }

  int get _displayScore => (_scoreAnim.value * widget.score).round();

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('MMMM d', 'en_US')
        .format(DateTime.parse('${widget.challenge.date}T00:00:00'))
        .toUpperCase();
    final isMilestone = _kMilestones.contains(widget.newStreak.currentStreak);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) context.go(AppRoutes.home);
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          fit: StackFit.expand,
          children: [
            const _StarFieldBg(),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.xl,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Header
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [
                          AppColors.buttonGradientStart,
                          AppColors.buttonGradientEnd,
                        ],
                      ).createShader(bounds),
                      child: Text(
                        'DAILY CHALLENGE',
                        style: AppTextStyles.headlineMedium.copyWith(
                          color: Colors.white,
                          letterSpacing: 3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'COMPLETE',
                      style: AppTextStyles.displayLarge.copyWith(
                        color: AppColors.starFilled,
                        letterSpacing: 4,
                        fontWeight: FontWeight.w800,
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
                      formattedDate,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    // Stars
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (i) {
                        final earned = i < widget.stars;
                        if (!_starVisible[i]) {
                          return const SizedBox(width: 64, height: 64);
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: ScaleTransition(
                            scale: _starScales[i],
                            child: _StarWidget(earned: earned),
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    // Score
                    Text(
                      'SCORE',
                      style: AppTextStyles.labelLarge.copyWith(
                        color: AppColors.textSecondary,
                        letterSpacing: 3,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    AnimatedBuilder(
                      animation: _scoreAnim,
                      builder: (_, __) => Text(
                        _formatScore(_displayScore),
                        style: AppTextStyles.displayLarge.copyWith(
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),

                    const SizedBox(height: AppSpacing.md),

                    // Reward badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.starFilled.withAlpha(30),
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusFull),
                        border: Border.all(
                          color: AppColors.starFilled.withAlpha(100),
                        ),
                      ),
                      child: Text(
                        '✦ +1 DAILY STAR',
                        style: AppTextStyles.labelLarge.copyWith(
                          color: AppColors.starFilled,
                          letterSpacing: 1,
                        ),
                      ),
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    // Streak
                    FadeTransition(
                      opacity: _streakAnim,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('🔥', style: TextStyle(fontSize: 32)),
                              const SizedBox(width: AppSpacing.sm),
                              Text(
                                '${widget.newStreak.currentStreak}',
                                style: AppTextStyles.displayLarge.copyWith(
                                  color: AppColors.starFilled,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Text(
                                'DAY\nSTREAK',
                                style: AppTextStyles.headlineMedium.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            'Best: ${widget.newStreak.longestStreak} days',
                            style: AppTextStyles.bodySmall,
                          ),
                          if (isMilestone) ...[
                            const SizedBox(height: AppSpacing.sm),
                            ScaleTransition(
                              scale: _badgeScale,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.lg,
                                  vertical: AppSpacing.sm,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.starFilled.withAlpha(30),
                                  borderRadius: BorderRadius.circular(
                                    AppSpacing.radiusLg,
                                  ),
                                  border: Border.all(
                                    color: AppColors.starFilled.withAlpha(120),
                                    width: 1.5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.starFilled.withAlpha(60),
                                      blurRadius: 16,
                                    ),
                                  ],
                                ),
                                child: Text(
                                  '🌟 MILESTONE: ${widget.newStreak.currentStreak} DAY STREAK!',
                                  style: AppTextStyles.headlineMedium.copyWith(
                                    color: AppColors.starFilled,
                                    letterSpacing: 1,
                                    shadows: [
                                      Shadow(
                                        color:
                                            AppColors.starFilled.withAlpha(100),
                                        blurRadius: 8,
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    // Buttons
                    SlideTransition(
                      position: _buttonsSlide,
                      child: FadeTransition(
                        opacity: _buttonsOpacity,
                        child: Column(
                          children: [
                            CosmicButton(
                              label: 'RETURN TO HOME',
                              icon: Icons.home_rounded,
                              onPressed: () => context.go(AppRoutes.home),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            CosmicButton(
                              label: 'GALAXY MAP',
                              icon: Icons.map_outlined,
                              variant: CosmicButtonVariant.secondary,
                              onPressed: () => context.go(AppRoutes.galaxyMap),
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
      ),
    );
  }
}

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

class _StarFieldBg extends StatelessWidget {
  const _StarFieldBg();

  @override
  Widget build(BuildContext context) {
    return const CustomPaint(painter: _StarFieldPainter());
  }
}

class _StarFieldPainter extends CustomPainter {
  const _StarFieldPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFFFFFFFF).withAlpha(80);
    int state = 0xFACEB00C;
    int next() {
      state = (state * 1664525 + 1013904223) & 0xFFFFFFFF;
      return state;
    }

    double nf() => (next() & 0xFFFF) / 65535.0;
    for (int i = 0; i < 60; i++) {
      canvas.drawCircle(
        Offset(nf() * size.width, nf() * size.height),
        i % 3 == 0 ? 1.5 : 0.8,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_StarFieldPainter old) => false;
}
