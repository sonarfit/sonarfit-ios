# SonarFit SDK Integration Guide

## 🚀 Quick Start

### Method 1: Manual XCFramework (Recommended for Testing)

1. Create a new iOS App project in Xcode
2. Copy `SonarFitSDK.xcframework` to your project directory
3. Drag `SonarFitSDK.xcframework` into your Xcode project
4. Select "Copy items if needed"
5. In Project Settings → General → "Frameworks, Libraries, and Embedded Content"
6. Set to "Embed & Sign"

### Method 2: Swift Package Manager (When Published)

#### In Xcode:
1. **File** → **Add Package Dependencies**
2. Enter URL: `https://github.com/your-org/SonarFitSDK-Binary`
3. Select version: `1.0.0` (or latest)
4. Add to your target

#### In Package.swift (for library targets only):
```swift
dependencies: [
    .package(url: "https://github.com/your-org/SonarFitSDK-Binary", from: "1.0.0")
],
targets: [
    .target(
        name: "YourLibrary",
        dependencies: ["SonarFitSDK"]
    )
]
```

**Note**: SPM with XCFramework works best for library targets, not iOS app targets.

---

## 💻 Basic Usage

### Import the SDK
```swift
import SonarFitSDK
```

### Start a Workout
```swift
import SwiftUI
import SonarFitSDK

struct ContentView: View {
    var body: some View {
        VStack {
            Text("My Fitness App")

            Button("Start Workout") {
                // Launch SonarFit SDK UI
            }
            .sonarFitWorkout(
                workoutType: .benchPress,
                onComplete: { result in
                    print("Workout completed: \(result)")
                }
            )
        }
    }
}
```

### Check SDK Version
```swift
print("SonarFit SDK Version: \(SonarFitSDKVersion.current)")
```

---

## 📋 Requirements

- **iOS 17.0+**
- **Xcode 15.0+**
- **Swift 5.9+**

---

## 🔧 Troubleshooting

### Build Issues
- Ensure your deployment target is iOS 17.0+
- Clean build folder: **Product** → **Clean Build Folder**
- If using Swift Package Manager with XCFramework, ensure you're using a library target, not executable target

### XCFramework Integration Issues
- **Error: "no such module 'SonarFitSDK'"**:
  - For iOS apps: Use manual XCFramework integration instead of SPM
  - For SPM: Only use with library targets, not executable targets
  - XCFramework contains iOS frameworks only, not macOS

### Runtime Issues
- Check device/simulator compatibility (iOS 17.0+)
- Verify framework is properly embedded and signed
- Ensure "Embed & Sign" is selected in project settings

### Common SPM Issues
- **Swift Package executable targets**: Don't work well with iOS XCFrameworks
- **Solution**: Create iOS app project and drag XCFramework manually
- **Alternative**: Use SPM only for library targets that will be consumed by iOS apps

---

## 📞 Support

- Issues: [GitHub Issues](https://github.com/your-org/SonarFitSDK-Binary/issues)
- Docs: [Documentation](https://your-docs-site.com)