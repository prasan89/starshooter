import 'package:star_shooter/data/local/local_storage.dart';
import 'package:star_shooter/features/daily_challenge/domain/models/streak_state.dart';
import 'package:star_shooter/features/daily_challenge/domain/repositories/streak_repository.dart';

class LocalStreakRepository implements StreakRepository {
  LocalStreakRepository({required LocalStorage storage}) : _storage = storage;

  static const _kStreak = 'daily_challenge_streak_v1';

  final LocalStorage _storage;

  @override
  StreakState getStreak() {
    try {
      final raw = _storage.getString(_kStreak);
      if (raw == null || raw.isEmpty) return StreakState.empty;
      return StreakState.decode(raw);
    } catch (_) {
      return StreakState.empty;
    }
  }

  @override
  Future<void> saveStreak(StreakState state) async {
    await _storage.setString(_kStreak, state.encode());
  }
}
