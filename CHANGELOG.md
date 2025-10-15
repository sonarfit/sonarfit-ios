# Changelog

All notable changes to the SonarFit iOS SDK will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2024-10-15

### Added
- Initial release of SonarFit iOS SDK
- AI-powered exercise recognition with 5 ML models
- Real-time workout tracking and form analysis
- SwiftUI integration with workout UI
- Support for multiple workout types:
  - Bench press
  - Additional exercises (more coming soon)
- Comprehensive audio feedback system
- Rest timer functionality with pause/resume
- Version management system
- XCFramework distribution for easy integration

### Technical Details
- **Platform**: iOS 17.0+
- **Swift**: 5.9+
- **Size**: ~25MB (includes ML models and audio resources)
- **Architecture**: arm64 (device), arm64 + x86_64 (simulator)
- **Distribution**: XCFramework via Swift Package Manager

### Included Components
- 5 compiled ML models (.mlmodelc)
- Audio resources for workout guidance
- Complete SwiftUI workout interface
- Version tracking and SDK information
- Comprehensive error handling and logging

### Known Issues
- None at initial release

### Breaking Changes
- N/A (initial release)