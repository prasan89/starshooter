import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:star_shooter/core/navigation/app_routes.dart';
import 'package:star_shooter/core/theme/app_colors.dart';
import 'package:star_shooter/core/theme/app_spacing.dart';
import 'package:star_shooter/core/theme/app_text_styles.dart';
import 'package:star_shooter/domain/usecases/get_world_progress_usecase.dart';
import 'package:star_shooter/features/galaxy/state/galaxy_map_notifier.dart';

// ── Galaxy Map Screen ─────────────────────────────────────────────────────────

class GalaxyMapScreen extends StatefulWidget {
  const GalaxyMapScreen({super.key});

  @override
  State<GalaxyMapScreen> createState() => _GalaxyMapScreenState();
}

class _GalaxyMapScreenState extends State<GalaxyMapScreen>
    with TickerProviderStateMixin {
  late AnimationController _entranceCtrl;
  late List<Animation<double>> _cardFades;
  late List<Animation<Offset>> _cardSlides;

  @override
  void initState() {
    super.initState();
    _entranceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // 5 staggered card animations
    _cardFades = List.generate(
      5,
      (i) => CurvedAnimation(
        parent: _entranceCtrl,
        curve: Interval(
          i * 0.12,
          (0.5 + i * 0.12).clamp(0.0, 1.0),
          curve: Curves.easeOut,
        ),
      ),
    );
    _cardSlides = List.generate(
      5,
      (i) => Tween<Offset>(
        begin: const Offset(0, 0.3),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _entranceCtrl,
          curve: Interval(
            i * 0.12,
            (0.5 + i * 0.12).clamp(0.0, 1.0),
            curve: Curves.easeOut,
          ),
        ),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GalaxyMapNotifier>().load().then((_) {
        if (mounted) _entranceCtrl.forward();
      });
    });
  }

  @override
  void dispose() {
    _entranceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<GalaxyMapNotifier>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Cosmic starfield background — no Flame, pure CustomPaint
          const CustomPaint(painter: _StarFieldPainter()),

          // Subtle radial nebula overlay
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topCenter,
                radius: 1.4,
                colors: [
                  Color(0x221A1E4A),
                  AppColors.background,
                ],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(context),
                Expanded(child: _buildBody(context, notifier)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Header ────────────────────────────────────────────────────────────────

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.md,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF0D1B2E),
            Colors.transparent,
          ],
        ),
      ),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(18),
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                border: Border.all(
                  color: Colors.white.withAlpha(30),
                ),
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
                color: AppColors.textPrimary,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'GALAXY MAP',
                  style: AppTextStyles.headlineLarge.copyWith(
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w800,
                    foreground: Paint()
                      ..shader = const LinearGradient(
                        colors: [Color(0xFF67E8F9), Color(0xFF4A90E2)],
                      ).createShader(
                        const Rect.fromLTWH(0, 0, 200, 30),
                      ),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '5 Worlds  ·  50 Levels',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Body ──────────────────────────────────────────────────────────────────

  Widget _buildBody(BuildContext context, GalaxyMapNotifier notifier) {
    if (notifier.isLoading) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4A90E2)),
            ),
            SizedBox(height: AppSpacing.md),
            Text(
              'Charting the galaxy...',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    if (notifier.loadState == GalaxyLoadState.error) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline_rounded,
                color: AppColors.error,
                size: 48,
              ),
              const SizedBox(height: AppSpacing.md),
              const Text(
                'Failed to load galaxy data',
                style: AppTextStyles.titleMedium,
                textAlign: TextAlign.center,
              ),
              if (notifier.errorMessage != null) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  notifier.errorMessage!,
                  style: AppTextStyles.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: AppSpacing.lg),
              GestureDetector(
                onTap: () => notifier.refresh(),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.buttonGradientStart,
                        AppColors.buttonGradientEnd,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                  ),
                  child: const Text(
                    'Retry',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Loaded state — build the 5 world cards
    final worldProgressList = notifier.worldProgress;

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.xxl,
      ),
      itemCount: worldProgressList.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) {
        if (index >= worldProgressList.length) return const SizedBox.shrink();
        final worldProg = worldProgressList[index];
        final isUnlocked = worldProg.isUnlocked;
        final colors = _WorldCard._kWorldColors[
            (index).clamp(0, _WorldCard._kWorldColors.length - 1)];
        final fadeAnim =
            index < _cardFades.length ? _cardFades[index] : _cardFades.last;
        final slideAnim =
            index < _cardSlides.length ? _cardSlides[index] : _cardSlides.last;

        // Compute level range for this world (10 levels per world)
        final firstLevel = (worldProg.worldId - 1) * 10 + 1;
        final lastLevel = worldProg.worldId * 10;

        return _WorldCard(
          worldProg: worldProg,
          isUnlocked: isUnlocked,
          colors: colors,
          cardIndex: index,
          fade: fadeAnim,
          slide: slideAnim,
          firstLevel: firstLevel,
          lastLevel: lastLevel,
          onTap: isUnlocked
              ? () => context.push(
                    AppRoutes.levelSelectionPath(worldProg.worldId.toString()),
                  )
              : null,
        );
      },
    );
  }
}

