import 'package:star_shooter/game/models/board_grid.dart';
import 'package:star_shooter/game/models/grid_position.dart';
import 'package:star_shooter/game/level/level_objective.dart';

/// Tracks progress towards a [LevelObjective] during a game session.
///
/// Call [onResolution] after each BoardResolver.resolve() to update counts.
/// Call [isSatisfied] to check whether the level should end.
class ObjectiveEvaluator {
  final LevelObjective objective;

  int _scoreAccumulated = 0;
  int _starsCleared = 0;
  int _targetTypeCleared = 0;
  int _specialCleared = 0;

  ObjectiveEvaluator({required this.objective});

  /// Update tracking after a resolution cycle.
  void onResolution({
    required int scoreGained,
    required List<GridPosition> matchedPositions,
    required List<GridPosition> floatingPositions,
    required List<GridPosition> specialEffectPositions,
    required BoardGrid board, // board BEFORE resolution (to read star types)
  }) {
    _scoreAccumulated += scoreGained;
    final allRemoved = [
      ...matchedPositions,
      ...floatingPositions,
      ...specialEffectPositions,
    ];
    _starsCleared += allRemoved.length;

    if (objective.type == ObjectiveType.clearStarType &&
        objective.targetStarType != null) {
      for (final pos in allRemoved) {
        final star = board.starAt(pos);
        if (star != null && star.type == objective.targetStarType) {
          _targetTypeCleared++;
        }
      }
    }
    if (objective.type == ObjectiveType.clearSpecial) {
      for (final pos in specialEffectPositions) {
        final star = board.starAt(pos);
        if (star != null && star.type.isSpecial) {
          _specialCleared++;
        }
      }
    }
  }

  /// True when the objective has been met.
  bool get isSatisfied {
    switch (objective.type) {
      case ObjectiveType.scoreTarget:
        return _scoreAccumulated >= objective.target;
      case ObjectiveType.clearStars:
        return _starsCleared >= objective.target;
      case ObjectiveType.clearStarType:
        return _targetTypeCleared >= objective.target;
      case ObjectiveType.clearSpecial:
        return _specialCleared >= objective.target;
    }
  }

  /// Current progress value (for HUD display).
  int get currentProgress {
    switch (objective.type) {
      case ObjectiveType.scoreTarget:
        return _scoreAccumulated;
      case ObjectiveType.clearStars:
        return _starsCleared;
      case ObjectiveType.clearStarType:
        return _targetTypeCleared;
      case ObjectiveType.clearSpecial:
        return _specialCleared;
    }
  }

  int get target => objective.target;

  /// 0.0 – 1.0 completion fraction (capped at 1.0).
  double get progressFraction => (currentProgress / target).clamp(0.0, 1.0);

  void reset() {
    _scoreAccumulated = 0;
    _starsCleared = 0;
    _targetTypeCleared = 0;
    _specialCleared = 0;
  }
}
