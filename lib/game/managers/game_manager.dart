import 'package:flutter/foundation.dart';

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
  ShooterGameState _shooterState = ShooterGameState.ready;

  // ── Combo / scoring fields ────────────────────────────────────────────────

  int _comboLevel = 0;
  bool _boardCleared = false;
  int _totalStarsPopped = 0;

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
  ShooterGameState get shooterState => _shooterState;

  int get comboLevel => _comboLevel;
  bool get hasActiveCombo => _comboLevel > 1;
  bool get boardCleared => _boardCleared;
  int get totalStarsPopped => _totalStarsPopped;

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
  void initLevel(int levelId, {int moves = 20, int starsReq = 5}) {
    _level = levelId;
    _score = 0;
    _stars = 0;
    _movesRemaining = moves;
    _movesTotal = moves;
    _starsEarned = 0;
    _starsRequired = starsReq;
    _currentStarType = StarType.normal;
    _nextStarType = StarType.normal;
    _shooterState = ShooterGameState.ready;
    _comboLevel = 0;
    _boardCleared = false;
    _totalStarsPopped = 0;
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
    notifyListeners();
  }

  /// Records that the player has fired a shot by decrementing [_movesRemaining].
  void onShot() {
    if (_movesRemaining > 0) {
      _movesRemaining--;
    }
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
  void advanceTurn(StarType nextCurrent, StarType nextNext) {
    _currentStarType = nextCurrent;
    _nextStarType = nextNext;
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
  }) {
    _score += scoreGained;
    _comboLevel = comboLevel;
    _totalStarsPopped += starsPopped + floatingDropped;
    _boardCleared = boardCleared;
    if (boardCleared) {
      _state = GameState.levelComplete;
    }
    notifyListeners();
  }
}
