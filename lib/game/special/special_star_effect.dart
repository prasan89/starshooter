import 'package:star_shooter/game/models/board_grid.dart';
import 'package:star_shooter/game/models/grid_position.dart';
import 'package:star_shooter/game/models/star_type.dart';

/// Describes how a special star interacts with the board when activated.
///
/// Implementations are pure-Dart and deterministic: they receive a snapshot of
/// the board and the position where the special star was placed, then return the
/// set of positions that should be removed. They do NOT modify the board
/// directly — that responsibility belongs to [BoardResolver].
abstract class SpecialStarEffect {
  /// The type of star this effect handles.
  StarType get type;

  /// Compute which board positions should be removed by this effect.
  ///
  /// [board]     — current board state (before removal)
  /// [placedPos] — the grid position where the special star was just placed
  ///
  /// Returns a (possibly empty) list of positions to remove.
  /// The caller (BoardResolver) is responsible for actually removing them and
  /// running gravity/cascade afterward.
  List<GridPosition> computeTargets(BoardGrid board, GridPosition placedPos);

  /// Score multiplier applied to stars removed by this effect.
  /// Defaults to 1. Supernova/BlackHole may use higher values.
  double get scoreMultiplier => 1.0;

  /// Human-readable description (for tooltips/tutorial hooks).
  String get description;
}

/// Registry of all available special star effects.
///
/// Register effects at startup — the pipeline queries this registry.
class SpecialStarRegistry {
  static final Map<StarType, SpecialStarEffect> _effects = {};

  static void register(SpecialStarEffect effect) {
    _effects[effect.type] = effect;
  }

  static SpecialStarEffect? effectFor(StarType type) => _effects[type];

  static bool hasEffect(StarType type) => _effects.containsKey(type);

  /// Register all built-in special star effects.
  ///
  /// Concrete effect instances must be registered by the caller (StarShooterGame)
  /// since they live in separate files to avoid circular imports:
  ///
  ///   SpecialStarRegistry.register(MeteorEffect());
  ///   SpecialStarRegistry.register(RainbowEffect());
  ///   SpecialStarRegistry.register(SupernovaEffect());
  ///   SpecialStarRegistry.register(BlackHoleEffect());
  ///   SpecialStarRegistry.register(FrozenStarEffect());
  ///
  /// See StarShooterGame.onLoad() for the authoritative call site.
  static void registerDefaults() {
    // Registration is performed by StarShooterGame.onLoad() which imports all
    // concrete effect files. This method is kept as a no-op hook so the call
    // site remains unchanged if registration logic is centralised here later.
  }
}
