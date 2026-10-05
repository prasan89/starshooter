import 'dart:convert';

class EntitlementState {
  const EntitlementState({
    required this.isPremium,
    required this.lastVerifiedAt,
    required this.source,
  });

  final bool isPremium;
  final String lastVerifiedAt; // ISO-8601 UTC timestamp
  final String source; // 'google_play' | 'restored' | 'local' | 'none'

  static EntitlementState get defaultFree => const EntitlementState(
        isPremium: false,
        lastVerifiedAt: '',
        source: 'none',
      );

  Map<String, dynamic> toJson() => {
        'isPremium': isPremium,
        'lastVerifiedAt': lastVerifiedAt,
        'source': source,
      };

  factory EntitlementState.fromJson(Map<String, dynamic> json) =>
      EntitlementState(
        isPremium: (json['isPremium'] as bool?) ?? false,
        lastVerifiedAt: json['lastVerifiedAt'] as String? ?? '',
        source: json['source'] as String? ?? 'none',
      );

  String encode() {
    // manual JSON encoding to avoid adding json_serializable dependency
    return '{"isPremium":$isPremium,"lastVerifiedAt":"$lastVerifiedAt","source":"$source"}';
  }

  static EntitlementState decode(String raw) {
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return EntitlementState.fromJson(map);
    } catch (_) {
      return EntitlementState.defaultFree;
    }
  }
}
