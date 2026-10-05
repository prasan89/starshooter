import 'dart:collection';
import 'dart:math' show Random;
import 'dart:ui' show Offset, Rect;

import 'package:star_shooter/game/models/board_config.dart';
import 'package:star_shooter/game/models/grid_position.dart';
import 'package:star_shooter/game/models/star_model.dart';
import 'package:star_shooter/game/models/star_type.dart';

/// Pure-Dart, immutable hex-grid data model for the Star Shooter board.
///
/// Uses offset coordinates: even rows start at column 0; odd rows are shifted
/// right by half a cell width (the standard "offset hex" layout).
///
/// All mutation methods return a *new* [BoardGrid] instance rather than
/// modifying the receiver, making the model trivially safe to use in tests and
/// in widget / component state.
class BoardGrid {
  final BoardConfig config;

  /// Internal star registry keyed by grid position.
  ///
  /// [LinkedHashMap] preserves insertion order, which makes iteration
  /// deterministic and simplifies snapshot-based tests.
  final Map<GridPosition, StarModel> _stars;

  BoardGrid({BoardConfig? config})
      : config = config ?? BoardConfig.standard,
        _stars = {};

  /// Private constructor used by the immutable mutation helpers.
  BoardGrid._withStars({
    required this.config,
    required Map<GridPosition, StarModel> stars,
  }) : _stars = LinkedHashMap<GridPosition, StarModel>.from(stars);

  // ── Query ──────────────────────────────────────────────────────────────────

  /// Returns `true` when [pos] already holds a star.
  bool isOccupied(GridPosition pos) => _stars.containsKey(pos);

  /// Returns the [StarModel] at [pos], or `null` if the cell is empty.
  StarModel? starAt(GridPosition pos) => _stars[pos];

  /// All stars currently on the board, in insertion order.
  List<StarModel> get allStars => _stars.values.toList();

  /// All occupied positions, in insertion order.
  List<GridPosition> get occupiedPositions => _stars.keys.toList();

  /// Returns `true` when [pos] refers to a real cell inside the board boundary.
  ///
  /// Even rows span columns `0 …< config.cols`.
  /// Odd rows span columns `0 …< config.cols - 1`.
  bool isValidPosition(GridPosition pos) {
    if (pos.row < 0 || pos.row >= config.rows) return false;
    if (pos.col < 0) return false;
    final maxCols = pos.row.isOdd ? config.cols - 1 : config.cols;
    return pos.col < maxCols;
  }

  // ── Mutation (immutable style) ─────────────────────────────────────────────

  /// Returns a new [BoardGrid] with [star] placed at [pos].
  ///
  /// Any star previously at [pos] is silently replaced.
  BoardGrid placeStar(StarModel star, GridPosition pos) {
    final updated = LinkedHashMap<GridPosition, StarModel>.from(_stars)
      ..[pos] = star;
    return BoardGrid._withStars(config: config, stars: updated);
  }

  /// Returns a new [BoardGrid] with the star at [pos] removed.
  ///
  /// If [pos] is empty this is a no-op and the same logical board is returned.
  BoardGrid removeStar(GridPosition pos) {
    if (!_stars.containsKey(pos)) return this;
    final updated = LinkedHashMap<GridPosition, StarModel>.from(_stars)
      ..remove(pos);
    return BoardGrid._withStars(config: config, stars: updated);
  }

  /// Returns a new [BoardGrid] with all stars at [positions] removed.
  BoardGrid removeStars(List<GridPosition> positions) {
    final updated = LinkedHashMap<GridPosition, StarModel>.from(_stars);
    for (final pos in positions) {
      updated.remove(pos);
    }
    return BoardGrid._withStars(config: config, stars: updated);
  }

  // ── Hex neighbour calculation ──────────────────────────────────────────────

  /// Returns the (up to 6) valid hex neighbours of [pos].
  ///
  /// Offset-hex neighbourhoods differ by row parity:
  ///
  /// * **Even row** neighbours of `(r, c)`:
  ///   `(r-1,c-1)`, `(r-1,c)`, `(r,c-1)`, `(r,c+1)`, `(r+1,c-1)`, `(r+1,c)`
  ///
  /// * **Odd row** neighbours of `(r, c)`:
  ///   `(r-1,c)`, `(r-1,c+1)`, `(r,c-1)`, `(r,c+1)`, `(r+1,c)`, `(r+1,c+1)`
  List<GridPosition> neighborsOf(GridPosition pos) {
    final r = pos.row;
    final c = pos.col;

    final List<GridPosition> candidates;
    if (r.isEven) {
      candidates = [
        GridPosition(r - 1, c - 1),
        GridPosition(r - 1, c),
        GridPosition(r, c - 1),
        GridPosition(r, c + 1),
        GridPosition(r + 1, c - 1),
        GridPosition(r + 1, c),
      ];
    } else {
      candidates = [
        GridPosition(r - 1, c),
        GridPosition(r - 1, c + 1),
        GridPosition(r, c - 1),
        GridPosition(r, c + 1),
        GridPosition(r + 1, c),
        GridPosition(r + 1, c + 1),
      ];
    }

    return candidates.where(isValidPosition).toList();
  }

