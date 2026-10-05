/// An immutable (row, col) address in the hex grid.
class GridPosition {
  final int row;
  final int col;

  const GridPosition(this.row, this.col);

  /// A sentinel value meaning "not on the board".
  factory GridPosition.invalid() => const GridPosition(-1, -1);

  /// Returns true when the position refers to a real cell.
  bool get isValid => row >= 0 && col >= 0;

  /// Returns a copy with the given fields replaced.
  GridPosition copyWith({int? row, int? col}) =>
      GridPosition(row ?? this.row, col ?? this.col);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GridPosition &&
          runtimeType == other.runtimeType &&
          row == other.row &&
          col == other.col;

  @override
  int get hashCode => Object.hash(row, col);

  @override
  String toString() => 'GridPosition($row, $col)';
}
