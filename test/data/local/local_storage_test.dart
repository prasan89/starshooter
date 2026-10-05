import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:star_shooter/data/local/local_storage.dart';

void main() {
  late SharedPreferences prefs;
  late LocalStorage storage;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    storage = LocalStorage(prefs);
  });

  group('LocalStorage', () {
    group('getString / setString', () {
      test('returns null for an absent key', () {
        expect(storage.getString('missing'), isNull);
      });

      test('stores and retrieves a string value', () async {
        await storage.setString('key', 'hello');
        expect(storage.getString('key'), equals('hello'));
      });

      test('overwrites an existing value', () async {
        await storage.setString('key', 'first');
        await storage.setString('key', 'second');
        expect(storage.getString('key'), equals('second'));
      });
    });

    group('getInt / setInt', () {
      test('returns null for an absent key', () {
        expect(storage.getInt('count'), isNull);
      });

      test('stores and retrieves an int value', () async {
        await storage.setInt('count', 42);
        expect(storage.getInt('count'), equals(42));
      });
    });

    group('getBool / setBool', () {
      test('returns null for an absent key', () {
        expect(storage.getBool('flag'), isNull);
      });

      test('stores and retrieves a bool value', () async {
        await storage.setBool('flag', true);
        expect(storage.getBool('flag'), isTrue);
      });

      test('stores false correctly', () async {
        await storage.setBool('flag', false);
        expect(storage.getBool('flag'), isFalse);
      });
    });

    group('getJson / setJson', () {
      test('returns null for an absent key', () {
        expect(storage.getJson('data'), isNull);
      });

      test('round-trips a map through JSON', () async {
        final map = {'id': 1, 'name': 'Alice', 'active': true};
        await storage.setJson('data', map);
        final result = storage.getJson('data');
        expect(result, isNotNull);
        expect(result!['id'], equals(1));
        expect(result['name'], equals('Alice'));
        expect(result['active'], isTrue);
      });

      test('returns null gracefully for corrupt JSON', () async {
        // Write a raw invalid JSON string directly via SharedPreferences.
        await prefs.setString('corrupt', '{not valid json}');
        final result = storage.getJson('corrupt');
        expect(result, isNull);
      });

      test('returns null for an empty string', () async {
        await prefs.setString('empty', '');
        expect(storage.getJson('empty'), isNull);
      });

      test('returns null when stored value is a JSON array (not a map)', () async {
        await prefs.setString('arr', '[1, 2, 3]');
        expect(storage.getJson('arr'), isNull);
      });
    });

    group('setJsonList / getJsonList', () {
      test('returns null for an absent key', () {
        expect(storage.getJsonList('list'), isNull);
      });

      test('round-trips a list of maps', () async {
        final list = [
          {'id': 1, 'val': 'a'},
          {'id': 2, 'val': 'b'},
        ];
        await storage.setJsonList('list', list);
        final result = storage.getJsonList('list');
        expect(result, isNotNull);
        expect(result!.length, equals(2));
        expect(result[0]['id'], equals(1));
        expect(result[1]['val'], equals('b'));
      });
    });
  });
}
