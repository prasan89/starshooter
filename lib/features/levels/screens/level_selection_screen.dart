import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:star_shooter/core/navigation/app_routes.dart';
import 'package:star_shooter/core/theme/app_colors.dart';
import 'package:star_shooter/core/theme/app_spacing.dart';
import 'package:star_shooter/core/theme/app_text_styles.dart';
import 'package:star_shooter/core/widgets/star_rating.dart';
import 'package:star_shooter/domain/models/level_progress.dart';
import 'package:star_shooter/features/galaxy/state/galaxy_map_notifier.dart';
import 'package:star_shooter/game/level/level_catalog.dart';
import 'package:star_shooter/game/models/level_definition.dart';

// ── World color palette ───────────────────────────────────────────────────────

const _worldGradients = <int, List<Color>>{
  1: [Color(0xFF0EA5E9), Color(0xFF38BDF8)],
  2: [Color(0xFFF59E0B), Color(0xFFEF4444)],
  3: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
  4: [Color(0xFFDC2626), Color(0xFF7C3AED)],
  5: [Color(0xFF67E8F9), Color(0xFFE0F2FE)],
};

List<Color> _colorsFor(int worldId) =>
    _worldGradients[worldId] ?? const [Color(0xFF4A90E2), Color(0xFF8B5CF6)];

// ── Screen ────────────────────────────────────────────────────────────────────

class LevelSelectionScreen extends StatefulWidget {
  const LevelSelectionScreen({super.key, required this.worldId});

  final String worldId;

  @override
  State<LevelSelectionScreen> createState() => _LevelSelectionScreenState();
}

