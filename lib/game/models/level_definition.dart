import 'package:star_shooter/game/models/board_config.dart';
import 'package:star_shooter/game/models/board_grid.dart';
import 'package:star_shooter/game/models/grid_position.dart';
import 'package:star_shooter/game/models/star_model.dart';
import 'package:star_shooter/game/models/star_type.dart';

/// Data-driven definition of a single game level.
///
/// Pure Dart — no Flutter or Flame dependencies. All fields are immutable;
/// mutation produces a new [LevelDefinition] (use [copyWith] if added later).
class LevelDefinition {
  final int id;
  final String displayName;

  /// Maximum number of shots allowed before the level is lost.
  final int moveLimit;

  /// Minimum score required to earn a 3-star rating.
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

  const LevelDefinition({
    required this.id,
    required this.displayName,
    required this.moveLimit,
    required this.scoreTarget,
    required this.failureBoundaryRow,
    this.boardConfig = BoardConfig.standard,
    this.availableStarTypes = const [StarType.normal],
    this.randomSeed = 42,
    this.initialStars = const [],
  });

  // ── Factories ──────────────────────────────────────────────────────────────

  /// Returns a [LevelDefinition] for [levelId] using built-in defaults.
  ///
  /// Level 1 (and every level until a real loader is added in M5) has:
  /// * 5 rows of normal stars
  /// * 20-move limit
  /// * 250-point score target
  factory LevelDefinition.forLevel(int levelId) {
    return LevelDefinition(
      id: levelId,
      displayName: 'Level $levelId',
      moveLimit: 20,
      scoreTarget: 250,
      failureBoundaryRow: 10,
      availableStarTypes: const [StarType.normal],
      randomSeed: levelId * 137, // deterministic per level
    );
  }

  // ── Board construction ─────────────────────────────────────────────────────

  /// Builds the initial [BoardGrid] for this level.
  ///
  /// When [initialStars] is empty the board is populated with 5 rows of
  /// [StarType.normal] stars via [BoardGrid.initialBoard]. Otherwise each
  /// [_InitialStarPlacement] is applied in order.
  BoardGrid buildInitialBoard() {
    if (initialStars.isEmpty) {
      return BoardGrid.initialBoard(rows: 5);
    }

    var grid = BoardGrid(config: boardConfig);
    for (final placement in initialStars) {
      final star = StarModel.create(
        type: placement.type,
        gridPosition: placement.position,
      );
      grid = grid.placeStar(star, placement.position);
    }
    return grid;
  }

  @override
  String toString() => 'LevelDefinition(id: $id, moveLimit: $moveLimit, '
      'scoreTarget: $scoreTarget, failureBoundaryRow: $failureBoundaryRow)';
}

// ── Supporting types ───────────────────────────────────────────────────────

/// Describes a single star that should be placed on the board at level start.
class InitialStarPlacement {
  final GridPosition position;
  final StarType type;

  const InitialStarPlacement({required this.position, required this.type});
}
