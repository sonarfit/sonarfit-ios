# Changelog

All notable changes to the SonarFit iOS SDK will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
