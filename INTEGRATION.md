# SonarFit SDK Integration Guide

Complete guide for integrating the SonarFit AI fitness tracking SDK into your iOS application.

## 📋 Prerequisites

- **iOS 17.0+**
- **Xcode 15.0+**
- **Swift 5.9+**

## 🚀 Installation

### Method 1: Swift Package Manager (Recommended)

1. **In Xcode**: File → Add Package Dependencies
2. **Enter URL**: `https://github.com/sonarfit/sonarfit-ios`
3. **Dependency Rule**: "Up to Next Major Version"
4. **Version**: `1.0.0` (or latest)
5. **Add to Target**: Select your app target

### Method 2: Manual XCFramework

1. Download `SonarFitSDK.xcframework.zip` from [Releases](https://github.com/sonarfit/sonarfit-ios/releases)
2. Unzip and drag `SonarFitSDK.xcframework` into your Xcode project
3. Select "Copy items if needed"
4. Project Settings → General → "Frameworks, Libraries, and Embedded Content"
5. Set framework to "Embed & Sign"

## ⚙️ Configuration

### 1. Privacy Permissions

In Xcode, select your app target → **Info** tab → **Custom iOS Target Properties**:

1. Click **+** to add new key
2. Key: `Privacy - Motion Usage Description`
3. Value: `This app uses motion sensors to track your workout reps and provide real-time feedback`

## ⚙️ Required Setup

### iPhone App (Required)

**Capabilities** - In your iOS app target, enable:
- ☑️ Background Modes (Background fetch + Background processing)
- ☑️ HealthKit (HealthKit Background Delivery)

### Apple Watch Integration (Optional)

**If you want Apple Watch support:**

1. **Add Watch App target** to your project
2. **Add SonarFitSDK** to Watch App target
3. **Enable Watch App capabilities:**
   - ☑️ Background Modes (Workout processing, type: Self Care)
   - ☑️ HealthKit (HealthKit Background Delivery)

**If you only use AirPods:** Skip the Watch App setup entirely.

### 2. Initialize SDK

```swift
import SonarFitSDK

@main
struct MyFitnessApp: App {
    init() {
        // Initialize with your API key
        SonarFitSDK.initialize(apiKey: "sk_live_your_api_key_here") { success, error in
            if success {
                print("✅ SonarFit SDK initialized")
                // Optional: Configure additional settings
                SonarFitSDK.configure(debugMode: true)
            } else {
                print("❌ SDK init failed: \(error?.localizedDescription ?? "Unknown")")
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
```

## 💪 Workout Integration

### Basic Workout Setup

```swift
import SwiftUI
import SonarFitSDK

struct ContentView: View {
    @State private var showWorkout = false

    var body: some View {
        VStack(spacing: 20) {
            Button("Start Squat Workout") {
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
                    // Handle workout results
                },
                onPermissionError: { error in
                    print("Permission error: \(error.localizedDescription)")
                    // Handle permission issues
                }
            )
        }
        .padding()
    }
}
```

### Workout Configuration Options

```swift
WorkoutConfig(
    workoutType: .squat,          // .squat, .benchPress, etc.
    sets: 3,                      // Number of sets
    reps: 10,                     // Reps per set
    restTime: 60,                 // Rest between sets (seconds)
    countdownDuration: 3,         // Countdown before starting (seconds)
    autoReLift: false,           // Auto-start lifting when rest timer completes
    deviceType: .airpods         // .airpods or .watch
)
```

### autoReLift Parameter

- **`true`**: Automatically starts the next set when rest timer completes
- **`false`**: User must tap "Start" on watch or phone to begin next set

### Available Workout Types

- `.squat` - Squat exercises
- `.benchPress` - Bench press exercises
- `.deadlift` - Deadlift exercises

### Device Types

- `.airpods` - Use AirPods motion sensors (recommended)
- `.watch` - Use Apple Watch sensors (requires watch app)

## 🎨 Theming (Optional)

Customize the SDK appearance with your brand colors:

```swift
// Create custom theme
let customTheme = SonarFitTheme(
    colors: SonarFitTheme.Colors(
        primary: UIColor.systemBlue,      // Main accent color
        accent: UIColor.systemTeal,       // Secondary accent
        background: UIColor.systemBackground,
        textPrimary: UIColor.label,
        textSecondary: UIColor.secondaryLabel,
        success: UIColor.systemGreen,     // Rep completion
        error: UIColor.systemRed          // Error states
    ),
    typography: SonarFitTheme.Typography(
        titleFont: UIFont.systemFont(ofSize: 20, weight: .semibold),
        bodyFont: UIFont.systemFont(ofSize: 16, weight: .regular),
        captionFont: UIFont.systemFont(ofSize: 12, weight: .regular)
    )
)

// Configure SDK with custom theme
SonarFitSDK.configure(theme: customTheme, debugMode: false)

// Or update theme at runtime
SonarFitSDK.updateTheme(customTheme)
```

## ⌚ Apple Watch Integration (Optional)

### 1. Add Watch App Target

1. **File** → **New** → **Target** → **Watch App**
2. **Add SonarFitSDK** to Watch App target

### 2. Enable SonarFit in Your Watch App

For existing Watch apps, add one line:

```swift
import SwiftUI
import SonarFitSDK

struct ContentView: View {
    var body: some View {
        Text("My Watch App")
            .enableSonarFitWorkouts()  // ← Add this line!
    }
}
```

For dedicated fitness Watch apps:

```swift
import SwiftUI
import SonarFitSDK

struct ContentView: View {
    var body: some View {
        SonarFitWatchMainView()  // Complete workout interface
    }
}
```

The watch app will automatically sync workout data with iPhone and provide haptic feedback during exercises.

---

## 📚 API Reference

### WorkoutConfig

Configuration object for workout sessions:

```swift
struct WorkoutConfig {
    let workoutType: WorkoutType       // Exercise type
    let sets: Int                      // Number of sets
    let reps: Int                      // Target reps per set
    let restTime: TimeInterval         // Rest between sets (seconds)
    let countdownDuration: TimeInterval // Countdown before each set
    let autoReLift: Bool              // Auto-start next set after rest
    let deviceType: DeviceType        // Motion sensor device
}
```

### WorkoutType

Available exercise types:

```swift
enum WorkoutType {
    case squat      // Squat exercises
    case benchPress // Bench press exercises
    case deadlift   // Deadlift exercises
}
```

### DeviceType

Motion sensor options:

```swift
enum DeviceType {
    case airpods    // AirPods motion sensors
    case watch      // Apple Watch sensors
}
```

### WorkoutResult

Workout completion data:

```swift
struct WorkoutResult {
    let workoutType: WorkoutType
    let status: WorkoutStatus
    let completionPercentage: Double    // 0.0 - 1.0
    let totalRepsCompleted: Int
    let totalTargetReps: Int
    let totalDuration: TimeInterval     // Total workout time
    let setResults: [SetResult]         // Per-set breakdown
}
```

### WorkoutStatus

Workout completion states:

```swift
enum WorkoutStatus {
    case completed      // Workout finished successfully
    case cancelled      // User cancelled workout
    case error(Error)   // Workout failed with error
}
```

### SetResult

Individual set performance:

```swift
struct SetResult {
    let setNumber: Int
    let targetReps: Int
    let completedReps: Int
    let duration: TimeInterval
    let restDuration: TimeInterval?
}
```

### SonarFitSDK Class

Main SDK interface:

```swift
class SonarFitSDK {
    // Initialize SDK with API key
    static func initialize(apiKey: String, completion: @escaping (Bool, Error?) -> Void)

    // Configure SDK options
    static func configure(theme: SonarFitTheme? = nil, debugMode: Bool = false)

    // Update theme at runtime
    static func updateTheme(_ theme: SonarFitTheme)

    // Enable debug logging
    static var enableDebugLogging: Bool { get set }
}
```

### Error Handling

SDK error types:

```swift
enum SDKError: Error {
    case invalidAPIKey              // API key format incorrect
    case networkError(Error)        // Network connectivity issues
    case permissionDenied          // Motion permissions not granted
    case deviceNotSupported        // Device doesn't support selected type
    case workoutInProgress         // Another workout already active
}
```

### SonarFitTheme

Customize SDK appearance:

```swift
struct SonarFitTheme {
    let colors: Colors
    let typography: Typography

    struct Colors {
        let primary: UIColor        // Main accent color
        let accent: UIColor         // Secondary accent
        let background: UIColor     // Background color
        let textPrimary: UIColor    // Primary text
        let textSecondary: UIColor  // Secondary text
        let success: UIColor        // Success states
        let error: UIColor          // Error states
    }
}
```

---

## 📋 Requirements

- **iOS 17.0+**
- **Xcode 15.0+**
- **Swift 5.9+**
- **AirPods or Apple Watch** for motion tracking
- **Valid API Key** from SonarFit

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
