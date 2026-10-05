import 'package:star_shooter/game/level/level_catalog_101_150.dart';
import 'package:star_shooter/game/level/level_catalog_151_200.dart';
import 'package:star_shooter/game/level/level_catalog_51_100.dart';
import 'package:star_shooter/game/level/level_objective.dart';
import 'package:star_shooter/game/level/level_world_meta.dart';
import 'package:star_shooter/game/models/grid_position.dart';
import 'package:star_shooter/game/models/level_definition.dart';
import 'package:star_shooter/game/models/star_type.dart';

/// Static catalog of all 200 production levels.
///
/// World structure (M12 — 40 levels per world):
///   World 1 "Nebula Nursery"   — Levels   1–40  (intro → advanced, all normal + specials introduced)
///   World 2 "Asteroid Fields"  — Levels  41–80  (advanced, meteor + rainbow + supernova + blackHole)
///   World 3 "Solar Winds"      — Levels  81–120 (hard → very hard, frozen stars introduced)
///   World 4 "Event Horizon"    — Levels 121–160 (expert → master, dense frozen boards)
///   World 5 "Frozen Nebula"    — Levels 161–200 (extreme endgame, maximum difficulty)
class LevelCatalog {
  LevelCatalog._();

  static final List<LevelDefinition> allLevels = [
    // ════════════════════════════════════════════════════════════════════════
    // WORLD 1 — NEBULA NURSERY  (Levels 1–10)
    // Intro zone: normal stars only, generous move limits, low score targets.
    // ════════════════════════════════════════════════════════════════════════

    // Level 1 — First Light
    const LevelDefinition(
      id: 1,
      version: 1,
      displayName: 'First Light',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 1,
        worldName: 'Nebula Nursery',
        isUnlocked: true,
        unlockRequirement: 0,
      ),
      moveLimit: 30,
      scoreTarget: 300,
      failureBoundaryRow: 10,
      availableStarTypes: [StarType.normal],
      randomSeed: 137,
      objective: LevelObjective.scoreTarget(300),
      initialStars: [
        // Row 0 — balanced colors, max group size 1
        InitialStarPlacement(position: GridPosition(0, 0), type: StarType.normal, colorIndex: 2),
        InitialStarPlacement(position: GridPosition(0, 1), type: StarType.normal, colorIndex: 3),
        InitialStarPlacement(position: GridPosition(0, 2), type: StarType.normal, colorIndex: 0),
        InitialStarPlacement(position: GridPosition(0, 3), type: StarType.normal, colorIndex: 2),
        InitialStarPlacement(position: GridPosition(0, 4), type: StarType.normal, colorIndex: 1),
        InitialStarPlacement(position: GridPosition(0, 5), type: StarType.normal, colorIndex: 0),
        InitialStarPlacement(position: GridPosition(0, 6), type: StarType.normal, colorIndex: 4),
        InitialStarPlacement(position: GridPosition(0, 7), type: StarType.normal, colorIndex: 1),
        InitialStarPlacement(position: GridPosition(0, 8), type: StarType.normal, colorIndex: 3),
        // Row 1 (odd — 8 cols, offset right)
        InitialStarPlacement(position: GridPosition(1, 0), type: StarType.normal, colorIndex: 1),
        InitialStarPlacement(position: GridPosition(1, 1), type: StarType.normal, colorIndex: 4),
        InitialStarPlacement(position: GridPosition(1, 2), type: StarType.normal, colorIndex: 2),
        InitialStarPlacement(position: GridPosition(1, 3), type: StarType.normal, colorIndex: 0),
        InitialStarPlacement(position: GridPosition(1, 4), type: StarType.normal, colorIndex: 3),
        InitialStarPlacement(position: GridPosition(1, 5), type: StarType.normal, colorIndex: 1),
        InitialStarPlacement(position: GridPosition(1, 6), type: StarType.normal, colorIndex: 0),
        InitialStarPlacement(position: GridPosition(1, 7), type: StarType.normal, colorIndex: 4),
        // Row 2
        InitialStarPlacement(position: GridPosition(2, 0), type: StarType.normal, colorIndex: 3),
        InitialStarPlacement(position: GridPosition(2, 1), type: StarType.normal, colorIndex: 0),
        InitialStarPlacement(position: GridPosition(2, 2), type: StarType.normal, colorIndex: 2),
        InitialStarPlacement(position: GridPosition(2, 3), type: StarType.normal, colorIndex: 4),
        InitialStarPlacement(position: GridPosition(2, 4), type: StarType.normal, colorIndex: 0),
        InitialStarPlacement(position: GridPosition(2, 5), type: StarType.normal, colorIndex: 3),
        InitialStarPlacement(position: GridPosition(2, 6), type: StarType.normal, colorIndex: 2),
        InitialStarPlacement(position: GridPosition(2, 7), type: StarType.normal, colorIndex: 1),
        InitialStarPlacement(position: GridPosition(2, 8), type: StarType.normal, colorIndex: 4),
      ],
    ),

