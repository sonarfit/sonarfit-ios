# Changelog

All notable changes to the SonarFit iOS SDK will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).




## [2.1.2] - 2026-03-22

**Breaking Changes**
- Rename SDK module from `SonarFit` to `SonarFitKit` — update all import statements
- Rename rep and set properties on workout models for clarity — update any references to affected fields
- Update logging API to support granular log levels — replace previous log configuration calls with the new `LogLevel` API

**Added**
- Add `WatchStatusManager` to monitor and respond to Apple Watch app state changes
- Add `resendWatchConfig` method to re-push configuration to the Watch when connectivity is lost
- Add communicating-state UI indicator when the SDK is syncing with the Watch
- Add Watch handshake to verify connection before workout operations
- Add device availability checks when starting or resuming a workout
- Add headphone status delegate to receive AirPods connectivity updates
- Add `skipRestWithCountdown` method as a timed variant of `skipRest`

**Changed**
- Update AirPods rep detector to v2 model with improved motion filtering for more accurate rep counts
- Replace AirPods workout detection with a new processing pipeline for lower latency and higher reliability
- Improve Watch connectivity handling and workout device session management
## [2.1.1] - 2026-03-22

**Breaking Changes**
- Rename SDK module from `SonarFit` to `SonarFitKit` — update all import statements
- Rename rep and set properties on workout models for clarity — update any property references at call sites
- Replace logging API with new granular log level system — update any custom logging configuration

**Added**
- New AirPods workout detection pipeline for rep counting via headphone motion sensors
- `WatchStatusManager` for observing Apple Watch app status
- Headphone status delegate for monitoring AirPods availability during workouts
- Device availability checks before workout start and resume
- `skipRestWithCountdown` method to skip rest periods with a countdown
- `resendWatchConfig` method to re-sync configuration with the paired Watch
- Watch handshake flow to confirm communication before workout begins
- Communicating state UI to surface Watch connectivity status to users
- New color theme options for SDK UI components

**Changed**
- Improve AirPods rep detector with updated v2 ML model and enhanced signal filtering
- Improve Apple Watch connectivity reliability and workout device handling
## [2.1.0] - 2026-03-22

**Breaking Changes**
- Rename SDK module from `SonarFit` to `SonarFitKit` — update all imports and references
- Rename rep and set properties on workout models for clarity — update any code accessing these fields directly

**Added**
- Add `WatchStatusManager` to expose Apple Watch connection and app status
- Add device availability checks before starting or resuming a workout
- Add `skipRestWithCountdown` API for skipping rest periods with a countdown
- Add headphone status delegate for monitoring AirPods connectivity state
- Add `resendWatchConfig` method to re-sync configuration with the paired Watch
- Add granular log level system with updated logging API for filtering SDK output
- Add communicating state indicator in UI during Watch data sync

**Changed**
- Upgrade AirPods rep detector to v2 model with improved signal filtering for more accurate rep counts
- Introduce new AirPods workout detection pipeline for improved reliability
- Improve Watch connectivity handling and workout device session management
- Update theme manager with new color options and remove unused color definitions
## [2.0.1] - 2025-01-22

### Added
- **Custom UI API**: Complete custom UI integration via `SonarFitWorkout` (SwiftUI ObservableObject) and `WorkoutEngine` (UIKit delegate pattern)
- `SonarFit.createWorkout()` and `SonarFit.createEngine()` factory methods for custom UI development
- `DeviceStatusDelegate` protocol for real-time device status monitoring (AirPods connection/in-ear, Watch paired/installed/reachable)
- Device switching support - seamlessly switch between Watch and AirPods mid-workout
- Push-based rest timer with automatic second-by-second updates via `didUpdateRestTime` delegate method
- Device availability validation with specific error codes (1001: no devices available, 1002: Watch unavailable, 1003: AirPods unavailable)
- Auto-reset from completed state - can start new workouts immediately after completion without manual reset
- UIKit device switching pattern with `SonarFit.setupWatchHandlers()` for AirPods workouts

### Changed
- **Watch countdown timer improvements**: Now uses `.common` RunLoop mode to prevent pausing during screen sleep
- ML model automatically reloads when switching between devices to handle different sample sizes
- `WorkoutEngineDelegate` made `@MainActor` for guaranteed main thread callbacks
- Rest timer now push-based instead of poll-based for more reliable updates

### Fixed
- UIKit device switching delegate wrapper pattern now properly unwraps for AirPods workouts
- AirPods workout UI updates correctly after switching from Watch mid-workout
- ML model shape mismatch resolved when switching between Watch (75 samples) and AirPods (150 samples)
- Can now start new workout immediately after completion without manual reset call

### Documentation
- Added comprehensive `CUSTOM_UI_API.md` developer guide (100+ pages)
- Documented all `WorkoutEngineDelegate` methods including iOS-only Watch communication methods
- Added device availability validation documentation with error codes and handling patterns
- Included 6 complete working examples covering SwiftUI and UIKit custom implementations

### Breaking Changes
- Rest timer updates now delivered via `didUpdateRestTime(remaining:)` delegate method instead of polling `session.restTimeRemaining`
- `WorkoutEngineDelegate` protocol now requires `@MainActor` context (or use default implementation)
- Device switching may cause brief ML model reload delay when transitioning between Watch and AirPods

### Migration from v1.1.x

