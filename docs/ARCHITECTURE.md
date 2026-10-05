# Architecture

Star Shooter is a Flutter + Flame Android game structured around clean
architecture principles: each layer has a single responsibility, dependencies
point inward only, and the domain layer has no knowledge of Flutter or any
platform SDK.

---

## Layer overview

```
┌─────────────────────────────────────────────────────┐
│                  Presentation layer                  │
│  Flutter widgets  ·  Flame game shell  ·  HUD        │
│  lib/features/**  ·  lib/game/**                     │
├─────────────────────────────────────────────────────┤
│                   Domain layer                       │
│  Use-cases  ·  Models  ·  Repository interfaces      │
│  lib/domain/**                                       │
├─────────────────────────────────────────────────────┤
│                    Data layer                        │
│  Repository implementations  ·  LocalStorage         │
│  lib/data/**                                         │
├─────────────────────────────────────────────────────┤
│               Infrastructure / Platform              │
│  SharedPreferences  ·  Android SDK  ·  Flame engine  │
└─────────────────────────────────────────────────────┘
```

### Why each layer exists

| Layer | Purpose |
|-------|---------|
| **Presentation** | Renders UI, reacts to state, delegates all business logic to use-cases. Never reads from storage directly. |
| **Domain** | Pure Dart. Owns the business rules (what counts as a completed level, whether daily attempts are exhausted). Testable without Flutter. |
| **Data** | Translates domain contracts (repository interfaces) into concrete storage operations. The only layer that imports `shared_preferences`. |
| **Infrastructure** | Third-party SDKs the data layer depends on. Swappable without touching domain. |

---

## Data flow

```
User action
    │
    ▼
Widget / GameManager   (Presentation)
    │  calls
    ▼
UseCase                (Domain)
    │  calls interface
    ▼
Repository interface   (Domain contract)
    │  implemented by
    ▼
RepositoryImpl         (Data)
    │  delegates to
    ▼
LocalStorage           (Data)
    │  wraps
    ▼
SharedPreferences      (Infrastructure)
```

