# Analytics — Event Taxonomy & Privacy

**M14 | Star Shooter**

---

## Privacy principles

- No personal data collected — no name, email, device ID, or advertising identifier.
- No third-party SDK in M14 — all events queue locally in SharedPreferences.
- No new Android permissions added.
- Event params contain only: level IDs, numeric scores, stars, shots, combo, product ID (string constant), date strings (ISO format), and streak counts.
- The analytics pipeline is offline-first: events queue locally and are never a requirement for starting a level, saving progress, using attempts, or daily challenges.

---

## Storage keys

| Key | Purpose |
|---|---|
| `analytics_queue_v1` | JSON list of pending events (max 200; oldest dropped when full) |
| `analytics_milestones_v1` | Comma-separated int string of already-fired milestone level IDs |

---

## Event catalogue

All event names use snake_case. Params use snake_case keys. All boolean params default to `false`.

### Lifecycle

| Event | Params | When fired |
|---|---|---|
| `app_opened` | — | SplashScreen.initState, post-frame |
| `session_started` | — | SplashScreen.initState, post-frame |
| `session_ended` | `session_duration_s: int` | Reserved (not yet wired to AppLifecycleState) |

### Level

| Event | Params | When fired |
|---|---|---|
| `level_started` | `level_id`, `world_id`, `is_premium` | After `StartLevelUseCase` grants the attempt |
| `level_completed` | `level_id`, `world_id`, `score`, `stars`, `shots_used`, `combo` | After `CompleteLevelUseCase` persists results |
| `level_failed` | `level_id`, `world_id`, `score`, `shots_used`, `failure_reason` | When all shots exhausted with objective unmet |
| `level_restarted` | `level_id` | When user taps restart from HUD or pause overlay |
| `level_milestone` | `level_id` | First completion ever of a milestone level (see below) |

**Milestone levels:** `{5, 20, 50, 75, 100, 101, 125, 150, 175, 200}` — fires at most once per level ID per device lifetime (deduped via `analytics_milestones_v1`).

### Attempts

| Event | Params | When fired |
|---|---|---|
| `attempt_consumed` | `level_id`, `is_premium`, `attempts_remaining` | When a non-premium attempt is consumed |
| `daily_limit_reached` | `level_id`, `is_premium` | When `StartLevelUseCase` returns `dailyLimitReached` |

### Premium funnel

| Event | Params | When fired |
|---|---|---|
| `premium_screen_viewed` | — | PremiumScreen.initState, post-frame |
| `purchase_started` | `product_id` | Before `BillingRepository.initiatePurchase` is called |
| `purchase_completed` | `product_id` | When purchase stream emits `purchased` |
| `purchase_failed` | `product_id`, `reason` | On initiation failure (`initiate_failed`) or billing error (`billing_error`) |
| `restore_started` | — | Before `entitlementRepository.refreshFromBilling` |
| `restore_completed` | `product_id` | When purchase stream emits `restored` |

### Daily challenge

| Event | Params | When fired |
|---|---|---|
| `daily_challenge_viewed` | `date`, `level_id` | When daily challenge card is viewed |
| `daily_challenge_started` | `date`, `level_id` | When daily challenge starts |
| `daily_challenge_completed` | `date`, `level_id`, `score`, `stars` | When daily challenge level is completed |
| `daily_challenge_failed` | `date`, `level_id`, `score` | When daily challenge level is failed |
| `streak_updated` | `streak`, `milestone` | After streak changes; `milestone: true` for streaks in `{3, 7, 14, 30}` |

---

## Architecture

```
Game / UI / Use Cases
     ↓  (one call per event)
AnalyticsService          lib/analytics/analytics_service.dart
     ↓  (async, non-blocking)
AnalyticsRepository       lib/domain/repositories/analytics_repository.dart
     ↓
LocalAnalyticsRepository  lib/data/repositories/analytics_repository_impl.dart
     ↓
SharedPreferences queue   (kKeyAnalyticsQueue)
     +
dev.log in debug builds   (AppConfig.isDev)
```

To add a real analytics backend (Firebase, Amplitude, etc.), replace `LocalAnalyticsRepository._dispatch` — no other code changes required.

---

## Debug logging

In `AppConfig.isDev` builds, every event is logged via `dart:developer`:

```
[Analytics] level_started {level_id: 1, world_id: 1, is_premium: false}
```

No debug screen in production.
