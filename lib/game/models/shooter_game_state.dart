/// The high-level state of the shooter game loop.
enum ShooterGameState {
  /// Launcher is loaded; waiting for the player to touch.
  ready,

  /// Player is dragging to aim; trajectory line is visible.
  aiming,

  /// Star is in flight toward the board.
  shooting,

  /// Checking matches and applying gravity after placement.
  resolving,

  /// Board has settled; waiting for the player's next shot.
  waitingForInput,

  /// Game is paused.
  paused,

  /// All stars on the board have been cleared.
  levelComplete,

  /// Player has run out of shots without clearing the board.
  gameFailed;

  /// True when the player can interact with the launcher.
  bool get isInteractive =>
      this == ShooterGameState.ready || this == ShooterGameState.aiming;

  /// True while the game is mid-animation and input is blocked.
  bool get isAnimating =>
      this == ShooterGameState.shooting || this == ShooterGameState.resolving;
}
