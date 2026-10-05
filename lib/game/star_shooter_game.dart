import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:star_shooter/domain/models/player_settings.dart';
import 'package:star_shooter/game/components/aim_trajectory_component.dart';
import 'package:star_shooter/game/components/cosmic_background_component.dart';
import 'package:star_shooter/game/components/game_board_component.dart';
import 'package:star_shooter/game/components/projectile_component.dart';
import 'package:star_shooter/game/components/shooter_component.dart';
import 'package:star_shooter/game/fx/screen_effects.dart';
import 'package:star_shooter/game/managers/game_manager.dart';
import 'package:star_shooter/game/level/level_catalog.dart';
import 'package:star_shooter/game/models/level_definition.dart';
import 'package:star_shooter/game/models/star_model.dart';
import 'package:star_shooter/game/models/star_type.dart';
import 'package:star_shooter/game/services/audio_service.dart';
import 'package:star_shooter/game/services/haptic_service.dart';
import 'package:star_shooter/game/special/black_hole_effect.dart';
import 'package:star_shooter/game/special/frozen_star_effect.dart';
import 'package:star_shooter/game/special/meteor_effect.dart';
import 'package:star_shooter/game/special/rainbow_effect.dart';
import 'package:star_shooter/game/special/special_star_config.dart';
import 'package:star_shooter/game/special/special_star_effect.dart';
import 'package:star_shooter/game/special/special_star_spawner.dart';
import 'package:star_shooter/game/special/supernova_effect.dart';
import 'package:star_shooter/game/systems/turn_system.dart';

/// The root Flame game class for Star Shooter.
///
/// Handles the game loop, component management, and touch-based aim/shoot input.
///
/// Pass [levelId] to load the correct [LevelDefinition] automatically on
/// [onLoad]. Defaults to level 1 when omitted.
class StarShooterGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents, DragCallbacks {
  StarShooterGame({this.levelId = 1});

  /// The level this game instance is playing.
  final int levelId;

  late GameBoardComponent _board;
  late ShooterComponent _shooter;
  late AimTrajectoryComponent _trajectory;
  late ScreenEffectsComponent _screenEffects;

  Vector2 _aimDirection = Vector2(0, -1);
  bool _isDragging = false;

  final GameManager gameManager = GameManager();
  final TurnSystem turnSystem = TurnSystem();
  final AudioService audioService = AudioService();
  final HapticService hapticService = HapticService();

  LevelDefinition? _currentLevelDef;

  // ── Public accessors ────────────────────────────────────────────────────────

  GameBoardComponent get board => _board;
  ShooterComponent get shooter => _shooter;
  AimTrajectoryComponent get trajectory => _trajectory;
  ScreenEffectsComponent get screenEffects => _screenEffects;
  LevelDefinition? get currentLevelDef => _currentLevelDef;
  AudioService get audio => audioService;
  HapticService get haptic => hapticService;

  // ── Lifecycle ───────────────────────────────────────────────────────────────

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Register all special star effects before any board resolution runs.
    SpecialStarRegistry.register(MeteorEffect());
    SpecialStarRegistry.register(RainbowEffect());
    SpecialStarRegistry.register(SupernovaEffect());
    SpecialStarRegistry.register(BlackHoleEffect());
    SpecialStarRegistry.register(FrozenStarEffect());
    SpecialStarRegistry.registerDefaults();

    // Fix the camera anchor to the top-left so (0,0) is the top-left corner.
    camera.viewfinder.anchor = Anchor.topLeft;

    // Layer order (priority): background(-10) < board(0) < shooter(5).
    await add(CosmicBackgroundComponent());

    _currentLevelDef =
        LevelCatalog.getLevelById(levelId) ?? LevelDefinition.forLevel(levelId);
    _board = GameBoardComponent(levelDef: _currentLevelDef);
    await add(_board);

    _board.setSpecialConfig(SpecialStarConfig.standard);

    _shooter = ShooterComponent();
    await add(_shooter);

    _trajectory = AimTrajectoryComponent();
    _trajectory.priority = 3;
    await add(_trajectory);

    _screenEffects = ScreenEffectsComponent();
    await add(_screenEffects);

    // Initialise subsystems.
    final spawner = SpecialStarSpawner(
      levelId: _currentLevelDef!.id,
      seed: _currentLevelDef!.randomSeed,
      allowedTypes: _currentLevelDef!.availableStarTypes,
    );
    turnSystem.initialize(_currentLevelDef!.moveLimit, spawner: spawner);

    // Build the initial board grid to read which colors are present.
    final initialGrid = _currentLevelDef!.buildInitialBoard();

