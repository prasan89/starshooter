import 'package:flutter/foundation.dart';
import 'package:star_shooter/features/daily_challenge/domain/models/daily_challenge.dart';

class DailyChallengeNotifier extends ChangeNotifier {
  DailyChallenge? _activeDailyChallenge;
  bool _startedFromDailyChallenge = false;

  DailyChallenge? get activeDailyChallenge => _activeDailyChallenge;
  bool get startedFromDailyChallenge => _startedFromDailyChallenge;

  void setActiveChallenge(DailyChallenge challenge) {
    _activeDailyChallenge = challenge;
    _startedFromDailyChallenge = true;
    notifyListeners();
  }

  void clearActiveChallenge() {
    _activeDailyChallenge = null;
    _startedFromDailyChallenge = false;
    notifyListeners();
  }
}
