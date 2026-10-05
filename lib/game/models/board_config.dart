/// Immutable configuration for the hex star grid.
class BoardConfig {
  final int rows;
  final int cols;
  final double starRadius;
  final double padding;

  const BoardConfig({
    this.rows = 8,
    this.cols = 9,
    this.starRadius = 22.0,
    this.padding = 4.0,
  });

  /// Diameter of one star cell.
  double get starDiameter => starRadius * 2;

  /// Width of one grid column (diameter + padding).
  double get cellWidth => starDiameter + padding;

  /// Height of one hex row (uses the hex vertical spacing ratio).
  double get cellHeight => (starDiameter + padding) * 0.866;

  /// The default board used throughout the game.
  static const BoardConfig standard = BoardConfig();
}
