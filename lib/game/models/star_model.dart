import 'package:flutter/painting.dart';
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

  /// Color variant index (0–4) for [StarType.normal] stars.
  /// Maps to [StarColor.fromIndex]. Ignored for special star types.
  final int colorIndex;

  /// Remaining hits needed to thaw this star.
  ///
  /// Always `0` for non-frozen stars.  For [StarType.frozenStar] this starts
  /// at [SpecialStarConfig.frozenThawHits] and decrements with each adjacent
  /// match; the star is fully thawed when it reaches `0`.
  final int frozenHitsRemaining;

  const StarModel({
    required this.id,
    required this.type,
    required this.gridPosition,
    required this.state,
    this.collisionRadius = 20.0,
    this.colorIndex = 0,
    this.frozenHitsRemaining = 0,
  });

  // ── ID generation ────────────────────────────────────────────────────────

  static int _idCounter = 0;

  static String _nextId() => 'star_${_idCounter++}';

  // ── Factories ─────────────────────────────────────────────────────────────

  /// Creates a new star placed at [gridPosition] in the [idle] state.
  factory StarModel.create({
    required StarType type,
    required GridPosition gridPosition,
    int colorIndex = 0,
    int frozenHitsRemaining = 0,
  }) =>
      StarModel(
        id: _nextId(),
        type: type,
        gridPosition: gridPosition,
        state: StarState.idle,
        colorIndex: colorIndex,
        frozenHitsRemaining: frozenHitsRemaining,
      );

  /// Creates a star that has just been loaded into the launcher.
  factory StarModel.projectile({required StarType type, int colorIndex = 0}) => StarModel(
        id: _nextId(),
        type: type,
        gridPosition: GridPosition.invalid(),
        state: StarState.projectile,
        colorIndex: colorIndex,
        frozenHitsRemaining: 0,
      );

  // ── Mutation helpers ──────────────────────────────────────────────────────

  /// Returns a copy of this model with the given fields replaced.
  StarModel copyWith({
    String? id,
    StarType? type,
    GridPosition? gridPosition,
    StarState? state,
    double? collisionRadius,
    int? colorIndex,
    int? frozenHitsRemaining,
  }) =>
      StarModel(
        id: id ?? this.id,
        type: type ?? this.type,
        gridPosition: gridPosition ?? this.gridPosition,
        state: state ?? this.state,
        collisionRadius: collisionRadius ?? this.collisionRadius,
        colorIndex: colorIndex ?? this.colorIndex,
        frozenHitsRemaining: frozenHitsRemaining ?? this.frozenHitsRemaining,
      );

  // ── Frozen star helpers ───────────────────────────────────────────────────

  /// The display color for this star.
  /// Normal stars use [colorIndex] to pick a [StarColor]; special stars use their fixed color.
  Color get displayColor => type == StarType.normal
      ? StarColor.fromIndex(colorIndex).color
      : type.color;

  /// `true` when this is a [StarType.frozenStar] that still needs more hits.
  bool get isFrozen => type == StarType.frozenStar && frozenHitsRemaining > 0;

  /// `true` when this is a [StarType.frozenStar] whose hit count has
  /// reached zero — i.e. it has been thawed and can now be matched normally.
  bool get isThawed => type == StarType.frozenStar && frozenHitsRemaining <= 0;

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