    // Level 2 — Starfield
    const LevelDefinition(
      id: 2,
      version: 1,
      displayName: 'Starfield',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 2,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 1,
      ),
      moveLimit: 30,
      scoreTarget: 350,
      failureBoundaryRow: 10,
      availableStarTypes: [StarType.normal],
      randomSeed: 274,
      objective: LevelObjective.clearStars(20),
      initialStars: [
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
        InitialStarPlacement(
          position: GridPosition(2, 1),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 3),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 5),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 7),
          type: StarType.normal,
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
      ],
    ),

    // Level 3 — Cluster
    const LevelDefinition(
      id: 3,
      version: 1,
      displayName: 'Cluster',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 3,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 2,
      ),
      moveLimit: 30,
      scoreTarget: 400,
      failureBoundaryRow: 10,
      availableStarTypes: [StarType.normal],
      randomSeed: 411,
      objective: LevelObjective.clearStars(25),
      initialStars: [
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
        InitialStarPlacement(
          position: GridPosition(3, 0),
          type: StarType.normal,
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
          type: StarType.normal,
        ),
      ],
    ),

    // Level 4 — Tricolor Dawn  (3 colors via normal; score target)
    const LevelDefinition(
      id: 4,
      version: 1,
      displayName: 'Tricolor Dawn',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 4,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 3,
      ),
      moveLimit: 25,
      scoreTarget: 500,
      failureBoundaryRow: 10,
      availableStarTypes: [StarType.normal],
      randomSeed: 548,
      objective: LevelObjective.scoreTarget(500),
      initialStars: [
        // Row 0: dense top row
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
        // Row 1: alternating
        InitialStarPlacement(
          position: GridPosition(1, 0),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(1, 2),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(1, 4),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(1, 6),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(1, 8),
          type: StarType.normal,
        ),
        // Row 2: full
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
        // Row 3: sparse
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

    // Level 5 — Cascade
    const LevelDefinition(
      id: 5,
      version: 1,
      displayName: 'Cascade',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 5,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 4,
      ),
      moveLimit: 25,
      scoreTarget: 600,
      failureBoundaryRow: 10,
      availableStarTypes: [StarType.normal],
      randomSeed: 685,
      objective: LevelObjective.clearStars(28),
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
          position: GridPosition(3, 0),
          type: StarType.normal,
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
          type: StarType.normal,
        ),
      ],
    ),

    // Level 6 — Crossfire
    const LevelDefinition(
      id: 6,
      version: 1,
      displayName: 'Crossfire',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 6,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 5,
      ),
      moveLimit: 25,
      scoreTarget: 700,
      failureBoundaryRow: 10,
      availableStarTypes: [StarType.normal],
      randomSeed: 822,
      objective: LevelObjective.scoreTarget(700),
      initialStars: [
        InitialStarPlacement(
          position: GridPosition(0, 0),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 2),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 4),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 6),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 8),
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
        InitialStarPlacement(
          position: GridPosition(3, 1),
          type: StarType.normal,
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
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 0),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 4),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 8),
          type: StarType.normal,
        ),
      ],
    ),

    // Level 7 — Prism  (5 colours, harder score)
    const LevelDefinition(
      id: 7,
      version: 1,
      displayName: 'Prism',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 7,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 6,
      ),
      moveLimit: 22,
      scoreTarget: 800,
      failureBoundaryRow: 10,
      availableStarTypes: [StarType.normal],
      randomSeed: 959,
      objective: LevelObjective.scoreTarget(800),
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
        InitialStarPlacement(
          position: GridPosition(2, 0),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 2),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 4),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 6),
          type: StarType.normal,
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
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 5),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 7),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 2),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 4),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 6),
          type: StarType.normal,
        ),
      ],
    ),

    // Level 8 — Spiral
    const LevelDefinition(
      id: 8,
      version: 1,
      displayName: 'Spiral',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 8,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 7,
      ),
      moveLimit: 22,
      scoreTarget: 900,
      failureBoundaryRow: 10,
      availableStarTypes: [StarType.normal],
      randomSeed: 1096,
      objective: LevelObjective.clearStars(30),
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
        InitialStarPlacement(
          position: GridPosition(1, 0),
          type: StarType.normal,
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
          position: GridPosition(2, 7),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 8),
          type: StarType.normal,
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
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 6),
          type: StarType.normal,
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
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 2),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 3),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 4),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 5),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 6),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 8),
          type: StarType.normal,
        ),
      ],
    ),

    // Level 9 — Vortex
    const LevelDefinition(
      id: 9,
      version: 1,
      displayName: 'Vortex',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 9,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 8,
      ),
      moveLimit: 22,
      scoreTarget: 1000,
      failureBoundaryRow: 10,
      availableStarTypes: [StarType.normal],
      randomSeed: 1233,
      objective: LevelObjective.scoreTarget(1000),
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
        InitialStarPlacement(
          position: GridPosition(1, 0),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(1, 1),
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
        InitialStarPlacement(
          position: GridPosition(2, 0),
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
          position: GridPosition(2, 5),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 6),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 8),
          type: StarType.normal,
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
          position: GridPosition(3, 3),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 4),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 5),
          type: StarType.normal,
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
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 2),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 4),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 6),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 8),
          type: StarType.normal,
        ),
      ],
    ),

    // Level 10 — Nova Gate  (World 1 boss)
    const LevelDefinition(
      id: 10,
      version: 1,
      displayName: 'Nova Gate',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 10,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 9,
      ),
      moveLimit: 22,
      scoreTarget: 1200,
      failureBoundaryRow: 10,
      availableStarTypes: [StarType.normal],
      randomSeed: 1370,
      objective: LevelObjective.clearStars(36),
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
          position: GridPosition(3, 4),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 6),
          type: StarType.normal,
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
          position: GridPosition(4, 2),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 4),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 6),
          type: StarType.normal,
        ),
      ],
    ),

    // ════════════════════════════════════════════════════════════════════════
    // WORLD 2 — ASTEROID FIELDS  (Levels 11–20)
    // Meteor stars introduced; mixed layouts, tighter shots.
    // ════════════════════════════════════════════════════════════════════════

    // Level 11 — Meteor Shower
    const LevelDefinition(
      id: 11,
      version: 1,
      displayName: 'Meteor Shower',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 11,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 10,
      ),
      moveLimit: 22,
      scoreTarget: 1000,
      failureBoundaryRow: 10,
      availableStarTypes: [StarType.normal, StarType.meteor],
      randomSeed: 1507,
      objective: LevelObjective.clearStarType(5, StarType.meteor),
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
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 7),
          type: StarType.meteor,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 0),
          type: StarType.normal,
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
          type: StarType.normal,
        ),
      ],
    ),

    // Level 12 — Rock Storm
    const LevelDefinition(
      id: 12,
      version: 1,
      displayName: 'Rock Storm',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 12,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 11,
      ),
      moveLimit: 22,
      scoreTarget: 1100,
      failureBoundaryRow: 10,
      availableStarTypes: [StarType.normal, StarType.meteor],
      randomSeed: 1644,
      objective: LevelObjective.clearStarType(6, StarType.meteor),
      initialStars: [
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
          type: StarType.normal,
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
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(1, 2),
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

    // Level 13 — Debris Field
    const LevelDefinition(
      id: 13,
      version: 1,
      displayName: 'Debris Field',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 13,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 12,
      ),
      moveLimit: 21,
      scoreTarget: 1200,
      failureBoundaryRow: 10,
      availableStarTypes: [StarType.normal, StarType.meteor],
      randomSeed: 1781,
      objective: LevelObjective.scoreTarget(1200),
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
          type: StarType.meteor,
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
        InitialStarPlacement(
          position: GridPosition(2, 0),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 2),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 4),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 6),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 8),
          type: StarType.normal,
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
          position: GridPosition(3, 5),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 7),
          type: StarType.normal,
        ),
      ],
    ),

    // Level 14 — Comet Trail
    const LevelDefinition(
      id: 14,
      version: 1,
      displayName: 'Comet Trail',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 14,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 13,
      ),
      moveLimit: 21,
      scoreTarget: 1300,
      failureBoundaryRow: 10,
      availableStarTypes: [StarType.normal, StarType.meteor],
      randomSeed: 1918,
      objective: LevelObjective.clearStarType(8, StarType.meteor),
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
          type: StarType.normal,
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
        InitialStarPlacement(
          position: GridPosition(2, 1),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 3),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 5),
          type: StarType.meteor,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 7),
          type: StarType.normal,
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
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 8),
          type: StarType.normal,
        ),
      ],
    ),

    // Level 15 — Impact Zone
    const LevelDefinition(
      id: 15,
      version: 1,
      displayName: 'Impact Zone',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 15,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 14,
      ),
      moveLimit: 20,
      scoreTarget: 1400,
      failureBoundaryRow: 10,
      availableStarTypes: [StarType.normal, StarType.meteor],
      randomSeed: 2055,
      objective: LevelObjective.clearStars(30),
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
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 4),
          type: StarType.meteor,
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
          type: StarType.meteor,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 0),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 4),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 8),
          type: StarType.normal,
        ),
      ],
    ),

    // Level 16 — Shatter
    const LevelDefinition(
      id: 16,
      version: 1,
      displayName: 'Shatter',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 16,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 15,
      ),
      moveLimit: 20,
      scoreTarget: 1400,
      failureBoundaryRow: 10,
      availableStarTypes: [StarType.normal, StarType.meteor],
      randomSeed: 2192,
      objective: LevelObjective.clearStarType(10, StarType.meteor),
      initialStars: [
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
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 2),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 4),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 6),
          type: StarType.normal,
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
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 7),
          type: StarType.meteor,
        ),
      ],
    ),

    // Level 17 — Pulsar
    const LevelDefinition(
      id: 17,
      version: 1,
      displayName: 'Pulsar',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 17,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 16,
      ),
      moveLimit: 20,
      scoreTarget: 1500,
      failureBoundaryRow: 10,
      availableStarTypes: [StarType.normal, StarType.meteor],
      randomSeed: 2329,
      objective: LevelObjective.scoreTarget(1500),
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
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 3),
          type: StarType.meteor,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 4),
          type: StarType.meteor,
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
          position: GridPosition(2, 3),
          type: StarType.meteor,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 4),
          type: StarType.meteor,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 5),
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
          type: StarType.normal,
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
          type: StarType.normal,
        ),
      ],
    ),

    // Level 18 — Flux
    const LevelDefinition(
      id: 18,
      version: 1,
      displayName: 'Flux',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 18,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 17,
      ),
      moveLimit: 20,
      scoreTarget: 1600,
      failureBoundaryRow: 10,
      availableStarTypes: [StarType.normal, StarType.meteor],
      randomSeed: 2466,
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
          type: StarType.normal,
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
          position: GridPosition(3, 1),
          type: StarType.normal,
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
        InitialStarPlacement(
          position: GridPosition(4, 0),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 4),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 8),
          type: StarType.normal,
        ),
      ],
    ),

    // Level 19 — Deep Rock
    const LevelDefinition(
      id: 19,
      version: 1,
      displayName: 'Deep Rock',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 19,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 18,
      ),
      moveLimit: 20,
      scoreTarget: 1700,
      failureBoundaryRow: 10,
      availableStarTypes: [StarType.normal, StarType.meteor],
      randomSeed: 2603,
      objective: LevelObjective.clearStarType(12, StarType.meteor),
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
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 6),
          type: StarType.meteor,
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
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(1, 3),
          type: StarType.meteor,
        ),
        InitialStarPlacement(
          position: GridPosition(1, 4),
          type: StarType.meteor,
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
        InitialStarPlacement(
          position: GridPosition(2, 1),
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
          position: GridPosition(2, 7),
          type: StarType.meteor,
        ),
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
          type: StarType.normal,
        ),
      ],
    ),

    // Level 20 — Asteroid King  (World 2 boss)
    const LevelDefinition(
      id: 20,
      version: 1,
      displayName: 'Asteroid King',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 20,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 19,
      ),
      moveLimit: 20,
      scoreTarget: 1800,
      failureBoundaryRow: 10,
      availableStarTypes: [StarType.normal, StarType.meteor],
      randomSeed: 2740,
      objective: LevelObjective.clearStarType(15, StarType.meteor),
      initialStars: [
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
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 4),
          type: StarType.meteor,
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
          position: GridPosition(4, 0),
          type: StarType.meteor,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 2),
          type: StarType.normal,
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

    // ════════════════════════════════════════════════════════════════════════
    // WORLD 3 — SOLAR WINDS  (Levels 21–30)
    // Rainbow + meteor stars; tighter shots; score 1500+.
    // ════════════════════════════════════════════════════════════════════════

    // Level 21 — Rainbow Rush
    const LevelDefinition(
      id: 21,
      version: 1,
      displayName: 'Rainbow Rush',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 21,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 20,
      ),
      moveLimit: 18,
      scoreTarget: 1500,
      failureBoundaryRow: 10,
      availableStarTypes: [StarType.normal, StarType.meteor, StarType.rainbow],
      randomSeed: 2877,
      objective: LevelObjective.scoreTarget(1500),
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

    // Level 22 — Spectrum
    const LevelDefinition(
      id: 22,
      version: 1,
      displayName: 'Spectrum',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 22,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 21,
      ),
      moveLimit: 18,
      scoreTarget: 1600,
      failureBoundaryRow: 10,
      availableStarTypes: [StarType.normal, StarType.meteor, StarType.rainbow],
      randomSeed: 3014,
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
          type: StarType.rainbow,
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
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 2),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 4),
          type: StarType.meteor,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 6),
          type: StarType.normal,
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
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 7),
          type: StarType.rainbow,
        ),
      ],
    ),

    // Level 23 — Prism Storm
    const LevelDefinition(
      id: 23,
      version: 1,
      displayName: 'Prism Storm',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 23,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 22,
      ),
      moveLimit: 18,
      scoreTarget: 1700,
      failureBoundaryRow: 10,
      availableStarTypes: [StarType.normal, StarType.meteor, StarType.rainbow],
      randomSeed: 3151,
      objective: LevelObjective.scoreTarget(1700),
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
          type: StarType.rainbow,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 8),
          type: StarType.meteor,
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
          type: StarType.meteor,
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
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(1, 8),
          type: StarType.rainbow,
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
          type: StarType.rainbow,
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
          type: StarType.meteor,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 7),
          type: StarType.normal,
        ),
      ],
    ),

    // Level 24 — Solar Flare
    const LevelDefinition(
      id: 24,
      version: 1,
      displayName: 'Solar Flare',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 24,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 23,
      ),
      moveLimit: 18,
      scoreTarget: 1800,
      failureBoundaryRow: 10,
      availableStarTypes: [StarType.normal, StarType.meteor, StarType.rainbow],
      randomSeed: 3288,
      objective: LevelObjective.clearStarType(8, StarType.rainbow),
      initialStars: [
        InitialStarPlacement(
          position: GridPosition(0, 0),
          type: StarType.rainbow,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 2),
          type: StarType.rainbow,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 4),
          type: StarType.rainbow,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 6),
          type: StarType.rainbow,
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
          type: StarType.meteor,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 1),
          type: StarType.rainbow,
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
      ],
    ),

    // Level 25 — Wind Dancer
    const LevelDefinition(
      id: 25,
      version: 1,
      displayName: 'Wind Dancer',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 25,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 24,
      ),
      moveLimit: 18,
      scoreTarget: 1900,
      failureBoundaryRow: 10,
      availableStarTypes: [StarType.normal, StarType.meteor, StarType.rainbow],
      randomSeed: 3425,
      objective: LevelObjective.scoreTarget(1900),
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
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 3),
          type: StarType.rainbow,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 4),
          type: StarType.rainbow,
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

    // Level 26 — Refraction
    const LevelDefinition(
      id: 26,
      version: 1,
      displayName: 'Refraction',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 26,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 25,
      ),
      moveLimit: 17,
      scoreTarget: 2000,
      failureBoundaryRow: 10,
      availableStarTypes: [StarType.normal, StarType.meteor, StarType.rainbow],
      randomSeed: 3562,
      objective: LevelObjective.clearStarType(10, StarType.rainbow),
      initialStars: [
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
          type: StarType.rainbow,
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
        InitialStarPlacement(
          position: GridPosition(3, 0),
          type: StarType.rainbow,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 4),
          type: StarType.meteor,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 8),
          type: StarType.rainbow,
        ),
      ],
    ),

    // Level 27 — Chromatic
    const LevelDefinition(
      id: 27,
      version: 1,
      displayName: 'Chromatic',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 27,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 26,
      ),
      moveLimit: 17,
      scoreTarget: 2100,
      failureBoundaryRow: 10,
      availableStarTypes: [StarType.normal, StarType.meteor, StarType.rainbow],
      randomSeed: 3699,
      objective: LevelObjective.scoreTarget(2100),
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
          type: StarType.rainbow,
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
        InitialStarPlacement(
          position: GridPosition(3, 1),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 4),
          type: StarType.rainbow,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 7),
          type: StarType.normal,
        ),
      ],
    ),

    // Level 28 — Photon Burst
    const LevelDefinition(
      id: 28,
      version: 1,
      displayName: 'Photon Burst',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 28,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 27,
      ),
      moveLimit: 17,
      scoreTarget: 2200,
      failureBoundaryRow: 10,
      availableStarTypes: [StarType.normal, StarType.meteor, StarType.rainbow],
      randomSeed: 3836,
      objective: LevelObjective.clearStarType(12, StarType.meteor),
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
          type: StarType.meteor,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 3),
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
      ],
    ),

    // Level 29 — Aurora
    const LevelDefinition(
      id: 29,
      version: 1,
      displayName: 'Aurora',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 29,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 28,
      ),
      moveLimit: 17,
      scoreTarget: 2300,
      failureBoundaryRow: 10,
      availableStarTypes: [StarType.normal, StarType.meteor, StarType.rainbow],
      randomSeed: 3973,
      objective: LevelObjective.clearStarType(12, StarType.rainbow),
      initialStars: [
        InitialStarPlacement(
          position: GridPosition(0, 0),
          type: StarType.rainbow,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 1),
          type: StarType.rainbow,
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
          type: StarType.rainbow,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 8),
          type: StarType.rainbow,
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
          position: GridPosition(2, 1),
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
          position: GridPosition(2, 7),
          type: StarType.rainbow,
        ),
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

    // Level 30 — Solar Crown  (World 3 boss)
    const LevelDefinition(
      id: 30,
      version: 1,
      displayName: 'Solar Crown',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 30,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 29,
      ),
      moveLimit: 17,
      scoreTarget: 2500,
      failureBoundaryRow: 10,
      availableStarTypes: [StarType.normal, StarType.meteor, StarType.rainbow],
      randomSeed: 4110,
      objective: LevelObjective.scoreTarget(2500),
      initialStars: [
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
          type: StarType.meteor,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 8),
          type: StarType.rainbow,
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
          type: StarType.rainbow,
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

    // ════════════════════════════════════════════════════════════════════════
    // WORLD 4 — EVENT HORIZON  (Levels 31–40)
    // Supernova + blackHole stars; constrained shots; expert combos.
    // ════════════════════════════════════════════════════════════════════════

    // Level 31 — Ignition
    const LevelDefinition(
      id: 31,
      version: 1,
      displayName: 'Ignition',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 31,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 30,
      ),
      moveLimit: 16,
      scoreTarget: 2200,
      failureBoundaryRow: 10,
      availableStarTypes: [
        StarType.normal,
        StarType.meteor,
        StarType.rainbow,
        StarType.supernova,
      ],
      randomSeed: 4247,
      objective: LevelObjective.clearStarType(5, StarType.supernova),
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
          type: StarType.supernova,
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
          type: StarType.supernova,
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
          type: StarType.supernova,
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
          type: StarType.normal,
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

    // Level 32 — Collapse
    const LevelDefinition(
      id: 32,
      version: 1,
      displayName: 'Collapse',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 32,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 31,
      ),
      moveLimit: 16,
      scoreTarget: 2400,
      failureBoundaryRow: 10,
      availableStarTypes: [
        StarType.normal,
        StarType.meteor,
        StarType.rainbow,
        StarType.supernova,
        StarType.blackHole,
      ],
      randomSeed: 4384,
      objective: LevelObjective.clearStarType(4, StarType.blackHole),
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
          position: GridPosition(2, 2),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 4),
          type: StarType.normal,
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

    // Level 33 — Singularity
    const LevelDefinition(
      id: 33,
      version: 1,
      displayName: 'Singularity',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 33,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 32,
      ),
      moveLimit: 16,
      scoreTarget: 2500,
      failureBoundaryRow: 10,
      availableStarTypes: [
        StarType.normal,
        StarType.meteor,
        StarType.rainbow,
        StarType.supernova,
        StarType.blackHole,
      ],
      randomSeed: 4521,
      objective: LevelObjective.scoreTarget(2500),
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
          type: StarType.rainbow,
        ),
        InitialStarPlacement(
          position: GridPosition(1, 4),
          type: StarType.supernova,
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
          position: GridPosition(2, 2),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 4),
          type: StarType.rainbow,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 6),
          type: StarType.blackHole,
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
          position: GridPosition(3, 4),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 8),
          type: StarType.normal,
        ),
      ],
    ),

    // Level 34 — Gravity Well
    const LevelDefinition(
      id: 34,
      version: 1,
      displayName: 'Gravity Well',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 34,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 33,
      ),
      moveLimit: 16,
      scoreTarget: 2700,
      failureBoundaryRow: 10,
      availableStarTypes: [
        StarType.normal,
        StarType.meteor,
        StarType.rainbow,
        StarType.supernova,
        StarType.blackHole,
      ],
      randomSeed: 4658,
      objective: LevelObjective.clearStarType(6, StarType.blackHole),
      initialStars: [
        InitialStarPlacement(
          position: GridPosition(0, 0),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 2),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 4),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 6),
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
          type: StarType.blackHole,
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
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(1, 6),
          type: StarType.rainbow,
        ),
        InitialStarPlacement(
          position: GridPosition(1, 7),
          type: StarType.blackHole,
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
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 3),
          type: StarType.supernova,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 5),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 7),
          type: StarType.supernova,
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
        InitialStarPlacement(
          position: GridPosition(4, 0),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 4),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 8),
          type: StarType.normal,
        ),
      ],
    ),

    // Level 35 — Dark Matter
    const LevelDefinition(
      id: 35,
      version: 1,
      displayName: 'Dark Matter',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 35,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 34,
      ),
      moveLimit: 15,
      scoreTarget: 2800,
      failureBoundaryRow: 10,
      availableStarTypes: [
        StarType.normal,
        StarType.meteor,
        StarType.rainbow,
        StarType.supernova,
        StarType.blackHole,
      ],
      randomSeed: 4795,
      objective: LevelObjective.clearStarType(8, StarType.supernova),
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
          type: StarType.supernova,
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
          type: StarType.rainbow,
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
          type: StarType.supernova,
        ),
        InitialStarPlacement(
          position: GridPosition(1, 8),
          type: StarType.rainbow,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 0),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 2),
          type: StarType.supernova,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 4),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 6),
          type: StarType.supernova,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 8),
          type: StarType.blackHole,
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

    // Level 36 — Warp Field
    const LevelDefinition(
      id: 36,
      version: 1,
      displayName: 'Warp Field',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 36,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 35,
      ),
      moveLimit: 15,
      scoreTarget: 3000,
      failureBoundaryRow: 10,
      availableStarTypes: [
        StarType.normal,
        StarType.meteor,
        StarType.rainbow,
        StarType.supernova,
        StarType.blackHole,
      ],
      randomSeed: 4932,
      objective: LevelObjective.scoreTarget(3000),
      initialStars: [
        InitialStarPlacement(
          position: GridPosition(0, 0),
          type: StarType.blackHole,
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
          type: StarType.rainbow,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 7),
          type: StarType.supernova,
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
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(1, 3),
          type: StarType.supernova,
        ),
        InitialStarPlacement(
          position: GridPosition(1, 4),
          type: StarType.rainbow,
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
          type: StarType.blackHole,
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
      ],
    ),

    // Level 37 — Tidal Force
    const LevelDefinition(
      id: 37,
      version: 1,
      displayName: 'Tidal Force',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 37,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 36,
      ),
      moveLimit: 15,
      scoreTarget: 3100,
      failureBoundaryRow: 10,
      availableStarTypes: [
        StarType.normal,
        StarType.meteor,
        StarType.rainbow,
        StarType.supernova,
        StarType.blackHole,
      ],
      randomSeed: 5069,
      objective: LevelObjective.clearStarType(8, StarType.blackHole),
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
          type: StarType.blackHole,
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
          type: StarType.supernova,
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
          type: StarType.rainbow,
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
          type: StarType.supernova,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 1),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 3),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 5),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 7),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 0),
          type: StarType.meteor,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 4),
          type: StarType.rainbow,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 8),
          type: StarType.meteor,
        ),
      ],
    ),

    // Level 38 — Accretion
    const LevelDefinition(
      id: 38,
      version: 1,
      displayName: 'Accretion',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 38,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 37,
      ),
      moveLimit: 15,
      scoreTarget: 3300,
      failureBoundaryRow: 10,
      availableStarTypes: [
        StarType.normal,
        StarType.meteor,
        StarType.rainbow,
        StarType.supernova,
        StarType.blackHole,
      ],
      randomSeed: 5206,
      objective: LevelObjective.clearStarType(10, StarType.supernova),
      initialStars: [
        InitialStarPlacement(
          position: GridPosition(0, 0),
          type: StarType.supernova,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 1),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 2),
          type: StarType.supernova,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 3),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 4),
          type: StarType.supernova,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 5),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 6),
          type: StarType.supernova,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 7),
          type: StarType.blackHole,
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
          type: StarType.supernova,
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
          type: StarType.supernova,
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
          type: StarType.blackHole,
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
          type: StarType.blackHole,
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

    // Level 39 — Horizon Breach
    const LevelDefinition(
      id: 39,
      version: 1,
      displayName: 'Horizon Breach',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 39,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 38,
      ),
      moveLimit: 15,
      scoreTarget: 3500,
      failureBoundaryRow: 10,
      availableStarTypes: [
        StarType.normal,
        StarType.meteor,
        StarType.rainbow,
        StarType.supernova,
        StarType.blackHole,
      ],
      randomSeed: 5343,
      objective: LevelObjective.scoreTarget(3500),
      initialStars: [
        InitialStarPlacement(
          position: GridPosition(0, 0),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 1),
          type: StarType.supernova,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 2),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 3),
          type: StarType.supernova,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 4),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 5),
          type: StarType.supernova,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 6),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 7),
          type: StarType.supernova,
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
          type: StarType.normal,
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
          type: StarType.supernova,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 2),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 4),
          type: StarType.supernova,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 6),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 8),
          type: StarType.supernova,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 1),
          type: StarType.rainbow,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 4),
          type: StarType.meteor,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 7),
          type: StarType.rainbow,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 0),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 4),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 8),
          type: StarType.normal,
        ),
      ],
    ),

    // Level 40 — Event Horizon  (World 4 boss)
    const LevelDefinition(
      id: 40,
      version: 1,
      displayName: 'Event Horizon',
      worldMeta: LevelWorldMeta(
        worldId: 1,
        levelNumber: 40,
        worldName: 'Nebula Nursery',
        isUnlocked: false,
        unlockRequirement: 39,
      ),
      moveLimit: 15,
      scoreTarget: 3800,
      failureBoundaryRow: 10,
      availableStarTypes: [
        StarType.normal,
        StarType.meteor,
        StarType.rainbow,
        StarType.supernova,
        StarType.blackHole,
      ],
      randomSeed: 5480,
      objective: LevelObjective.clearStarType(10, StarType.blackHole),
      initialStars: [
        InitialStarPlacement(
          position: GridPosition(0, 0),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 1),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 2),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 3),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 4),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 5),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 6),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 7),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 8),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(1, 0),
          type: StarType.supernova,
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
          type: StarType.normal,
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
          type: StarType.supernova,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 0),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 2),
          type: StarType.supernova,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 4),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 6),
          type: StarType.supernova,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 8),
          type: StarType.blackHole,
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
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 2),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 6),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 8),
          type: StarType.normal,
        ),
      ],
    ),

    // ════════════════════════════════════════════════════════════════════════
    // WORLD 5 — FROZEN NEBULA  (Levels 41–50)
    // Frozen star obstacles; all special types; 12–14 shots; hardest world.
    // ════════════════════════════════════════════════════════════════════════

    // Level 41 — First Frost
    const LevelDefinition(
      id: 41,
      version: 1,
      displayName: 'First Frost',
      worldMeta: LevelWorldMeta(
        worldId: 2,
        levelNumber: 1,
        worldName: 'Asteroid Fields',
        isUnlocked: false,
        unlockRequirement: 40,
      ),
      moveLimit: 14,
      scoreTarget: 3000,
      failureBoundaryRow: 10,
      availableStarTypes: [
        StarType.normal,
        StarType.meteor,
        StarType.rainbow,
        StarType.supernova,
        StarType.blackHole,
      ],
      randomSeed: 5617,
      objective: LevelObjective.clearStarType(4, StarType.meteor),
      initialStars: [
        InitialStarPlacement(
          position: GridPosition(0, 0),
          type: StarType.meteor,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 2),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 4),
          type: StarType.meteor,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 6),
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
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 0),
          type: StarType.meteor,
        ),
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
          type: StarType.normal,
        ),
      ],
    ),

    // Level 42 — Ice Storm
    const LevelDefinition(
      id: 42,
      version: 1,
      displayName: 'Ice Storm',
      worldMeta: LevelWorldMeta(
        worldId: 2,
        levelNumber: 2,
        worldName: 'Asteroid Fields',
        isUnlocked: false,
        unlockRequirement: 41,
      ),
      moveLimit: 14,
      scoreTarget: 3200,
      failureBoundaryRow: 10,
      availableStarTypes: [
        StarType.normal,
        StarType.meteor,
        StarType.rainbow,
        StarType.supernova,
        StarType.blackHole,
        StarType.frozenStar,
      ],
      randomSeed: 5754,
      objective: LevelObjective.clearStarType(6, StarType.frozenStar),
      initialStars: [
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
          type: StarType.frozenStar,
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
          type: StarType.meteor,
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
          type: StarType.normal,
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
          type: StarType.normal,
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

    // Level 43 — Cryo Field
    const LevelDefinition(
      id: 43,
      version: 1,
      displayName: 'Cryo Field',
      worldMeta: LevelWorldMeta(
        worldId: 2,
        levelNumber: 3,
        worldName: 'Asteroid Fields',
        isUnlocked: false,
        unlockRequirement: 42,
      ),
      moveLimit: 14,
      scoreTarget: 3400,
      failureBoundaryRow: 10,
      availableStarTypes: [
        StarType.normal,
        StarType.meteor,
        StarType.rainbow,
        StarType.supernova,
        StarType.blackHole,
        StarType.frozenStar,
      ],
      randomSeed: 5891,
      objective: LevelObjective.clearSpecial(8),
      initialStars: [
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
          type: StarType.frozenStar,
        ),
        InitialStarPlacement(
          position: GridPosition(1, 4),
          type: StarType.meteor,
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
          type: StarType.rainbow,
        ),
        InitialStarPlacement(
          position: GridPosition(1, 8),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 0),
          type: StarType.supernova,
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
          type: StarType.supernova,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 1),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 4),
          type: StarType.frozenStar,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 7),
          type: StarType.normal,
        ),
      ],
    ),

    // Level 44 — Absolute Zero
    const LevelDefinition(
      id: 44,
      version: 1,
      displayName: 'Absolute Zero',
      worldMeta: LevelWorldMeta(
        worldId: 2,
        levelNumber: 4,
        worldName: 'Asteroid Fields',
        isUnlocked: false,
        unlockRequirement: 43,
      ),
      moveLimit: 14,
      scoreTarget: 3600,
      failureBoundaryRow: 10,
      availableStarTypes: [
        StarType.normal,
        StarType.meteor,
        StarType.rainbow,
        StarType.supernova,
        StarType.blackHole,
        StarType.frozenStar,
      ],
      randomSeed: 6028,
      objective: LevelObjective.clearStarType(8, StarType.frozenStar),
      initialStars: [
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
          type: StarType.normal,
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
        InitialStarPlacement(
          position: GridPosition(1, 0),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(1, 1),
          type: StarType.supernova,
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
          type: StarType.supernova,
        ),
        InitialStarPlacement(
          position: GridPosition(1, 8),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 0),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 2),
          type: StarType.frozenStar,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 4),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 6),
          type: StarType.frozenStar,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 8),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 1),
          type: StarType.supernova,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 4),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 7),
          type: StarType.supernova,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 0),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 4),
          type: StarType.frozenStar,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 8),
          type: StarType.normal,
        ),
      ],
    ),

    // Level 45 — Permafrost
    const LevelDefinition(
      id: 45,
      version: 1,
      displayName: 'Permafrost',
      worldMeta: LevelWorldMeta(
        worldId: 2,
        levelNumber: 5,
        worldName: 'Asteroid Fields',
        isUnlocked: false,
        unlockRequirement: 44,
      ),
      moveLimit: 13,
      scoreTarget: 3800,
      failureBoundaryRow: 10,
      availableStarTypes: [
        StarType.normal,
        StarType.meteor,
        StarType.rainbow,
        StarType.supernova,
        StarType.blackHole,
        StarType.frozenStar,
      ],
      randomSeed: 6165,
      objective: LevelObjective.clearSpecial(12),
      initialStars: [
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
          type: StarType.rainbow,
        ),
        InitialStarPlacement(
          position: GridPosition(1, 3),
          type: StarType.frozenStar,
        ),
        InitialStarPlacement(
          position: GridPosition(1, 4),
          type: StarType.meteor,
        ),
        InitialStarPlacement(
          position: GridPosition(1, 5),
          type: StarType.frozenStar,
        ),
        InitialStarPlacement(
          position: GridPosition(1, 6),
          type: StarType.rainbow,
        ),
        InitialStarPlacement(
          position: GridPosition(1, 7),
          type: StarType.frozenStar,
        ),
        InitialStarPlacement(
          position: GridPosition(1, 8),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 0),
          type: StarType.supernova,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 2),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 4),
          type: StarType.supernova,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 6),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 8),
          type: StarType.supernova,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 1),
          type: StarType.frozenStar,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 3),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 5),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 7),
          type: StarType.frozenStar,
        ),
      ],
    ),

    // Level 46 — Ice Veil
    const LevelDefinition(
      id: 46,
      version: 1,
      displayName: 'Ice Veil',
      worldMeta: LevelWorldMeta(
        worldId: 2,
        levelNumber: 6,
        worldName: 'Asteroid Fields',
        isUnlocked: false,
        unlockRequirement: 45,
      ),
      moveLimit: 13,
      scoreTarget: 4000,
      failureBoundaryRow: 10,
      availableStarTypes: [
        StarType.normal,
        StarType.meteor,
        StarType.rainbow,
        StarType.supernova,
        StarType.blackHole,
        StarType.frozenStar,
      ],
      randomSeed: 6302,
      objective: LevelObjective.clearStarType(10, StarType.frozenStar),
      initialStars: [
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
          type: StarType.blackHole,
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
          type: StarType.frozenStar,
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
          type: StarType.blackHole,
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
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 1),
          type: StarType.frozenStar,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 4),
          type: StarType.supernova,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 7),
          type: StarType.frozenStar,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 0),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 4),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 8),
          type: StarType.normal,
        ),
      ],
    ),

    // Level 47 — Crystal Web
    const LevelDefinition(
      id: 47,
      version: 1,
      displayName: 'Crystal Web',
      worldMeta: LevelWorldMeta(
        worldId: 2,
        levelNumber: 7,
        worldName: 'Asteroid Fields',
        isUnlocked: false,
        unlockRequirement: 46,
      ),
      moveLimit: 13,
      scoreTarget: 4200,
      failureBoundaryRow: 10,
      availableStarTypes: [
        StarType.normal,
        StarType.meteor,
        StarType.rainbow,
        StarType.supernova,
        StarType.blackHole,
        StarType.frozenStar,
      ],
      randomSeed: 6439,
      objective: LevelObjective.clearSpecial(15),
      initialStars: [
        InitialStarPlacement(
          position: GridPosition(0, 0),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 1),
          type: StarType.frozenStar,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 2),
          type: StarType.supernova,
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
          type: StarType.frozenStar,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 6),
          type: StarType.supernova,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 7),
          type: StarType.frozenStar,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 8),
          type: StarType.blackHole,
        ),
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
          type: StarType.rainbow,
        ),
        InitialStarPlacement(
          position: GridPosition(1, 8),
          type: StarType.frozenStar,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 0),
          type: StarType.supernova,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 2),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 4),
          type: StarType.frozenStar,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 6),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 8),
          type: StarType.supernova,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 1),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 4),
          type: StarType.rainbow,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 7),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 0),
          type: StarType.frozenStar,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 4),
          type: StarType.meteor,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 8),
          type: StarType.frozenStar,
        ),
      ],
    ),

    // Level 48 — Tundra
    const LevelDefinition(
      id: 48,
      version: 1,
      displayName: 'Tundra',
      worldMeta: LevelWorldMeta(
        worldId: 2,
        levelNumber: 8,
        worldName: 'Asteroid Fields',
        isUnlocked: false,
        unlockRequirement: 47,
      ),
      moveLimit: 12,
      scoreTarget: 4500,
      failureBoundaryRow: 10,
      availableStarTypes: [
        StarType.normal,
        StarType.meteor,
        StarType.rainbow,
        StarType.supernova,
        StarType.blackHole,
        StarType.frozenStar,
      ],
      randomSeed: 6576,
      objective: LevelObjective.clearStarType(12, StarType.frozenStar),
      initialStars: [
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
          type: StarType.frozenStar,
        ),
        InitialStarPlacement(
          position: GridPosition(0, 8),
          type: StarType.frozenStar,
        ),
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
          type: StarType.rainbow,
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
          type: StarType.rainbow,
        ),
        InitialStarPlacement(
          position: GridPosition(1, 7),
          type: StarType.frozenStar,
        ),
        InitialStarPlacement(
          position: GridPosition(1, 8),
          type: StarType.supernova,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 0),
          type: StarType.frozenStar,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 1),
          type: StarType.blackHole,
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
          position: GridPosition(2, 7),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 8),
          type: StarType.frozenStar,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 0),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 2),
          type: StarType.frozenStar,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 4),
          type: StarType.supernova,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 6),
          type: StarType.frozenStar,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 8),
          type: StarType.normal,
        ),
      ],
    ),

    // Level 49 — Blizzard
    const LevelDefinition(
      id: 49,
      version: 1,
      displayName: 'Blizzard',
      worldMeta: LevelWorldMeta(
        worldId: 2,
        levelNumber: 9,
        worldName: 'Asteroid Fields',
        isUnlocked: false,
        unlockRequirement: 48,
      ),
      moveLimit: 12,
      scoreTarget: 4800,
      failureBoundaryRow: 10,
      availableStarTypes: [
        StarType.normal,
        StarType.meteor,
        StarType.rainbow,
        StarType.supernova,
        StarType.blackHole,
        StarType.frozenStar,
      ],
      randomSeed: 6713,
      objective: LevelObjective.clearSpecial(18),
      initialStars: [
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
          type: StarType.supernova,
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
          type: StarType.supernova,
        ),
        InitialStarPlacement(
          position: GridPosition(1, 7),
          type: StarType.frozenStar,
        ),
        InitialStarPlacement(
          position: GridPosition(1, 8),
          type: StarType.blackHole,
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
          position: GridPosition(2, 3),
          type: StarType.frozenStar,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 5),
          type: StarType.frozenStar,
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
          type: StarType.meteor,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 2),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 4),
          type: StarType.frozenStar,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 6),
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 8),
          type: StarType.meteor,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 0),
          type: StarType.normal,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 4),
          type: StarType.supernova,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 8),
          type: StarType.normal,
        ),
      ],
    ),

    // Level 50 — Frozen Core  (World 5 boss / final level)
    const LevelDefinition(
      id: 50,
      version: 1,
      displayName: 'Frozen Core',
      worldMeta: LevelWorldMeta(
        worldId: 2,
        levelNumber: 10,
        worldName: 'Asteroid Fields',
        isUnlocked: false,
        unlockRequirement: 49,
      ),
      moveLimit: 12,
      scoreTarget: 5000,
      failureBoundaryRow: 10,
      availableStarTypes: [
        StarType.normal,
        StarType.meteor,
        StarType.rainbow,
        StarType.supernova,
        StarType.blackHole,
        StarType.frozenStar,
      ],
      randomSeed: 6850,
      objective: LevelObjective.clearSpecial(20),
      initialStars: [
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
        InitialStarPlacement(
          position: GridPosition(1, 0),
          type: StarType.blackHole,
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
          type: StarType.blackHole,
        ),
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
          type: StarType.blackHole,
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
          type: StarType.blackHole,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 7),
          type: StarType.frozenStar,
        ),
        InitialStarPlacement(
          position: GridPosition(2, 8),
          type: StarType.supernova,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 0),
          type: StarType.rainbow,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 1),
          type: StarType.meteor,
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
          type: StarType.meteor,
        ),
        InitialStarPlacement(
          position: GridPosition(3, 8),
          type: StarType.rainbow,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 0),
          type: StarType.frozenStar,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 2),
          type: StarType.supernova,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 4),
          type: StarType.frozenStar,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 6),
          type: StarType.supernova,
        ),
        InitialStarPlacement(
          position: GridPosition(4, 8),
          type: StarType.frozenStar,
        ),
      ],
    ),

    // ════════════════════════════════════════════════════════════════════════
    // LEVELS 51–200  (imported from split catalog files)
    // ════════════════════════════════════════════════════════════════════════
    ...levelsFrom51To100,
    ...levelsFrom101To150,
    ...levelsFrom151To200,
  ];

  /// Returns the [LevelDefinition] for [id], or null if not in the catalog.
  static LevelDefinition? getLevelById(int id) =>
      allLevels.cast<LevelDefinition?>().firstWhere(
            (l) => l!.id == id,
            orElse: () => null,
          );

  /// Returns all levels belonging to [worldId].
  static List<LevelDefinition> getWorld(int worldId) =>
      allLevels.where((l) => l.worldMeta?.worldId == worldId).toList();
}
