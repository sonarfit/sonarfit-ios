# SonarFit SDK v1.0.0

## 📦 Distribution
- **File**: SonarFitSDK-1.0.0.xcframework.zip
- **Checksum**: a27df9b9bd7dabb435056c10d6cf5758ca862fe256c39edb96ede6ffb628c741
- **Size**: ~25MB

## 📋 Package.swift Usage
```swift
.binaryTarget(
    name: "SonarFitSDK",
    url: "https://github.com/sonarfit/sonarfit-ios/releases/download/v1.0.0/SonarFitSDK-1.0.0.xcframework.zip",
    checksum: "a27df9b9bd7dabb435056c10d6cf5758ca862fe256c39edb96ede6ffb628c741"
)
```

## 🎯 Supported Platforms
- iOS Device (arm64)
- iOS Simulator (arm64 + x86_64)

## 📱 What's Included
- Complete SonarFit SDK
- 5 ML Models (compiled .mlmodelc)
- Audio Resources
- All Swift Modules

## 🚀 Quick Start

### Swift Package Manager
1. Add package: `https://github.com/sonarfit/sonarfit-ios`
2. Import: `import SonarFitSDK`
3. Use: `SonarFitSDKVersion.current`

### Manual Integration
1. Download XCFramework
2. Drag into Xcode project
3. Set to "Embed & Sign"

## 📋 Requirements
- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

## 🔧 Known Issues
- None at initial release

## 📞 Support
- Issues: https://github.com/sonarfit/sonarfit-ios/issues
- Docs: https://github.com/sonarfit/sonarfit-ios/blob/main/INTEGRATION.md