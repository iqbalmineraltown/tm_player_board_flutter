# Terraforming Mars Player Board

A Flutter resource tracker for the Terraforming Mars board game.

## Features

- Track resources: MC, Steel, Titanium, Plants, Energy, Heat
- Track production levels for all resources
- Generation and Terraform Rating (TR) tracking
- Undo/Redo support with full action history
- Production phase automation
- Persistent game state storage

## Running the App

### Web
```bash
# Run with default APP_ID
flutter run -d chrome

# Run with custom APP_ID
APP_ID=com.example.myapp flutter run -d chrome
```

### Android
```bash
flutter run -d android
```

## Building

### Web Release
```bash
flutter build web --release
```

### Android APK
```bash
flutter build apk --release
```

## E2E Testing with Maestro

All Maestro tests use `${APP_ID}` environment variable for the application ID.

### Run Tests

```bash
# Default APP_ID (com.iqbalmineraltown.tmplayerboard)
maestro test maestro/01_smoke_test.yaml

# With custom APP_ID
APP_ID=com.example.myapp maestro test maestro/01_smoke_test.yaml

# Run all tests
for test in maestro/*.yaml; do maestro test "$test"; done
```

### Available Test Scenarios

| File | Description |
|------|-------------|
| `01_smoke_test.yaml` | Basic UI verification |
| `02_resource_amounts.yaml` | Resource amount adjustments |
| `03_production_adjustments.yaml` | Production level changes |
| `04_generation_tracking.yaml` | Generation increment/decrement |
| `05_tr_tracking.yaml` | Terraform Rating tracking |
| `06_undo_redo.yaml` | Undo/Redo functionality |
| `07_reset_game.yaml` | Game reset |
| `08_history_page.yaml` | Action history page |
| `09_full_gameplay.yaml` | Complete gameplay simulation |

## Project Structure

```
lib/
├── core/           # Theme and constants
├── domain/         # Models, commands, services
├── application/    # State management (Riverpod)
└── presentation/   # UI widgets and screens

maestro/            # E2E test scenarios
web/                # Web configuration
```
