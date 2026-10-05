import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';
import 'package:star_shooter/domain/repositories/level_repository.dart';
import 'package:star_shooter/domain/models/level_progress.dart';
import 'package:star_shooter/domain/usecases/get_world_progress_usecase.dart';
import 'package:star_shooter/game/level/level_catalog.dart';
import 'package:star_shooter/game/models/level_definition.dart';

enum GalaxyLoadState { loading, loaded, error }

class GalaxyMapNotifier extends ChangeNotifier {
  final LevelRepository _levelRepo;
  final GetWorldProgressUseCase _worldProgressUseCase;

  GalaxyLoadState _loadState = GalaxyLoadState.loading;
  List<WorldProgress> _worldProgress = [];
  Map<int, LevelProgress> _levelProgressById = {};
  int _highestUnlockedLevel = 1;
  String? _errorMessage;

  GalaxyMapNotifier({
    required LevelRepository levelRepository,
    required GetWorldProgressUseCase worldProgressUseCase,
  })  : _levelRepo = levelRepository,
        _worldProgressUseCase = worldProgressUseCase;

  // ── Getters ────────────────────────────────────────────────────────────────
  GalaxyLoadState get loadState => _loadState;
  List<WorldProgress> get worldProgress => _worldProgress;
  int get highestUnlockedLevel => _highestUnlockedLevel;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _loadState == GalaxyLoadState.loading;

  /// Returns the [LevelProgress] for [levelId] or an empty default.
  LevelProgress progressFor(int levelId) =>
      _levelProgressById[levelId] ?? LevelProgress.empty(levelId);

  /// True when [levelId] is unlocked (≤ highestUnlockedLevel).
  bool isLevelUnlocked(int levelId) => levelId <= _highestUnlockedLevel;

  /// True when [levelId] has been completed.
  bool isLevelCompleted(int levelId) =>
      _levelProgressById[levelId]?.isCompleted ?? false;

  /// Returns all [LevelDefinition]s for [worldId] from the M6 catalog.
  List<LevelDefinition> levelsForWorld(int worldId) =>
      LevelCatalog.getWorld(worldId);

  /// The level the player should play next (the highest unlocked, uncompleted,
  /// or the first level of the highest unlocked world).
  int get currentLevelId {
    // Walk up from 1 to find the first incomplete unlocked level
    for (int id = 1; id <= _highestUnlockedLevel; id++) {
      if (!isLevelCompleted(id)) return id;
    }
    return _highestUnlockedLevel;
  }

  LevelDefinition? get currentLevel =>
      LevelCatalog.getLevelById(currentLevelId);

  // ── Loading ────────────────────────────────────────────────────────────────

  Future<void> load() async {
    _loadState = GalaxyLoadState.loading;
    notifyListeners();

    try {
      // Load all data in parallel
      final futures = await Future.wait([
        _worldProgressUseCase.call(),
        _levelRepo.getAllLevelProgress(),
        _levelRepo.getHighestUnlockedLevel(),
      ]);

      final worldResult = futures[0] as dynamic;
      final allProgressResult = futures[1] as dynamic;
      final highestResult = futures[2] as dynamic;

      _worldProgress = worldResult.when(
        onSuccess: (list) => list as List<WorldProgress>,
        onFailure: (_) => <WorldProgress>[],
      );

      final allProgress = allProgressResult.when(
        onSuccess: (list) => list as List<LevelProgress>,
        onFailure: (_) => <LevelProgress>[],
      );
      _levelProgressById = {for (final p in allProgress) p.levelId: p};

      _highestUnlockedLevel = highestResult.when(
        onSuccess: (v) => v as int,
        onFailure: (_) => 1,
      );

      _loadState = GalaxyLoadState.loaded;
      _errorMessage = null;
    } catch (e, st) {
      dev.log('GalaxyMapNotifier.load failed', error: e, stackTrace: st);
      _loadState = GalaxyLoadState.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  /// Refreshes data after a level is completed (called from gameplay).
  Future<void> refresh() => load();
}
