import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:star_shooter/core/navigation/app_routes.dart';
import 'package:star_shooter/core/theme/app_colors.dart';
import 'package:star_shooter/core/theme/app_spacing.dart';
import 'package:star_shooter/core/theme/app_text_styles.dart';
import 'package:star_shooter/core/widgets/cosmic_button.dart';
import 'package:star_shooter/core/widgets/cosmic_card.dart';
import 'package:star_shooter/domain/config/daily_attempt_config.dart';
import 'package:star_shooter/domain/usecases/start_level_usecase.dart';
import 'package:star_shooter/features/daily_challenge/domain/analytics/challenge_analytics.dart';
import 'package:star_shooter/features/daily_challenge/domain/models/daily_challenge.dart';
import 'package:star_shooter/features/daily_challenge/domain/models/streak_state.dart';
import 'package:star_shooter/features/daily_challenge/domain/usecases/get_today_challenge_usecase.dart';
import 'package:star_shooter/features/daily_challenge/presentation/state/daily_challenge_notifier.dart';
import 'package:star_shooter/features/gameplay/screens/daily_limit_screen.dart';

const _kMilestones = [3, 7, 14, 30];

class DailyChallengeScreen extends StatefulWidget {
  const DailyChallengeScreen({super.key});

  @override
  State<DailyChallengeScreen> createState() => _DailyChallengeScreenState();
}

class _DailyChallengeScreenState extends State<DailyChallengeScreen>
    with SingleTickerProviderStateMixin {
  TodayChallengeInfo? _info;
  bool _loading = true;
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
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadChallenge());
  }

  void _loadChallenge() {
    final info = context.read<GetTodayChallengeUseCase>().call();
    setState(() {
      _info = info;
      _loading = false;
    });
    _fadeCtrl.forward();
    context
        .read<ChallengeAnalytics>()
        .logChallengeViewed(info.todayDate, info.challenge.levelId);
  }

  Future<void> _onPlay() async {
    final info = _info;
    if (info == null) return;

    context
        .read<ChallengeAnalytics>()
        .logChallengeStarted(info.todayDate, info.challenge.levelId);

    final startResult = await context
        .read<StartLevelUseCase>()
        .call(levelId: info.challenge.levelId);

    if (!mounted) return;

    if (startResult.status == StartLevelStatus.dailyLimitReached) {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => DailyLimitScreen(
            dailyLimit: DailyAttemptConfig.defaultConfig.freeDailyLimit,
          ),
        ),
      );
      return;
    }

    if (!startResult.isAllowed) return;

    context.read<DailyChallengeNotifier>().setActiveChallenge(info.challenge);

    if (!mounted) return;
    context.push(AppRoutes.gameplayPath(info.challenge.levelId.toString()));
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const _CosmicBackground(),
          FadeTransition(
            opacity: _fade,
            child: _loading
                ? const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  )
                : _Body(info: _info!, onPlay: _onPlay),
          ),
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.info, required this.onPlay});

  final TodayChallengeInfo info;
  final VoidCallback onPlay;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                color: AppColors.textSecondary,
              ),
              onPressed: () => context.pop(),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              children: [
                _ChallengeHeader(
                  date: info.challenge.date,
                  difficulty: info.challenge.difficulty,
                ),
                const SizedBox(height: AppSpacing.xl),
                _ChallengeCard(challenge: info.challenge),
                const SizedBox(height: AppSpacing.lg),
                _StreakCard(streak: info.streak),
                const SizedBox(height: AppSpacing.xl),
                if (info.todayCompleted)
                  const _CompletedSection()
                else
                  CosmicButton(
                    label: 'PLAY CHALLENGE',
                    icon: Icons.rocket_launch_rounded,
                    onPressed: onPlay,
                  ),
                const SizedBox(height: AppSpacing.md),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChallengeHeader extends StatelessWidget {
  const _ChallengeHeader({required this.date, required this.difficulty});

  final String date;
  final ChallengeDifficulty difficulty;

  @override
  Widget build(BuildContext context) {
    final formatted = DateFormat('MMMM d', 'en_US')
        .format(DateTime.parse('${date}T00:00:00'))
        .toUpperCase();

    final (badgeColor, badgeLabel) = switch (difficulty) {
      ChallengeDifficulty.easy => (AppColors.success, 'EASY'),
      ChallengeDifficulty.medium => (AppColors.primary, 'MEDIUM'),
      ChallengeDifficulty.hard => (const Color(0xFFF97316), 'HARD'),
      ChallengeDifficulty.expert => (AppColors.error, 'EXPERT'),
    };

    return Column(
      children: [
        const SizedBox(height: AppSpacing.md),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              AppColors.buttonGradientStart,
              AppColors.buttonGradientEnd,
            ],
          ).createShader(bounds),
          child: Text(
            'DAILY CHALLENGE',
            style: AppTextStyles.displayMedium.copyWith(
              color: Colors.white,
              letterSpacing: 3,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          formatted,
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textSecondary,
            letterSpacing: 1,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: badgeColor.withAlpha(30),
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            border: Border.all(color: badgeColor.withAlpha(100)),
          ),
          child: Text(
            badgeLabel,
            style: AppTextStyles.labelLarge.copyWith(
              color: badgeColor,
              letterSpacing: 2,
            ),
          ),
        ),
      ],
    );
  }
}