  // ── Pixel ↔ Grid coordinate conversion ────────────────────────────────────

  /// Converts a pixel [pixel] inside [boardRect] to the nearest grid cell.
  ///
  /// Returns [GridPosition.invalid()] when the pixel is outside the board.
  GridPosition pixelToGrid(Offset pixel, Rect boardRect) {
    final localX = pixel.dx - boardRect.left;
    final localY = pixel.dy - boardRect.top;

    // Estimate the row from the y coordinate.
    final row = ((localY - config.starRadius) / config.cellHeight).floor();

    // Account for the half-cell offset on odd rows.
    final xOffset = row.isOdd ? config.cellWidth * 0.5 : 0.0;
    final col =
        ((localX - xOffset - config.starRadius) / config.cellWidth).floor();

    final candidate = GridPosition(row, col);
    if (!isValidPosition(candidate)) return GridPosition.invalid();
    return candidate;
  }

  /// Returns the pixel centre of the cell at [pos] within [boardRect].
  Offset gridToPixel(GridPosition pos, Rect boardRect) {
    final xOffset = pos.row.isOdd ? config.cellWidth * 0.5 : 0.0;
    final x = boardRect.left +
        xOffset +
        pos.col * config.cellWidth +
        config.starRadius;
    final y = boardRect.top + pos.row * config.cellHeight + config.starRadius;
    return Offset(x, y);
  }

  // ── Match detection (M3 stub) ──────────────────────────────────────────────

  /// Returns the positions of all stars that form a match.
  ///
  /// Stubbed for M2 — full flood-fill / colour-group logic is implemented in
  /// Milestone 3.
  List<GridPosition> findMatches() => [];

  // ── Frozen star queries ───────────────────────────────────────────────────

  /// Returns all positions occupied by [StarType.frozenStar] stars that are
  /// still frozen (i.e. [StarModel.isFrozen] is `true`).
  List<GridPosition> get frozenPositions =>
      occupiedPositions.where((p) => _stars[p]!.isFrozen).toList();

  /// Returns the set of distinct [StarModel.colorIndex] values present on the
  /// board in the [rows] lowest-numbered rows that actually contain stars.
  ///
  /// "Lowest" here means highest row index — the stars nearest to the shooter.
  /// Used to seed the launcher with a color that exists near the landing zone.
  Set<int> colorsInBottomRows({int rows = 2}) {
    if (_stars.isEmpty) return {0, 1, 2, 3, 4};

    // Find the highest occupied row (closest to the shooter).
    int maxRow = 0;
    for (final pos in _stars.keys) {
      if (pos.row > maxRow) maxRow = pos.row;
    }

    final result = <int>{};
    for (final entry in _stars.entries) {
      final pos = entry.key;
      final star = entry.value;
      if (star.type == StarType.normal && pos.row >= maxRow - rows + 1) {
        result.add(star.colorIndex);
      }
    }
    // Fall back to all normal star colors on the board.
    if (result.isEmpty) {
      for (final star in _stars.values) {
        if (star.type == StarType.normal) result.add(star.colorIndex);
      }
    }
    return result;
  }

  // ── Factory: initial level board ──────────────────────────────────────────

  /// Builds the starting board for level 1 by populating the top [rows] rows
  /// with [StarType.normal] stars in the standard hex offset pattern.
  static BoardGrid initialBoard({int rows = 5, int seed = 42}) {
    final grid = BoardGrid();
    var current = grid;
    final rng = Random(seed);
    for (int r = 0; r < rows; r++) {
      final colCount = r.isOdd ? grid.config.cols - 1 : grid.config.cols;
      for (int c = 0; c < colCount; c++) {
        final pos = GridPosition(r, c);
        final star = StarModel.create(
          type: StarType.normal,
          gridPosition: pos,
          colorIndex: rng.nextInt(StarColor.values.length),
        );
        current = current.placeStar(star, pos);
      }
    }
    return current;
  }

  /// Builds a board from an explicit list of `(GridPosition, StarType)` pairs.
  ///
  /// Useful for constructing levels that contain special stars (frozen, meteor,
  /// rainbow, etc.).  For each placement, [StarModel.create] is called with
  /// [frozenHitsRemaining] pre-set to `2` when the type is
  /// [StarType.frozenStar], and `0` otherwise.
  static BoardGrid withPlacements(
    List<(GridPosition, StarType)> placements, {
    BoardConfig? config,
    int seed = 42,
  }) {
    var grid = BoardGrid(config: config);
    final rng = Random(seed);
    for (final (pos, type) in placements) {
      final star = StarModel.create(
        type: type,
        gridPosition: pos,
        colorIndex: type == StarType.normal ? rng.nextInt(StarColor.values.length) : 0,
        frozenHitsRemaining: type == StarType.frozenStar ? 2 : 0,
      );
      grid = grid.placeStar(star, pos);
    }
    return grid;
  }
}