// ── World Card ────────────────────────────────────────────────────────────────

class _WorldCard extends StatelessWidget {
  const _WorldCard({
    required this.worldProg,
    required this.isUnlocked,
    required this.colors,
    required this.cardIndex,
    required this.fade,
    required this.slide,
    required this.firstLevel,
    required this.lastLevel,
    this.onTap,
  });

  final WorldProgress worldProg;
  final bool isUnlocked;
  final List<Color> colors;
  final int cardIndex;
  final Animation<double> fade;
  final Animation<Offset> slide;
  final int firstLevel;
  final int lastLevel;
  final VoidCallback? onTap;

  // World-specific gradient palettes
  static const List<List<Color>> _kWorldColors = [
    [Color(0xFF0EA5E9), Color(0xFF38BDF8)], // W1 Nebula Nursery
    [Color(0xFFF59E0B), Color(0xFFEF4444)], // W2 Asteroid Fields
    [Color(0xFF8B5CF6), Color(0xFFEC4899)], // W3 Solar Winds
    [Color(0xFFDC2626), Color(0xFF7C3AED)], // W4 Event Horizon
    [Color(0xFF67E8F9), Color(0xFFE0F2FE)], // W5 Frozen Nebula
  ];

  @override
  Widget build(BuildContext context) {
    final primaryColor = colors[0];
    final secondaryColor = colors[1];

    return SlideTransition(
      position: slide,
      child: FadeTransition(
        opacity: fade,
        child: GestureDetector(
          onTap: onTap,
          child: _CardContent(
            worldProg: worldProg,
            isUnlocked: isUnlocked,
            primaryColor: primaryColor,
            secondaryColor: secondaryColor,
            cardIndex: cardIndex,
            firstLevel: firstLevel,
            lastLevel: lastLevel,
          ),
        ),
      ),
    );
  }
}

// ── Card Content (inner widget) ───────────────────────────────────────────────

class _CardContent extends StatefulWidget {
  const _CardContent({
    required this.worldProg,
    required this.isUnlocked,
    required this.primaryColor,
    required this.secondaryColor,
    required this.cardIndex,
    required this.firstLevel,
    required this.lastLevel,
  });

  final WorldProgress worldProg;
  final bool isUnlocked;
  final Color primaryColor;
  final Color secondaryColor;
  final int cardIndex;
  final int firstLevel;
  final int lastLevel;

  @override
  State<_CardContent> createState() => _CardContentState();
}