class _ChallengeCard extends StatelessWidget {
  const _ChallengeCard({required this.challenge});

  final DailyChallenge challenge;

  @override
  Widget build(BuildContext context) {
    final worldName = challenge.levelDefinition.worldMeta?.worldName;

    return CosmicCard(
      glow: true,
      glowColor: AppColors.primary,
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [
                  AppColors.buttonGradientStart,
                  AppColors.buttonGradientEnd,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withAlpha(80),
                  blurRadius: 16,
                  spreadRadius: 2,
                ),
              ],
            ),
            child:
                const Icon(Icons.star_rounded, color: Colors.white, size: 32),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            "TODAY'S MISSION",
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColors.textSecondary,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            challenge.objective.displayText,
            style: AppTextStyles.headlineLarge.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ChipLabel(
                icon: Icons.send_rounded,
                label: 'Shots: ${challenge.effectiveMoveLimit}',
              ),
              const SizedBox(width: AppSpacing.sm),
              const _ChipLabel(
                icon: Icons.star_rounded,
                label: 'Reward: +1 Daily Star',
                color: AppColors.starFilled,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Level ${challenge.levelId}'
            '${worldName != null ? ' · $worldName' : ''}',
            style: AppTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _ChipLabel extends StatelessWidget {
  const _ChipLabel({required this.icon, required this.label, this.color});

  final IconData icon;
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.textSecondary;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.shimmerBase,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: c),
          const SizedBox(width: 4),
          Text(label, style: AppTextStyles.bodySmall.copyWith(color: c)),
        ],
      ),
    );
  }
}

class _StreakCard extends StatelessWidget {
  const _StreakCard({required this.streak});

  final StreakState streak;

  @override
  Widget build(BuildContext context) {
    final hasMilestone = _kMilestones.contains(streak.currentStreak);

    return CosmicCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('🔥', style: TextStyle(fontSize: 28)),
              const SizedBox(width: AppSpacing.sm),
              Text(
                streak.currentStreak > 0 ? '${streak.currentStreak}' : '0',
                style: AppTextStyles.displayLarge.copyWith(
                  color: AppColors.starFilled,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'DAY STREAK',
                style: AppTextStyles.headlineMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            streak.currentStreak > 0
                ? 'Best: ${streak.longestStreak} days'
                : 'Start your streak today!',
            style: AppTextStyles.bodySmall,
          ),
          if (hasMilestone) ...[
            const SizedBox(height: AppSpacing.sm),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: AppColors.starFilled.withAlpha(30),
                borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                border: Border.all(color: AppColors.starFilled.withAlpha(100)),
              ),
              child: Text(
                '🌟 ${streak.currentStreak} DAY MILESTONE!',
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.starFilled,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CompletedSection extends StatelessWidget {
  const _CompletedSection();

  @override
  Widget build(BuildContext context) {
    return CosmicCard(
      borderColor: AppColors.success.withAlpha(100),
      backgroundColor: AppColors.success.withAlpha(15),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          const Icon(
            Icons.check_circle_rounded,
            color: AppColors.success,
            size: 48,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'COMPLETED TODAY',
            style: AppTextStyles.headlineMedium.copyWith(
              color: AppColors.success,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          const Text(
            'Come back tomorrow for a new challenge',
            style: AppTextStyles.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _CosmicBackground extends StatelessWidget {
  const _CosmicBackground();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const CustomPaint(painter: _StarFieldPainter()),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.topCenter,
              radius: 1.4,
              colors: [
                AppColors.surfaceHighlight.withAlpha(80),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StarFieldPainter extends CustomPainter {
  const _StarFieldPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFFFFFFFF).withAlpha(80);
    int state = 0xCAFEBABE;
    int next() {
      state = (state * 1664525 + 1013904223) & 0xFFFFFFFF;
      return state;
    }

    double nf() => (next() & 0xFFFF) / 65535.0;
    for (int i = 0; i < 60; i++) {
      final x = nf() * size.width;
      final y = nf() * size.height;
      canvas.drawCircle(Offset(x, y), i % 3 == 0 ? 1.5 : 0.8, paint);
    }
  }

  @override
  bool shouldRepaint(_StarFieldPainter oldDelegate) => false;
}
