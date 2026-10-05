import 'dart:math' show Random;

import 'package:flutter/foundation.dart';

import 'package:star_shooter/game/level/level_objective.dart';
import 'package:star_shooter/game/level/objective_evaluator.dart';
import 'package:star_shooter/game/models/board_grid.dart';
import 'package:star_shooter/game/models/grid_position.dart';
import 'package:star_shooter/game/models/level_definition.dart';
import 'package:star_shooter/game/models/shooter_game_state.dart';
import 'package:star_shooter/game/models/star_type.dart';

/// Possible states the game session can be in.
enum GameState {
  /// Assets / level data are still being loaded.
  loading,

  /// The player is actively playing.
  playing,

  /// The player has paused the game.
  paused,

  /// The current level has been completed.
  levelComplete,

  /// No shots remain and the level is not yet complete.
  gameOver,
}

/// Manages transient game-session state and notifies listeners on change.
///
/// This manager is intentionally lightweight in M1 — it holds in-memory state
/// only. Persistence and deeper game logic are layered on in M2.
class GameManager extends ChangeNotifier {
  GameState _state = GameState.loading;
  int _score = 0;
  int _level = 1;
  int _stars = 0;

  // ── Shooter-specific fields ───────────────────────────────────────────────

  int _movesRemaining = 20;
  int _movesTotal = 20;
  int _starsEarned = 0;
  int _starsRequired = 5;
  StarType _currentStarType = StarType.normal;
  StarType _nextStarType = StarType.normal;
  int _currentColorIndex = 0;
  int _nextColorIndex = 1;
  ShooterGameState _shooterState = ShooterGameState.ready;

  // ── Combo / scoring fields ────────────────────────────────────────────────

  int _comboLevel = 0;
  bool _boardCleared = false;
  int _totalStarsPopped = 0;

  // ── Objective fields ──────────────────────────────────────────────────────

  ObjectiveEvaluator? _objectiveEvaluator;
  LevelObjective? _currentObjective;

  // ── Getters ──────────────────────────────────────────────────────────────

  GameState get state => _state;
  int get score => _score;
  int get level => _level;
  int get stars => _stars;

  bool get isPlaying => _state == GameState.playing;
  bool get isPaused => _state == GameState.paused;
  bool get isComplete => _state == GameState.levelComplete;
  bool get isGameOver => _state == GameState.gameOver;

  int get movesRemaining => _movesRemaining;
  int get movesTotal => _movesTotal;
  int get totalMoves => _movesTotal;
  int get starsEarned => _starsEarned;
  int get starsRequired => _starsRequired;
  StarType get currentStarType => _currentStarType;
  StarType get nextStarType => _nextStarType;
  int get currentColorIndex => _currentColorIndex;
  int get nextColorIndex => _nextColorIndex;
  ShooterGameState get shooterState => _shooterState;

  int get comboLevel => _comboLevel;
  bool get hasActiveCombo => _comboLevel > 1;
  bool get boardCleared => _boardCleared;
  int get totalStarsPopped => _totalStarsPopped;

  // ── Objective getters ─────────────────────────────────────────────────────

  int get objectiveProgress => _objectiveEvaluator?.currentProgress ?? 0;
  int get objectiveTarget => _objectiveEvaluator?.target ?? 100;
  double get objectiveProgressFraction =>
      _objectiveEvaluator?.progressFraction ?? 0.0;
  String get objectiveDisplayText => _currentObjective?.displayText ?? '';

  // ── Actions ──────────────────────────────────────────────────────────────

  /// Initialises a new session for [levelId] and transitions to [GameState.playing].
  void startLevel(int levelId) {
    _level = levelId;
    _score = 0;
    _stars = 0;
    _state = GameState.playing;
    notifyListeners();
  }

  /// Initialises shooter-specific state for [levelId] and transitions to
  /// [GameState.playing].
  ///
  /// [moves] sets both the remaining and total move counts.
  /// [starsReq] sets the number of stars the player must earn to pass the level.
  /// [levelDef] wires the objective evaluator when provided.
  /// [boardColors] restricts the initial launcher colors to those actually on
  /// the board, guaranteeing the first shot can make a match.
  void initLevel(
    int levelId, {
    int moves = 20,
    int starsReq = 5,
    LevelDefinition? levelDef,
    int seed = 42,
    Set<int>? boardColors,
  }) {
    _level = levelId;
    _score = 0;
    _stars = 0;
    _movesRemaining = moves;
    _movesTotal = moves;
    _starsEarned = 0;
    _starsRequired = starsReq;
    _currentStarType = StarType.normal;
    _nextStarType = StarType.normal;
    // Pick initial launcher colors from the colors actually on the board so
    // the first shot always has a realistic chance of making a match.
    final rng = Random(seed);
    final palette = boardColors != null && boardColors.isNotEmpty
        ? boardColors.toList()
        : List.generate(5, (i) => i);
    _currentColorIndex = palette[rng.nextInt(palette.length)];
    _nextColorIndex = palette[rng.nextInt(palette.length)];
    _shooterState = ShooterGameState.ready;
    _comboLevel = 0;
    _boardCleared = false;
    _totalStarsPopped = 0;
    if (levelDef != null) {
      _currentObjective = levelDef.objective;
      _objectiveEvaluator = ObjectiveEvaluator(objective: levelDef.objective);
    } else {
      _currentObjective = null;
      _objectiveEvaluator = null;
    }
    _state = GameState.playing;
    notifyListeners();
  }

