import 'package:star_shooter/game/level/difficulty_model.dart';
import 'package:star_shooter/game/level/level_objective.dart';
import 'package:star_shooter/game/level/level_world_meta.dart';
import 'package:star_shooter/game/level/star_rating_config.dart';
import 'package:star_shooter/game/models/board_config.dart';
import 'package:star_shooter/game/models/board_grid.dart';
import 'package:star_shooter/game/models/grid_position.dart';
import 'package:star_shooter/game/models/star_model.dart';
import 'package:star_shooter/game/models/star_type.dart';
import 'package:star_shooter/game/services/scoring_config.dart';
import 'package:star_shooter/game/special/special_star_config.dart';

/// Data-driven definition of a single game level.
///
/// Pure Dart — no Flutter or Flame dependencies. All fields are immutable;
/// mutation produces a new [LevelDefinition] (use [copyWith] if added later).
class LevelDefinition {
  /// Schema version — increment when the serialised shape changes.
  final int version;

  final int id;
  final String displayName;

  /// Maximum number of shots allowed before the level is lost.
  final int moveLimit;

  /// Minimum score required to earn a 3-star rating.
  ///
  /// Retained for backwards-compatibility; the canonical objective is [objective].
  final int scoreTarget;

  /// Board row index. If any star reaches this row the game ends in failure.
  final int failureBoundaryRow;

  final BoardConfig boardConfig;

  /// Star types that may appear in the launcher for this level.
  final List<StarType> availableStarTypes;

  /// Seed used for deterministic star-type generation.
  final int randomSeed;

  /// Explicit initial star placement. When empty, [buildInitialBoard] falls
  /// back to a default 5-row board of [StarType.normal] stars.
  final List<InitialStarPlacement> initialStars;

  // ── New M6 fields ──────────────────────────────────────────────────────────

  /// The world/galaxy context for this level. Null for procedurally generated
  /// levels that are not part of the catalog.
  final LevelWorldMeta? worldMeta;

  /// The primary win condition for this level.
  final LevelObjective objective;

  /// Balance tuning for special-star mechanics.
  final SpecialStarConfig specialStarConfig;

  /// Balance tuning for score calculation.
  final ScoringConfig scoringConfig;

  /// Thresholds for star-rating awards on completion.
  final StarRatingConfig starRatingConfig;

  /// Computed difficulty metadata. Null until the difficulty calculator runs.
  final DifficultyModel? difficulty;

  /// Minimum star rating the player must earn to unlock the next level.
  final int minStarsToPass;

  const LevelDefinition({
    required this.id,
    required this.displayName,
    required this.moveLimit,
    required this.scoreTarget,
    required this.failureBoundaryRow,
    this.version = 1,
    this.boardConfig = BoardConfig.standard,
    this.availableStarTypes = const [StarType.normal],
    this.randomSeed = 42,
    this.initialStars = const [],
    this.worldMeta,
    this.objective = const LevelObjective.scoreTarget(250),
    this.specialStarConfig = SpecialStarConfig.standard,
    this.scoringConfig = ScoringConfig.standard,
    this.starRatingConfig = StarRatingConfig.standard,
    this.difficulty,
    this.minStarsToPass = 1,
  });

  // ── Factories ──────────────────────────────────────────────────────────────

  /// Returns a [LevelDefinition] for [levelId] using built-in defaults.
  ///
  /// Level 1 (and every level until a real loader is added in M6) has:
  /// * 5 rows of normal stars
  /// * 20-move limit
  /// * Score target scaling with level id
  factory LevelDefinition.forLevel(int levelId) {
    final types = [StarType.normal];
    if (levelId >= 11) types.add(StarType.meteor);
    if (levelId >= 21) types.add(StarType.rainbow);
    if (levelId >= 31) types.add(StarType.supernova);
    if (levelId >= 41) types.add(StarType.blackHole);
    if (levelId >= 51) types.add(StarType.frozenStar);

    final scoreGoal = levelId * 200 + 250;

    return LevelDefinition(
      id: levelId,
      displayName: 'Level $levelId',
      moveLimit: 20,
      scoreTarget: scoreGoal,
      failureBoundaryRow: 10,
      availableStarTypes: List.unmodifiable(types),
      randomSeed: levelId * 137, // deterministic per level
      objective: LevelObjective.scoreTarget(scoreGoal),
    );
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  /// `true` when the initial star list contains at least one frozen star.
  bool get hasFrozenStars =>
      initialStars.any((p) => p.type == StarType.frozenStar);

  // ── Board construction ─────────────────────────────────────────────────────

  /// Builds the initial [BoardGrid] for this level.
  ///
  /// When [initialStars] is empty the board is populated with 5 rows of
  /// [StarType.normal] stars via [BoardGrid.initialBoard]. Otherwise each
  /// [InitialStarPlacement] is applied in order.
  ///
  /// Frozen stars are created with [frozenHitsRemaining] set to `2` so that
  /// they require two adjacent matches before thawing.
  BoardGrid buildInitialBoard() {
    if (initialStars.isEmpty) {
      return BoardGrid.initialBoard(rows: 5);
    }

    var grid = BoardGrid(config: boardConfig);
    for (final placement in initialStars) {
      final frozenHits = placement.type == StarType.frozenStar ? 2 : 0;
      final star = StarModel.create(
        type: placement.type,
        gridPosition: placement.position,
        frozenHitsRemaining: frozenHits,
      );
      grid = grid.placeStar(star, placement.position);
    }
    return grid;
  }

  @override
  String toString() => 'LevelDefinition(id: $id, moveLimit: $moveLimit, '
      'scoreTarget: $scoreTarget, failureBoundaryRow: $failureBoundaryRow, '
      'objective: ${objective.displayText})';
}

// ── Supporting types ───────────────────────────────────────────────────────

/// Describes a single star that should be placed on the board at level start.
class InitialStarPlacement {
  final GridPosition position;
  final StarType type;

  const InitialStarPlacement({required this.position, required this.type});
}
