import 'package:star_shooter/core/utils/result.dart';
import 'package:star_shooter/domain/models/level_progress.dart';
import 'package:star_shooter/domain/repositories/level_repository.dart';

/// Retrieves the [LevelProgress] for a given [levelId].
///
/// Returns [LevelProgress.empty] when no progress has been recorded yet.
class GetLevelProgressUseCase {
  const GetLevelProgressUseCase(this._levelRepository);

  final LevelRepository _levelRepository;

  Future<Result<LevelProgress>> call(int levelId) async {
    final result = await _levelRepository.getLevelProgress(levelId);
    return switch (result) {
      Success<LevelProgress>() => result,
      Failure<LevelProgress>() =>
        // Treat a missing record as empty progress rather than a hard error.
        Success(LevelProgress.empty(levelId)),
    };
  }
}
