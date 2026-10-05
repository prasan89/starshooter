import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:star_shooter/core/utils/result.dart';
import 'package:star_shooter/data/local/local_storage.dart';
import 'package:star_shooter/data/repositories/player_repository_impl.dart';
import 'package:star_shooter/domain/models/daily_attempts.dart';
import 'package:star_shooter/domain/models/player_settings.dart';

void main() {
  late SharedPreferences prefs;
  late LocalStorage storage;
  late PlayerRepositoryImpl repository;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    storage = LocalStorage(prefs);
    repository = PlayerRepositoryImpl(storage);
  });

  group('PlayerRepositoryImpl', () {
    group('getSettings', () {
      test('returns defaults when no data is stored', () async {
        final result = await repository.getSettings();
        expect(result.isSuccess, isTrue);
        final settings = (result as Success<PlayerSettings>).value;
        expect(settings, equals(PlayerSettings.defaults()));
      });
    });

    group('saveSettings / getSettings', () {
      test('save then get returns the saved settings', () async {
        const custom = PlayerSettings(
          musicEnabled: false,
          sfxEnabled: true,
          hapticsEnabled: false,
        );
        final saveResult = await repository.saveSettings(custom);
        expect(saveResult.isSuccess, isTrue);

        final getResult = await repository.getSettings();
        expect(getResult.isSuccess, isTrue);
        final retrieved = (getResult as Success<PlayerSettings>).value;
        expect(retrieved, equals(custom));
      });
    });

    group('getDailyAttempts', () {
      test('returns defaults when no data is stored', () async {
        final result = await repository.getDailyAttempts();
        expect(result.isSuccess, isTrue);
        final attempts = (result as Success<DailyAttempts>).value;
        expect(attempts.used, equals(0));
        expect(attempts.max, equals(5));
      });

      test('returns stored attempts when data is present', () async {
        final now = DateTime.now().toUtc();
        final original = DailyAttempts(
          used: 3,
          max: 5,
          lastResetDate: now,
        );
        await repository.saveDailyAttempts(original);

        final result = await repository.getDailyAttempts();
        expect(result.isSuccess, isTrue);
        final retrieved = (result as Success<DailyAttempts>).value;
        expect(retrieved.used, equals(3));
        expect(retrieved.max, equals(5));
      });
    });

    group('corrupt stored data', () {
      test('getSettings with corrupt JSON returns defaults or failure gracefully', () async {
        await prefs.setString('player_settings', '{invalid json');
        final result = await repository.getSettings();
        // The implementation must not throw; it returns either defaults or a failure.
        expect(result, isA<Result<PlayerSettings>>());
      });

      test('getDailyAttempts with corrupt JSON does not throw', () async {
        await prefs.setString('daily_attempts', 'not-json-at-all');
        final result = await repository.getDailyAttempts();
        expect(result, isA<Result<DailyAttempts>>());
      });
    });
  });
}
