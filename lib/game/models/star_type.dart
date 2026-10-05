import 'package:flutter/painting.dart';

/// The 5 color variants for normal stars.
enum StarColor {
  yellow,
  red,
  green,
  blue,
  purple;

  Color get color => switch (this) {
        StarColor.yellow => const Color(0xFFFFBF00),
        StarColor.red    => const Color(0xFFFF3D3D),
        StarColor.green  => const Color(0xFF3DCC3D),
        StarColor.blue   => const Color(0xFF3D9EFF),
        StarColor.purple => const Color(0xFFCC55FF),
      };

  static StarColor fromIndex(int i) => StarColor.values[i % StarColor.values.length];
}

/// The visual and behavioural type of a star on the board.
enum StarType {
  normal,
  meteor,
  rainbow,
  supernova,
  blackHole,
  frozenStar;

  /// The representative color for this star type.
  Color get color => switch (this) {
        StarType.normal => const Color(0xFFFFBF00),
        StarType.meteor => const Color(0xFFFF6B35),
        StarType.rainbow => const Color(0xFF00D4FF),
        StarType.supernova => const Color(0xFFFF1493),
        StarType.blackHole => const Color(0xFF2D1B69),
        StarType.frozenStar => const Color(0xFF87CEEB),
      };

  /// Returns true for types that have special game mechanics.
  bool get isSpecial => switch (this) {
        StarType.normal => false,
        _ => true,
      };

  /// Human-readable label used in UI and debug output.
  String get displayName => switch (this) {
        StarType.normal => 'Normal',
        StarType.meteor => 'Meteor',
        StarType.rainbow => 'Rainbow',
        StarType.supernova => 'Supernova',
        StarType.blackHole => 'Black Hole',
        StarType.frozenStar => 'Frozen Star',
      };
}
