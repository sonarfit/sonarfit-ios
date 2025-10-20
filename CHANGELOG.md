# Changelog

All notable changes to the SonarFit iOS SDK will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
