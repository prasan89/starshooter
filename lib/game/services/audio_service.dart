import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

/// Wraps FlameAudio with graceful no-op fallbacks for missing assets.
///
/// Real .ogg files are added in M6; until then every play call silently
/// no-ops via try/catch so the rest of the game runs without errors.
/// On web (kIsWeb) all audio is disabled entirely — web audio requires
/// user interaction before the AudioContext can start, and OGG assets
/// are not bundled yet, so every call would error.
class AudioService {
  bool _musicEnabled = true;
  bool _sfxEnabled = true;
  bool _initialized = false;

  bool get musicEnabled => _musicEnabled;
  bool get sfxEnabled => _sfxEnabled;

  // Audio path constants — real files added in M6
  static const String _bgMusic = 'audio/bg_cosmic.ogg';
  static const String _sfxShoot = 'audio/sfx_shoot.ogg';
  static const String _sfxMatch = 'audio/sfx_match.ogg';
  static const String _sfxPop = 'audio/sfx_pop.ogg';
  static const String _sfxCascade = 'audio/sfx_cascade.ogg';
  static const String _sfxImpact = 'audio/sfx_impact.ogg';
  static const String _sfxCombo = 'audio/sfx_combo.ogg';
  static const String _sfxUI = 'audio/sfx_ui.ogg';
  static const String _sfxLevelComplete = 'audio/sfx_level_complete.ogg';
  static const String _sfxDrop = 'audio/sfx_drop.ogg';

  Future<void> initialize() async {
    if (kIsWeb) return; // No audio on web — OGG assets not bundled yet
    _initialized = true;
  }

  void setMusicEnabled(bool enabled) {
    _musicEnabled = enabled;
    if (!enabled) stopMusic();
  }

  void setSfxEnabled(bool enabled) {
    _sfxEnabled = enabled;
  }

  Future<void> playMusic() async {
    if (kIsWeb || !_initialized || !_musicEnabled) return;
    try {
      await FlameAudio.bgm.play(_bgMusic, volume: 0.4);
    } catch (_) {}
  }

  void stopMusic() {
    if (kIsWeb) return;
    try {
      FlameAudio.bgm.stop().catchError((_) {});
    } catch (_) {}
  }

  void pauseMusic() {
    if (kIsWeb) return;
    try {
      FlameAudio.bgm.pause().catchError((_) {});
    } catch (_) {}
  }

  void resumeMusic() {
    if (kIsWeb) return;
    try {
      if (_musicEnabled) FlameAudio.bgm.resume().catchError((_) {});
    } catch (_) {}
  }

  Future<void> _playSfx(String asset, {double volume = 0.8}) async {
    if (kIsWeb || !_initialized || !_sfxEnabled) return;
    try {
      await FlameAudio.play(asset, volume: volume);
    } catch (_) {}
  }

  void playShoot() => _playSfx(_sfxShoot, volume: 0.7);
  void playImpact() => _playSfx(_sfxImpact, volume: 0.6);
  void playMatch() => _playSfx(_sfxMatch, volume: 0.9);
  void playPop() => _playSfx(_sfxPop, volume: 0.8);
  void playCascade() => _playSfx(_sfxCascade, volume: 0.9);
  void playCombo() => _playSfx(_sfxCombo, volume: 1.0);
  void playDrop() => _playSfx(_sfxDrop, volume: 0.6);
  void playUI() => _playSfx(_sfxUI, volume: 0.5);
  void playLevelComplete() => _playSfx(_sfxLevelComplete, volume: 1.0);

  void dispose() {
    if (kIsWeb) return;
    try {
      FlameAudio.bgm.dispose();
    } catch (_) {}
  }
}