class _LevelSelectionScreenState extends State<LevelSelectionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseCtrl;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final parsedWorldId = int.tryParse(widget.worldId) ?? 1;
    final notifier = context.watch<GalaxyMapNotifier>();

    final levels = LevelCatalog.getWorld(parsedWorldId);
    final worldColors = _colorsFor(parsedWorldId);

    // World name from catalog (fall back gracefully)
    final worldName = levels.isNotEmpty
        ? (levels.first.worldMeta?.worldName ?? 'World $parsedWorldId')
        : 'World $parsedWorldId';

    // Level id range for subtitle
    final firstId = levels.isNotEmpty ? levels.first.id : 0;
    final lastId = levels.isNotEmpty ? levels.last.id : 0;

    // World-level progress summary
    final worldProg = notifier.worldProgress.cast<dynamic>().firstWhere(
          (w) => (w as dynamic).worldId == parsedWorldId,
          orElse: () => null,
        );
    final completedLevels =
        worldProg != null ? (worldProg.completedLevels as int) : 0;
    final totalLevels = levels.length;
    final totalStars = worldProg != null ? (worldProg.totalStars as int) : 0;
    final maxStars =
        worldProg != null ? (worldProg.maxStars as int) : totalLevels * 3;

    // Determine which is the "current" level (first unlocked, not completed)
    int? currentLevelId;
    for (final level in levels) {
      if (notifier.isLevelUnlocked(level.id) &&
          !notifier.isLevelCompleted(level.id)) {
        currentLevelId = level.id;
        break;
      }
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background gradient
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  worldColors[0].withValues(alpha: 0.15),
                  AppColors.background,
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── Header ──────────────────────────────────────────────────
                _Header(
                  worldName: worldName,
                  worldId: parsedWorldId,
                  firstLevelId: firstId,
                  lastLevelId: lastId,
                  completedLevels: completedLevels,
                  totalLevels: totalLevels,
                  totalStars: totalStars,
                  maxStars: maxStars,
                  worldColors: worldColors,
                ),
                // ── Path ────────────────────────────────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.md,
                    ),
                    child: _CosmicPath(
                      levels: levels,
                      notifier: notifier,
                      currentLevelId: currentLevelId,
                      worldColors: worldColors,
                      pulseAnim: _pulseAnim,
                      onTap: (level) => _onLevelTap(context, level, notifier),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onLevelTap(
    BuildContext context,
    LevelDefinition level,
    GalaxyMapNotifier notifier,
  ) {
    final isUnlocked = notifier.isLevelUnlocked(level.id);
    if (isUnlocked) {
      context.push(AppRoutes.gameplayPath(level.id.toString()));
    } else {
      HapticFeedback.lightImpact();
      final prevId = level.id - 1;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Level ${level.id} is locked. Complete Level $prevId first.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          backgroundColor: AppColors.surface,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          margin: const EdgeInsets.all(AppSpacing.md),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}

// ── Header ────────────────────────────────────────────────────────────────────

class _Header extends StatelessWidget {
  const _Header({
    required this.worldName,
    required this.worldId,
    required this.firstLevelId,
    required this.lastLevelId,
    required this.completedLevels,
    required this.totalLevels,
    required this.totalStars,
    required this.maxStars,
    required this.worldColors,
  });

  final String worldName;
  final int worldId;
  final int firstLevelId;
  final int lastLevelId;
  final int completedLevels;
  final int totalLevels;
  final int totalStars;
  final int maxStars;
  final List<Color> worldColors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.sm,
        AppSpacing.xs,
        AppSpacing.md,
        AppSpacing.md,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: worldColors[0].withValues(alpha: 0.2),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back button row
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.textPrimary,
                ),
                onPressed: () => context.pop(),
              ),
              const Spacer(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // World name with gradient
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: worldColors,
                  ).createShader(bounds),
                  child: Text(
                    worldName,
                    style: AppTextStyles.displayMedium.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                // Subtitle: World N · Levels X–Y
                Text(
                  'World $worldId  ·  Levels $firstLevelId–$lastLevelId',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                // Progress summary
                Row(
                  children: [
                    Icon(
                      Icons.check_circle_outline_rounded,
                      size: 14,
                      color: worldColors[0],
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      '$completedLevels/$totalLevels levels',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    const Icon(
                      Icons.star_rounded,
                      size: 14,
                      color: AppColors.starFilled,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      '$totalStars/$maxStars',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Cosmic path ───────────────────────────────────────────────────────────────

class _CosmicPath extends StatelessWidget {
  const _CosmicPath({
    required this.levels,
    required this.notifier,
    required this.currentLevelId,
    required this.worldColors,
    required this.pulseAnim,
    required this.onTap,
  });

  final List<LevelDefinition> levels;
  final GalaxyMapNotifier notifier;
  final int? currentLevelId;
  final List<Color> worldColors;
  final Animation<double> pulseAnim;
  final void Function(LevelDefinition) onTap;

  // How many levels are completed before this node (for determining path style)
  bool _isPathCompleted(int index) {
    if (index <= 0) return false;
    final prevLevel = levels[index - 1];
    return notifier.isLevelCompleted(prevLevel.id);
  }

  @override
  Widget build(BuildContext context) {
    if (levels.isEmpty) {
      return const Center(
        child: Text(
          'No levels available.',
          style: AppTextStyles.bodyMedium,
        ),
      );
    }

    final children = <Widget>[];

    for (int i = 0; i < levels.length; i++) {
      final level = levels[i];
      final isCompleted = notifier.isLevelCompleted(level.id);
      final isUnlocked = notifier.isLevelUnlocked(level.id);
      final isCurrent = level.id == currentLevelId;
      final progress = notifier.progressFor(level.id);

      // Determine if path segment above this node is completed
      final pathIsCompleted = _isPathCompleted(i);

      // Add path segment above every node except the first
      if (i > 0) {
        children.add(
          _PathSegment(
            isCompleted: pathIsCompleted,
            worldColors: worldColors,
          ),
        );
      }

      // Alternate: odd index (0-based) nodes go left, even go right
      final alignLeft = i.isEven;

      children.add(
        _LevelNodeRow(
          level: level,
          levelNumber: i + 1,
          isCompleted: isCompleted,
          isUnlocked: isUnlocked,
          isCurrent: isCurrent,
          progress: progress,
          worldColors: worldColors,
          pulseAnim: pulseAnim,
          alignLeft: alignLeft,
          onTap: () => onTap(level),
        ),
      );
    }

    return Column(
      children: children,
    );
  }
}

// ── Path segment ──────────────────────────────────────────────────────────────

class _PathSegment extends StatelessWidget {
  const _PathSegment({
    required this.isCompleted,
    required this.worldColors,
  });

  final bool isCompleted;
  final List<Color> worldColors;

  static const double _height = 40.0;
  static const double _lineWidth = 3.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      child: Center(
        child: isCompleted
            ? Container(
                width: _lineWidth,
                height: _height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: worldColors,
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              )
            : CustomPaint(
                size: const Size(_lineWidth, _height),
                painter: _DashedLinePainter(),
              ),
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const dashHeight = 5.0;
    const dashGap = 4.0;
    final paint = Paint()
      ..color = AppColors.textDisabled.withValues(alpha: 0.5)
      ..strokeWidth = size.width
      ..strokeCap = StrokeCap.round;

    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, (startY + dashHeight).clamp(0, size.height)),
        paint,
      );
      startY += dashHeight + dashGap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── Level node row ────────────────────────────────────────────────────────────

class _LevelNodeRow extends StatelessWidget {
  const _LevelNodeRow({
    required this.level,
    required this.levelNumber,
    required this.isCompleted,
    required this.isUnlocked,
    required this.isCurrent,
    required this.progress,
    required this.worldColors,
    required this.pulseAnim,
    required this.alignLeft,
    required this.onTap,
  });

  final LevelDefinition level;
  final int levelNumber;
  final bool isCompleted;
  final bool isUnlocked;
  final bool isCurrent;
  final LevelProgress progress;
  final List<Color> worldColors;
  final Animation<double> pulseAnim;
  final bool alignLeft;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final nodeWidget = _LevelNode(
      level: level,
      levelNumber: levelNumber,
      isCompleted: isCompleted,
      isUnlocked: isUnlocked,
      isCurrent: isCurrent,
      progress: progress,
      worldColors: worldColors,
      pulseAnim: pulseAnim,
      onTap: onTap,
    );

    // Build the row: node on one side, info label on the other
    final infoWidget = _LevelInfoLabel(
      level: level,
      isCompleted: isCompleted,
      isUnlocked: isUnlocked,
      isCurrent: isCurrent,
      progress: progress,
      worldColors: worldColors,
      alignRight: alignLeft,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: alignLeft
            ? [
                const SizedBox(width: AppSpacing.lg),
                nodeWidget,
                const SizedBox(width: AppSpacing.md),
                Expanded(child: infoWidget),
                const SizedBox(width: AppSpacing.lg),
              ]
            : [
                const SizedBox(width: AppSpacing.lg),
                Expanded(child: infoWidget),
                const SizedBox(width: AppSpacing.md),
                nodeWidget,
                const SizedBox(width: AppSpacing.lg),
              ],
      ),
    );
  }
}

// ── Level node circle ─────────────────────────────────────────────────────────

class _LevelNode extends StatelessWidget {
  const _LevelNode({
    required this.level,
    required this.levelNumber,
    required this.isCompleted,
    required this.isUnlocked,
    required this.isCurrent,
    required this.progress,
    required this.worldColors,
    required this.pulseAnim,
    required this.onTap,
  });

  final LevelDefinition level;
  final int levelNumber;
  final bool isCompleted;
  final bool isUnlocked;
  final bool isCurrent;
  final LevelProgress progress;
  final List<Color> worldColors;
  final Animation<double> pulseAnim;
  final VoidCallback onTap;

  static const double _normalSize = 52.0;
  static const double _currentSize = 60.0;

  @override
  Widget build(BuildContext context) {
    final size = isCurrent ? _currentSize : _normalSize;

    Widget node = GestureDetector(
      onTap: onTap,
      child: _buildNodeCircle(size),
    );

    if (isCurrent) {
      node = AnimatedBuilder(
        animation: pulseAnim,
        builder: (context, child) =>
            Transform.scale(scale: pulseAnim.value, child: child),
        child: node,
      );
    }

    return node;
  }

  Widget _buildNodeCircle(double size) {
    if (isCompleted) {
      return _CompletedNode(
        size: size,
        levelNumber: levelNumber,
        worldColors: worldColors,
      );
    } else if (isCurrent) {
      return _CurrentNode(
        size: size,
        levelNumber: levelNumber,
        worldColors: worldColors,
      );
    } else if (isUnlocked) {
      return _UnlockedNode(
        size: size,
        levelNumber: levelNumber,
        worldColors: worldColors,
      );
    } else {
      return _LockedNode(
        size: size,
        levelNumber: levelNumber,
      );
    }
  }
}

// ── Node states ───────────────────────────────────────────────────────────────

class _CompletedNode extends StatelessWidget {
  const _CompletedNode({
    required this.size,
    required this.levelNumber,
    required this.worldColors,
  });

  final double size;
  final int levelNumber;
  final List<Color> worldColors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: worldColors,
        ),
        boxShadow: [
          BoxShadow(
            color: worldColors[0].withValues(alpha: 0.4),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Text(
          '$levelNumber',
          style: AppTextStyles.titleMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _CurrentNode extends StatelessWidget {
  const _CurrentNode({
    required this.size,
    required this.levelNumber,
    required this.worldColors,
  });

  final double size;
  final int levelNumber;
  final List<Color> worldColors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: worldColors,
        ),
        boxShadow: [
          BoxShadow(
            color: worldColors[0].withValues(alpha: 0.7),
            blurRadius: 20,
            spreadRadius: 4,
          ),
          BoxShadow(
            color: worldColors[1].withValues(alpha: 0.4),
            blurRadius: 30,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Text(
          '$levelNumber',
          style: AppTextStyles.titleLarge.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _UnlockedNode extends StatelessWidget {
  const _UnlockedNode({
    required this.size,
    required this.levelNumber,
    required this.worldColors,
  });

  final double size;
  final int levelNumber;
  final List<Color> worldColors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.background,
        border: Border.all(
          color: worldColors[0],
          width: 2.5,
        ),
        boxShadow: [
          BoxShadow(
            color: worldColors[0].withValues(alpha: 0.2),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Center(
        child: Text(
          '$levelNumber',
          style: AppTextStyles.titleMedium.copyWith(
            color: worldColors[0],
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _LockedNode extends StatelessWidget {
  const _LockedNode({
    required this.size,
    required this.levelNumber,
  });

  final double size;
  final int levelNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF1C2033),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.lock_rounded,
              color: AppColors.textDisabled,
              size: 18,
            ),
            Text(
              '$levelNumber',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textDisabled,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Level info label ──────────────────────────────────────────────────────────

class _LevelInfoLabel extends StatelessWidget {
  const _LevelInfoLabel({
    required this.level,
    required this.isCompleted,
    required this.isUnlocked,
    required this.isCurrent,
    required this.progress,
    required this.worldColors,
    required this.alignRight,
  });

  final LevelDefinition level;
  final bool isCompleted;
  final bool isUnlocked;
  final bool isCurrent;
  final LevelProgress progress;
  final List<Color> worldColors;
  // When true, text is right-aligned (node is on the left side)
  final bool alignRight;

  @override
  Widget build(BuildContext context) {
    final alignment =
        alignRight ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    if (!isUnlocked) {
      return Column(
        crossAxisAlignment: alignment,
        children: [
          Text(
            level.displayName,
            textAlign: alignRight ? TextAlign.right : TextAlign.left,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textDisabled,
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          level.displayName,
          textAlign: alignRight ? TextAlign.right : TextAlign.left,
          style: AppTextStyles.labelLarge.copyWith(
            color: isCurrent ? worldColors[0] : AppColors.textPrimary,
          ),
        ),
        if (isCurrent) ...[
          const SizedBox(height: AppSpacing.xs),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: worldColors),
              borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            ),
            child: Text(
              'PLAY',
              style: AppTextStyles.bodySmall.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ],
        if (isCompleted) ...[
          const SizedBox(height: AppSpacing.xs),
          StarRating(rating: progress.stars, size: 14, spacing: 2),
          if (progress.bestScore > 0) ...[
            const SizedBox(height: 2),
            Text(
              _formatScore(progress.bestScore),
              textAlign: alignRight ? TextAlign.right : TextAlign.left,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ],
        if (isUnlocked && !isCompleted && !isCurrent) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            level.objective.displayText,
            textAlign: alignRight ? TextAlign.right : TextAlign.left,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
              fontSize: 11,
            ),
          ),
        ],
      ],
    );
  }

  String _formatScore(int score) {
    if (score >= 1000000) {
      return '${(score / 1000000).toStringAsFixed(1)}M';
    }
    if (score >= 1000) {
      final thousands = score ~/ 1000;
      final remainder = score % 1000;
      return remainder == 0
          ? '$thousands,000'
          : '$thousands,${remainder.toString().padLeft(3, '0')}';
    }
    return '$score';
  }
}
