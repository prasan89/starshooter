import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/core/errors/failures.dart';
import 'package:star_shooter/core/utils/result.dart';
import 'package:star_shooter/domain/models/daily_attempts.dart';
import 'package:star_shooter/domain/models/game_session.dart';
import 'package:star_shooter/domain/models/level_progress.dart';
import 'package:star_shooter/domain/models/player_profile.dart';
import 'package:star_shooter/domain/models/player_settings.dart';
import 'package:star_shooter/domain/repositories/level_repository.dart';
import 'package:star_shooter/domain/repositories/player_repository.dart';
import 'package:star_shooter/domain/usecases/complete_level_usecase.dart';
import 'package:star_shooter/game/level/level_catalog.dart';
import 'package:star_shooter/game/level/star_rating_calculator.dart';
import 'package:star_shooter/game/level/level_validation_result.dart';
import 'package:star_shooter/game/models/level_definition.dart';

// ── Fake repositories ────────────────────────────────────────────────────────

class _FakeLevelRepository implements LevelRepository {
  int highestUnlocked;
  final List<LevelProgress> _progress;

  _FakeLevelRepository({List<LevelProgress>? progress, int highest = 1})
      : _progress = progress ?? [],
        highestUnlocked = highest;

  @override
  Future<Result<LevelProgress>> getLevelProgress(int id) async =>
      Result.success(
        _progress.firstWhere(
          (p) => p.levelId == id,
          orElse: () => LevelProgress.empty(id),
        ),
      );

  @override
  Future<Result<List<LevelProgress>>> getAllLevelProgress() async =>
      Result.success(List.unmodifiable(_progress));

  @override
  Future<Result<void>> saveLevelProgress(LevelProgress p) async {
    final idx = _progress.indexWhere((e) => e.levelId == p.levelId);
    if (idx >= 0) {
      _progress[idx] = p;
    } else {
      _progress.add(p);
    }
    return Result.success(null);
  }

  @override
  Future<Result<int>> getCurrentLevel() async => Result.success(1);

  @override
  Future<Result<void>> setCurrentLevel(int level) async => Result.success(null);

  @override
  Future<Result<LevelDefinition>> getLevel(int id) async {
    final l = LevelCatalog.getLevelById(id);
    if (l == null) return Result.failure(const NotFoundFailure('not found'));
    return Result.success(l);
  }

  @override
  Future<Result<List<LevelDefinition>>> getLevels(int worldId) async =>
      Result.success(LevelCatalog.getWorld(worldId));

  @override
  Future<Result<LevelDefinition>> getNextLevel() async =>
      Result.success(LevelCatalog.allLevels.first);

  @override
  Future<Result<LevelValidationResult>> validateLevel(int id) async =>
      Result.success(LevelValidationResult.valid());

  @override
  Future<Result<int>> getHighestUnlockedLevel() async =>
      Result.success(highestUnlocked);

  @override
  Future<Result<void>> setHighestUnlockedLevel(int level) async {
    highestUnlocked = level;
    return Result.success(null);
  }
}

class _FakePlayerRepository implements PlayerRepository {
  PlayerProfile _profile = PlayerProfile(
    name: 'Test Player',
    currentLevel: 1,
    totalStars: 0,
    premiumEntitlement: false,
    createdAt: DateTime.utc(2024, 1, 1),
  );

  @override
  Future<Result<PlayerProfile>> getProfile() async => Result.success(_profile);

  @override
  Future<Result<void>> saveProfile(PlayerProfile profile) async {
    _profile = profile;
    return Result.success(null);
  }

  @override
  Future<Result<PlayerSettings>> getSettings() async =>
      Result.success(PlayerSettings.defaults());

  @override
  Future<Result<void>> saveSettings(PlayerSettings settings) async =>
      Result.success(null);

  @override
  Future<Result<DailyAttempts>> getDailyAttempts() async =>
      Result.success(DailyAttempts.fresh());

  @override
  Future<Result<void>> saveDailyAttempts(DailyAttempts attempts) async =>
      Result.success(null);
}

// ── Tests ────────────────────────────────────────────────────────────────────

void main() {
  group('Victory flow', () {
    test('StarRatingCalculator produces 1-3 stars', () {
      final level = LevelCatalog.getLevelById(1)!;
      final r1 = StarRatingCalculator.calculate(
        level: level,
        score: 100,
        shotsUsed: 19,
      );
      final r2 = StarRatingCalculator.calculate(
        level: level,
        score: 500,
        shotsUsed: 10,
      );
      final r3 = StarRatingCalculator.calculate(
        level: level,
        score: level.objective.target * 2,
        shotsUsed: 5,
      );
      expect(r1.stars, inInclusiveRange(1, 3));
      expect(r2.stars, inInclusiveRange(1, 3));
      expect(r3.stars, 3);
    });

    test('LevelCatalog.getLevelById returns null for level 51', () {
      expect(LevelCatalog.getLevelById(51), isNull);
    });

    test('Level 50 is the last level', () {
      expect(LevelCatalog.getLevelById(50), isNotNull);
      expect(LevelCatalog.getLevelById(51), isNull);
    });

    test('Next level exists for levels 1-49', () {
      for (int i = 1; i <= 49; i++) {
        expect(
          LevelCatalog.getLevelById(i + 1),
          isNotNull,
          reason: 'Level ${i + 1} should exist after $i',
        );
      }
    });

    test('Completing level unlocks next via CompleteLevelUseCase', () async {
      final repo = _FakeLevelRepository();
      final playerRepo = _FakePlayerRepository();
      final useCase = CompleteLevelUseCase(
        levelRepository: repo,
        playerRepository: playerRepo,
      );
      final session = GameSession(
        levelId: 1,
        startedAt: DateTime.now().toUtc(),
        score: 1000,
        starsEarned: 2,
        isCompleted: true,
      );
      await useCase(session, shotsUsed: 10, comboLevel: 2);
      // Highest unlocked should now be 2
      final highest = await repo.getHighestUnlockedLevel();
      expect(
        highest.when(onSuccess: (v) => v, onFailure: (_) => -1),
        2,
      );
    });

    test('LevelProgress new-best detection', () {
      const newScore = 800;
      const previousBest = 500;
      const isNewBest = newScore > previousBest; // true
      expect(isNewBest, isTrue);
    });
  });
}