#### Rest Timer (Breaking)
```swift
// OLD (v1.1.x) - polling pattern:
Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
    let remaining = engine.session.restTimeRemaining
    updateUI(remaining)
}

// NEW (v2.0.0) - push-based pattern:
func workoutEngine(_ engine: WorkoutEngine, didUpdateRestTime remaining: Int) {
    updateUI(remaining)  // Called automatically every second
}
```

#### Custom UI Development
If you were previously attempting to build custom UI by observing `WorkoutEngine` directly, migrate to the new official Custom UI API:
- SwiftUI: Use `SonarFitWorkout` ObservableObject
- UIKit: Use `WorkoutEngine` with `WorkoutEngineDelegate`
- See `CUSTOM_UI_API.md` for complete migration guide and examples

## [1.1.1] - 2025-10-20

### Fixed
- Fixed Swift Package Manager dependency linking for binary frameworks
- Added `SonarFitKitWrapper` target to properly declare dependencies between frameworks
- Resolves "No such module 'SonarFitConnectivity'" and similar import errors

### Technical Details
SPM doesn't support adding dependencies to `.binaryTarget()` entries. This release adds a lightweight wrapper target that explicitly declares all framework dependencies, ensuring proper linking when integrating via SPM.

**No code changes** - XCFrameworks are identical to v1.1.0. Only Package.swift structure updated.

## [1.1.0] - 2025-10-19

### Changed
- **Simplified installation**: SDK now installs via Swift Package Manager with zero manual configuration
- **One-step setup**: Add package dependency and you're done
- Single `import SonarFitKit` statement provides access to all SDK functionality
- **Theme system improvements**: Implemented surface-scoped color system to prevent contrast issues

### Improved
- Installation process - streamlined to one package addition
- Build times and dependency management
- Integration documentation
- Theme color system with better naming and surface-scoped design

### Requirements
- **Platforms**: iOS 17.0+, watchOS 10.0+
- **Xcode**: 16.0+
- **Swift**: 5.9+

### Migration from v1.0.x

#### Installation
- **Installation**: Use SPM package dependency instead of manual framework embedding
- **Import**: Still just `import SonarFitKit`

#### Theme Changes (Breaking)
If you customize the theme, update your color configuration:

```swift
// OLD (v1.0.x):
SonarFitTheme.Colors(
    background: UIColor.systemBackground,
    primary: UIColor.systemBlue,
    textPrimary: UIColor.label,           // ❌ Removed
    textSecondary: UIColor.secondaryLabel, // ❌ Removed
    accent: UIColor.systemOrange,          // ❌ Renamed
    success: UIColor.systemGreen,          // ❌ Removed (unused)
    error: UIColor.systemRed               // ❌ Removed (unused)
)

// NEW (v1.1.0+):
SonarFitTheme.Colors(
    background: UIColor.systemBackground,
    primary: UIColor.systemBlue,
    textOnBackground: UIColor.label,        // ✅ Paired with background
    subtextOnBackground: UIColor.secondaryLabel, // ✅ Paired with background
    textOnPrimary: UIColor.white,           // ✅ New: text on primary buttons
    timerWarning: UIColor.systemOrange      // ✅ Renamed from 'accent'
)
```

**Why the change?** Surface-scoped colors prevent contrast issues by explicitly pairing text colors with their surfaces (e.g., `textOnBackground` with `background`, `textOnPrimary` with `primary` buttons).

**Default behavior**: If you don't customize themes, no changes needed - defaults work automatically.

### Breaking Changes
- **Theme API**: Color property names changed to surface-scoped system (see Migration section above)
- Removed unused `success` and `error` colors
- Renamed `accent` to `timerWarning` for clarity

## [1.0.2] - 2024-10-16

### Fixed
- Fixed XCFramework structure to properly support watchOS platforms
- Resolved "no library for this platform was found" error when adding SDK to Apple Watch targets
- Updated XCFramework to include all required platforms:
  - iOS Device (arm64)
  - iOS Simulator (arm64 + x86_64)
  - watchOS Device (arm64 + arm64_32)
  - watchOS Simulator (arm64 + x86_64)

### Technical Details
- **Platforms**: iOS 17.0+, watchOS 10.0+
- **XCFramework**: Now properly structured with correct Info.plist
- **Distribution**: Updated checksum for Swift Package Manager

### Note
- Version 1.0.1 tag was incorrectly placed; use 1.0.2 for the watchOS fix

## [1.0.1] - 2024-10-16 [Deprecated]

### Fixed
- Documentation updates only (tag incorrectly placed)
- Use v1.0.2 for watchOS support

## [1.0.0] - 2024-10-15

### Added
- Initial release of SonarFit iOS SDK
- AI-powered exercise recognition
- Real-time workout tracking and form analysis
- SwiftUI integration with workout UI
- Support for multiple workout types:
  - Bench press
  - Squat
  - Deadlift
- Rest timer functionality with pause/resume
- Version management system
- XCFramework distribution for easy integration

### Technical Details
- **Platform**: iOS 17.0+
- **Swift**: 5.9+
- **Size**: ~25MB (includes ML models and audio resources)
- **Architecture**: arm64 (device), arm64 + x86_64 (simulator)
- **Distribution**: XCFramework via Swift Package Manager

### Known Issues
- None at initial release

### Breaking Changes
- N/A (initial release)
