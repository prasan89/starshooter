# Architecture Decision Records

Each ADR captures a significant design choice: the context that prompted it,
the decision made, and the consequences — good and bad.

---

## ADR-001: Flutter + Flame for the game engine

**Status:** Accepted — M1

### Context

Star Shooter is a mobile-first game targeting Android. We needed a framework
that could:

- Render a real-time game loop (60 fps canvas, physics, collision detection).
- Integrate with a mature UI toolkit for menus, HUDs, and settings screens.
- Compile to a single APK with a small footprint.
- Support a team already proficient in Dart.

Options evaluated: Unity (C#), Godot (GDScript/C#), React Native + Expo Game
Engine, Flutter + Flame.

### Decision

Use **Flutter 3.22+** as the application framework and **Flame 1.18+** as the
game engine, both in Dart.

### Consequences

**Positive:**
- A single language (Dart) for UI, game logic, domain, and tests.
- Flame's `FlameGame` / `Component` model integrates naturally with Flutter
  widgets via `GameWidget`, enabling native-quality menus and HUDs without
  platform channels.
- Flutter's hot-reload accelerates iteration on UI screens.
- Strong ecosystem: Flame has first-class support for collision detection,
  camera, audio, and tilemap — enough for M1–M4 without additional engines.

**Negative / trade-offs:**
- Flame is less mature than Unity for 3-D or console-quality physics; this
  game is 2-D so this is acceptable.
- Performance profiling requires Flutter DevTools familiarity rather than
  engine-specific tooling.

---

## ADR-002: Offline-first with SharedPreferences

**Status:** Accepted — M1

### Context

M1–M2 have no backend. Player profile, level progress, settings, and daily
attempt counts must survive app restarts. The data volume is small (a few KB
of JSON per player).

Options evaluated: SQLite (via `sqflite`), Hive, Isar, SharedPreferences,
plain file I/O.

### Decision

Use **SharedPreferences** (`shared_preferences ^2.3.0`) as the sole
persistence layer for M1–M2, wrapped in a typed `LocalStorage` class that
provides JSON helpers and catches platform exceptions.

### Consequences

**Positive:**
- Zero schema migration burden in M1–M2.
- Synchronous reads (after async init) keep the game-loop free of `await`.
- The `LocalStorage` abstraction means the data layer can be migrated to
  SQLite or a remote API by swapping repository implementations without
  touching domain or presentation code.

**Negative / trade-offs:**
- SharedPreferences is not designed for relational queries; this is fine for
  the current data model (key-value + JSON blobs) but would become awkward
  if level count reaches hundreds of rows. Migration to SQLite would be
  planned for M3/M4 if needed.
- No encryption at rest; no PII is stored, so this is acceptable.

---

## ADR-003: GoRouter for navigation

**Status:** Accepted — M1

### Context

Star Shooter has eight distinct screens and will add deep-link support (e.g.
direct-to-level from a notification) in M3. Navigator 1.0 push/pop grows
unwieldy beyond a handful of screens and cannot express URL-based deep links
cleanly.

Options evaluated: Navigator 1.0, Navigator 2.0 (raw), GoRouter, AutoRoute,
Beamer.

### Decision

Use **GoRouter 14.x** for all navigation.

### Consequences

**Positive:**
- Declarative route table in one file (`app_router.dart`) — all routes are
  visible at a glance.
- Path parameters (`/play/:levelId`) are type-safe at parse time and
  eliminate manual string splitting.
- `redirect` callbacks provide a clean hook for future premium gating (e.g.
  redirect `/play/:levelId` to `/premium` when the level is locked).
- Deep-link URIs work out of the box in M3 with minimal additional config.

**Negative / trade-offs:**
- GoRouter v14 introduced minor breaking changes vs v13; version pins in
  `pubspec.yaml` guard against unexpected upgrades.
- The router is a singleton (`AppRouter.router`); this is conventional for
  GoRouter but complicates widget tests that need isolated navigation.
  Solution: pass a test router via the `routerConfig` parameter in tests.

---

## ADR-004: Provider for dependency injection

**Status:** Accepted — M1

### Context

The app needs to inject repository implementations into use-cases and surfaces
them to widgets (e.g. `PlayerRepository` for the profile screen). Options
considered: `get_it` (service locator), Riverpod, Bloc, Provider.

### Decision

Use **Provider 6.x** (`provider ^6.1.0`) with `MultiProvider` at the root of
the widget tree.

### Consequences

**Positive:**
- Minimal boilerplate for `ChangeNotifier`-based state (score, game phase).
- `MultiProvider` co-locates all registrations in `main.dart`, making the
  dependency graph explicit and easy to audit.
- No code generation step; faster CI and simpler onboarding.

**Negative / trade-offs:**
- Provider does not enforce immutability; careless use of `notifyListeners()`
  can trigger excessive rebuilds. Mitigated by using `context.select` /
  `Selector` in performance-sensitive widgets.
- If M2 introduces complex async event chains (e.g. combo animations driven
  by rapid input), a `GameCubit` can wrap `GameManager` incrementally.
  `flutter_bloc` can coexist with Provider.

---

## ADR-005: Result<T> type for error handling

**Status:** Accepted — M1

### Context

Repository methods and use-cases can fail (storage read errors, data
corruption, future network timeouts). Propagating raw exceptions across layer
boundaries couples callers to implementation details and makes failure paths
invisible in function signatures.

Options evaluated: exceptions, `Either<Failure, T>` (from `dartz`),
custom `Result<T>` sealed class.

### Decision

Define a lightweight **`Result<T>` sealed class** (`lib/core/result/result.dart`)
with two subtypes: `Success<T>` and `ResultFailure<T>`. All use-cases and
repository methods return `Result<T>`.

### Consequences

**Positive:**
- Failure paths are encoded in the return type — callers cannot ignore them
  without a compiler warning (Dart exhaustive switch / pattern-matching).
- No third-party dependency (`dartz` brings functional-programming idioms
  that are unfamiliar to most Flutter developers).
- Sealed class exhaustiveness checking in Dart 3 catches unhandled cases at
  compile time.

**Negative / trade-offs:**
- Callers must pattern-match rather than calling `.getOrThrow()` — slightly
  more verbose than exception-based code for simple cases.
- Async stack traces are preserved inside `ResultFailure.failure`; logging
  must be explicit at the repository boundary (done in `LocalStorage`).

---

## ADR-006: Minimum Android SDK 23 (Android 6.0)

**Status:** Accepted — M1

### Context

Selecting `minSdkVersion` balances device coverage against access to modern
APIs (JobScheduler, BiometricPrompt, foreground services). Play Store
distribution data (2024) shows < 2 % of active devices run Android < 6.0.

### Decision

Set `minSdkVersion 23` (Android 6.0 Marshmallow) in
`android/app/build.gradle`.

### Consequences

**Positive:**
- Runtime permission model (introduced in API 23) is always available;
  no legacy `uses-permission` fallback code needed.
- `SharedPreferences` and all current dependencies support API 23+.
- Covers approximately 98 % of the active Android install base.

**Negative / trade-offs:**
- Devices running Android 5.x (API 21–22) cannot install the game. This is
  an accepted trade-off given negligible market share.
- If a future feature requires API 26+ (e.g. Notification Channels),
  a runtime API-level check is required to avoid crashes on API 23–25 devices.
