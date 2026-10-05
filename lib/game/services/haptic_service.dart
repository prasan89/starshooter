import 'package:flutter/services.dart';

/// Wraps Flutter's [HapticFeedback] with an enable/disable toggle.
///
/// All public methods are safe to call even when haptics are disabled
/// or the platform does not support them.
class HapticService {
  bool _enabled = true;

  bool get enabled => _enabled;
  void setEnabled(bool value) => _enabled = value;

  void onShoot() {
    if (!_enabled) return;
    HapticFeedback.lightImpact();
  }

  void onMatch() {
    if (!_enabled) return;
    HapticFeedback.mediumImpact();
  }

  void onLargeMatch() {
    if (!_enabled) return;
    HapticFeedback.heavyImpact();
  }

  void onCascade() {
    if (!_enabled) return;
    HapticFeedback.mediumImpact();
  }

  void onHighCombo() {
    if (!_enabled) return;
    HapticFeedback.heavyImpact();
  }

  void onLevelComplete() {
    if (!_enabled) return;
    HapticFeedback.vibrate();
  }

  void onUI() {
    if (!_enabled) return;
    HapticFeedback.selectionClick();
  }
}
