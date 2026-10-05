# Star Shooter

> A premium cosmic puzzle-shooter for Android, built with Flutter and Flame.

[![CI](https://github.com/starshooter/starshooter/actions/workflows/ci.yml/badge.svg)](https://github.com/starshooter/starshooter/actions/workflows/ci.yml)
[![Flutter](https://img.shields.io/badge/Flutter-3.22%2B-blue)](https://flutter.dev)
[![License](https://img.shields.io/badge/License-TBD-lightgrey)](#license)

---

## Screenshots

See M2 for gameplay screenshots.

---

## Architecture overview

Star Shooter follows a clean-architecture layering:

```
UI (Flutter widgets + Flame components)
        |
   Domain (use-cases, models, repository interfaces)
        |
   Data (repository implementations, LocalStorage)
        |
SharedPreferences (offline-first persistence)
```

Navigation is handled by **GoRouter**; state is provided via **Provider**.
The Flame game shell (`StarShooterGame`) runs inside a Flutter widget and
communicates back to the widget tree through `GameManager` (a
`ChangeNotifier`).

Full details: [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md)  
Decision records: [`docs/DECISIONS.md`](docs/DECISIONS.md)

---

## Setup

### Prerequisites

| Tool | Minimum version |
|------|-----------------|
| Flutter | 3.22 |
| Android SDK | API 34 (compile), API 23 (min) |
| Java | 17 (Temurin recommended) |

### Install dependencies

```bash
flutter pub get
```

### Run on a device / emulator

```bash
flutter run
```

A connected Android device or running emulator is required; iOS is not a
target platform for this project.

### Build

```bash
# Debug APK
flutter build apk --debug

# Release APK (requires signing config)
flutter build apk --release
```

### Test

```bash
flutter test
```

Run with coverage:

```bash
flutter test --coverage
```

### Format

```bash
dart format .
```

CI enforces `dart format --output=none --set-exit-if-changed .`, so run
this before pushing.

### Analyse

```bash
flutter analyze
```

CI uses `--fatal-infos --fatal-warnings`, so fix all warnings before
opening a PR.

---

## Milestone roadmap

| Milestone | Theme | Status |
|-----------|-------|--------|
| **M1** | Project scaffold — clean arch skeleton, Flame shell, CI | Complete |
| **M2** | Core gameplay — shooter mechanics, bullet physics, star targets | Planned |
| **M3** | Progression & monetisation — level map, daily attempts, billing | Planned |
| **M4** | Polish — animations, sound, particle effects, accessibility | Planned |
| **M5** | Launch — Play Store listing, crash reporting, analytics | Planned |

---

## Contributing

1. Fork the repository and create a feature branch from `main`.
2. Follow the existing code style (`flutter analyze` and `dart format` must
   pass with zero warnings).
3. Write unit tests for any new domain logic or repository code.
4. Open a pull request — the CI pipeline runs automatically. All checks
   must be green before a review is requested.
5. Use the PR template provided in `.github/PULL_REQUEST_TEMPLATE.md`.

---

## License

License TBD. All rights reserved until further notice.
