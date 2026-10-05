import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:star_shooter/game/models/shooter_game_state.dart';
import 'package:star_shooter/game/models/star_type.dart';
import 'package:star_shooter/game/special/special_star_spawner.dart';

/// Manages the turn state machine for Star Shooter.
///
/// Transitions: Ready → Aiming → Shooting → Resolving → Ready
/// (or → GameFailed when moves run out).
///
/// Extends [ChangeNotifier] so the UI and game components can rebuild
/// whenever the state changes.
class TurnSystem with ChangeNotifier {
  ShooterGameState _state = ShooterGameState.ready;
  StarType _currentStarType = StarType.normal;
  StarType _nextStarType = StarType.normal;
  int _movesRemaining = 20;
  int _score = 0;

  /// Seeded random for deterministic star-type generation across runs.
  final Random _random = Random(42);

  /// Optional spawner that controls star-type selection when set.
  SpecialStarSpawner? _spawner;

  // ── Getters ────────────────────────────────────────────────────────────────

  ShooterGameState get state => _state;
  StarType get currentStarType => _currentStarType;
  StarType get nextStarType => _nextStarType;
  int get movesRemaining => _movesRemaining;
  int get score => _score;

  /// True when the player is allowed to fire a shot.
  bool get canShoot =>
      _state == ShooterGameState.ready || _state == ShooterGameState.aiming;

  // ── Lifecycle ──────────────────────────────────────────────────────────────

  /// Resets the turn system for a new level with [moves] remaining shots.
  ///
  /// An optional [spawner] may be supplied to drive weighted star-type
  /// selection; without one the system falls back to [StarType.normal].
  void initialize(int moves, {SpecialStarSpawner? spawner}) {
    _spawner = spawner;
    _movesRemaining = moves;
    _currentStarType = StarType.normal;
    _nextStarType = StarType.normal;
    _score = 0;
    _transitionTo(ShooterGameState.ready);
  }

  // ── State transitions ──────────────────────────────────────────────────────

  /// Player begins dragging to aim; moves from [ready] → [aiming].
  void startAiming() {
    if (_state != ShooterGameState.ready) return;
    _transitionTo(ShooterGameState.aiming);
  }

  /// Player lifts finger without firing; reverts [aiming] → [ready].
  void cancelAim() {
    if (_state != ShooterGameState.aiming) return;
    _transitionTo(ShooterGameState.ready);
  }

  /// Player fires; consumes one move and moves to [shooting].
  void shoot() {
    if (!canShoot) return;
    _movesRemaining--;
    _transitionTo(ShooterGameState.shooting);
  }

  /// Called by the projectile component once it has snapped to the board.
  void onProjectileLanded() {
    if (_state != ShooterGameState.shooting) return;
    _transitionTo(ShooterGameState.resolving);
  }

  /// Called once match/gravity resolution is complete.
  ///
  /// [scoreGained] is added to the running total before advancing.
  void onResolvingComplete({int scoreGained = 0}) {
    _score += scoreGained;
    _advanceToNextTurn();
  }

  /// Pauses the game loop; idempotent if already [paused].
  void pause() {
    if (_state == ShooterGameState.paused) return;
    _transitionTo(ShooterGameState.paused);
  }

  /// Resumes from a paused state back to [ready].
  void resume() {
    if (_state != ShooterGameState.paused) return;
    _transitionTo(ShooterGameState.ready);
  }

  // ── Internal helpers ───────────────────────────────────────────────────────

  void _advanceToNextTurn() {
    _currentStarType = _nextStarType;
    _nextStarType = _randomStarType();
    if (_movesRemaining <= 0) {
      _transitionTo(ShooterGameState.gameFailed);
    } else {
      _transitionTo(ShooterGameState.ready);
    }
  }

  /// Returns the star type for the next shot.
  ///
  /// Delegates to [_spawner] when one is set; otherwise falls back to
  /// [StarType.normal] (original M2 behaviour).
  StarType _randomStarType() {
    if (_spawner != null) return _spawner!.nextType();
    // ignore: unused_local_variable — kept for parity with seeded RNG usage.
    final _ = _random.nextDouble();
    return StarType.normal;
  }

  void _transitionTo(ShooterGameState next) {
    _state = next;
    notifyListeners();
  }
}
