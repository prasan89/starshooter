/// The lifecycle state of a single star instance.
enum StarState {
  /// Sitting on the board in its grid cell, not animating.
  idle,

  /// Currently in flight after being shot from the launcher.
  projectile,

  /// Settling into its target grid position (brief transition).
  snapping,

  /// Flagged as part of a match — will be removed next frame.
  matched,

  /// Playing the removal animation.
  removing,

  /// Fully removed from the board.
  removed,
}