  /// Freezes updates; the player can resume via [resumeGame].
  void pauseGame() {
    if (_state != GameState.playing) return;
    _state = GameState.paused;
    notifyListeners();
  }

  /// Resumes from a paused state.
  void resumeGame() {
    if (_state != GameState.paused) return;
    _state = GameState.playing;
    notifyListeners();
  }

  /// Adds [points] to the running score (clamped to 0).
  void addScore(int points) {
    if (_state != GameState.playing) return;
    _score = (_score + points).clamp(0, double.maxFinite.toInt());
    notifyListeners();
  }

  /// Marks the level as complete with the given star rating (0-3).
  void completeLevel({required int stars}) {
    if (_state == GameState.levelComplete) return;
    _stars = stars.clamp(0, 3);
    _state = GameState.levelComplete;
    notifyListeners();
  }

  /// Transitions to the game-over state (no shots remaining).
  void gameOver() {
    if (_state == GameState.gameOver) return;
    _state = GameState.gameOver;
    notifyListeners();
  }

  /// Resets all session state back to loading for reuse.
  void reset() {
    _state = GameState.loading;
    _score = 0;
    _level = 1;
    _stars = 0;
    _movesRemaining = 20;
    _movesTotal = 20;
    _starsEarned = 0;
    _starsRequired = 5;
    _currentStarType = StarType.normal;
    _nextStarType = StarType.normal;
    _shooterState = ShooterGameState.ready;
    _comboLevel = 0;
    _boardCleared = false;
    _totalStarsPopped = 0;
    _currentObjective = null;
    _objectiveEvaluator = null;
    notifyListeners();
  }

  /// Records that the player has fired a shot by decrementing
  /// [_movesRemaining].
  ///
  /// Exhausting the final shot does NOT immediately show game-over. The
  /// projectile still has to land and the board must finish resolving because
  /// the final shot may complete the objective. The terminal state is decided
  /// by [onResolutionComplete].
  void onShot() {
    if (_state != GameState.playing || _movesRemaining <= 0) return;
    _movesRemaining--;
    notifyListeners();
  }

  /// Adds [count] to [_starsEarned].
  ///
  /// Automatically transitions to [GameState.levelComplete] when
  /// [starsEarned] reaches or exceeds [starsRequired].
  void onStarEarned(int count) {
    _starsEarned += count;
    if (_starsEarned >= _starsRequired) {
      _state = GameState.levelComplete;
    }
    notifyListeners();
  }

  /// Updates the shooter loop state machine.
  void updateShooterState(ShooterGameState state) {
    _shooterState = state;
    notifyListeners();
  }

  /// Advances the star-type queue: [nextCurrent] becomes the current star and
  /// [nextNext] becomes the upcoming (preview) star.
  void advanceTurn(
    StarType nextCurrent,
    StarType nextNext, {
    int currentColorIndex = 0,
    int nextColorIndex = 0,
  }) {
    _currentStarType = nextCurrent;
    _nextStarType = nextNext;
    _currentColorIndex = currentColorIndex;
    _nextColorIndex = nextColorIndex;
    notifyListeners();
  }

  /// Updates the active combo level and notifies listeners.
  void updateCombo(int level) {
    _comboLevel = level;
    notifyListeners();
  }

  /// Called when a shot's full resolution (matches + cascades + floating removal)
  /// is complete. Updates score, combo, pop counts, and board-cleared flag.
  void onResolutionComplete({
    required int scoreGained,
    required int comboLevel,
    required int starsPopped,
    required int floatingDropped,
    required bool boardCleared,
    List<GridPosition> matchedPositions = const [],
    List<GridPosition> floatingPositions = const [],
    List<GridPosition> specialPositions = const [],
    BoardGrid? boardBeforeResolution,
  }) {
    _score += scoreGained;
    _comboLevel = comboLevel;
    _totalStarsPopped += starsPopped + floatingDropped;
    _boardCleared = boardCleared;

    // Update objective evaluator
    if (_objectiveEvaluator != null && boardBeforeResolution != null) {
      _objectiveEvaluator!.onResolution(
        scoreGained: scoreGained,
        matchedPositions: matchedPositions,
        floatingPositions: floatingPositions,
        specialEffectPositions: specialPositions,
        board: boardBeforeResolution,
      );
    }

    // Win detection must happen before the final-shot failure check.
    // A player is allowed to win with their last available shot.
    final objectiveMet = _objectiveEvaluator?.isSatisfied ?? boardCleared;
    if (boardCleared || objectiveMet) {
      _state = GameState.levelComplete;
    } else if (_movesRemaining <= 0) {
      _state = GameState.gameOver;
    }
    notifyListeners();
  }
}
