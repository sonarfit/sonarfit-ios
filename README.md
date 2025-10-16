# SonarFit iOS SDK

AI-powered fitness tracking and workout analysis SDK for iOS applications.

## 🚀 Quick Start

### Swift Package Manager

In Xcode:
1. **File** → **Add Package Dependencies**
2. Enter URL: `https://github.com/sonarfit/sonarfit-ios`
3. Select version: `1.0.0` (or latest)
4. Add to your target

### Manual XCFramework

1. Download `SonarFitSDK.xcframework.zip` from [Releases](https://github.com/sonarfit/sonarfit-ios/releases)
2. Drag into your Xcode project and select "Copy items if needed"
3. Set to "Embed & Sign" in Project Settings → General → Frameworks

## 💻 Setup & Usage

### 1. Initialize SDK
```swift
import SonarFitSDK

// In your App struct or main view
SonarFitSDK.initialize()
```

### 2. Add Privacy Permissions
Add to your `Info.plist`:
```xml
<key>NSMotionUsageDescription</key>
<string>This app uses motion data to track workout form and repetitions</string>
<key>NSMicrophoneUsageDescription</key>
<string>This app uses microphone to provide audio feedback during workouts</string>
```

### 3. Basic Workout Integration
```swift
import SwiftUI
import SonarFitSDK

struct ContentView: View {
    @State private var showWorkout = false

    var body: some View {
        VStack {
            Button("Start Workout") {
                showWorkout = true
            }
            .sonarFitWorkout(
                config: WorkoutConfig(
                    workoutType: .squat,
                    sets: 3,
                    reps: 10,
                    restTime: 60,
                    countdownDuration: 3,
                    autoReLift: false,
                    deviceType: .airpods
                ),
                isPresented: $showWorkout,
                onCompletion: { result in
                    guard let result = result else {
                        print("Workout dismissed")
                        return
                    }
                    print("Workout completed: \(result.status)")
                },
                onPermissionError: { error in
                    print("Permission error: \(error.localizedDescription)")
                }
            )
        }
    }
}
```

### 4. Theming (Optional)
```swift
// Apply custom theme
SonarFitTheme.apply()
```

### 5. Check SDK Version
```swift
print("SonarFit SDK Version: \(SonarFitSDKVersion.current)")
```

## 📋 Requirements

- **iOS 17.0+**
- **Xcode 15.0+**
- **Swift 5.9+**

## 🏋️ Features

- AI-powered exercise recognition
- Real-time form analysis
- Multiple workout types supported
- Comprehensive workout tracking
- SwiftUI integration

## 📖 Documentation

- [Integration Guide](https://github.com/sonarfit/sonarfit-ios/blob/main/INTEGRATION.md)
- [API Reference](https://sonarfit.github.io/sonarfit-ios/)
- [Example Projects](https://github.com/sonarfit/sonarfit-ios/tree/main/Examples)

## 🔧 Troubleshooting

### Common Issues
- Ensure deployment target is iOS 17.0+
- Clean build folder if needed
- Verify framework is "Embed & Sign"

See [Integration Guide](https://github.com/sonarfit/sonarfit-ios/blob/main/INTEGRATION.md) for detailed troubleshooting.

## 📞 Support

- 🐛 [Issues](https://github.com/sonarfit/sonarfit-ios/issues)
- 📧 Email: support@sonarfit.com
- 📚 [Documentation](https://sonarfit.github.io/sonarfit-ios/)

## 📄 License

© 2024 SonarFit. All rights reserved.