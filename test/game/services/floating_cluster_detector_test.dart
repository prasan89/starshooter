import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/game/models/board_grid.dart';
import 'package:star_shooter/game/models/grid_position.dart';
import 'package:star_shooter/game/models/star_model.dart';
import 'package:star_shooter/game/models/star_type.dart';
import 'package:star_shooter/game/services/floating_cluster_detector.dart';

void main() {
  group('FloatingClusterDetector', () {
    BoardGrid buildGrid(List<(int, int)> positions) {
      var g = BoardGrid();
      for (final (r, c) in positions) {
        final pos = GridPosition(r, c);
        g = g.placeStar(
          StarModel.create(type: StarType.normal, gridPosition: pos),
          pos,
        );
      }
      return g;
    }

    test('empty board has no floaters', () {
      expect(FloatingClusterDetector.findFloatingStars(BoardGrid()), isEmpty);
    });

    test('star in row 0 is always supported', () {
      final g = buildGrid([(0, 0)]);
      expect(FloatingClusterDetector.findFloatingStars(g), isEmpty);
    });

    test('star in row 1 connected to row 0 is supported', () {
      // Row 0 col 0 supports row 1 col 0 (they are neighbours in even-row hex)
      final g = buildGrid([(0, 0), (1, 0)]);
      expect(FloatingClusterDetector.findFloatingStars(g), isEmpty);
    });

    test('isolated star below row 0 is floating', () {
      // Only a star at row 3 — nothing connects to row 0
      final g = buildGrid([(3, 3)]);
      expect(FloatingClusterDetector.findFloatingStars(g), hasLength(1));
    });

    test('chain disconnected from top is all floating', () {
      // Row 2 and 3 stars, no row 0 — all float
      final g = buildGrid([(2, 0), (2, 1), (3, 0)]);
      expect(FloatingClusterDetector.findFloatingStars(g), hasLength(3));
    });

    test('mixed: connected and floating clusters', () {
      // Row 0 col 0 + row 1 col 0 (supported chain)
      // Row 5 col 5 (isolated floater)
      final g = buildGrid([(0, 0), (1, 0), (5, 5)]);
      final floaters = FloatingClusterDetector.findFloatingStars(g);
      expect(floaters, hasLength(1));
      expect(floaters.first, equals(const GridPosition(5, 5)));
    });
  });
}