class _CardContentState extends State<_CardContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _glowCtrl;
  late Animation<double> _glowAnim;

  @override
  void initState() {
    super.initState();
    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );
    _glowAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut),
    );
    if (widget.isUnlocked) {
      _glowCtrl.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _glowCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wp = widget.worldProg;
    final isUnlocked = widget.isUnlocked;
    final primaryColor = widget.primaryColor;
    final secondaryColor = widget.secondaryColor;

    return AnimatedBuilder(
      animation: _glowAnim,
      builder: (context, child) {
        final glowAlpha =
            isUnlocked ? ((_glowAnim.value * 0.35 + 0.15) * 255).round() : 0;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            boxShadow: isUnlocked
                ? [
                    BoxShadow(
                      color: primaryColor.withAlpha(glowAlpha),
                      blurRadius: 18,
                      spreadRadius: 1,
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withAlpha(80),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // 1. Gradient background
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isUnlocked
                          ? [
                              primaryColor.withAlpha(200),
                              secondaryColor.withAlpha(180),
                            ]
                          : [
                              const Color(0xFF1A1E2E),
                              const Color(0xFF0F1220),
                            ],
                    ),
                  ),
                ),

                // 2. Decorative cosmic dots (inline CustomPaint)
                CustomPaint(
                  painter: _CosmicDotsPainter(
                    seed: wp.worldId * 37,
                    baseColor: isUnlocked
                        ? Colors.white.withAlpha(30)
                        : Colors.white.withAlpha(10),
                  ),
                ),

                // 3. Main content row
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // World badge
                      _WorldBadge(
                        worldId: wp.worldId,
                        isUnlocked: isUnlocked,
                        primaryColor: primaryColor,
                        secondaryColor: secondaryColor,
                      ),
                      const SizedBox(width: AppSpacing.md),

                      // Text column
                      Expanded(
                        child: _WorldInfo(
                          worldName: wp.worldName,
                          firstLevel: widget.firstLevel,
                          lastLevel: widget.lastLevel,
                          isUnlocked: isUnlocked,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),

                      // Progress column
                      _WorldProgress(
                        completedLevels: wp.completedLevels,
                        totalLevels: wp.totalLevels,
                        totalStars: wp.totalStars,
                        maxStars: wp.maxStars,
                        isUnlocked: isUnlocked,
                        primaryColor: primaryColor,
                      ),

                      if (isUnlocked) ...[
                        const SizedBox(width: AppSpacing.sm),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white.withAlpha(180),
                          size: 16,
                        ),
                      ],
                    ],
                  ),
                ),

                // 4. Locked overlay
                if (!isUnlocked)
                  _LockedOverlay(
                    prevWorldId: wp.worldId - 1,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ── World Badge ───────────────────────────────────────────────────────────────

class _WorldBadge extends StatelessWidget {
  const _WorldBadge({
    required this.worldId,
    required this.isUnlocked,
    required this.primaryColor,
    required this.secondaryColor,
  });

  final int worldId;
  final bool isUnlocked;
  final Color primaryColor;
  final Color secondaryColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: isUnlocked
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withAlpha(60),
                  Colors.white.withAlpha(20),
                ],
              )
            : const LinearGradient(
                colors: [Color(0xFF374151), Color(0xFF1F2937)],
              ),
        border: Border.all(
          color: isUnlocked
              ? Colors.white.withAlpha(100)
              : Colors.white.withAlpha(20),
          width: 1.5,
        ),
      ),
      child: Center(
        child: Text(
          '$worldId',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: isUnlocked ? Colors.white : AppColors.textDisabled,
          ),
        ),
      ),
    );
  }
}

// ── World Info ────────────────────────────────────────────────────────────────

class _WorldInfo extends StatelessWidget {
  const _WorldInfo({
    required this.worldName,
    required this.firstLevel,
    required this.lastLevel,
    required this.isUnlocked,
  });

  final String worldName;
  final int firstLevel;
  final int lastLevel;
  final bool isUnlocked;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          worldName,
          style: AppTextStyles.titleLarge.copyWith(
            fontWeight: FontWeight.w700,
            color: isUnlocked ? Colors.white : AppColors.textDisabled,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          'Levels $firstLevel–$lastLevel',
          style: TextStyle(
            fontSize: 13,
            color: isUnlocked
                ? Colors.white.withAlpha(190)
                : AppColors.textDisabled,
          ),
        ),
      ],
    );
  }
}

// ── World Progress ────────────────────────────────────────────────────────────

class _WorldProgress extends StatelessWidget {
  const _WorldProgress({
    required this.completedLevels,
    required this.totalLevels,
    required this.totalStars,
    required this.maxStars,
    required this.isUnlocked,
    required this.primaryColor,
  });

  final int completedLevels;
  final int totalLevels;
  final int totalStars;
  final int maxStars;
  final bool isUnlocked;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    final textColor =
        isUnlocked ? Colors.white.withAlpha(210) : AppColors.textDisabled;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Star count
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.star_rounded,
              color: isUnlocked ? AppColors.starFilled : AppColors.textDisabled,
              size: 16,
            ),
            const SizedBox(width: 3),
            Text(
              '$totalStars / $maxStars',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        // Level count
        Text(
          '$completedLevels / $totalLevels levels',
          style: TextStyle(
            fontSize: 12,
            color: textColor,
          ),
        ),
      ],
    );
  }
}

