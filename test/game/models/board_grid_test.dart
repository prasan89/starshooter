import 'dart:ui' show Rect;

import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/game/models/board_config.dart';
import 'package:star_shooter/game/models/board_grid.dart';
import 'package:star_shooter/game/models/grid_position.dart';
import 'package:star_shooter/game/models/star_model.dart';
import 'package:star_shooter/game/models/star_type.dart';

void main() {
  group('BoardGrid', () {
    late BoardGrid emptyGrid;

    setUp(() {
      emptyGrid = BoardGrid();
    });

    test('starts empty', () {
      expect(emptyGrid.allStars, isEmpty);
      expect(emptyGrid.occupiedPositions, isEmpty);
    });

    group('placeStar', () {
      test('adds a star and occupiedPositions includes it', () {
        const pos = GridPosition(0, 0);
        final star = StarModel.create(type: StarType.normal, gridPosition: pos);
        final grid = emptyGrid.placeStar(star, pos);

        expect(grid.occupiedPositions, contains(pos));
        expect(grid.allStars, hasLength(1));
        expect(grid.starAt(pos), equals(star));
      });
    });

    group('isOccupied', () {
      test('returns false on empty grid', () {
        expect(emptyGrid.isOccupied(const GridPosition(0, 0)), isFalse);
      });

      test('returns true after placement', () {
        const pos = GridPosition(0, 0);
        final star = StarModel.create(type: StarType.normal, gridPosition: pos);
        final grid = emptyGrid.placeStar(star, pos);
        expect(grid.isOccupied(pos), isTrue);
      });
    });

    group('removeStar', () {
      test('removes the star from the grid', () {
        const pos = GridPosition(0, 0);
        final star = StarModel.create(type: StarType.normal, gridPosition: pos);
        final grid = emptyGrid.placeStar(star, pos).removeStar(pos);

        expect(grid.isOccupied(pos), isFalse);
        expect(grid.allStars, isEmpty);
      });

      test('no-op when position is empty', () {
        const pos = GridPosition(1, 1);
        final grid = emptyGrid.removeStar(pos);
        // removeStar on empty returns same logical board (still empty)
        expect(grid.allStars, isEmpty);
      });
    });

    group('neighborsOf', () {
      test('returns correct neighbors for even row center', () {
        // Even row: row=2, col=4
        // Expected: (1,3),(1,4),(2,3),(2,5),(3,3),(3,4)
        const pos = GridPosition(2, 4);
        final neighbors = emptyGrid.neighborsOf(pos);
        final expected = {
          const GridPosition(1, 3),
          const GridPosition(1, 4),
          const GridPosition(2, 3),
          const GridPosition(2, 5),
          const GridPosition(3, 3),
          const GridPosition(3, 4),
        };
        // All valid neighbors should be in expected set
        for (final n in neighbors) {
          expect(expected, contains(n));
        }
        // All valid expected positions should be in neighbors
        const config = BoardConfig.standard;
        for (final e in expected) {
          final valid = e.row >= 0 &&
              e.row < config.rows &&
              e.col >= 0 &&
              e.col < (e.row.isOdd ? config.cols - 1 : config.cols);
          if (valid) {
            expect(neighbors, contains(e));
          }
        }
      });

      test('returns correct neighbors for odd row center', () {
        // Odd row: row=1, col=3
        // Expected: (0,3),(0,4),(1,2),(1,4),(2,3),(2,4)
        const pos = GridPosition(1, 3);
        final neighbors = emptyGrid.neighborsOf(pos);
        final expected = {
          const GridPosition(0, 3),
          const GridPosition(0, 4),
          const GridPosition(1, 2),
          const GridPosition(1, 4),
          const GridPosition(2, 3),
          const GridPosition(2, 4),
        };
        for (final n in neighbors) {
          expect(expected, contains(n));
        }
        const config = BoardConfig.standard;
        for (final e in expected) {
          final valid = e.row >= 0 &&
              e.row < config.rows &&
              e.col >= 0 &&
              e.col < (e.row.isOdd ? config.cols - 1 : config.cols);
          if (valid) {
            expect(neighbors, contains(e));
          }
        }
      });
    });

    group('gridToPixel / pixelToGrid', () {
      late Rect boardRect;

      setUp(() {
        // Use a simple board rect starting at origin
        boardRect = const Rect.fromLTWH(0, 0, 400, 300);
      });

      test('gridToPixel returns deterministic pixel for pos (0,0)', () {
        const pos = GridPosition(0, 0);
        const config = BoardConfig.standard;
        final pixel = emptyGrid.gridToPixel(pos, boardRect);

        // Even row (row=0): xOffset=0
        // x = boardRect.left + 0 + 0 * cellWidth + starRadius
        // y = boardRect.top + 0 * cellHeight + starRadius
        final expectedX = boardRect.left + config.starRadius;
        final expectedY = boardRect.top + config.starRadius;

        expect(pixel.dx, closeTo(expectedX, 0.001));
        expect(pixel.dy, closeTo(expectedY, 0.001));
      });

      test('pixelToGrid round-trips: pixelToGrid(gridToPixel(pos)) == pos', () {
        const pos = GridPosition(2, 3);
        final pixel = emptyGrid.gridToPixel(pos, boardRect);
        final roundTripped = emptyGrid.pixelToGrid(pixel, boardRect);
        expect(roundTripped, equals(pos));
      });
    });

    group('initialBoard', () {
      test('fills top N rows with stars', () {
        const rows = 5;
        final grid = BoardGrid.initialBoard(rows: rows);
        const config = BoardConfig.standard;

        // Count expected stars: even rows have cols stars, odd rows have cols-1
        int expectedCount = 0;
        for (int r = 0; r < rows; r++) {
          expectedCount += r.isOdd ? config.cols - 1 : config.cols;
        }

        expect(grid.allStars, hasLength(expectedCount));
      });

      test('all positions in initial board are valid', () {
        final grid = BoardGrid.initialBoard(rows: 3);
        for (final pos in grid.occupiedPositions) {
          expect(grid.isValidPosition(pos), isTrue);
        }
      });
    });

    group('isValidPosition', () {
      test('returns false for negative row', () {
        expect(
          emptyGrid.isValidPosition(const GridPosition(-1, 0)),
          isFalse,
        );
      });

      test('returns false for negative col', () {
        expect(
          emptyGrid.isValidPosition(const GridPosition(0, -1)),
          isFalse,
        );
      });

      test('returns false for row out-of-bounds', () {
        const config = BoardConfig.standard;
        expect(
          emptyGrid.isValidPosition(GridPosition(config.rows, 0)),
          isFalse,
        );
      });

      test('returns false for col out-of-bounds on even row', () {
        const config = BoardConfig.standard;
        expect(
          emptyGrid.isValidPosition(GridPosition(0, config.cols)),
          isFalse,
        );
      });

      test('returns false for col out-of-bounds on odd row', () {
        const config = BoardConfig.standard;
        // Odd rows have cols-1 valid columns (0..cols-2)
        expect(
          emptyGrid.isValidPosition(GridPosition(1, config.cols - 1)),
          isFalse,
        );
      });

      test('returns true for a valid position', () {
        expect(
          emptyGrid.isValidPosition(const GridPosition(0, 0)),
          isTrue,
        );
      });
    });
  });
}