A use-case always returns `Result<T>` (see [Result type](#resultt-type)).
The presentation layer pattern-matches on `Success` / `ResultFailure` and
updates state accordingly — it never throws or catches exceptions from domain
calls.

---

## Navigation — GoRouter

All navigation is declared in `lib/core/navigation/app_router.dart`.

**Why GoRouter over Navigator 2.0 directly:**

- URL-based routing maps naturally to named routes (`/play/:levelId`), making
  deep links and back-stack management straightforward.
- Route guards (future: premium gate) slot in cleanly as `redirect` callbacks
  without scattering `Navigator.push` calls across the codebase.
- Typed path parameters eliminate string-parsing bugs at call sites.

**Route table:**

| Path | Screen |
|------|--------|
| `/` | `SplashScreen` |
| `/home` | `HomeScreen` |
| `/galaxy-map` | `GalaxyMapScreen` |
| `/levels/:worldId` | `LevelSelectionScreen` |
| `/play/:levelId` | `GameplayScreen` |
| `/settings` | `SettingsScreen` |
| `/premium` | `PremiumScreen` |
| `/profile` | `ProfileScreen` |

---

## State management — Provider

**Why Provider over Bloc (for M1):**

The game has two categories of state:

1. **Repository state** — player profile, level progress, settings. These are
   loaded once, mutated infrequently, and consumed by several screens.
   `ChangeNotifier` + `Provider` covers this with minimal boilerplate.

2. **Game-loop state** — score, current level, pause/resume. Managed by
   `GameManager` (`ChangeNotifier`), which the Flame shell calls directly.
   A stream-based architecture (Bloc/Cubit) would add complexity with no
   observable benefit at this scale.

If M2 introduces complex async event chains (multiplayer, animations driven by
user input sequences), a `GameCubit` can wrap `GameManager` without changing
the domain or data layers.

---

## Offline-first philosophy

There is no remote backend in M1–M2. All persistence goes through
`LocalStorage` → `SharedPreferences`. The design deliberately treats this as
the primary source of truth rather than a cache, so:

- The app works on first launch with no network.
- No loading spinners for local reads (synchronous `SharedPreferences` access
  is acceptable for small key-value data).
- When a backend is added (M5+), the repository implementations can be
  swapped to network-first-with-local-fallback without touching use-cases or
  the UI.

---

## Entitlement abstraction

`EntitlementRepository` is a separate interface from `PlayerRepository`
deliberately:

- It isolates the "is this player allowed to do X?" question from profile data.
- Billing SDK integration (Google Play Billing — M3) requires its own async
  lifecycle. Keeping it separate avoids polluting `PlayerRepository` with
  billing callbacks.
- Unit tests can stub `EntitlementRepository` to simulate premium / free user
  states independently.

---

## Result<T> type

```
sealed class Result<T>
  ├── Success<T>(value)
  └── ResultFailure<T>(failure)
```

Located at `lib/core/result/result.dart`. All use-cases and repository methods
return `Result<T>`. Benefits:

- No unchecked exceptions crossing layer boundaries.
- Pattern-matching at the call site makes every failure path visible.
- Consistent error handling across network (future) and local storage.

---

## Flame game architecture

```
StarShooterGame  (FlameGame)
 ├── CosmicBackgroundComponent   priority –10  (parallax stars)
 ├── GameBoardComponent          priority   0  (level grid)
 └── ShooterComponent            priority   5  (player cannon)

Flutter widget tree
 └── GameWidget<StarShooterGame>   (lib/features/gameplay/screens/)
      └── GameHudOverlay            (Stack overlay on top of GameWidget)
```

**Component conventions:**

- Each component owns its own rendering, update logic, and resize handling
  via `onGameResize`.
- The game shell (`StarShooterGame`) does not contain game logic; it only
  wires components together.
- `GameManager` (`ChangeNotifier`) is the bridge: Flame calls
  `GameManager.onLevelComplete(...)` which notifies Flutter listeners to
  update the HUD or navigate away.

---

## How to add a new feature

1. **Domain first.** Define a model in `lib/domain/models/` and a repository
   interface in `lib/domain/repositories/`. Add a use-case in
   `lib/domain/usecases/`.

2. **Data layer.** Implement the repository interface in
   `lib/data/repositories/`. Wire it to `LocalStorage` for any persistence.
   Register the implementation in `lib/data/providers/storage_provider.dart`.

3. **Presentation.** Create a screen in `lib/features/<feature>/screens/`.
   Add a route to `AppRouter` and a constant to `AppRoutes`.

4. **Tests.** Add unit tests under `test/domain/` (pure Dart),
   `test/data/repositories/` (mock `LocalStorage`), and
   `test/features/<feature>/` (widget tests with mocked repositories).

---

## Key files map

| File | Role |
|------|------|
| `lib/main.dart` | Entry point; bootstraps data providers and runs the app |
| `lib/app.dart` | Root `MaterialApp.router` with theme and router wired together |
| `lib/core/result/result.dart` | `Result<T>` sealed class |
| `lib/core/navigation/app_router.dart` | GoRouter configuration and route table |
| `lib/core/theme/app_theme.dart` | Dark theme definition |
| `lib/data/local/local_storage.dart` | Typed `SharedPreferences` wrapper |
| `lib/data/providers/storage_provider.dart` | Provider factory — creates all repository instances |
| `lib/game/star_shooter_game.dart` | Root Flame game class |
| `lib/game/managers/game_manager.dart` | Flutter↔Flame bridge (`ChangeNotifier`) |
| `lib/game/screens/game_hud_overlay.dart` | Flutter HUD rendered over the Flame canvas |
| `dart_defines/dev.json` | Dev-environment compile-time constants |
| `dart_defines/prod.json` | Prod-environment compile-time constants |
| `.github/workflows/ci.yml` | GitHub Actions CI pipeline |