// ── Locked Overlay ────────────────────────────────────────────────────────────

class _LockedOverlay extends StatelessWidget {
  const _LockedOverlay({required this.prevWorldId});

  final int prevWorldId;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withAlpha(77), // ~30% dark tint
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.lock_rounded,
                color: Colors.white.withAlpha(180),
                size: 28,
              ),
              const SizedBox(height: 4),
              const Text(
                'LOCKED',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                ),
              ),
              if (prevWorldId > 0) ...[
                const SizedBox(height: 3),
                Text(
                  'Complete World $prevWorldId to unlock',
                  style: TextStyle(
                    color: Colors.white.withAlpha(150),
                    fontSize: 11,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ── Star Field CustomPainter ──────────────────────────────────────────────────

class _StarFieldPainter extends CustomPainter {
  const _StarFieldPainter();

  static const int _starCount = 80;
  static const int _seed = 0xCAFEBEEF;

  @override
  void paint(Canvas canvas, Size size) {
    // Seeded LCG — same algorithm as CosmicBackgroundComponent
    int state = _seed;
    int next() {
      state = (state * 1664525 + 1013904223) & 0xFFFFFFFF;
      return state;
    }

    double nf() => (next() & 0xFFFF) / 65535.0;

    // Deep space fill
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = AppColors.background,
    );

    // Bottom nebula haze
    final nebula1Center = Offset(size.width * 0.75, size.height * 0.85);
    canvas.drawCircle(
      nebula1Center,
      size.width * 0.55,
      Paint()
        ..shader = RadialGradient(
          colors: [
            const Color(0xFF2D1B69).withAlpha(28),
            AppColors.background.withAlpha(0),
          ],
        ).createShader(
          Rect.fromCircle(center: nebula1Center, radius: size.width * 0.55),
        ),
    );

    // Mid nebula haze
    final nebula2Center = Offset(size.width * 0.25, size.height * 0.35);
    canvas.drawCircle(
      nebula2Center,
      size.width * 0.45,
      Paint()
        ..shader = RadialGradient(
          colors: [
            const Color(0xFF1A1E4A).withAlpha(40),
            AppColors.background.withAlpha(0),
          ],
        ).createShader(
          Rect.fromCircle(center: nebula2Center, radius: size.width * 0.45),
        ),
    );

    // Static stars (no twinkle — this is a CustomPainter, not animated)
    final paint = Paint();
    for (int i = 0; i < _starCount; i++) {
      final x = nf() * size.width;
      final y = nf() * size.height;

      // Radius: occasional bright star, medium, small
      final rand3 = next() % 6;
      final radius = rand3 == 0 ? 1.8 : (next() % 3 == 0 ? 1.2 : 0.8);
      final brightness = 0.4 + nf() * 0.6;
      final alpha = (brightness * 220).round().clamp(0, 255);

      paint.color = Color.fromARGB(alpha, 255, 255, 255);
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(_StarFieldPainter oldDelegate) => false;
}

// ── Cosmic Dots Painter (per-card decorative dots) ────────────────────────────

class _CosmicDotsPainter extends CustomPainter {
  const _CosmicDotsPainter({required this.seed, required this.baseColor});

  final int seed;
  final Color baseColor;

  @override
  void paint(Canvas canvas, Size size) {
    int state = seed;
    int next() {
      state = (state * 1664525 + 1013904223) & 0xFFFFFFFF;
      return state;
    }

    double nf() => (next() & 0xFFFF) / 65535.0;

    final paint = Paint()..color = baseColor;

    // Draw 7 small decorative dots scattered across the card
    for (int i = 0; i < 7; i++) {
      final x = nf() * size.width;
      final y = nf() * size.height;
      final r = 1.0 + nf() * 3.0;
      canvas.drawCircle(Offset(x, y), r, paint);
    }
  }

  @override
  bool shouldRepaint(_CosmicDotsPainter oldDelegate) =>
      oldDelegate.seed != seed || oldDelegate.baseColor != baseColor;
}