    gameManager.initLevel(
      _currentLevelDef!.id,
      moves: _currentLevelDef!.moveLimit,
      levelDef: _currentLevelDef,
      seed: _currentLevelDef!.randomSeed,
      boardColors: initialGrid.colorsInBottomRows(rows: 2),
    );

    await audioService.initialize();

    // Sync shooter display and trajectory tint to the initial launcher colors.
    _shooter.loadStars(
      gameManager.currentStarType,
      gameManager.nextStarType,
      currentColorIndex: gameManager.currentColorIndex,
      nextColorIndex: gameManager.nextColorIndex,
    );
    _trajectory.setTintColor(StarColor.fromIndex(gameManager.currentColorIndex).color);
  }

  // ── Pause / resume ──────────────────────────────────────────────────────────

  /// Pauses the game loop and all component updates.
  void pauseGame() {
    paused = true;
    audioService.pauseMusic();
  }

  /// Resumes the game loop.
  void resumeGame() {
    paused = false;
    audioService.resumeMusic();
  }

  @override
  void onRemove() {
    audioService.dispose();
    super.onRemove();
  }

  // ── Settings ─────────────────────────────────────────────────────────────────

  /// Applies [settings] to the audio and haptic services.
  void applySettings(PlayerSettings settings) {
    audioService.setMusicEnabled(settings.musicEnabled);
    audioService.setSfxEnabled(settings.sfxEnabled);
    hapticService.setEnabled(settings.hapticsEnabled);
  }

  // ── Drag / aim input ────────────────────────────────────────────────────────

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    if (!turnSystem.canShoot) return;
    _isDragging = true;
    turnSystem.startAiming();
    final dir = _computeAimDir(event.canvasPosition);
    _aimDirection = dir;
    _trajectory.showTrajectory(
      from: _shooter.launcherWorldCenter,
      direction: dir,
    );
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    if (!_isDragging) return;
    final dir = _computeAimDir(event.canvasStartPosition);
    _aimDirection = dir;
    _trajectory.showTrajectory(
      from: _shooter.launcherWorldCenter,
      direction: dir,
    );
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    if (!_isDragging) return;
    _isDragging = false;
    _trajectory.hideTrajectory();
    shootProjectile();
  }

  // ── Shooting ────────────────────────────────────────────────────────────────

  /// Fires the current star in the aim direction.
  void shootProjectile() {
    final currentType = gameManager.currentStarType;
    final model = StarModel.projectile(
      type: currentType,
      colorIndex: gameManager.currentColorIndex,
    );
    final projectile = ProjectileComponent(
      model: model,
      direction: _aimDirection,
    );
    projectile.position = _shooter.launcherWorldCenter.clone();
    audioService.playShoot();
    hapticService.onShoot();
    add(projectile);
    gameManager.onShot();
    turnSystem.shoot();
    _trajectory.setTintColor(StarColor.fromIndex(gameManager.currentColorIndex).color);
  }

  // ── Helpers ─────────────────────────────────────────────────────────────────

  /// Updates the trajectory tint and shooter display when the star type changes.
  // ignore: unused_element
  void _onStarTypeChanged() {
    _trajectory.setTintColor(StarColor.fromIndex(gameManager.currentColorIndex).color);
    _shooter.loadStars(gameManager.currentStarType, gameManager.nextStarType, currentColorIndex: gameManager.currentColorIndex, nextColorIndex: gameManager.nextColorIndex);
  }

  /// Computes a clamped aim direction from the launcher centre toward [touch].
  ///
  /// The angle is clamped so the shot travels upward and stays between 20° and
  /// 160° measured from the left-pointing horizontal (i.e. the shot can never
  /// fire nearly sideways or downward).
  Vector2 _computeAimDir(Vector2 touch) {
    final launcher = _shooter.launcherWorldCenter;
    final raw = touch - launcher;

    // Angle from the positive-x axis (right).  We want "up" to be 90°.
    // The raw direction from launcher → touch points downward when touch is
    // above the launcher, so flip the y to get the direction of travel.
    final travel = Vector2(raw.x, -raw.y);
    if (travel.isZero()) return Vector2(0, -1);

    // atan2 gives angle from positive-x axis.
    double angle = math.atan2(travel.y, travel.x);

    // Clamp to [20°, 160°] — i.e. between nearly-left and nearly-right while
    // still pointing upward.
    const minAngle = 20.0 * math.pi / 180.0;
    const maxAngle = 160.0 * math.pi / 180.0;
    angle = angle.clamp(minAngle, maxAngle);

    // Convert back to a Vector2 in game space (flip y again).
    return Vector2(math.cos(angle), -math.sin(angle));
  }
}
