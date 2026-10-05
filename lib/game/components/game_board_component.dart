import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';
import 'package:star_shooter/core/theme/app_colors.dart';

/// Placeholder Flame component for the bubble-shooter game board.
///
/// Renders a semi-transparent arc/grid area and a "GAME BOARD — M2" label so
/// the screen has visible content during Milestone 1. The real bubble grid and
/// game logic are wired up in M2.
class GameBoardComponent extends PositionComponent {
  GameBoardComponent() : super(priority: 0);

  late TextComponent _label;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _label = TextComponent(
      text: 'GAME BOARD — M2',
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
          letterSpacing: 1.5,
        ),
      ),
    );
    await add(_label);
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);

    // The board occupies the upper 65 % of the canvas, centred horizontally.
    final boardWidth = gameSize.x * 0.9;
    final boardHeight = gameSize.y * 0.65;
    size = Vector2(boardWidth, boardHeight);
    position = Vector2((gameSize.x - boardWidth) / 2, gameSize.y * 0.04);

    // Centre the label inside the board.
    _label.position = Vector2(
      boardWidth / 2 - (_label.size.x / 2),
      boardHeight / 2 - 12,
    );
  }

  @override
  void render(Canvas canvas) {
    final w = size.x;
    final h = size.y;

    // Outer rounded-rect border.
    final borderPaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, w, h),
        const Radius.circular(16),
      ),
      borderPaint,
    );

    // Grid dots — 7 columns × 10 rows representing bubble slots.
    const cols = 7;
    const rows = 10;
    final cellW = w / cols;
    final cellH = h / rows;
    final dotPaint = Paint()
      ..color = AppColors.surface.withValues(alpha: 0.8)
      ..style = PaintingStyle.fill;

    for (int row = 0; row < rows; row++) {
      // Odd rows are offset by half a cell (hex grid layout).
      final xOffset = (row.isOdd) ? cellW * 0.5 : 0.0;
      final effectiveCols = row.isOdd ? cols - 1 : cols;
      for (int col = 0; col < effectiveCols; col++) {
        canvas.drawCircle(
          Offset(
            xOffset + cellW * col + cellW / 2,
            cellH * row + cellH / 2,
          ),
          cellW * 0.28,
          dotPaint,
        );
      }
    }

    // Arc at the top of the board (decorative launcher trajectory hint).
    final arcPaint = Paint()
      ..color = AppColors.secondary.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(w / 2, h + h * 0.1),
        width: w * 1.4,
        height: h * 0.8,
      ),
      -3.14,
      3.14,
      false,
      arcPaint,
    );
  }
}
