import 'package:star_shooter/game/level/level_objective.dart';
import 'package:star_shooter/game/level/level_world_meta.dart';
import 'package:star_shooter/game/models/grid_position.dart';
import 'package:star_shooter/game/models/level_definition.dart';
import 'package:star_shooter/game/models/star_type.dart';

/// Levels 151–200: Master (151–175) and Extreme Endgame (176–200).
/// World 4 (Event Horizon): levels 151–160, levelNumber 31–40
/// World 5 (Frozen Nebula): levels 161–200, levelNumber 1–40
const List<LevelDefinition> levelsFrom151To200 = [
  // ══════════════════════════════════════════════════════════════════════════
  // WORLD 4 — EVENT HORIZON  (Levels 151–160, levelNumber 31–40)
  // Master tier: all 6 star types, moveLimit 10–13, dense frozen boards.
  // ══════════════════════════════════════════════════════════════════════════

  // Level 151 — Gravity Storm
  // Pattern: frozen top row + specials + dense normal interior (51 stars)
  LevelDefinition(
    id: 151,
    version: 1,
    displayName: 'Gravity Storm',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 31,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 150,
    ),
    moveLimit: 13,
    scoreTarget: 10000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 20687,
    objective: LevelObjective.clearSpecial(20),
    initialStars: [
      // Row 0: full frozen row (9 frozen)
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: alternating frozen / supernova
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: blackHole / normal alternating
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.blackHole,
      ),
      // Row 3: normal stars
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: sparse normal
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.normal,
      ),
      // Row 5: corners
      InitialStarPlacement(
        position: GridPosition(5, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 8),
        type: StarType.frozenStar,
      ),
    ],
  ),

  // Level 152 — Mass Collapse
  // Pattern B: frozen checkerboard with specials (50 stars)
  LevelDefinition(
    id: 152,
    version: 1,
    displayName: 'Mass Collapse',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 32,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 151,
    ),
    moveLimit: 13,
    scoreTarget: 10000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 20824,
    objective: LevelObjective.clearSpecial(20),
    initialStars: [
      // Row 0: checkerboard frozen/normal
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: normal/frozen checkerboard
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.supernova,
      ),
      // Row 2: frozen/blackHole
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.frozenStar,
      ),
      // Row 3: normal mix
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: sparse
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.normal,
      ),
      // Row 5: line
      InitialStarPlacement(
        position: GridPosition(5, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 6),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 153 — Event Nexus
  // Pattern C: frozen border with supernova/blackHole interior (49 stars)
  LevelDefinition(
    id: 153,
    version: 1,
    displayName: 'Event Nexus',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 33,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 152,
    ),
    moveLimit: 12,
    scoreTarget: 10500,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 20961,
    objective: LevelObjective.clearSpecial(22),
    initialStars: [
      // Row 0: full frozen border top
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: frozen walls, specials interior
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: frozen walls, normal interior
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.frozenStar,
      ),
      // Row 3: frozen walls, specials interior
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.frozenStar,
      ),
      // Row 4: sparse bottom
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.meteor,
      ),
      // Row 5: anchors
      InitialStarPlacement(
        position: GridPosition(5, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 8),
        type: StarType.frozenStar,
      ),
    ],
  ),

  // Level 154 — Dark Spiral
  // Pattern D: frozen columns + gap interior (52 stars)
  LevelDefinition(
    id: 154,
    version: 1,
    displayName: 'Dark Spiral',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 34,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 153,
    ),
    moveLimit: 12,
    scoreTarget: 10500,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 21098,
    objective: LevelObjective.clearSpecial(22),
    initialStars: [
      // Row 0: frozen columns at 0,3,6 + specials at 1,4,7 + normal at 2,5,8
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: same column pattern
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.meteor,
      ),
      // Row 2: frozen columns + specials
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.normal,
      ),
      // Row 3: normal mix
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: partial
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: bottom anchors
      InitialStarPlacement(
        position: GridPosition(5, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 7),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 155 — Void Lock
  // Pattern E: cascading frozen center blocks (51 stars)
  LevelDefinition(
    id: 155,
    version: 1,
    displayName: 'Void Lock',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 35,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 154,
    ),
    moveLimit: 12,
    scoreTarget: 11000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 21235,
    objective: LevelObjective.clearSpecial(23),
    initialStars: [
      // Row 0: full row mixed
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: specials flanking frozen center
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.blackHole,
      ),
      // Row 2: specials + frozen center
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.normal,
      ),
      // Row 3: all types mixed
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.meteor,
      ),
      // Row 4: partial
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.normal,
      ),
      // Row 5: anchors
      InitialStarPlacement(
        position: GridPosition(5, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 6),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 156 — Horizon Trap
  // Pattern A: two complete frozen rows + special interior (54 stars)
  LevelDefinition(
    id: 156,
    version: 1,
    displayName: 'Horizon Trap',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 36,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 155,
    ),
    moveLimit: 11,
    scoreTarget: 11000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 21372,
    objective: LevelObjective.clearSpecial(25),
    initialStars: [
      // Row 0: full frozen
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: full frozen
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: specials
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.blackHole,
      ),
      // Row 3: normal mix
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: partial
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.normal,
      ),
      // Row 5: bottom
      InitialStarPlacement(
        position: GridPosition(5, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 8),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 157 — Warp Collapse
  // Pattern F: near-completely filled board (57 stars)
  LevelDefinition(
    id: 157,
    version: 1,
    displayName: 'Warp Collapse',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 37,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 156,
    ),
    moveLimit: 11,
    scoreTarget: 11500,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 21509,
    objective: LevelObjective.clearSpecial(25),
    initialStars: [
      // Row 0: full row - alternating frozen/supernova
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: full frozen
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: blackHole + normal
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.normal,
      ),
      // Row 3: full normal mix
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.meteor,
      ),
      // Row 4: near full
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: bottom row
      InitialStarPlacement(
        position: GridPosition(5, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 8),
        type: StarType.normal,
      ),
      // Row 6: anchors
      InitialStarPlacement(
        position: GridPosition(6, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(6, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(6, 7),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 158 — Space Prison
  // Pattern B: checkerboard with very high frozen count (54 stars)
  LevelDefinition(
    id: 158,
    version: 1,
    displayName: 'Space Prison',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 38,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 157,
    ),
    moveLimit: 11,
    scoreTarget: 12000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 21646,
    objective: LevelObjective.clearSpecial(26),
    initialStars: [
      // Row 0: frozen every other
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: supernova/frozen
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.supernova,
      ),
      // Row 2: frozen/normal
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.frozenStar,
      ),
      // Row 3: normal mix
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: partial frozen
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: anchors
      InitialStarPlacement(
        position: GridPosition(5, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 7),
        type: StarType.normal,
      ),
      // Row 6: final anchor
      InitialStarPlacement(
        position: GridPosition(6, 4),
        type: StarType.frozenStar,
      ),
    ],
  ),

  // Level 159 — Quantum Freeze
  // Pattern A + extra frozen (55 stars)
  LevelDefinition(
    id: 159,
    version: 1,
    displayName: 'Quantum Freeze',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 39,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 158,
    ),
    moveLimit: 11,
    scoreTarget: 12000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 21783,
    objective: LevelObjective.clearSpecial(27),
    initialStars: [
      // Row 0: full frozen
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: alternating frozen/supernova
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: blackHole + normal alternating
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.blackHole,
      ),
      // Row 3: frozen + specials
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.frozenStar,
      ),
      // Row 4: partial
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: sparse
      InitialStarPlacement(
        position: GridPosition(5, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 6),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 160 — Event End  (World 4 boss)
  // Frozen Grid pattern: rows 0+4 full frozen, specials throughout (51 stars)
  LevelDefinition(
    id: 160,
    version: 1,
    displayName: 'Event End',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 40,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 159,
    ),
    moveLimit: 10,
    scoreTarget: 12000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 21920,
    objective: LevelObjective.clearSpecial(25),
    initialStars: [
      // Row 0: full frozen
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: alternating frozen/normal (9 stars)
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: full normal
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.normal,
      ),
      // Row 3: blackHole(4) + supernova(5)
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.blackHole,
      ),
      // Row 4: full frozen
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: supernova interspersed
      InitialStarPlacement(
        position: GridPosition(5, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 7),
        type: StarType.normal,
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════════════════════
  // WORLD 5 — FROZEN NEBULA  (Levels 161–200, levelNumber 1–40)
  // Extreme Endgame: moveLimit 10–12, 50–70 stars, maximum frozen clusters.
  // ══════════════════════════════════════════════════════════════════════════

  // Level 161 — Crystal Vault
  // Pattern C: frozen borders, special interior (52 stars)
  LevelDefinition(
    id: 161,
    version: 1,
    displayName: 'Crystal Vault',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 1,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 160,
    ),
    moveLimit: 12,
    scoreTarget: 12000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 22057,
    objective: LevelObjective.clearSpecial(25),
    initialStars: [
      // Row 0: full frozen top
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: frozen walls, specials interior
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: frozen walls, normal interior
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.frozenStar,
      ),
      // Row 3: frozen walls, specials interior
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.frozenStar,
      ),
      // Row 4: partial row
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: sparse bottom
      InitialStarPlacement(
        position: GridPosition(5, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 7),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 162 — Ice Labyrinth
  // Pattern D: frozen columns (54 stars)
  LevelDefinition(
    id: 162,
    version: 1,
    displayName: 'Ice Labyrinth',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 2,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 161,
    ),
    moveLimit: 12,
    scoreTarget: 12500,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 22194,
    objective: LevelObjective.clearSpecial(26),
    initialStars: [
      // Row 0: frozen columns 0,2,4,6,8 + specials in between
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: same column pattern
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: frozen columns + specials
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.frozenStar,
      ),
      // Row 3: normal mix
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: partial frozen columns
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: bottom anchors
      InitialStarPlacement(
        position: GridPosition(5, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 3),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 7),
        type: StarType.rainbow,
      ),
      // Row 6: center
      InitialStarPlacement(
        position: GridPosition(6, 4),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 163 — Frozen Prison
  // Pattern A: two full frozen rows + heavy specials (54 stars)
  LevelDefinition(
    id: 163,
    version: 1,
    displayName: 'Frozen Prison',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 3,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 162,
    ),
    moveLimit: 12,
    scoreTarget: 13000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 22331,
    objective: LevelObjective.clearSpecial(27),
    initialStars: [
      // Row 0: full frozen
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: full frozen
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: supernova + blackHole
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.supernova,
      ),
      // Row 3: normal mix
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: partial frozen
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: sparse
      InitialStarPlacement(
        position: GridPosition(5, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 7),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 164 — Arctic Nexus
  // Pattern B: checkerboard dense (54 stars)
  LevelDefinition(
    id: 164,
    version: 1,
    displayName: 'Arctic Nexus',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 4,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 163,
    ),
    moveLimit: 12,
    scoreTarget: 13000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 22468,
    objective: LevelObjective.clearSpecial(27),
    initialStars: [
      // Row 0: frozen/supernova checkerboard
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: blackHole/frozen checkerboard
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.blackHole,
      ),
      // Row 2: frozen/normal
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.frozenStar,
      ),
      // Row 3: full normal mix
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: partial frozen
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.normal,
      ),
      // Row 5: anchors
      InitialStarPlacement(
        position: GridPosition(5, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 8),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 165 — Polar Grid
  // Pattern E: cascading center (53 stars)
  LevelDefinition(
    id: 165,
    version: 1,
    displayName: 'Polar Grid',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 5,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 164,
    ),
    moveLimit: 11,
    scoreTarget: 13500,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 22605,
    objective: LevelObjective.clearSpecial(27),
    initialStars: [
      // Row 0: full top with frozen clusters
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: frozen flanks + specials center
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: specials flanking frozen core
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.blackHole,
      ),
      // Row 3: normal mix
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: partial
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: anchors
      InitialStarPlacement(
        position: GridPosition(5, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 6),
        type: StarType.normal,
      ),
      // Row 6: center anchor
      InitialStarPlacement(
        position: GridPosition(6, 4),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 166 — Sub-Zero Web
  // Pattern C: frozen border, very high special count (57 stars)
  LevelDefinition(
    id: 166,
    version: 1,
    displayName: 'Sub-Zero Web',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 6,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 165,
    ),
    moveLimit: 11,
    scoreTarget: 13500,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 22742,
    objective: LevelObjective.clearSpecial(28),
    initialStars: [
      // Row 0: full frozen
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: frozen border + specials
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: frozen border + normal
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.frozenStar,
      ),
      // Row 3: frozen border + specials
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.frozenStar,
      ),
      // Row 4: partial frozen
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.normal,
      ),
      // Row 5: sparse
      InitialStarPlacement(
        position: GridPosition(5, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 6),
        type: StarType.normal,
      ),
      // Row 6: bottom anchors
      InitialStarPlacement(
        position: GridPosition(6, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(6, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(6, 7),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 167 — Cryo Lock
  // Pattern F: near-full board (60 stars)
  LevelDefinition(
    id: 167,
    version: 1,
    displayName: 'Cryo Lock',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 7,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 166,
    ),
    moveLimit: 11,
    scoreTarget: 14000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 22879,
    objective: LevelObjective.clearSpecial(28),
    initialStars: [
      // Row 0: full frozen
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: alternating frozen/supernova
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: blackHole/normal
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.blackHole,
      ),
      // Row 3: all types
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: frozen + normal
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: partial
      InitialStarPlacement(
        position: GridPosition(5, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 8),
        type: StarType.normal,
      ),
      // Row 6: anchors
      InitialStarPlacement(
        position: GridPosition(6, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(6, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(6, 7),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 168 — Frost Prison
  // Pattern A: two frozen rows + dense specials (57 stars)
  LevelDefinition(
    id: 168,
    version: 1,
    displayName: 'Frost Prison',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 8,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 167,
    ),
    moveLimit: 11,
    scoreTarget: 14000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 23016,
    objective: LevelObjective.clearSpecial(28),
    initialStars: [
      // Row 0: full frozen
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: full frozen
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: blackHole/supernova alternating
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.blackHole,
      ),
      // Row 3: full normal
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: frozen + normal alternating
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: partial bottom
      InitialStarPlacement(
        position: GridPosition(5, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 3),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 7),
        type: StarType.rainbow,
      ),
      // Row 6: anchors
      InitialStarPlacement(
        position: GridPosition(6, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(6, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(6, 6),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 169 — Glacial Maze
  // Pattern D: frozen columns + specials (57 stars)
  LevelDefinition(
    id: 169,
    version: 1,
    displayName: 'Glacial Maze',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 9,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 168,
    ),
    moveLimit: 11,
    scoreTarget: 14500,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 23153,
    objective: LevelObjective.clearSpecial(29),
    initialStars: [
      // Row 0: frozen at even cols, specials at odd
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: frozen at even, normal at odd
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: full row with specials
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.frozenStar,
      ),
      // Row 3: normal mix full
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: frozen + normal
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: partial
      InitialStarPlacement(
        position: GridPosition(5, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 3),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 7),
        type: StarType.rainbow,
      ),
      // Row 6: final anchors
      InitialStarPlacement(
        position: GridPosition(6, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(6, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(6, 6),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 170 — Ice Storm
  // Pattern F: near-completely filled board (60 stars)
  LevelDefinition(
    id: 170,
    version: 1,
    displayName: 'Ice Storm',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 10,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 169,
    ),
    moveLimit: 11,
    scoreTarget: 15000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 23290,
    objective: LevelObjective.clearSpecial(29),
    initialStars: [
      // Row 0: full frozen
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: supernova/frozen alternating
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.supernova,
      ),
      // Row 2: blackHole/normal
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.blackHole,
      ),
      // Row 3: full normal
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: frozen + normal alternating full
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: partial
      InitialStarPlacement(
        position: GridPosition(5, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 2),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 6),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 8),
        type: StarType.normal,
      ),
      // Row 6: anchors
      InitialStarPlacement(
        position: GridPosition(6, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(6, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(6, 7),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 171 — Blizzard Core
  // Pattern B: frozen checkerboard extra dense (57 stars)
  LevelDefinition(
    id: 171,
    version: 1,
    displayName: 'Blizzard Core',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 11,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 170,
    ),
    moveLimit: 11,
    scoreTarget: 15000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 23427,
    objective: LevelObjective.clearSpecial(29),
    initialStars: [
      // Row 0: full frozen
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: blackHole/frozenStar checkerboard
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.blackHole,
      ),
      // Row 2: frozenStar/supernova checkerboard
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.frozenStar,
      ),
      // Row 3: full normal mix
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: partial frozen
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: sparse
      InitialStarPlacement(
        position: GridPosition(5, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 6),
        type: StarType.normal,
      ),
      // Row 6: anchors
      InitialStarPlacement(
        position: GridPosition(6, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(6, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(6, 7),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 172 — Polar Crush
  // Pattern C: frozen border + special interior (57 stars)
  LevelDefinition(
    id: 172,
    version: 1,
    displayName: 'Polar Crush',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 12,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 171,
    ),
    moveLimit: 10,
    scoreTarget: 15000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 23564,
    objective: LevelObjective.clearSpecial(30),
    initialStars: [
      // Row 0: full frozen
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: frozen walls + specials interior
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: frozen walls + normal mix
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.frozenStar,
      ),
      // Row 3: frozen walls + specials
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.frozenStar,
      ),
      // Row 4: frozen walls + normal
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: sparse bottom
      InitialStarPlacement(
        position: GridPosition(5, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 7),
        type: StarType.normal,
      ),
      // Row 6: anchors
      InitialStarPlacement(
        position: GridPosition(6, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(6, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(6, 6),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 173 — Zero Point
  // Pattern A: two frozen rows + maximal specials (54 stars)
  LevelDefinition(
    id: 173,
    version: 1,
    displayName: 'Zero Point',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 13,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 172,
    ),
    moveLimit: 10,
    scoreTarget: 15500,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 23701,
    objective: LevelObjective.clearSpecial(30),
    initialStars: [
      // Row 0: full frozen
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: full frozen
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: supernova + blackHole alternating
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.supernova,
      ),
      // Row 3: full normal mix
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: partial frozen
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: sparse
      InitialStarPlacement(
        position: GridPosition(5, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 7),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 174 — Frost Nexus
  // Pattern F: near-complete board (60 stars)
  LevelDefinition(
    id: 174,
    version: 1,
    displayName: 'Frost Nexus',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 14,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 173,
    ),
    moveLimit: 10,
    scoreTarget: 15500,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 23838,
    objective: LevelObjective.clearSpecial(30),
    initialStars: [
      // Row 0: full frozen
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: alternating frozen/supernova
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: blackHole/normal full
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.blackHole,
      ),
      // Row 3: full normal
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: frozen + normal alternating
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: partial
      InitialStarPlacement(
        position: GridPosition(5, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 8),
        type: StarType.normal,
      ),
      // Row 6: anchors
      InitialStarPlacement(
        position: GridPosition(6, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(6, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(6, 7),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 175 — Ice Master  (Master tier final)
  // Pattern: ultimate frozen grid (54 stars) — moveLimit 10
  LevelDefinition(
    id: 175,
    version: 1,
    displayName: 'Ice Master',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 15,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 174,
    ),
    moveLimit: 10,
    scoreTarget: 16000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 23975,
    objective: LevelObjective.clearSpecial(30),
    initialStars: [
      // Row 0: full frozen
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: alternating frozen/normal
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: full normal
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.normal,
      ),
      // Row 3: blackHole/supernova
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.blackHole,
      ),
      // Row 4: full frozen
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: sparse supernova
      InitialStarPlacement(
        position: GridPosition(5, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 7),
        type: StarType.normal,
      ),
    ],
  ),

  // ── EXTREME ENDGAME  (Levels 176–200, moveLimit ≤ 12) ─────────────────────

  // Level 176 — Absolute Zero
  // Ultimate Boss pattern: two full frozen rows + dense special interior (57 stars)
  LevelDefinition(
    id: 176,
    version: 1,
    displayName: 'Absolute Zero',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 16,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 175,
    ),
    moveLimit: 12,
    scoreTarget: 16000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 24112,
    objective: LevelObjective.clearSpecial(30),
    initialStars: [
      // Row 0: all frozen
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: all frozen
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: blackHole(0,2,4,6,8) + supernova(1,3,5,7) + frozenStar at end
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.blackHole,
      ),
      // Row 3: all normal
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: frozenStar(0,2,4,6,8) + blackHole(1,3,5,7)
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: all frozen
      InitialStarPlacement(
        position: GridPosition(5, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 8),
        type: StarType.frozenStar,
      ),
    ],
  ),

  // Level 177 — Cryo Fortress
  // Ultimate Boss Pattern: 6 rows filled (60 stars)
  LevelDefinition(
    id: 177,
    version: 1,
    displayName: 'Cryo Fortress',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 17,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 176,
    ),
    moveLimit: 12,
    scoreTarget: 16000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 24249,
    objective: LevelObjective.clearSpecial(30),
    initialStars: [
      // Row 0: all frozen
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: supernova/frozen alternating
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.supernova,
      ),
      // Row 2: blackHole/normal alternating
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.blackHole,
      ),
      // Row 3: normal mix full
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: frozen/blackHole
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: all frozen
      InitialStarPlacement(
        position: GridPosition(5, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 8),
        type: StarType.frozenStar,
      ),
    ],
  ),

  // Level 178 — Frozen Cosmos
  // Massive board: 6 rows almost completely filled (62 stars)
  LevelDefinition(
    id: 178,
    version: 1,
    displayName: 'Frozen Cosmos',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 18,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 177,
    ),
    moveLimit: 12,
    scoreTarget: 16500,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 24386,
    objective: LevelObjective.clearSpecial(31),
    initialStars: [
      // Row 0: full frozen
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: full frozen
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: blackHole/supernova/frozenStar mix
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.frozenStar,
      ),
      // Row 3: normal mix full
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: frozen/normal alternating
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: near full
      InitialStarPlacement(
        position: GridPosition(5, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 1),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 3),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 8),
        type: StarType.normal,
      ),
      // Row 6: anchors
      InitialStarPlacement(
        position: GridPosition(6, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(6, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(6, 7),
        type: StarType.frozenStar,
      ),
    ],
  ),

  // Level 179 — Ice Singularity
  // Pattern: massive frozen block (57 stars)
  LevelDefinition(
    id: 179,
    version: 1,
    displayName: 'Ice Singularity',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 19,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 178,
    ),
    moveLimit: 12,
    scoreTarget: 16500,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 24523,
    objective: LevelObjective.clearSpecial(31),
    initialStars: [
      // Row 0: full frozen
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: frozen walls + blackHole interior
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: frozen walls + supernova interior
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.frozenStar,
      ),
      // Row 3: all normal mix
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: frozen/normal alternating
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: sparse
      InitialStarPlacement(
        position: GridPosition(5, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 3),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 7),
        type: StarType.rainbow,
      ),
    ],
  ),

  // Level 180 — Arctic God
  // Two frozen rows + massive special matrix (60 stars)
  LevelDefinition(
    id: 180,
    version: 1,
    displayName: 'Arctic God',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 20,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 179,
    ),
    moveLimit: 11,
    scoreTarget: 17000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 24660,
    objective: LevelObjective.clearSpecial(32),
    initialStars: [
      // Row 0: all frozen
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: all frozen
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: blackHole+supernova alternating
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.blackHole,
      ),
      // Row 3: full normal mix
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: frozen+blackHole alternating
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: all frozen
      InitialStarPlacement(
        position: GridPosition(5, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 8),
        type: StarType.frozenStar,
      ),
    ],
  ),

  // Level 181 — Deep Freeze X
  // 6-row board: frozen+specials (63 stars)
  LevelDefinition(
    id: 181,
    version: 1,
    displayName: 'Deep Freeze X',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 21,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 180,
    ),
    moveLimit: 11,
    scoreTarget: 17000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 24797,
    objective: LevelObjective.clearSpecial(32),
    initialStars: [
      // Row 0: all frozen
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: alternating frozen/supernova
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: blackHole/normal
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.blackHole,
      ),
      // Row 3: full normal
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: frozen+normal alternating
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: near full
      InitialStarPlacement(
        position: GridPosition(5, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 1),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 3),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 8),
        type: StarType.normal,
      ),
      // Row 6: frozen row
      InitialStarPlacement(
        position: GridPosition(6, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(6, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(6, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(6, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(6, 8),
        type: StarType.frozenStar,
      ),
    ],
  ),

  // Level 182 — Polar Tyrant
  // massive board: 6 rows with super dense frozen (63 stars)
  LevelDefinition(
    id: 182,
    version: 1,
    displayName: 'Polar Tyrant',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 22,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 181,
    ),
    moveLimit: 11,
    scoreTarget: 17500,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 24934,
    objective: LevelObjective.clearSpecial(32),
    initialStars: [
      // Row 0: full frozen
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: full frozen
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: supernova/blackHole alternating
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.supernova,
      ),
      // Row 3: normal mix
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: frozen/blackHole alternating
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: partial
      InitialStarPlacement(
        position: GridPosition(5, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 1),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 3),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 8),
        type: StarType.normal,
      ),
      // Row 6: anchors
      InitialStarPlacement(
        position: GridPosition(6, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(6, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(6, 7),
        type: StarType.frozenStar,
      ),
    ],
  ),

  // Level 183 — Cryo Collapse
  // Extreme: three frozen rows + specials (57 stars)
  LevelDefinition(
    id: 183,
    version: 1,
    displayName: 'Cryo Collapse',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 23,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 182,
    ),
    moveLimit: 11,
    scoreTarget: 17500,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 25071,
    objective: LevelObjective.clearSpecial(33),
    initialStars: [
      // Row 0: full frozen
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: full frozen
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: blackHole/supernova alternating
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.blackHole,
      ),
      // Row 3: normal mix
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: full frozen
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: partial
      InitialStarPlacement(
        position: GridPosition(5, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 3),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 7),
        type: StarType.rainbow,
      ),
    ],
  ),

  // Level 184 — Winter's End
  // Boss-tier: near-full 6-row board (60 stars)
  LevelDefinition(
    id: 184,
    version: 1,
    displayName: "Winter's End",
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 24,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 183,
    ),
    moveLimit: 11,
    scoreTarget: 18000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 25208,
    objective: LevelObjective.clearSpecial(33),
    initialStars: [
      // Row 0: all frozen
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: supernova/frozen
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.supernova,
      ),
      // Row 2: blackHole/normal
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.blackHole,
      ),
      // Row 3: full normal mix
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: frozen/normal alternating
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: partial
      InitialStarPlacement(
        position: GridPosition(5, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 8),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 185 — Frost God
  // 6-row dense (63 stars) — pre-boss
  LevelDefinition(
    id: 185,
    version: 1,
    displayName: 'Frost God',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 25,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 184,
    ),
    moveLimit: 11,
    scoreTarget: 18000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 25345,
    objective: LevelObjective.clearSpecial(33),
    initialStars: [
      // Row 0: all frozen
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: all frozen
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: blackHole row
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.blackHole,
      ),
      // Row 3: supernova row
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.supernova,
      ),
      // Row 4: normal mix
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.normal,
      ),
      // Row 5: frozen+normal
      InitialStarPlacement(
        position: GridPosition(5, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 8),
        type: StarType.frozenStar,
      ),
    ],
  ),

  // Level 186 — Crystal Prison
  // 5-row very dense (57 stars)
  LevelDefinition(
    id: 186,
    version: 1,
    displayName: 'Crystal Prison',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 26,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 185,
    ),
    moveLimit: 10,
    scoreTarget: 18000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 25482,
    objective: LevelObjective.clearSpecial(33),
    initialStars: [
      // Row 0: all frozen
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: all frozen
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: blackHole(0,2,4,6,8) supernova(1,3,5,7)
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.blackHole,
      ),
      // Row 3: normal mix
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: all frozen
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: sparse supernova
      InitialStarPlacement(
        position: GridPosition(5, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 7),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 187 — Ice Labyrinth II
  // Dense frozen columns (60 stars)
  LevelDefinition(
    id: 187,
    version: 1,
    displayName: 'Ice Labyrinth II',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 27,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 186,
    ),
    moveLimit: 10,
    scoreTarget: 18500,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 25619,
    objective: LevelObjective.clearSpecial(34),
    initialStars: [
      // Row 0: all frozen
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: frozen+blackHole
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: supernova+frozen
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.supernova,
      ),
      // Row 3: normal mix
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: frozen+normal alternating
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: partial
      InitialStarPlacement(
        position: GridPosition(5, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 8),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 188 — Glacial Core
  // Dense 6-row (60 stars)
  LevelDefinition(
    id: 188,
    version: 1,
    displayName: 'Glacial Core',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 28,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 187,
    ),
    moveLimit: 10,
    scoreTarget: 18500,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 25756,
    objective: LevelObjective.clearSpecial(34),
    initialStars: [
      // Row 0: all frozen
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: frozen+supernova
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: blackHole+normal
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.blackHole,
      ),
      // Row 3: full normal
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: frozen/normal alternating
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: partial bottom
      InitialStarPlacement(
        position: GridPosition(5, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 8),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 189 — Frozen Void
  // Dense 6-row (63 stars)
  LevelDefinition(
    id: 189,
    version: 1,
    displayName: 'Frozen Void',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 29,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 188,
    ),
    moveLimit: 10,
    scoreTarget: 19000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 25893,
    objective: LevelObjective.clearSpecial(34),
    initialStars: [
      // Row 0: all frozen
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: all frozen
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: blackHole+supernova
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.blackHole,
      ),
      // Row 3: full normal
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: all frozen
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: near full normal
      InitialStarPlacement(
        position: GridPosition(5, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 1),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 3),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 8),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 190 — Arctic Storm
  // 6-row dense (63 stars)
  LevelDefinition(
    id: 190,
    version: 1,
    displayName: 'Arctic Storm',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 30,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 189,
    ),
    moveLimit: 10,
    scoreTarget: 19000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 26030,
    objective: LevelObjective.clearSpecial(35),
    initialStars: [
      // Row 0: all frozen
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: all frozen
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: supernova/blackHole alternating
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.supernova,
      ),
      // Row 3: normal mix
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: frozen/blackHole alternating
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: all frozen
      InitialStarPlacement(
        position: GridPosition(5, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 8),
        type: StarType.frozenStar,
      ),
    ],
  ),

  // Level 191 — Cryo Nexus
  // Boss encounter: dense 6-row (63 stars)
  LevelDefinition(
    id: 191,
    version: 1,
    displayName: 'Cryo Nexus',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 31,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 190,
    ),
    moveLimit: 10,
    scoreTarget: 19000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 26167,
    objective: LevelObjective.clearSpecial(35),
    initialStars: [
      // Row 0: all frozen
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: all frozen
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: blackHole row
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.blackHole,
      ),
      // Row 3: normal mix
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: frozen/supernova alternating
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: all frozen
      InitialStarPlacement(
        position: GridPosition(5, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 8),
        type: StarType.frozenStar,
      ),
    ],
  ),

  // Level 192 — Polar Lock
  // Boss encounter: 6-row with 30+ frozen (60 stars)
  LevelDefinition(
    id: 192,
    version: 1,
    displayName: 'Polar Lock',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 32,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 191,
    ),
    moveLimit: 10,
    scoreTarget: 19500,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 26304,
    objective: LevelObjective.clearSpecial(35),
    initialStars: [
      // Row 0: all frozen
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: frozen+blackHole alternating
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: supernova+normal alternating
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.supernova,
      ),
      // Row 3: full normal
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: frozen/normal
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: near full
      InitialStarPlacement(
        position: GridPosition(5, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 8),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 193 — Ice Absolute
  // 6-row mega board (63 stars)
  LevelDefinition(
    id: 193,
    version: 1,
    displayName: 'Ice Absolute',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 33,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 192,
    ),
    moveLimit: 10,
    scoreTarget: 19500,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 26441,
    objective: LevelObjective.clearSpecial(35),
    initialStars: [
      // Row 0: all frozen
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: all frozen
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: blackHole row
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.blackHole,
      ),
      // Row 3: supernova row
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.supernova,
      ),
      // Row 4: normal mix
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.normal,
      ),
      // Row 5: frozen+normal
      InitialStarPlacement(
        position: GridPosition(5, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 8),
        type: StarType.frozenStar,
      ),
    ],
  ),

  // Level 194 — Frozen Horizon
  // Near-complete 6-row (63 stars) pre-final-boss
  LevelDefinition(
    id: 194,
    version: 1,
    displayName: 'Frozen Horizon',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 34,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 193,
    ),
    moveLimit: 10,
    scoreTarget: 19500,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 26578,
    objective: LevelObjective.clearSpecial(35),
    initialStars: [
      // Row 0: all frozen
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: supernova/frozen
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.supernova,
      ),
      // Row 2: blackHole/normal
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.blackHole,
      ),
      // Row 3: normal mix
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: all frozen
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: near full normal+frozen
      InitialStarPlacement(
        position: GridPosition(5, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 8),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 195 — Crystal God (Boss encounter)
  // 6-row max-density (63 stars)
  LevelDefinition(
    id: 195,
    version: 1,
    displayName: 'Crystal God',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 35,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 194,
    ),
    moveLimit: 10,
    scoreTarget: 20000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 26715,
    objective: LevelObjective.clearSpecial(35),
    initialStars: [
      // Row 0: all frozen
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: all frozen
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: blackHole(0,2,4,6,8) supernova(1,3,5,7)
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.blackHole,
      ),
      // Row 3: normal
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: frozenStar(0,2,4,6,8) blackHole(1,3,5,7)
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: all frozen
      InitialStarPlacement(
        position: GridPosition(5, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 8),
        type: StarType.frozenStar,
      ),
    ],
  ),

  // Level 196 — Blizzard End (Boss encounter)
  LevelDefinition(
    id: 196,
    version: 1,
    displayName: 'Blizzard End',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 36,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 195,
    ),
    moveLimit: 10,
    scoreTarget: 20000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 26852,
    objective: LevelObjective.clearSpecial(35),
    initialStars: [
      // Row 0: all frozen
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: all frozen
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: supernova row
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.supernova,
      ),
      // Row 3: normal mix
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: blackHole row
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.blackHole,
      ),
      // Row 5: all frozen
      InitialStarPlacement(
        position: GridPosition(5, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 8),
        type: StarType.frozenStar,
      ),
    ],
  ),

  // Level 197 — Ice Universe (Boss encounter)
  LevelDefinition(
    id: 197,
    version: 1,
    displayName: 'Ice Universe',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 37,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 196,
    ),
    moveLimit: 10,
    scoreTarget: 20000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 26989,
    objective: LevelObjective.clearSpecial(35),
    initialStars: [
      // Row 0: all frozen
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: all frozen
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: blackHole+supernova
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.blackHole,
      ),
      // Row 3: normal mix
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.blackHole,
      ),
      // Row 4: frozen+blackHole
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: all frozen
      InitialStarPlacement(
        position: GridPosition(5, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 8),
        type: StarType.frozenStar,
      ),
    ],
  ),

  // Level 198 — Cryo Infinity (Boss encounter)
  LevelDefinition(
    id: 198,
    version: 1,
    displayName: 'Cryo Infinity',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 38,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 197,
    ),
    moveLimit: 10,
    scoreTarget: 20000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 27126,
    objective: LevelObjective.clearSpecial(35),
    initialStars: [
      // Row 0: all frozen
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: all frozen
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: blackHole+frozenStar alternating
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.blackHole,
      ),
      // Row 3: supernova+normal alternating
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.supernova,
      ),
      // Row 4: normal mix
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.normal,
      ),
      // Row 5: all frozen
      InitialStarPlacement(
        position: GridPosition(5, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 8),
        type: StarType.frozenStar,
      ),
    ],
  ),

  // Level 199 — Frozen Eternity (Boss encounter)
  LevelDefinition(
    id: 199,
    version: 1,
    displayName: 'Frozen Eternity',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 39,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 198,
    ),
    moveLimit: 10,
    scoreTarget: 20000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 27263,
    objective: LevelObjective.clearSpecial(35),
    initialStars: [
      // Row 0: all frozen
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: all frozen
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: supernova+blackHole+frozenStar cycling
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.frozenStar,
      ),
      // Row 3: normal mix
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: frozen+supernova
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: all frozen
      InitialStarPlacement(
        position: GridPosition(5, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 8),
        type: StarType.frozenStar,
      ),
    ],
  ),

  // Level 200 — The Final Freeze (THE FINAL BOSS)
  // randomSeed = 200 * 137 = 27400
  // 6 rows, ~60 stars, 28 frozen, all specials, clearSpecial(35), moveLimit=10
  LevelDefinition(
    id: 200,
    version: 1,
    displayName: 'The Final Freeze',
    worldMeta: LevelWorldMeta(
      worldId: 5,
      levelNumber: 40,
      worldName: 'Frozen Nebula',
      isUnlocked: false,
      unlockRequirement: 199,
    ),
    moveLimit: 10,
    scoreTarget: 20000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 27400,
    objective: LevelObjective.clearSpecial(35),
    initialStars: [
      // Row 0: all 9 frozenStar
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: all 9 frozenStar
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: blackHole(0,2,4,6,8), supernova(1,3,5,7), frozenStar at pos 8 → use blackHole
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.blackHole,
      ),
      // Row 3: all 9 normal (mixed rainbow/meteor)
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.rainbow,
      ),
      // Row 4: frozenStar(0,2,4,6,8), blackHole(1,3,5,7)
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.frozenStar,
      ),
      // Row 5: all 9 frozenStar
      InitialStarPlacement(
        position: GridPosition(5, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 8),
        type: StarType.frozenStar,
      ),
    ],
  ),
];
