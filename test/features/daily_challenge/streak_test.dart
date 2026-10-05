import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/core/utils/game_clock.dart';
import 'package:star_shooter/core/utils/result.dart';
import 'package:star_shooter/features/daily_challenge/domain/generators/daily_challenge_generator.dart';
import 'package:star_shooter/features/daily_challenge/domain/models/challenge_history_entry.dart';
import 'package:star_shooter/features/daily_challenge/domain/models/streak_state.dart';
import 'package:star_shooter/features/daily_challenge/domain/repositories/daily_challenge_repository.dart';
import 'package:star_shooter/features/daily_challenge/domain/repositories/streak_repository.dart';
import 'package:star_shooter/features/daily_challenge/domain/usecases/complete_daily_challenge_usecase.dart';

class _FakeDailyChallengeRepository implements DailyChallengeRepository {
  bool _completed = false;
  String _completedDate = '';
  final List<ChallengeHistoryEntry> _history = [];

  @override
  Result<bool> getTodayCompleted(String date) =>
      Result.success(date == _completedDate && _completed);

  @override
  Future<void> markTodayCompleted(String date) async {
    _completed = true;
    _completedDate = date;
  }

  @override
  List<ChallengeHistoryEntry> getHistory() => List.unmodifiable(_history);

  @override
  Future<void> saveHistoryEntry(ChallengeHistoryEntry e) async {
    _history.add(e);
  }
}

class _FakeStreakRepository implements StreakRepository {
  StreakState state = StreakState.empty;

  @override
  StreakState getStreak() => state;

  @override
  Future<void> saveStreak(StreakState s) async {
    state = s;
  }
}

class _FakeClock implements GameClock {
  const _FakeClock(this._today);
  final String _today;

  @override
  DateTime now() => DateTime.parse('${_today}T00:00:00');

  @override
  String todayLocalDate() => _today;
}

void main() {
  const generator = DailyChallengeGenerator();

  group('CompleteDailyChallengeUseCase — streak logic', () {
    late _FakeDailyChallengeRepository challengeRepo;
    late _FakeStreakRepository streakRepo;

    setUp(() {
      challengeRepo = _FakeDailyChallengeRepository();
      streakRepo = _FakeStreakRepository();
    });

    CompleteDailyChallengeUseCase makeUseCase(String today) =>
        CompleteDailyChallengeUseCase(
          challengeRepository: challengeRepo,
          streakRepository: streakRepo,
          clock: _FakeClock(today),
        );

    test('first completion starts streak at 1', () async {
      final uc = makeUseCase('2024-10-05');
      final result = await uc.call(
        challenge: generator.generateForDate('2024-10-05'),
        score: 1000,
        stars: 2,
        alreadyCompleted: false,
      );
      expect(result.currentStreak, 1);
      expect(result.longestStreak, 1);
      expect(result.lastCompletedDate, '2024-10-05');
    });

    test('consecutive days extend streak', () async {
      streakRepo.state = const StreakState(
        currentStreak: 3,
        longestStreak: 3,
        lastCompletedDate: '2024-10-05',
        totalDaysCompleted: 3,
      );
      final uc = makeUseCase('2024-10-06');
      final result = await uc.call(
        challenge: generator.generateForDate('2024-10-06'),
        score: 1000,
        stars: 2,
        alreadyCompleted: false,
      );
      expect(result.currentStreak, 4);
      expect(result.longestStreak, 4);
    });

    test('missing a day resets streak to 1', () async {
      streakRepo.state = const StreakState(
        currentStreak: 5,
        longestStreak: 10,
        lastCompletedDate: '2024-10-03',
        totalDaysCompleted: 5,
      );
      final uc = makeUseCase('2024-10-05');
      final result = await uc.call(
        challenge: generator.generateForDate('2024-10-05'),
        score: 1000,
        stars: 2,
        alreadyCompleted: false,
      );
      expect(result.currentStreak, 1);
      expect(result.longestStreak, 10);
    });

    test('same-day completion is idempotent', () async {
      streakRepo.state = const StreakState(
        currentStreak: 3,
        longestStreak: 3,
        lastCompletedDate: '2024-10-05',
        totalDaysCompleted: 3,
      );
      final uc = makeUseCase('2024-10-05');
      final result = await uc.call(
        challenge: generator.generateForDate('2024-10-05'),
        score: 2000,
        stars: 3,
        alreadyCompleted: true,
      );
      expect(result.currentStreak, 3);
      expect(result.lastCompletedDate, '2024-10-05');
    });

    test('totalDaysCompleted increments on genuine completion', () async {
      streakRepo.state = const StreakState(
        currentStreak: 1,
        longestStreak: 1,
        lastCompletedDate: '2024-10-04',
        totalDaysCompleted: 5,
      );
      final uc = makeUseCase('2024-10-05');
      final result = await uc.call(
        challenge: generator.generateForDate('2024-10-05'),
        score: 1000,
        stars: 2,
        alreadyCompleted: false,
      );
      expect(result.totalDaysCompleted, 6);
    });
  });
}
