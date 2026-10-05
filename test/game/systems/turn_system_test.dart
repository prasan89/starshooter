import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/game/models/shooter_game_state.dart';
import 'package:star_shooter/game/systems/turn_system.dart';

void main() {
  group('TurnSystem', () {
    late TurnSystem turnSystem;

    setUp(() {
      turnSystem = TurnSystem();
    });

    tearDown(() {
      turnSystem.dispose();
    });

    test('initial state is ready', () {
      expect(turnSystem.state, equals(ShooterGameState.ready));
    });

    test('startAiming transitions to aiming', () {
      turnSystem.startAiming();
      expect(turnSystem.state, equals(ShooterGameState.aiming));
    });

    test('cancelAim transitions back to ready', () {
      turnSystem.startAiming();
      expect(turnSystem.state, equals(ShooterGameState.aiming));
      turnSystem.cancelAim();
      expect(turnSystem.state, equals(ShooterGameState.ready));
    });

    test('shoot decrements movesRemaining', () {
      final initialMoves = turnSystem.movesRemaining;
      turnSystem.shoot();
      expect(turnSystem.movesRemaining, equals(initialMoves - 1));
    });

    test('shoot transitions to shooting', () {
      turnSystem.shoot();
      expect(turnSystem.state, equals(ShooterGameState.shooting));
    });

    test('onProjectileLanded transitions to resolving', () {
      turnSystem.shoot();
      expect(turnSystem.state, equals(ShooterGameState.shooting));
      turnSystem.onProjectileLanded();
      expect(turnSystem.state, equals(ShooterGameState.resolving));
    });

    test('onResolvingComplete adds score and transitions to ready', () {
      turnSystem.shoot();
      turnSystem.onProjectileLanded();
      turnSystem.onResolvingComplete(scoreGained: 100);
      expect(turnSystem.score, equals(100));
      expect(turnSystem.state, equals(ShooterGameState.ready));
    });

    test('when movesRemaining reaches 0 after shot, transitions to gameFailed',
        () {
      // Initialize with only 1 move
      turnSystem.initialize(1);
      expect(turnSystem.movesRemaining, equals(1));

      // Shoot the last move
      turnSystem.shoot();
      expect(turnSystem.movesRemaining, equals(0));

      // Land and resolve — should transition to gameFailed
      turnSystem.onProjectileLanded();
      turnSystem.onResolvingComplete();
      expect(turnSystem.state, equals(ShooterGameState.gameFailed));
    });

    test('pause/resume cycle works', () {
      expect(turnSystem.state, equals(ShooterGameState.ready));

      turnSystem.pause();
      expect(turnSystem.state, equals(ShooterGameState.paused));

      turnSystem.resume();
      expect(turnSystem.state, equals(ShooterGameState.ready));
    });

    test('pause is idempotent', () {
      turnSystem.pause();
      turnSystem.pause(); // second call is a no-op
      expect(turnSystem.state, equals(ShooterGameState.paused));
    });

    test('notifies listeners on state transitions', () {
      int notifyCount = 0;
      turnSystem.addListener(() => notifyCount++);

      turnSystem.startAiming();
      turnSystem.cancelAim();

      expect(notifyCount, greaterThanOrEqualTo(2));
    });

    test('cannot shoot while resolving', () {
      final ts = TurnSystem()
        ..initialize(5)
        ..shoot();
      // Now in shooting state — onProjectileLanded moves to resolving
      ts.onProjectileLanded();
      expect(ts.canShoot, isFalse);
      expect(ts.state, ShooterGameState.resolving);
      ts.dispose();
    });

    test('resolving completes to ready state', () {
      final ts = TurnSystem()
        ..initialize(5)
        ..shoot();
      ts.onProjectileLanded();
      ts.onResolvingComplete(scoreGained: 100);
      expect(ts.state, ShooterGameState.ready);
      ts.dispose();
    });

    test('failure state when moves exhausted', () {
      final ts = TurnSystem()..initialize(1);
      ts.shoot(); // uses last move
      ts.onProjectileLanded();
      ts.onResolvingComplete();
      expect(ts.state, ShooterGameState.gameFailed);
      ts.dispose();
    });
  });
}
