import 'package:star_shooter/game/level/level_objective.dart';
import 'package:star_shooter/game/level/level_world_meta.dart';
import 'package:star_shooter/game/models/grid_position.dart';
import 'package:star_shooter/game/models/level_definition.dart';
import 'package:star_shooter/game/models/star_type.dart';

/// Levels 101–150: Very Hard (101–125) and Expert (126–150).
/// World 3 (Solar Winds): levels 101–120, levelNumber 21–40
/// World 4 (Event Horizon): levels 121–150, levelNumber 1–30
const List<LevelDefinition> levelsFrom101To150 = [
  // ══════════════════════════════════════════════════════════════════════════
  // WORLD 3 — SOLAR WINDS  (Levels 101–120, levelNumber 21–40)
  // Very Hard: all 6 star types, frozen obstacles, tight shot limits.
  // ══════════════════════════════════════════════════════════════════════════

  // Level 101 — Horizon Break
  // Pattern A: Frozen interspersed in row 1, supernova in row 3, blackHole in row 4
  LevelDefinition(
    id: 101,
    version: 1,
    displayName: 'Horizon Break',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 21,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 100,
    ),
    moveLimit: 14,
    scoreTarget: 6000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 13837,
    objective: LevelObjective.clearSpecial(15),
    initialStars: [
      // Row 0: full normal row (9 stars)
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: frozen interspersed (5 frozen, 4 normal)
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
      // Row 2: full normal row (9 stars)
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.normal,
      ),
      // Row 3: supernova at strategic spots
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.supernova,
      ),
      // Row 4: blackHole anchors
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.blackHole,
      ),
    ],
  ),

  // Level 102 — Event Cascade
  // Pattern B: Frozen block in top-left corner
  LevelDefinition(
    id: 102,
    version: 1,
    displayName: 'Event Cascade',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 22,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 101,
    ),
    moveLimit: 13,
    scoreTarget: 6500,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 13974,
    objective: LevelObjective.clearSpecial(16),
    initialStars: [
      // Row 0: frozen block top-left + normal right
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.rainbow,
      ),
      // Row 1: frozen block continues + normal right
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.normal,
      ),
      // Row 2: mixed
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.normal,
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
        position: GridPosition(2, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
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
      // Row 3: sparse specials
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.blackHole,
      ),
      // Row 4: anchor
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.supernova,
      ),
    ],
  ),

  // Level 103 — Solar Crisis
  // Pattern C: Frozen scattered across two rows
  LevelDefinition(
    id: 103,
    version: 1,
    displayName: 'Solar Crisis',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 23,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 102,
    ),
    moveLimit: 14,
    scoreTarget: 6000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 14111,
    objective: LevelObjective.clearStarType(18, StarType.normal),
    initialStars: [
      // Row 0: alternating frozen/normal
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
        type: StarType.normal,
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
      // Row 1: full normal
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.normal,
      ),
      // Row 2: frozen scattered 3 more
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.meteor,
      ),
      // Row 3: supernova/blackhole
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.supernova,
      ),
      // Row 4: anchors
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.blackHole,
      ),
    ],
  ),

  // Level 104 — Void Collapse
  // Pattern D: Frozen stars surrounding key specials
  LevelDefinition(
    id: 104,
    version: 1,
    displayName: 'Void Collapse',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 24,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 103,
    ),
    moveLimit: 12,
    scoreTarget: 7000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 14248,
    objective: LevelObjective.clearSpecial(18),
    initialStars: [
      // Row 0: full row
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.rainbow,
      ),
      // Row 1: frozen surrounding center specials
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.normal,
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
        type: StarType.normal,
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
        type: StarType.normal,
      ),
      // Row 2: full row
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.normal,
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
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.meteor,
      ),
      // Row 3: specials
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.blackHole,
      ),
      // Row 4: anchor
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 105 — Star Prison
  // Pattern E: Diagonal frozen line
  LevelDefinition(
    id: 105,
    version: 1,
    displayName: 'Star Prison',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 25,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 104,
    ),
    moveLimit: 13,
    scoreTarget: 6500,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 14385,
    objective: LevelObjective.clearSpecial(15),
    initialStars: [
      // Row 0: full row with diagonal frozen start
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.rainbow,
      ),
      // Row 1: diagonal frozen
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.normal,
      ),
      // Row 2: diagonal frozen continues
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.normal,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.normal,
      ),
      // Row 3: diagonal frozen continues
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
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
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.supernova,
      ),
      // Row 4: diagonal frozen end
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.blackHole,
      ),
    ],
  ),

  // Level 106 — Nebula Lock
  // Pattern F: Two isolated frozen clusters
  LevelDefinition(
    id: 106,
    version: 1,
    displayName: 'Nebula Lock',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 26,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 105,
    ),
    moveLimit: 14,
    scoreTarget: 6000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 14522,
    objective: LevelObjective.clearStarType(12, StarType.meteor),
    initialStars: [
      // Row 0: dense full row
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: cluster left + meteor scatter
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.meteor,
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
      // Row 2: mixed
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.meteor,
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.meteor,
      ),
      // Row 3: supernova band
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
      // Row 4: blackholes
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.blackHole,
      ),
    ],
  ),

  // Level 107 — Crystal Storm
  // Pattern A variant: frozen every-other in rows 0 and 2
  LevelDefinition(
    id: 107,
    version: 1,
    displayName: 'Crystal Storm',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 27,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 106,
    ),
    moveLimit: 13,
    scoreTarget: 7000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 14659,
    objective: LevelObjective.clearSpecial(17),
    initialStars: [
      // Row 0: frozen/normal alternating
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
      // Row 1: full normal+rainbow
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.normal,
      ),
      // Row 2: frozen alternating offset
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.frozenStar,
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
        type: StarType.normal,
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
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.normal,
      ),
      // Row 3: supernova/blackhole
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.supernova,
      ),
      // Row 4: blackhole
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.blackHole,
      ),
    ],
  ),

  // Level 108 — Deep Freeze
  // Pattern B variant: Frozen block in top-right corner
  LevelDefinition(
    id: 108,
    version: 1,
    displayName: 'Deep Freeze',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 28,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 107,
    ),
    moveLimit: 12,
    scoreTarget: 7500,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 14796,
    objective: LevelObjective.clearSpecial(20),
    initialStars: [
      // Row 0: normal left, frozen right block
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
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
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: normal left, frozen right block continues
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.normal,
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
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: full mixed
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.normal,
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
      // Row 3: specials
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.supernova,
      ),
      // Row 4: anchor
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 109 — Ice Barrier
  // Pattern C: Frozen spread across row 0 and row 3
  LevelDefinition(
    id: 109,
    version: 1,
    displayName: 'Ice Barrier',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 29,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 108,
    ),
    moveLimit: 13,
    scoreTarget: 7000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 14933,
    objective: LevelObjective.clearSpecial(18),
    initialStars: [
      // Row 0: frozen barrier at top
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
      // Row 1: full mixed
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.rainbow,
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.normal,
      ),
      // Row 2: mixed
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.meteor,
      ),
      // Row 3: frozen second barrier
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.frozenStar,
      ),
      // Row 4: blackhole
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.blackHole,
      ),
    ],
  ),

  // Level 110 — Permafrost
  // Pattern D: Frozen surrounding supernova cores
  LevelDefinition(
    id: 110,
    version: 1,
    displayName: 'Permafrost',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 30,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 109,
    ),
    moveLimit: 14,
    scoreTarget: 6500,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 15070,
    objective: LevelObjective.clearStarType(20, StarType.normal),
    initialStars: [
      // Row 0: full dense row
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: frozen/normal mix
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.frozenStar,
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
        type: StarType.normal,
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
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.normal,
      ),
      // Row 2: supernova cores
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.normal,
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
        type: StarType.normal,
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
        type: StarType.normal,
      ),
      // Row 3: meteor + frozen
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.meteor,
      ),
      // Row 4: anchors
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.blackHole,
      ),
    ],
  ),

  // Level 111 — Cryo Vault
  // Pattern E: Diagonal frozen from top-right to bottom-left
  LevelDefinition(
    id: 111,
    version: 1,
    displayName: 'Cryo Vault',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 31,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 110,
    ),
    moveLimit: 13,
    scoreTarget: 7000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 15207,
    objective: LevelObjective.clearSpecial(18),
    initialStars: [
      // Row 0: normal + frozen at end of diagonal
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.frozenStar,
      ),
      // Row 1: normal + diagonal frozen
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.normal,
      ),
      // Row 2: diagonal frozen continues
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.normal,
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.supernova,
      ),
      // Row 3: diagonal continues
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.normal,
      ),
      // Row 4: frozen end + anchor
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.blackHole,
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
        type: StarType.blackHole,
      ),
    ],
  ),

  // Level 112 — Frost Web
  // Pattern F: Two isolated frozen clusters mid-board
  LevelDefinition(
    id: 112,
    version: 1,
    displayName: 'Frost Web',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 32,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 111,
    ),
    moveLimit: 14,
    scoreTarget: 6500,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 15344,
    objective: LevelObjective.clearSpecial(16),
    initialStars: [
      // Row 0: full row
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.meteor,
      ),
      // Row 1: cluster left + cluster right frozen
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: mixed
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.normal,
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
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.normal,
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.normal,
      ),
      // Row 3: sparse specials
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.blackHole,
      ),
      // Row 4: anchors
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 113 — Arctic Core
  // Pattern A: Dense with frozen in row 1 interspersed + heavy specials
  LevelDefinition(
    id: 113,
    version: 1,
    displayName: 'Arctic Core',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 33,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 112,
    ),
    moveLimit: 12,
    scoreTarget: 8000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 15481,
    objective: LevelObjective.clearSpecial(20),
    initialStars: [
      // Row 0: full row
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: frozen interspersed
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.rainbow,
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
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: full row
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.normal,
      ),
      // Row 3: supernova band
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.supernova,
      ),
      // Row 4: blackholes
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.blackHole,
      ),
    ],
  ),

  // Level 114 — Ice Field
  // Pattern B: Frozen block top-center
  LevelDefinition(
    id: 114,
    version: 1,
    displayName: 'Ice Field',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 34,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 113,
    ),
    moveLimit: 14,
    scoreTarget: 6500,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 15618,
    objective: LevelObjective.clearStarType(14, StarType.meteor),
    initialStars: [
      // Row 0: frozen block in center top
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.meteor,
      ),
      // Row 1: frozen block continues
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.meteor,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.normal,
      ),
      // Row 2: meteor scattered
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.meteor,
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.meteor,
      ),
      // Row 3: supernova
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.supernova,
      ),
      // Row 4: anchors
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.blackHole,
      ),
    ],
  ),

  // Level 115 — Glacial Push
  // Pattern C: Frozen row 0 partial + row 2 partial
  LevelDefinition(
    id: 115,
    version: 1,
    displayName: 'Glacial Push',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 35,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 114,
    ),
    moveLimit: 13,
    scoreTarget: 7500,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 15755,
    objective: LevelObjective.clearSpecial(18),
    initialStars: [
      // Row 0: frozen at edges + normal center
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
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
        type: StarType.frozenStar,
      ),
      // Row 1: full row
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.rainbow,
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.normal,
      ),
      // Row 2: frozen partial in middle
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.normal,
      ),
      // Row 3: supernova
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.supernova,
      ),
      // Row 4: anchors
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.blackHole,
      ),
    ],
  ),

  // Level 116 — Polar Vortex
  // Pattern D: Frozen surrounding a blackhole core
  LevelDefinition(
    id: 116,
    version: 1,
    displayName: 'Polar Vortex',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 36,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 115,
    ),
    moveLimit: 12,
    scoreTarget: 8000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 15892,
    objective: LevelObjective.clearSpecial(20),
    initialStars: [
      // Row 0: full normal
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: full mixed
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.meteor,
      ),
      // Row 2: frozen ring around center
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.frozenStar,
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
        type: StarType.blackHole,
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
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.normal,
      ),
      // Row 3: sparse
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.supernova,
      ),
      // Row 4: anchors
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.blackHole,
      ),
    ],
  ),

  // Level 117 — Tundra Surge
  // Pattern E: Diagonal frozen from left to right
  LevelDefinition(
    id: 117,
    version: 1,
    displayName: 'Tundra Surge',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 37,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 116,
    ),
    moveLimit: 14,
    scoreTarget: 7000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 16029,
    objective: LevelObjective.clearStarType(16, StarType.rainbow),
    initialStars: [
      // Row 0: full + frozenStar at start of diagonal
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: diagonal step 2
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.normal,
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.rainbow,
      ),
      // Row 2: diagonal step 3
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.rainbow,
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.normal,
      ),
      // Row 3: diagonal step 4
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
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
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.supernova,
      ),
      // Row 4: end + anchor
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.blackHole,
      ),
    ],
  ),

  // Level 118 — Sub-Zero
  // Pattern F: Two isolated frozen clusters at rows 1-2
  LevelDefinition(
    id: 118,
    version: 1,
    displayName: 'Sub-Zero',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 38,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 117,
    ),
    moveLimit: 13,
    scoreTarget: 7500,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 16166,
    objective: LevelObjective.clearSpecial(19),
    initialStars: [
      // Row 0: full row
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.rainbow,
      ),
      // Row 1: cluster left frozen
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.supernova,
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
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: cluster right frozen
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.supernova,
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
      // Row 3: specials
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.blackHole,
      ),
      // Row 4: anchors
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.supernova,
      ),
    ],
  ),

  // Level 119 — Absolute Cold
  // Pattern A: Frozen interspersed in two rows
  LevelDefinition(
    id: 119,
    version: 1,
    displayName: 'Absolute Cold',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 39,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 118,
    ),
    moveLimit: 12,
    scoreTarget: 8500,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 16303,
    objective: LevelObjective.clearSpecial(22),
    initialStars: [
      // Row 0: full row, frozen in even positions
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
      // Row 1: full normal
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.normal,
      ),
      // Row 2: frozen in odd positions
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.frozenStar,
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
        type: StarType.normal,
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
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.normal,
      ),
      // Row 3: specials band
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.supernova,
      ),
      // Row 4: anchors
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.blackHole,
      ),
    ],
  ),

  // Level 120 — Ice Wall  (World 3 Solar Winds level 40 / final)
  // Pattern A+D combined: Full frozen row 1 + specials surrounded by frozen
  LevelDefinition(
    id: 120,
    version: 1,
    displayName: 'Ice Wall',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 40,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 119,
    ),
    moveLimit: 12,
    scoreTarget: 9000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 16440,
    objective: LevelObjective.clearSpecial(25),
    initialStars: [
      // Row 0: full row normal
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: all frozen ice wall
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
      // Row 2: full normal
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.normal,
      ),
      // Row 3: supernova/blackhole dense
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.supernova,
      ),
      // Row 4: rainbow
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.rainbow,
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════════════════════
  // WORLD 4 — EVENT HORIZON  (Levels 121–150, levelNumber 1–30)
  // Expert: very dense boards, 6-14 frozen stars, extreme shot limits.
  // ══════════════════════════════════════════════════════════════════════════

  // Level 121 — Gravity Crush
  // 6 frozen stars, full rows 0-3, dense board
  LevelDefinition(
    id: 121,
    version: 1,
    displayName: 'Gravity Crush',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 1,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 120,
    ),
    moveLimit: 13,
    scoreTarget: 9000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 16577,
    objective: LevelObjective.clearSpecial(22),
    initialStars: [
      // Row 0: full row
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: frozen 6 (alternating)
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
        type: StarType.normal,
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
        type: StarType.frozenStar,
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.normal,
      ),
      // Row 3: supernova/blackhole
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
        type: StarType.blackHole,
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
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.supernova,
      ),
      // Row 4: anchors
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.meteor,
      ),
    ],
  ),

  // Level 122 — Black Spiral
  // 8 frozen stars, near-full grid
  LevelDefinition(
    id: 122,
    version: 1,
    displayName: 'Black Spiral',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 2,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 121,
    ),
    moveLimit: 12,
    scoreTarget: 9500,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 16714,
    objective: LevelObjective.clearSpecial(24),
    initialStars: [
      // Row 0: full row
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: frozen 3 + specials
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
        type: StarType.blackHole,
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
      // Row 2: full row
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.normal,
      ),
      // Row 3: frozen 3 + mix
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.frozenStar,
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
        type: StarType.supernova,
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
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: anchors
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.blackHole,
      ),
    ],
  ),

  // Level 123 — Event Lock
  // 8 frozen stars, all 5 rows dense
  LevelDefinition(
    id: 123,
    version: 1,
    displayName: 'Event Lock',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 3,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 122,
    ),
    moveLimit: 11,
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
    randomSeed: 16851,
    objective: LevelObjective.clearSpecial(26),
    initialStars: [
      // Row 0: full row
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: full row with frozen and specials
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: full row
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.normal,
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
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.normal,
      ),
      // Row 3: frozen and specials
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.blackHole,
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
      // Row 4: anchors
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.meteor,
      ),
    ],
  ),

  // Level 124 — Horizon Fall
  // 9 frozen stars, fortress pattern
  LevelDefinition(
    id: 124,
    version: 1,
    displayName: 'Horizon Fall',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 4,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 123,
    ),
    moveLimit: 12,
    scoreTarget: 9500,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 16988,
    objective: LevelObjective.clearSpecial(25),
    initialStars: [
      // Row 0: full row
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: fortress walls - frozen at edges
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.supernova,
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
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: mixed
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.rainbow,
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
        type: StarType.blackHole,
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
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.normal,
      ),
      // Row 3: specials
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
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.supernova,
      ),
      // Row 4: anchors
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.blackHole,
      ),
    ],
  ),

  // Level 125 — Singularity Edge  (Very Hard final boss)
  // 8 frozen stars, boss level, all rows dense
  LevelDefinition(
    id: 125,
    version: 1,
    displayName: 'Singularity Edge',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 5,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 124,
    ),
    moveLimit: 11,
    scoreTarget: 9000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
      StarType.frozenStar,
    ],
    randomSeed: 17125,
    objective: LevelObjective.clearSpecial(28),
    initialStars: [
      // Row 0: full row
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: frozen + specials
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
      // Row 2: full row
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.normal,
      ),
      // Row 3: frozen + supernova
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.supernova,
      ),
      // Row 4: rainbow + blackhole
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.rainbow,
      ),
    ],
  ),

  // Level 126 — Dark Orbit
  // Expert: 10 frozen stars, very dense
  LevelDefinition(
    id: 126,
    version: 1,
    displayName: 'Dark Orbit',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 6,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 125,
    ),
    moveLimit: 12,
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
    randomSeed: 17262,
    objective: LevelObjective.clearSpecial(28),
    initialStars: [
      // Row 0: full row
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: frozen all odd
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.frozenStar,
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
        type: StarType.normal,
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
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.normal,
      ),
      // Row 2: full + frozen even
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
      // Row 3: mixed
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
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
        type: StarType.blackHole,
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
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: rainbow row
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.rainbow,
      ),
    ],
  ),

  // Level 127 — Mass Effect
  // Expert: 10 frozen, 5 rows completely full
  LevelDefinition(
    id: 127,
    version: 1,
    displayName: 'Mass Effect',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 7,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 126,
    ),
    moveLimit: 11,
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
    randomSeed: 17399,
    objective: LevelObjective.clearSpecial(30),
    initialStars: [
      // Row 0: full normal
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: frozen + meteor
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.meteor,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: full supernova row
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
      // Row 3: frozen + blackhole
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.blackHole,
      ),
      // Row 4: rainbow row
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.rainbow,
      ),
    ],
  ),

  // Level 128 — Warp Field
  // Expert: 11 frozen stars
  LevelDefinition(
    id: 128,
    version: 1,
    displayName: 'Warp Field',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 8,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 127,
    ),
    moveLimit: 12,
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
    randomSeed: 17536,
    objective: LevelObjective.clearSpecial(30),
    initialStars: [
      // Row 0: full normal
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: frozen wall even positions
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.rainbow,
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
        type: StarType.rainbow,
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.normal,
      ),
      // Row 3: frozen odd + specials
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.supernova,
      ),
      // Row 4: blackholes + meteor
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.blackHole,
      ),
    ],
  ),

  // Level 129 — Space Fold
  // Expert: 11 frozen stars, 6 rows (rows 0-5)
  LevelDefinition(
    id: 129,
    version: 1,
    displayName: 'Space Fold',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 9,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 128,
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
    randomSeed: 17673,
    objective: LevelObjective.clearSpecial(32),
    initialStars: [
      // Row 0: full normal
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: frozen all even
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
      // Row 3: frozen all odd
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: blackhole row
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
      // Row 5: frozen + rainbow
      InitialStarPlacement(
        position: GridPosition(5, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(5, 8),
        type: StarType.frozenStar,
      ),
    ],
  ),

  // Level 130 — Dimensional Rift
  // Expert: 12 frozen stars
  LevelDefinition(
    id: 130,
    version: 1,
    displayName: 'Dimensional Rift',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 10,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 129,
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
    randomSeed: 17810,
    objective: LevelObjective.clearSpecial(30),
    initialStars: [
      // Row 0: full row
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: frozen walls
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.normal,
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
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: supernova center
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.normal,
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
      // Row 3: frozen center wall
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: blackhole + anchor
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.blackHole,
      ),
    ],
  ),

  // Level 131 — Quantum Maze
  // Expert: 12 frozen stars, score target objective
  LevelDefinition(
    id: 131,
    version: 1,
    displayName: 'Quantum Maze',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 11,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 130,
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
    randomSeed: 17947,
    objective: LevelObjective.scoreTarget(110000),
    initialStars: [
      // Row 0: full normal
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: frozen maze step 1
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
        type: StarType.normal,
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
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: normal + meteor
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.meteor,
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
      // Row 3: frozen maze step 2
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.frozenStar,
      ),
      // Row 4: supernova + blackhole
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.supernova,
      ),
    ],
  ),

  // Level 132 — Photon Web
  // Expert: 10 frozen, dense 5-row board
  LevelDefinition(
    id: 132,
    version: 1,
    displayName: 'Photon Web',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 12,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 131,
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
    randomSeed: 18084,
    objective: LevelObjective.clearSpecial(28),
    initialStars: [
      // Row 0: full normal
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: photon web - frozen corners
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.rainbow,
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: full specials
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
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.supernova,
      ),
      // Row 3: frozen corners + normal
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
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.frozenStar,
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
        type: StarType.frozenStar,
      ),
      // Row 4: blackhole row
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.blackHole,
      ),
    ],
  ),

  // Level 133 — Neutron Path
  // Expert: 12 frozen stars
  LevelDefinition(
    id: 133,
    version: 1,
    displayName: 'Neutron Path',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 13,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 132,
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
    randomSeed: 18221,
    objective: LevelObjective.scoreTarget(120000),
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
      // Row 1: full normal
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.normal,
      ),
      // Row 2: full frozen
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.frozenStar,
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
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.frozenStar,
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
      // Row 4: blackhole row
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.blackHole,
      ),
    ],
  ),

  // Level 134 — Pulsar Lock
  // Expert: 10 frozen stars
  LevelDefinition(
    id: 134,
    version: 1,
    displayName: 'Pulsar Lock',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 14,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 133,
    ),
    moveLimit: 12,
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
    randomSeed: 18358,
    objective: LevelObjective.clearSpecial(30),
    initialStars: [
      // Row 0: full row
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: frozen + specials locked
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
        type: StarType.frozenStar,
      ),
      // Row 2: full normal
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.normal,
      ),
      // Row 3: frozen + supernova
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.supernova,
      ),
      // Row 4: anchors
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.rainbow,
      ),
    ],
  ),

  // Level 135 — Quasar Trap
  // Expert: 12 frozen stars
  LevelDefinition(
    id: 135,
    version: 1,
    displayName: 'Quasar Trap',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 15,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 134,
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
    randomSeed: 18495,
    objective: LevelObjective.clearSpecial(32),
    initialStars: [
      // Row 0: full row
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: frozen trap
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
        type: StarType.frozenStar,
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.normal,
      ),
      // Row 3: frozen + blackhole
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.blackHole,
      ),
      // Row 4: rainbow row
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.rainbow,
      ),
    ],
  ),

  // Level 136 — Plasma Cage
  // Expert: 11 frozen stars
  LevelDefinition(
    id: 136,
    version: 1,
    displayName: 'Plasma Cage',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 16,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 135,
    ),
    moveLimit: 12,
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
    randomSeed: 18632,
    objective: LevelObjective.clearSpecial(30),
    initialStars: [
      // Row 0: full normal
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: plasma cage - frozen at positions
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
      // Row 2: full mixed
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.rainbow,
      ),
      // Row 3: frozen + blackhole
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: meteor row
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.meteor,
      ),
    ],
  ),

  // Level 137 — Ion Prison
  // Expert: 12 frozen stars, score target
  LevelDefinition(
    id: 137,
    version: 1,
    displayName: 'Ion Prison',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 17,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 136,
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
    randomSeed: 18769,
    objective: LevelObjective.scoreTarget(120000),
    initialStars: [
      // Row 0: full normal
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: prison bars - frozen alternating
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.meteor,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: full mixed
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.supernova,
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
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.normal,
      ),
      // Row 3: frozen prison bars
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.frozenStar,
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
        type: StarType.meteor,
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
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.meteor,
      ),
      // Row 4: blackhole row
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.blackHole,
      ),
    ],
  ),

  // Level 138 — Magnetic Storm
  // Expert: 12 frozen, dense board
  LevelDefinition(
    id: 138,
    version: 1,
    displayName: 'Magnetic Storm',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 18,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 137,
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
    randomSeed: 18906,
    objective: LevelObjective.clearSpecial(32),
    initialStars: [
      // Row 0: full normal
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: magnetic frozen + specials
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
      // Row 2: full mixed
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.normal,
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.normal,
      ),
      // Row 3: frozen + blackhole
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.blackHole,
      ),
      // Row 4: rainbow + meteor
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.rainbow,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.rainbow,
      ),
    ],
  ),

  // Level 139 — Vortex Ring
  // Expert: 12 frozen stars, vortex pattern
  LevelDefinition(
    id: 139,
    version: 1,
    displayName: 'Vortex Ring',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 19,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 138,
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
    randomSeed: 19043,
    objective: LevelObjective.clearSpecial(32),
    initialStars: [
      // Row 0: full normal
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: vortex ring frozen
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: ring inner
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
        type: StarType.frozenStar,
      ),
      // Row 3: ring outer
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.frozenStar,
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
        type: StarType.supernova,
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
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.frozenStar,
      ),
      // Row 4: anchors
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.blackHole,
      ),
    ],
  ),

  // Level 140 — Spiral Nexus
  // Expert: 12 frozen stars
  LevelDefinition(
    id: 140,
    version: 1,
    displayName: 'Spiral Nexus',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 20,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 139,
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
    randomSeed: 19180,
    objective: LevelObjective.clearSpecial(30),
    initialStars: [
      // Row 0: full normal
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: frozen spiral step
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.normal,
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
      // Row 3: frozen spiral continues
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.frozenStar,
      ),
      // Row 4: blackhole + anchor
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.blackHole,
      ),
    ],
  ),

  // Level 141 — Event Web
  // Expert: 14 frozen stars
  LevelDefinition(
    id: 141,
    version: 1,
    displayName: 'Event Web',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 21,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 140,
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
    randomSeed: 19317,
    objective: LevelObjective.clearSpecial(34),
    initialStars: [
      // Row 0: full normal
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: web frozen all even
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
      // Row 2: full mixed
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.normal,
      ),
      // Row 3: web frozen all odd
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.blackHole,
      ),
      // Row 4: rainbow + meteor
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.rainbow,
      ),
    ],
  ),

  // Level 142 — Horizon Lock
  // Expert: 12 frozen stars
  LevelDefinition(
    id: 142,
    version: 1,
    displayName: 'Horizon Lock',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 22,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 141,
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
    randomSeed: 19454,
    objective: LevelObjective.clearSpecial(32),
    initialStars: [
      // Row 0: full normal
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: lock pattern
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
      // Row 2: full mixed
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
      // Row 3: lock 2
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: rainbow + anchors
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.rainbow,
      ),
    ],
  ),

  // Level 143 — Collapse Point
  // Expert: 12 frozen stars, score target
  LevelDefinition(
    id: 143,
    version: 1,
    displayName: 'Collapse Point',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 23,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 142,
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
    randomSeed: 19591,
    objective: LevelObjective.scoreTarget(120000),
    initialStars: [
      // Row 0: full normal
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: collapse pattern frozen
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.meteor,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: full rainbow
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.rainbow,
      ),
      // Row 3: frozen + supernova
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.supernova,
      ),
      // Row 4: blackhole row
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.blackHole,
      ),
    ],
  ),

  // Level 144 — Dark Nexus
  // Expert: 14 frozen stars
  LevelDefinition(
    id: 144,
    version: 1,
    displayName: 'Dark Nexus',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 24,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 143,
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
    randomSeed: 19728,
    objective: LevelObjective.clearSpecial(34),
    initialStars: [
      // Row 0: full normal
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: frozen dense
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
      // Row 2: full specials
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
      // Row 3: frozen dense
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.frozenStar,
      ),
      // Row 4: blackhole row
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.blackHole,
      ),
    ],
  ),

  // Level 145 — Void Spiral
  // Expert: 12 frozen stars
  LevelDefinition(
    id: 145,
    version: 1,
    displayName: 'Void Spiral',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 25,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 144,
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
    randomSeed: 19865,
    objective: LevelObjective.clearSpecial(32),
    initialStars: [
      // Row 0: full normal
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: frozen alternating
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
      // Row 2: full supernova
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
      // Row 3: frozen alternating offset
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      // Row 4: blackhole row
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.blackHole,
      ),
    ],
  ),

  // Level 146 — Mass Trap
  // Expert: 12 frozen stars
  LevelDefinition(
    id: 146,
    version: 1,
    displayName: 'Mass Trap',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 26,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 145,
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
    randomSeed: 20002,
    objective: LevelObjective.clearSpecial(32),
    initialStars: [
      // Row 0: full normal
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: trap pattern frozen
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
        type: StarType.supernova,
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
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.frozenStar,
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.normal,
      ),
      // Row 3: frozen + blackhole
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.blackHole,
      ),
      // Row 4: rainbow + meteor
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.rainbow,
      ),
    ],
  ),

  // Level 147 — Gravity Lock
  // Expert: 13 frozen stars
  LevelDefinition(
    id: 147,
    version: 1,
    displayName: 'Gravity Lock',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 27,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 146,
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
    randomSeed: 20139,
    objective: LevelObjective.clearSpecial(34),
    initialStars: [
      // Row 0: full normal
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: frozen all
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
      // Row 2: full specials
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
      // Row 3: frozen + supernova
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
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.frozenStar,
      ),
      // Row 4: rainbow row
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.rainbow,
      ),
    ],
  ),

  // Level 148 — Event Storm
  // Expert: 12 frozen stars
  LevelDefinition(
    id: 148,
    version: 1,
    displayName: 'Event Storm',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 28,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 147,
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
    randomSeed: 20276,
    objective: LevelObjective.clearSpecial(32),
    initialStars: [
      // Row 0: full normal
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: storm frozen pattern
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.supernova,
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
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.frozenStar,
      ),
      // Row 2: full mixed
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.meteor,
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
      // Row 3: frozen + blackhole
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.blackHole,
      ),
      // Row 4: rainbow row
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.rainbow,
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
        type: StarType.rainbow,
      ),
    ],
  ),

  // Level 149 — Horizon Web
  // Expert: 13 frozen stars, near-final
  LevelDefinition(
    id: 149,
    version: 1,
    displayName: 'Horizon Web',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 29,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 148,
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
    randomSeed: 20413,
    objective: LevelObjective.clearSpecial(34),
    initialStars: [
      // Row 0: full normal
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: web frozen
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
      // Row 2: full normal
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.normal,
      ),
      // Row 3: frozen web 2
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.blackHole,
      ),
      // Row 4: rainbow + meteor
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.rainbow,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.rainbow,
      ),
    ],
  ),

  // Level 150 — Dark Core  (World 4 / Expert final boss)
  // Expert: 14 frozen stars, near-full grid, brutal difficulty
  LevelDefinition(
    id: 150,
    version: 1,
    displayName: 'Dark Core',
    worldMeta: LevelWorldMeta(
      worldId: 4,
      levelNumber: 30,
      worldName: 'Event Horizon',
      isUnlocked: false,
      unlockRequirement: 149,
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
    randomSeed: 20550,
    objective: LevelObjective.clearSpecial(36),
    initialStars: [
      // Row 0: full normal
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1: dark frozen layer
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
      // Row 2: supernova layer
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
      // Row 3: frozen layer
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.frozenStar,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.frozenStar,
      ),
      // Row 4: blackhole layer (dark core)
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
    ],
  ),
];
