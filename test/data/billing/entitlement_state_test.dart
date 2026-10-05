import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/domain/models/entitlement_state.dart';

void main() {
  group('EntitlementState', () {
    test('defaultFree has isPremium=false', () {
      expect(EntitlementState.defaultFree.isPremium, isFalse);
      expect(EntitlementState.defaultFree.source, 'none');
    });

    test('encode / decode roundtrip', () {
      const s = EntitlementState(
        isPremium: true,
        lastVerifiedAt: '2024-10-05T12:00:00Z',
        source: 'google_play',
      );
      final decoded = EntitlementState.decode(s.encode());
      expect(decoded.isPremium, isTrue);
      expect(decoded.source, 'google_play');
      expect(decoded.lastVerifiedAt, '2024-10-05T12:00:00Z');
    });

    test('decode handles invalid json gracefully', () {
      final s = EntitlementState.decode('not-json');
      expect(s.isPremium, isFalse);
    });
  });
}
