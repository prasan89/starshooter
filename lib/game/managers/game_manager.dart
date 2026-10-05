import 'package:flutter/foundation.dart';

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

  // ── Getters ──────────────────────────────────────────────────────────────

  GameState get state => _state;
  int get score => _score;
  int get level => _level;
  int get stars => _stars;

  bool get isPlaying => _state == GameState.playing;
  bool get isPaused => _state == GameState.paused;
  bool get isComplete => _state == GameState.levelComplete;
  bool get isGameOver => _state == GameState.gameOver;

  // ── Actions ──────────────────────────────────────────────────────────────

  /// Initialises a new session for [levelId] and transitions to [GameState.playing].
  void startLevel(int levelId) {
    _level = levelId;
    _score = 0;
    _stars = 0;
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
    notifyListeners();
  }
}
