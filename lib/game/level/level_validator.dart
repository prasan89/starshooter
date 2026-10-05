import 'package:star_shooter/game/level/level_objective.dart';
import 'package:star_shooter/game/level/level_validation_result.dart';
import 'package:star_shooter/game/models/level_definition.dart';
import 'package:star_shooter/game/models/star_type.dart';

/// Validates a [LevelDefinition] and returns a [LevelValidationResult].
///
/// All checks are deterministic — same input always produces same result.
class LevelValidator {
  static LevelValidationResult validate(LevelDefinition level) {
    final issues = <ValidationIssue>[];

    _checkBoardDimensions(level, issues);
    _checkStarTypes(level, issues);
    _checkInitialPlacements(level, issues);
    _checkObjective(level, issues);
    _checkShotCount(level, issues);
    _checkFailureBoundary(level, issues);
    _checkSeed(level, issues);
    _checkSpecialConfig(level, issues);

    return issues.isEmpty
        ? LevelValidationResult.valid()
        : LevelValidationResult.invalid(issues);
  }

  static void _checkBoardDimensions(
    LevelDefinition level,
    List<ValidationIssue> issues,
  ) {
    final cfg = level.boardConfig;
    if (cfg.rows < 2 || cfg.rows > 20) {
      issues.add(
        ValidationIssue(
          code: 'INVALID_BOARD_ROWS',
          message: 'Board rows must be 2–20, got ${cfg.rows}',
        ),
      );
    }
    if (cfg.cols < 2 || cfg.cols > 15) {
      issues.add(
        ValidationIssue(
          code: 'INVALID_BOARD_COLS',
          message: 'Board cols must be 2–15, got ${cfg.cols}',
        ),
      );
    }
  }

  static void _checkStarTypes(
    LevelDefinition level,
    List<ValidationIssue> issues,
  ) {
    if (level.availableStarTypes.isEmpty) {
      issues.add(
        const ValidationIssue(
          code: 'NO_STAR_TYPES',
          message: 'Level must have at least one available star type',
        ),
      );
    }
    // Validate initialStars types are in availableStarTypes OR are frozenStar obstacles
    for (final placement in level.initialStars) {
      final t = placement.type;
      if (t != StarType.frozenStar && !level.availableStarTypes.contains(t)) {
        issues.add(
          ValidationIssue(
            code: 'INVALID_STAR_TYPE_IN_PLACEMENT',
            message:
                'Placement at ${placement.position} uses type ${t.name} not in availableStarTypes',
          ),
        );
      }
    }
    // If objective is clearStarType, the target type must be available
    final obj = level.objective;
    if (obj.type == ObjectiveType.clearStarType &&
        obj.targetStarType != null &&
        !level.availableStarTypes.contains(obj.targetStarType)) {
      issues.add(
        ValidationIssue(
          code: 'OBJECTIVE_TYPE_NOT_AVAILABLE',
          message:
              'Objective targets ${obj.targetStarType!.name} which is not in availableStarTypes',
        ),
      );
    }
  }

  static void _checkInitialPlacements(
    LevelDefinition level,
    List<ValidationIssue> issues,
  ) {
    final cfg = level.boardConfig;
    final seen = <String>{};
    for (final p in level.initialStars) {
      final key = '${p.position.row},${p.position.col}';
      if (seen.contains(key)) {
        issues.add(
          ValidationIssue(
            code: 'DUPLICATE_POSITION',
            message:
                'Duplicate star at row=${p.position.row}, col=${p.position.col}',
          ),
        );
      }
      seen.add(key);
      if (p.position.row < 0 || p.position.row >= cfg.rows) {
        issues.add(
          ValidationIssue(
            code: 'OUT_OF_BOUNDS_ROW',
            message:
                'Star at row=${p.position.row} is outside board rows (0–${cfg.rows - 1})',
          ),
        );
      }
      if (p.position.col < 0 || p.position.col >= cfg.cols) {
        issues.add(
          ValidationIssue(
            code: 'OUT_OF_BOUNDS_COL',
            message:
                'Star at col=${p.position.col} is outside board cols (0–${cfg.cols - 1})',
          ),
        );
      }
    }
  }

  static void _checkObjective(
    LevelDefinition level,
    List<ValidationIssue> issues,
  ) {
    final obj = level.objective;
    if (obj.target <= 0) {
      issues.add(
        ValidationIssue(
          code: 'INVALID_OBJECTIVE_TARGET',
          message: 'Objective target must be > 0, got ${obj.target}',
        ),
      );
    }
    if (obj.type == ObjectiveType.clearStarType && obj.targetStarType == null) {
      issues.add(
        const ValidationIssue(
          code: 'CLEAR_TYPE_MISSING_STAR_TYPE',
          message: 'clearStarType objective requires a targetStarType',
        ),
      );
    }
  }

  static void _checkShotCount(
    LevelDefinition level,
    List<ValidationIssue> issues,
  ) {
    if (level.moveLimit < 1 || level.moveLimit > 200) {
      issues.add(
        ValidationIssue(
          code: 'INVALID_SHOT_COUNT',
          message: 'moveLimit must be 1–200, got ${level.moveLimit}',
        ),
      );
    }
  }

  static void _checkFailureBoundary(
    LevelDefinition level,
    List<ValidationIssue> issues,
  ) {
    // failureBoundaryRow must be positive.  Values beyond boardConfig.rows are
    // allowed — they simply mean "no on-board failure boundary" (the level
    // relies on the move limit alone).  Values <= 0 are never valid.
    if (level.failureBoundaryRow < 1) {
      issues.add(
        ValidationIssue(
          code: 'INVALID_FAILURE_BOUNDARY',
          message:
              'failureBoundaryRow ${level.failureBoundaryRow} must be >= 1',
        ),
      );
    }
  }

  static void _checkSeed(LevelDefinition level, List<ValidationIssue> issues) {
    // Seed just needs to be a valid integer — any value is fine.
    // (No practical validation needed; keep hook for future rules.)
  }

  static void _checkSpecialConfig(
    LevelDefinition level,
    List<ValidationIssue> issues,
  ) {
    final sc = level.specialStarConfig;
    if (sc.meteorClearWidth < 1 || sc.meteorClearWidth > 9) {
      issues.add(
        ValidationIssue(
          code: 'INVALID_METEOR_WIDTH',
          message: 'meteorClearWidth must be 1–9, got ${sc.meteorClearWidth}',
        ),
      );
    }
    if (sc.supernovaRadius < 1 || sc.supernovaRadius > 5) {
      issues.add(
        ValidationIssue(
          code: 'INVALID_SUPERNOVA_RADIUS',
          message: 'supernovaRadius must be 1–5, got ${sc.supernovaRadius}',
        ),
      );
    }
    if (sc.specialSpawnRate < 0.0 || sc.specialSpawnRate > 1.0) {
      issues.add(
        ValidationIssue(
          code: 'INVALID_SPAWN_RATE',
          message:
              'specialSpawnRate must be 0.0–1.0, got ${sc.specialSpawnRate}',
        ),
      );
    }
  }
}
