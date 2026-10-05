import 'package:star_shooter/game/level/level_objective.dart';
import 'package:star_shooter/game/level/level_world_meta.dart';
import 'package:star_shooter/game/models/grid_position.dart';
import 'package:star_shooter/game/models/level_definition.dart';
import 'package:star_shooter/game/models/star_type.dart';

/// Levels 51–100: Advanced progression.
/// World 2 (Asteroid Fields): levels 51–80 (levelNumber 11–40 in that world)
/// World 3 (Solar Winds): levels 81–100 (levelNumber 1–20 in that world)
const List<LevelDefinition> levelsFrom51To100 = [
  // ══════════════════════════════════════════════════════════════════════════
  // WORLD 2 — ASTEROID FIELDS  (Levels 51–80, levelNumber 11–40)
  // Meteor + rainbow mechanics. Supernova/blackHole from level 71.
  // ══════════════════════════════════════════════════════════════════════════

  // Level 51 — Comet Trail
  LevelDefinition(
    id: 51,
    version: 1,
    displayName: 'Comet Trail',
    worldMeta: LevelWorldMeta(
      worldId: 2,
      levelNumber: 11,
      worldName: 'Asteroid Fields',
      isUnlocked: false,
      unlockRequirement: 50,
    ),
    moveLimit: 22,
    scoreTarget: 2500,
    failureBoundaryRow: 10,
    availableStarTypes: [StarType.normal, StarType.meteor, StarType.rainbow],
    randomSeed: 6987,
    objective: LevelObjective.scoreTarget(2500),
    initialStars: [
      // Row 0 — full
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
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1 — full
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
      // Row 2 — partial
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.normal,
      ),
      // Row 3 — sparse
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 52 — Asteroid Belt
  LevelDefinition(
    id: 52,
    version: 1,
    displayName: 'Asteroid Belt',
    worldMeta: LevelWorldMeta(
      worldId: 2,
      levelNumber: 12,
      worldName: 'Asteroid Fields',
      isUnlocked: false,
      unlockRequirement: 51,
    ),
    moveLimit: 21,
    scoreTarget: 2600,
    failureBoundaryRow: 10,
    availableStarTypes: [StarType.normal, StarType.meteor, StarType.rainbow],
    randomSeed: 7124,
    objective: LevelObjective.clearStarType(8, StarType.meteor),
    initialStars: [
      // Row 0 — checkerboard meteors
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.meteor,
      ),
      // Row 1 — full normal/rainbow
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
      // Row 2 — partial
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.meteor,
      ),
      // Row 3 — sparse
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 53 — Orbital Drift
  LevelDefinition(
    id: 53,
    version: 1,
    displayName: 'Orbital Drift',
    worldMeta: LevelWorldMeta(
      worldId: 2,
      levelNumber: 13,
      worldName: 'Asteroid Fields',
      isUnlocked: false,
      unlockRequirement: 52,
    ),
    moveLimit: 21,
    scoreTarget: 2700,
    failureBoundaryRow: 10,
    availableStarTypes: [StarType.normal, StarType.meteor, StarType.rainbow],
    randomSeed: 7261,
    objective: LevelObjective.clearStars(25),
    initialStars: [
      // Row 0 — full
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.meteor,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1 — alternating
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.normal,
      ),
      // Row 2 — full
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
        type: StarType.meteor,
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
        type: StarType.rainbow,
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
      // Row 3 — sparse
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.rainbow,
      ),
    ],
  ),

  // Level 54 — Debris Field
  LevelDefinition(
    id: 54,
    version: 1,
    displayName: 'Debris Field',
    worldMeta: LevelWorldMeta(
      worldId: 2,
      levelNumber: 14,
      worldName: 'Asteroid Fields',
      isUnlocked: false,
      unlockRequirement: 53,
    ),
    moveLimit: 21,
    scoreTarget: 2800,
    failureBoundaryRow: 10,
    availableStarTypes: [StarType.normal, StarType.meteor, StarType.rainbow],
    randomSeed: 7398,
    objective: LevelObjective.clearStarType(6, StarType.rainbow),
    initialStars: [
      // Row 0 — full with rainbows
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
        type: StarType.meteor,
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
      // Row 1 — full
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.normal,
      ),
      // Row 2 — partial
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.normal,
      ),
      // Row 3 — sparse
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 55 — Crater Storm
  LevelDefinition(
    id: 55,
    version: 1,
    displayName: 'Crater Storm',
    worldMeta: LevelWorldMeta(
      worldId: 2,
      levelNumber: 15,
      worldName: 'Asteroid Fields',
      isUnlocked: false,
      unlockRequirement: 54,
    ),
    moveLimit: 20,
    scoreTarget: 2900,
    failureBoundaryRow: 10,
    availableStarTypes: [StarType.normal, StarType.meteor, StarType.rainbow],
    randomSeed: 7535,
    objective: LevelObjective.clearStars(28),
    initialStars: [
      // Row 0 — dense
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.rainbow,
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
      // Row 1 — dense
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
        type: StarType.normal,
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
      // Row 2 — medium
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.normal,
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
        type: StarType.rainbow,
      ),
      // Row 3 — sparse
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.meteor,
      ),
      // Row 4 — 2 stars
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.rainbow,
      ),
    ],
  ),

  // Level 56 — Space Rock
  LevelDefinition(
    id: 56,
    version: 1,
    displayName: 'Space Rock',
    worldMeta: LevelWorldMeta(
      worldId: 2,
      levelNumber: 16,
      worldName: 'Asteroid Fields',
      isUnlocked: false,
      unlockRequirement: 55,
    ),
    moveLimit: 20,
    scoreTarget: 3000,
    failureBoundaryRow: 10,
    availableStarTypes: [StarType.normal, StarType.meteor, StarType.rainbow],
    randomSeed: 7672,
    objective: LevelObjective.clearStarType(10, StarType.meteor),
    initialStars: [
      // Row 0 — heavy meteors
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.rainbow,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.meteor,
      ),
      // Row 1 — full
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
        type: StarType.meteor,
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
      // Row 2 — partial
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.meteor,
      ),
      // Row 3 — sparse
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.meteor,
      ),
    ],
  ),

  // Level 57 — Micro Impact
  LevelDefinition(
    id: 57,
    version: 1,
    displayName: 'Micro Impact',
    worldMeta: LevelWorldMeta(
      worldId: 2,
      levelNumber: 17,
      worldName: 'Asteroid Fields',
      isUnlocked: false,
      unlockRequirement: 56,
    ),
    moveLimit: 20,
    scoreTarget: 3100,
    failureBoundaryRow: 10,
    availableStarTypes: [StarType.normal, StarType.meteor, StarType.rainbow],
    randomSeed: 7809,
    objective: LevelObjective.scoreTarget(3100),
    initialStars: [
      // Row 0 — full with rainbows
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.rainbow,
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
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.rainbow,
      ),
      // Row 1 — full
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.normal,
      ),
      // Row 2 — partial
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.meteor,
      ),
      // Row 3 — sparse
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
    ],
  ),

  // Level 58 — Gravity Pull
  LevelDefinition(
    id: 58,
    version: 1,
    displayName: 'Gravity Pull',
    worldMeta: LevelWorldMeta(
      worldId: 2,
      levelNumber: 18,
      worldName: 'Asteroid Fields',
      isUnlocked: false,
      unlockRequirement: 57,
    ),
    moveLimit: 19,
    scoreTarget: 3200,
    failureBoundaryRow: 10,
    availableStarTypes: [StarType.normal, StarType.meteor, StarType.rainbow],
    randomSeed: 7946,
    objective: LevelObjective.clearStarType(8, StarType.rainbow),
    initialStars: [
      // Row 0 — rainbow focus
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.rainbow,
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
        type: StarType.meteor,
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
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1 — full
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.rainbow,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.rainbow,
      ),
      // Row 2 — partial
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.meteor,
      ),
      // Row 3 — sparse
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.rainbow,
      ),
    ],
  ),

  // Level 59 — Stellar Wind
  LevelDefinition(
    id: 59,
    version: 1,
    displayName: 'Stellar Wind',
    worldMeta: LevelWorldMeta(
      worldId: 2,
      levelNumber: 19,
      worldName: 'Asteroid Fields',
      isUnlocked: false,
      unlockRequirement: 58,
    ),
    moveLimit: 19,
    scoreTarget: 3300,
    failureBoundaryRow: 10,
    availableStarTypes: [StarType.normal, StarType.meteor, StarType.rainbow],
    randomSeed: 8083,
    objective: LevelObjective.clearStars(30),
    initialStars: [
      // Row 0 — diagonal pattern
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.meteor,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      // Row 1 — full
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
        type: StarType.rainbow,
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
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.normal,
      ),
      // Row 2 — full
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.meteor,
      ),
      // Row 3 — sparse
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 60 — Meteor Shower (W2 checkpoint)
  LevelDefinition(
    id: 60,
    version: 1,
    displayName: 'Meteor Shower',
    worldMeta: LevelWorldMeta(
      worldId: 2,
      levelNumber: 20,
      worldName: 'Asteroid Fields',
      isUnlocked: false,
      unlockRequirement: 59,
    ),
    moveLimit: 18,
    scoreTarget: 3500,
    failureBoundaryRow: 10,
    availableStarTypes: [StarType.normal, StarType.meteor, StarType.rainbow],
    randomSeed: 8220,
    objective: LevelObjective.scoreTarget(3500),
    initialStars: [
      // Row 0 — dense with all types
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.rainbow,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.meteor,
      ),
      // Row 1 — full
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
        type: StarType.rainbow,
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
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.normal,
      ),
      // Row 2 — partial
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.rainbow,
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
        type: StarType.rainbow,
      ),
      // Row 3 — sparse
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
    ],
  ),

  // Level 61 — Deep Field
  LevelDefinition(
    id: 61,
    version: 1,
    displayName: 'Deep Field',
    worldMeta: LevelWorldMeta(
      worldId: 2,
      levelNumber: 21,
      worldName: 'Asteroid Fields',
      isUnlocked: false,
      unlockRequirement: 60,
    ),
    moveLimit: 18,
    scoreTarget: 3600,
    failureBoundaryRow: 10,
    availableStarTypes: [StarType.normal, StarType.meteor, StarType.rainbow],
    randomSeed: 8357,
    objective: LevelObjective.clearStarType(12, StarType.meteor),
    initialStars: [
      // Row 0 — full
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.meteor,
      ),
      // Row 1 — full
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.rainbow,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.normal,
      ),
      // Row 2 — partial
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.meteor,
      ),
      // Row 3 — sparse
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 62 — Void Current
  LevelDefinition(
    id: 62,
    version: 1,
    displayName: 'Void Current',
    worldMeta: LevelWorldMeta(
      worldId: 2,
      levelNumber: 22,
      worldName: 'Asteroid Fields',
      isUnlocked: false,
      unlockRequirement: 61,
    ),
    moveLimit: 18,
    scoreTarget: 3700,
    failureBoundaryRow: 10,
    availableStarTypes: [StarType.normal, StarType.meteor, StarType.rainbow],
    randomSeed: 8494,
    objective: LevelObjective.clearStars(32),
    initialStars: [
      // Fortress shape: outer ring + interior specials
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
        type: StarType.normal,
      ),
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.normal,
      ),
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.meteor,
      ),
    ],
  ),

  // Level 63 — Dark Matter
  LevelDefinition(
    id: 63,
    version: 1,
    displayName: 'Dark Matter',
    worldMeta: LevelWorldMeta(
      worldId: 2,
      levelNumber: 23,
      worldName: 'Asteroid Fields',
      isUnlocked: false,
      unlockRequirement: 62,
    ),
    moveLimit: 17,
    scoreTarget: 3800,
    failureBoundaryRow: 10,
    availableStarTypes: [StarType.normal, StarType.meteor, StarType.rainbow],
    randomSeed: 8631,
    objective: LevelObjective.scoreTarget(3800),
    initialStars: [
      // Dense block rows 0-3
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.meteor,
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
        type: StarType.meteor,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
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
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 64 — Pulsar Beat
  LevelDefinition(
    id: 64,
    version: 1,
    displayName: 'Pulsar Beat',
    worldMeta: LevelWorldMeta(
      worldId: 2,
      levelNumber: 24,
      worldName: 'Asteroid Fields',
      isUnlocked: false,
      unlockRequirement: 63,
    ),
    moveLimit: 17,
    scoreTarget: 3900,
    failureBoundaryRow: 10,
    availableStarTypes: [StarType.normal, StarType.meteor, StarType.rainbow],
    randomSeed: 8768,
    objective: LevelObjective.clearStarType(10, StarType.rainbow),
    initialStars: [
      // Row 0 — dense rainbow
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.rainbow,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.meteor,
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
        type: StarType.rainbow,
      ),
      // Row 1 — full
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
        type: StarType.meteor,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.normal,
      ),
      // Row 2 — partial
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.normal,
      ),
      // Row 3 — sparse
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.rainbow,
      ),
    ],
  ),

  // Level 65 — Ion Storm
  LevelDefinition(
    id: 65,
    version: 1,
    displayName: 'Ion Storm',
    worldMeta: LevelWorldMeta(
      worldId: 2,
      levelNumber: 25,
      worldName: 'Asteroid Fields',
      isUnlocked: false,
      unlockRequirement: 64,
    ),
    moveLimit: 17,
    scoreTarget: 4000,
    failureBoundaryRow: 10,
    availableStarTypes: [StarType.normal, StarType.meteor, StarType.rainbow],
    randomSeed: 8905,
    objective: LevelObjective.clearStars(34),
    initialStars: [
      // Pyramid shape — rows 0-4
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.meteor,
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
        type: StarType.meteor,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.rainbow,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.rainbow,
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
        type: StarType.meteor,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.meteor,
      ),
    ],
  ),

  // Level 66 — Cosmic Ray
  LevelDefinition(
    id: 66,
    version: 1,
    displayName: 'Cosmic Ray',
    worldMeta: LevelWorldMeta(
      worldId: 2,
      levelNumber: 26,
      worldName: 'Asteroid Fields',
      isUnlocked: false,
      unlockRequirement: 65,
    ),
    moveLimit: 17,
    scoreTarget: 4100,
    failureBoundaryRow: 10,
    availableStarTypes: [StarType.normal, StarType.meteor, StarType.rainbow],
    randomSeed: 9042,
    objective: LevelObjective.scoreTarget(4100),
    initialStars: [
      // Cross pattern
      // Horizontal bar (row 2, all cols)
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
        type: StarType.meteor,
      ),
      // Vertical bar (col 4, all rows)
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.meteor,
      ),
      // row 2 col 4 already placed above
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.rainbow,
      ),
      // Extra fill rows 0-1
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.rainbow,
      ),
      // Extra fill rows 3-4
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.meteor,
      ),
    ],
  ),

  // Level 67 — Plasma Wave
  LevelDefinition(
    id: 67,
    version: 1,
    displayName: 'Plasma Wave',
    worldMeta: LevelWorldMeta(
      worldId: 2,
      levelNumber: 27,
      worldName: 'Asteroid Fields',
      isUnlocked: false,
      unlockRequirement: 66,
    ),
    moveLimit: 16,
    scoreTarget: 4200,
    failureBoundaryRow: 10,
    availableStarTypes: [StarType.normal, StarType.meteor, StarType.rainbow],
    randomSeed: 9179,
    objective: LevelObjective.clearStarType(14, StarType.meteor),
    initialStars: [
      // Heavy meteor rows
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.rainbow,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.meteor,
      ),
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
        type: StarType.meteor,
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
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 3),
        type: StarType.meteor,
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
        position: GridPosition(2, 8),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
    ],
  ),

  // Level 68 — Nebula Veil
  LevelDefinition(
    id: 68,
    version: 1,
    displayName: 'Nebula Veil',
    worldMeta: LevelWorldMeta(
      worldId: 2,
      levelNumber: 28,
      worldName: 'Asteroid Fields',
      isUnlocked: false,
      unlockRequirement: 67,
    ),
    moveLimit: 16,
    scoreTarget: 4300,
    failureBoundaryRow: 10,
    availableStarTypes: [StarType.normal, StarType.meteor, StarType.rainbow],
    randomSeed: 9316,
    objective: LevelObjective.clearStars(36),
    initialStars: [
      // Dense block rows 0-3 + sparse row 4
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.meteor,
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
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
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
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.rainbow,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.rainbow,
      ),
    ],
  ),

  // Level 69 — Quantum Shift
  LevelDefinition(
    id: 69,
    version: 1,
    displayName: 'Quantum Shift',
    worldMeta: LevelWorldMeta(
      worldId: 2,
      levelNumber: 29,
      worldName: 'Asteroid Fields',
      isUnlocked: false,
      unlockRequirement: 68,
    ),
    moveLimit: 16,
    scoreTarget: 4400,
    failureBoundaryRow: 10,
    availableStarTypes: [StarType.normal, StarType.meteor, StarType.rainbow],
    randomSeed: 9453,
    objective: LevelObjective.scoreTarget(4400),
    initialStars: [
      // Diagonal bands
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.meteor,
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
        type: StarType.meteor,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.rainbow,
      ),
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
        type: StarType.meteor,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.rainbow,
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
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.meteor,
      ),
    ],
  ),

  // Level 70 — Event Surge (W2 mid-boss)
  LevelDefinition(
    id: 70,
    version: 1,
    displayName: 'Event Surge',
    worldMeta: LevelWorldMeta(
      worldId: 2,
      levelNumber: 30,
      worldName: 'Asteroid Fields',
      isUnlocked: false,
      unlockRequirement: 69,
    ),
    moveLimit: 16,
    scoreTarget: 4500,
    failureBoundaryRow: 10,
    availableStarTypes: [StarType.normal, StarType.meteor, StarType.rainbow],
    randomSeed: 9590,
    objective: LevelObjective.clearStarType(16, StarType.meteor),
    initialStars: [
      // Very heavy meteor board
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.meteor,
      ),
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
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.meteor,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.meteor,
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════════════════════
  // WORLD 2 — ASTEROID FIELDS  (Levels 71–80) — Supernova + BlackHole added
  // ══════════════════════════════════════════════════════════════════════════

  // Level 71 — Star Forge
  LevelDefinition(
    id: 71,
    version: 1,
    displayName: 'Star Forge',
    worldMeta: LevelWorldMeta(
      worldId: 2,
      levelNumber: 31,
      worldName: 'Asteroid Fields',
      isUnlocked: false,
      unlockRequirement: 70,
    ),
    moveLimit: 16,
    scoreTarget: 4600,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
    ],
    randomSeed: 9727,
    objective: LevelObjective.clearSpecial(2),
    initialStars: [
      // Supernova introduced strategically at center
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.meteor,
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
        type: StarType.supernova,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
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
        type: StarType.meteor,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.normal,
      ),
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
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.supernova,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 72 — Core Burn
  LevelDefinition(
    id: 72,
    version: 1,
    displayName: 'Core Burn',
    worldMeta: LevelWorldMeta(
      worldId: 2,
      levelNumber: 32,
      worldName: 'Asteroid Fields',
      isUnlocked: false,
      unlockRequirement: 71,
    ),
    moveLimit: 15,
    scoreTarget: 4700,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
    ],
    randomSeed: 9864,
    objective: LevelObjective.scoreTarget(4700),
    initialStars: [
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
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.meteor,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.normal,
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.rainbow,
      ),
    ],
  ),

  // Level 73 — Nova Seed
  LevelDefinition(
    id: 73,
    version: 1,
    displayName: 'Nova Seed',
    worldMeta: LevelWorldMeta(
      worldId: 2,
      levelNumber: 33,
      worldName: 'Asteroid Fields',
      isUnlocked: false,
      unlockRequirement: 72,
    ),
    moveLimit: 15,
    scoreTarget: 4800,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
    ],
    randomSeed: 10001,
    objective: LevelObjective.clearSpecial(3),
    initialStars: [
      // BlackHole introduced
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.rainbow,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 74 — Fusion Arc
  LevelDefinition(
    id: 74,
    version: 1,
    displayName: 'Fusion Arc',
    worldMeta: LevelWorldMeta(
      worldId: 2,
      levelNumber: 34,
      worldName: 'Asteroid Fields',
      isUnlocked: false,
      unlockRequirement: 73,
    ),
    moveLimit: 15,
    scoreTarget: 4900,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
    ],
    randomSeed: 10138,
    objective: LevelObjective.clearStars(30),
    initialStars: [
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.rainbow,
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
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
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
        type: StarType.supernova,
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
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.meteor,
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
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 75 — Solar Flare
  LevelDefinition(
    id: 75,
    version: 1,
    displayName: 'Solar Flare',
    worldMeta: LevelWorldMeta(
      worldId: 2,
      levelNumber: 35,
      worldName: 'Asteroid Fields',
      isUnlocked: false,
      unlockRequirement: 74,
    ),
    moveLimit: 15,
    scoreTarget: 5000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
    ],
    randomSeed: 10275,
    objective: LevelObjective.scoreTarget(5000),
    initialStars: [
      // Supernova cluster in center rows
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.meteor,
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
        type: StarType.meteor,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.rainbow,
      ),
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 76 — Prominence
  LevelDefinition(
    id: 76,
    version: 1,
    displayName: 'Prominence',
    worldMeta: LevelWorldMeta(
      worldId: 2,
      levelNumber: 36,
      worldName: 'Asteroid Fields',
      isUnlocked: false,
      unlockRequirement: 75,
    ),
    moveLimit: 15,
    scoreTarget: 5100,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
    ],
    randomSeed: 10412,
    objective: LevelObjective.clearSpecial(4),
    initialStars: [
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
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
        type: StarType.normal,
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
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
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.rainbow,
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
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 77 — Coronal Mass
  LevelDefinition(
    id: 77,
    version: 1,
    displayName: 'Coronal Mass',
    worldMeta: LevelWorldMeta(
      worldId: 2,
      levelNumber: 37,
      worldName: 'Asteroid Fields',
      isUnlocked: false,
      unlockRequirement: 76,
    ),
    moveLimit: 14,
    scoreTarget: 5200,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
    ],
    randomSeed: 10549,
    objective: LevelObjective.scoreTarget(5200),
    initialStars: [
      // Dense block with scattered specials
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
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.rainbow,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.rainbow,
      ),
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
        type: StarType.rainbow,
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
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 5),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 78 — Sun Cycle
  LevelDefinition(
    id: 78,
    version: 1,
    displayName: 'Sun Cycle',
    worldMeta: LevelWorldMeta(
      worldId: 2,
      levelNumber: 38,
      worldName: 'Asteroid Fields',
      isUnlocked: false,
      unlockRequirement: 77,
    ),
    moveLimit: 14,
    scoreTarget: 5300,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
    ],
    randomSeed: 10686,
    objective: LevelObjective.clearStars(34),
    initialStars: [
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.blackHole,
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
        type: StarType.blackHole,
      ),
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
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.normal,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.normal,
      ),
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
        type: StarType.meteor,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.meteor,
      ),
    ],
  ),

  // Level 79 — Heat Vortex
  LevelDefinition(
    id: 79,
    version: 1,
    displayName: 'Heat Vortex',
    worldMeta: LevelWorldMeta(
      worldId: 2,
      levelNumber: 39,
      worldName: 'Asteroid Fields',
      isUnlocked: false,
      unlockRequirement: 78,
    ),
    moveLimit: 14,
    scoreTarget: 5400,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
    ],
    randomSeed: 10823,
    objective: LevelObjective.clearSpecial(5),
    initialStars: [
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
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
        type: StarType.normal,
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
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
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.supernova,
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
        type: StarType.blackHole,
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
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.meteor,
      ),
    ],
  ),

  // Level 80 — Stellar Core (World 2 boss)
  LevelDefinition(
    id: 80,
    version: 1,
    displayName: 'Stellar Core',
    worldMeta: LevelWorldMeta(
      worldId: 2,
      levelNumber: 40,
      worldName: 'Asteroid Fields',
      isUnlocked: false,
      unlockRequirement: 79,
    ),
    moveLimit: 14,
    scoreTarget: 5500,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
    ],
    randomSeed: 10960,
    objective: LevelObjective.clearStars(38),
    initialStars: [
      // Big dense board — rows 0-4 near full
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
        type: StarType.supernova,
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
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.meteor,
      ),
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
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.rainbow,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.rainbow,
      ),
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.rainbow,
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.meteor,
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
        position: GridPosition(4, 8),
        type: StarType.meteor,
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════════════════════
  // WORLD 3 — SOLAR WINDS  (Levels 81–100, levelNumber 1–20)
  // All non-frozen specials; tight shot limits; complex objectives.
  // ══════════════════════════════════════════════════════════════════════════

  // Level 81 — Jet Stream
  LevelDefinition(
    id: 81,
    version: 1,
    displayName: 'Jet Stream',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 1,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 80,
    ),
    moveLimit: 17,
    scoreTarget: 5500,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
    ],
    randomSeed: 11097,
    objective: LevelObjective.scoreTarget(5500),
    initialStars: [
      // Solar Winds intro — medium density
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.meteor,
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
        type: StarType.supernova,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.blackHole,
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
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 82 — Thermal Climb
  LevelDefinition(
    id: 82,
    version: 1,
    displayName: 'Thermal Climb',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 2,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 81,
    ),
    moveLimit: 17,
    scoreTarget: 5600,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
    ],
    randomSeed: 11234,
    objective: LevelObjective.clearStarType(6, StarType.rainbow),
    initialStars: [
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.rainbow,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.meteor,
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
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.normal,
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
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.rainbow,
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
        type: StarType.rainbow,
      ),
    ],
  ),

  // Level 83 — Wind Shear
  LevelDefinition(
    id: 83,
    version: 1,
    displayName: 'Wind Shear',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 3,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 82,
    ),
    moveLimit: 16,
    scoreTarget: 5700,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
    ],
    randomSeed: 11371,
    objective: LevelObjective.clearStars(32),
    initialStars: [
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.blackHole,
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
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.meteor,
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
        type: StarType.supernova,
      ),
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
        type: StarType.meteor,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.rainbow,
      ),
    ],
  ),

  // Level 84 — Air Pocket
  LevelDefinition(
    id: 84,
    version: 1,
    displayName: 'Air Pocket',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 4,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 83,
    ),
    moveLimit: 16,
    scoreTarget: 5800,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
    ],
    randomSeed: 11508,
    objective: LevelObjective.clearSpecial(4),
    initialStars: [
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
        type: StarType.supernova,
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
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.meteor,
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
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 85 — Pressure Wave
  LevelDefinition(
    id: 85,
    version: 1,
    displayName: 'Pressure Wave',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 5,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 84,
    ),
    moveLimit: 15,
    scoreTarget: 5900,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
    ],
    randomSeed: 11645,
    objective: LevelObjective.scoreTarget(5900),
    initialStars: [
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.rainbow,
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
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.blackHole,
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
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.rainbow,
      ),
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
        type: StarType.rainbow,
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
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.blackHole,
      ),
    ],
  ),

  // Level 86 — Altitude Run
  LevelDefinition(
    id: 86,
    version: 1,
    displayName: 'Altitude Run',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 6,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 85,
    ),
    moveLimit: 15,
    scoreTarget: 6000,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
    ],
    randomSeed: 11782,
    objective: LevelObjective.clearStars(34),
    initialStars: [
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.meteor,
      ),
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
        type: StarType.blackHole,
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
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.rainbow,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 87 — Stratosphere
  LevelDefinition(
    id: 87,
    version: 1,
    displayName: 'Stratosphere',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 7,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 86,
    ),
    moveLimit: 15,
    scoreTarget: 6100,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
    ],
    randomSeed: 11919,
    objective: LevelObjective.clearSpecial(5),
    initialStars: [
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.blackHole,
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
        type: StarType.supernova,
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
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
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
        type: StarType.rainbow,
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
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 0),
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
        type: StarType.rainbow,
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
        position: GridPosition(2, 8),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
    ],
  ),

  // Level 88 — Turbulence
  LevelDefinition(
    id: 88,
    version: 1,
    displayName: 'Turbulence',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 8,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 87,
    ),
    moveLimit: 14,
    scoreTarget: 6100,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
    ],
    randomSeed: 12056,
    objective: LevelObjective.scoreTarget(6100),
    initialStars: [
      // Full rows 0-2 + partial rows 3-4
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.supernova,
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
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.blackHole,
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
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.meteor,
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
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.rainbow,
      ),
    ],
  ),

  // Level 89 — Lightning Arc
  LevelDefinition(
    id: 89,
    version: 1,
    displayName: 'Lightning Arc',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 9,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 88,
    ),
    moveLimit: 14,
    scoreTarget: 6200,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
    ],
    randomSeed: 12193,
    objective: LevelObjective.clearStarType(8, StarType.rainbow),
    initialStars: [
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.rainbow,
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
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.rainbow,
      ),
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
        type: StarType.blackHole,
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
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.normal,
      ),
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
        type: StarType.rainbow,
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
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.supernova,
      ),
    ],
  ),

  // Level 90 — Storm Eye (W3 mid-boss)
  LevelDefinition(
    id: 90,
    version: 1,
    displayName: 'Storm Eye',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 10,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 89,
    ),
    moveLimit: 14,
    scoreTarget: 6300,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
    ],
    randomSeed: 12330,
    objective: LevelObjective.clearStars(36),
    initialStars: [
      // Dense — rows 0-4
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
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
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.blackHole,
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
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
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
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.meteor,
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
        type: StarType.rainbow,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.rainbow,
      ),
    ],
  ),

  // ── Hard/Expert tier: levels 91–100 ───────────────────────────────────────

  // Level 91 — Gravity Well
  LevelDefinition(
    id: 91,
    version: 1,
    displayName: 'Gravity Well',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 11,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 90,
    ),
    moveLimit: 14,
    scoreTarget: 6300,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
    ],
    randomSeed: 12467,
    objective: LevelObjective.clearSpecial(6),
    initialStars: [
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.blackHole,
      ),
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
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.meteor,
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
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.normal,
      ),
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
        type: StarType.rainbow,
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
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.normal,
      ),
    ],
  ),

  // Level 92 — Escape Velocity
  LevelDefinition(
    id: 92,
    version: 1,
    displayName: 'Escape Velocity',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 12,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 91,
    ),
    moveLimit: 13,
    scoreTarget: 6400,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
    ],
    randomSeed: 12604,
    objective: LevelObjective.scoreTarget(6400),
    initialStars: [
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.supernova,
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
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.rainbow,
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
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.supernova,
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
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
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
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.blackHole,
      ),
    ],
  ),

  // Level 93 — Orbital Lock
  LevelDefinition(
    id: 93,
    version: 1,
    displayName: 'Orbital Lock',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 13,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 92,
    ),
    moveLimit: 13,
    scoreTarget: 6400,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
    ],
    randomSeed: 12741,
    objective: LevelObjective.clearStarType(10, StarType.meteor),
    initialStars: [
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.meteor,
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
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.meteor,
      ),
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 6),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.meteor,
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
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
    ],
  ),

  // Level 94 — Tidal Force
  LevelDefinition(
    id: 94,
    version: 1,
    displayName: 'Tidal Force',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 14,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 93,
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
    ],
    randomSeed: 12878,
    objective: LevelObjective.clearSpecial(6),
    initialStars: [
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.rainbow,
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
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.meteor,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.rainbow,
      ),
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
        type: StarType.meteor,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.meteor,
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
        position: GridPosition(3, 8),
        type: StarType.meteor,
      ),
    ],
  ),

  // Level 95 — Resonance
  LevelDefinition(
    id: 95,
    version: 1,
    displayName: 'Resonance',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 15,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 94,
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
    ],
    randomSeed: 13015,
    objective: LevelObjective.clearStars(36),
    initialStars: [
      // Very dense — rows 0-4
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.rainbow,
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
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
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
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.blackHole,
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
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.rainbow,
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
        type: StarType.meteor,
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
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 1),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 7),
        type: StarType.meteor,
      ),
    ],
  ),

  // Level 96 — Harmonic Wave
  LevelDefinition(
    id: 96,
    version: 1,
    displayName: 'Harmonic Wave',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 16,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 95,
    ),
    moveLimit: 12,
    scoreTarget: 6500,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
    ],
    randomSeed: 13152,
    objective: LevelObjective.scoreTarget(6500),
    initialStars: [
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.rainbow,
      ),
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
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.normal,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.normal,
      ),
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
        type: StarType.blackHole,
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
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 8),
        type: StarType.supernova,
      ),
    ],
  ),

  // Level 97 — Phase Shift
  LevelDefinition(
    id: 97,
    version: 1,
    displayName: 'Phase Shift',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 17,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 96,
    ),
    moveLimit: 12,
    scoreTarget: 6500,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
    ],
    randomSeed: 13289,
    objective: LevelObjective.clearSpecial(7),
    initialStars: [
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.normal,
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
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.blackHole,
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
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.meteor,
      ),
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
        type: StarType.rainbow,
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
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 2),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 4),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.rainbow,
      ),
    ],
  ),

  // Level 98 — Quantum Lock
  LevelDefinition(
    id: 98,
    version: 1,
    displayName: 'Quantum Lock',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 18,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 97,
    ),
    moveLimit: 12,
    scoreTarget: 6500,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
    ],
    randomSeed: 13426,
    objective: LevelObjective.clearStars(38),
    initialStars: [
      // Very dense — rows 0-4 nearly full
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.blackHole,
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
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 3),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 5),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 6),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.supernova,
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
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.supernova,
      ),
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
        position: GridPosition(3, 5),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 6),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
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
    ],
  ),

  // Level 99 — Vortex Core
  LevelDefinition(
    id: 99,
    version: 1,
    displayName: 'Vortex Core',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 19,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 98,
    ),
    moveLimit: 12,
    scoreTarget: 6500,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
    ],
    randomSeed: 13563,
    objective: LevelObjective.scoreTarget(6500),
    initialStars: [
      // Spiral shape with dense specials
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.blackHole,
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
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.supernova,
      ),
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
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 1),
        type: StarType.rainbow,
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
        type: StarType.meteor,
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
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 1),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 3),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 2),
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 4),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(4, 6),
        type: StarType.meteor,
      ),
    ],
  ),

  // Level 100 — Singularity (W3 boss)
  LevelDefinition(
    id: 100,
    version: 1,
    displayName: 'Singularity',
    worldMeta: LevelWorldMeta(
      worldId: 3,
      levelNumber: 20,
      worldName: 'Solar Winds',
      isUnlocked: false,
      unlockRequirement: 99,
    ),
    moveLimit: 12,
    scoreTarget: 6500,
    failureBoundaryRow: 10,
    availableStarTypes: [
      StarType.normal,
      StarType.meteor,
      StarType.rainbow,
      StarType.supernova,
      StarType.blackHole,
    ],
    randomSeed: 13700,
    objective: LevelObjective.clearStars(40),
    initialStars: [
      // Ultimate board — near-max density rows 0-4
      InitialStarPlacement(
        position: GridPosition(0, 0),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 1),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 2),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 3),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 4),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 5),
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 6),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(0, 8),
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 0),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 1),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 2),
        type: StarType.meteor,
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
        type: StarType.meteor,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 7),
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(1, 8),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 0),
        type: StarType.rainbow,
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
        type: StarType.supernova,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 4),
        type: StarType.meteor,
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
        type: StarType.blackHole,
      ),
      InitialStarPlacement(
        position: GridPosition(2, 8),
        type: StarType.rainbow,
      ),
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
        type: StarType.rainbow,
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
        type: StarType.rainbow,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 7),
        type: StarType.normal,
      ),
      InitialStarPlacement(
        position: GridPosition(3, 8),
        type: StarType.supernova,
      ),
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
        type: StarType.rainbow,
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
];
