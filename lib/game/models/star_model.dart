import 'package:star_shooter/game/models/grid_position.dart';
import 'package:star_shooter/game/models/star_state.dart';
import 'package:star_shooter/game/models/star_type.dart';

/// An immutable data record for a single star on the board.
class StarModel {
  final String id;
  final StarType type;
  final GridPosition gridPosition;
  final StarState state;
  final double collisionRadius;

  const StarModel({
    required this.id,
    required this.type,
    required this.gridPosition,
    required this.state,
    this.collisionRadius = 20.0,
  });

  // ── ID generation ────────────────────────────────────────────────────────

  static int _idCounter = 0;

  static String _nextId() => 'star_${_idCounter++}';

  // ── Factories ─────────────────────────────────────────────────────────────

  /// Creates a new star placed at [gridPosition] in the [idle] state.
  factory StarModel.create({
    required StarType type,
    required GridPosition gridPosition,
  }) =>
      StarModel(
        id: _nextId(),
        type: type,
        gridPosition: gridPosition,
        state: StarState.idle,
      );

  /// Creates a star that has just been loaded into the launcher.
  factory StarModel.projectile({required StarType type}) => StarModel(
        id: _nextId(),
        type: type,
        gridPosition: GridPosition.invalid(),
        state: StarState.projectile,
      );

  // ── Mutation helpers ──────────────────────────────────────────────────────

  /// Returns a copy of this model with the given fields replaced.
  StarModel copyWith({
    String? id,
    StarType? type,
    GridPosition? gridPosition,
    StarState? state,
    double? collisionRadius,
  }) =>
      StarModel(
        id: id ?? this.id,
        type: type ?? this.type,
        gridPosition: gridPosition ?? this.gridPosition,
        state: state ?? this.state,
        collisionRadius: collisionRadius ?? this.collisionRadius,
      );

  // ── Equality (identity is the id) ─────────────────────────────────────────

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StarModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'StarModel(id: $id, type: $type, pos: $gridPosition, state: $state)';
}
