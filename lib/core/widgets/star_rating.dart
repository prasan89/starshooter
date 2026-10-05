import 'package:flutter/material.dart';
import 'package:star_shooter/core/theme/app_colors.dart';
import 'package:star_shooter/core/theme/app_spacing.dart';

/// Displays a row of 1–3 stars representing a level's star rating.
///
/// The widget animates each star independently when the [rating] changes.
class StarRating extends StatefulWidget {
  const StarRating({
    super.key,
    required this.rating,
    this.size = 24.0,
    this.spacing = AppSpacing.xs,
  }) : assert(rating >= 0 && rating <= 3, 'rating must be between 0 and 3');

  /// Number of filled stars (0–3).
  final int rating;

  /// Size of each star icon in logical pixels.
  final double size;

  /// Horizontal gap between stars.
  final double spacing;

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late int _previousRating;

  @override
  void initState() {
    super.initState();
    _previousRating = widget.rating;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void didUpdateWidget(covariant StarRating old) {
    super.didUpdateWidget(old);
    if (old.rating != widget.rating) {
      _previousRating = old.rating;
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        final isFilled = index < widget.rating;
        final wasJustFilled = index >= _previousRating && index < widget.rating;

        Widget star = Icon(
          isFilled ? Icons.star_rounded : Icons.star_outline_rounded,
          color: isFilled ? AppColors.starFilled : AppColors.starEmpty,
          size: widget.size,
        );

        if (wasJustFilled) {
          star = AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final scale = Tween<double>(begin: 1.5, end: 1.0)
                  .chain(CurveTween(curve: Curves.elasticOut))
                  .evaluate(_controller);
              return Transform.scale(scale: scale, child: child);
            },
            child: star,
          );
        }

        if (index < 2) {
          return Padding(
            padding: EdgeInsets.only(right: widget.spacing),
            child: star,
          );
        }
        return star;
      }),
    );
  }
}
