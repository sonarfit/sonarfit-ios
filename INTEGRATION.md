# SonarFit SDK Integration Guide

Complete guide to integrating the SonarFit SDK into your iOS and watchOS applications.

## Table of Contents
- [Installation](#installation)
- [Quick Start](#quick-start)
- [iOS Integration](#ios-integration)
- [watchOS Integration](#watchos-integration)
- [Configuration](#configuration)
- [Examples](#examples)

## Installation

### Swift Package Manager (Recommended)

**One-step installation:**

1. In Xcode, select **File → Add Package Dependencies...**
2. Enter the repository URL:
   ```
   https://github.com/sonarfit/sonarfit-ios
   ```
3. Select **Version** → **Up to Next Major** → **1.1.0**
4. Click **Add Package**
5. Select **SonarFitKit** from the product list
6. Click **Add Package**

**That's it!** The SDK and all its dependencies are automatically configured. No manual framework embedding required.

### Requirements

- **iOS 17.0+** / **watchOS 10.0+**
- **Xcode 16.0+**
- **Swift 5.9+**
- **AirPods Pro/Max** or **Apple Watch** (for motion tracking)

## Quick Start

### 1. Initialize the SDK

In your app's main file (e.g., `YourApp.swift`):

```swift
import SwiftUI
import SonarFitKit

@main
struct YourApp: App {

    init() {
        SonarFitSDK.initialize(apiKey: "your_api_key_here") { success, error in
            if success {
                print("SonarFit SDK initialized")
            } else {
                print("Failed: \(error?.localizedDescription ?? "Unknown error")")
            }
        }

        let theme = SonarFitTheme(colors: SonarFitTheme.Colors(
            primary: UIColor.systemBlue,
            accent: UIColor.systemOrange,
            background: UIColor.systemBackground,
            textPrimary: UIColor.label,
            textSecondary: UIColor.secondaryLabel,
            success: UIColor.systemGreen,
            error: UIColor.systemRed
        ))
        SonarFitSDK.configure(theme: theme, debugMode: true)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

### 2. Add Permissions

Add these to your **Info.plist**:

```xml
<key>NSMotionUsageDescription</key>
<string>We use motion sensors to count your workout reps</string>

<key>NSHealthShareUsageDescription</key>
<string>We use HealthKit to track your workouts</string>

<key>NSHealthUpdateUsageDescription</key>
<string>We save workout data to HealthKit</string>
```

## iOS Integration

### SwiftUI

Use the `.sonarFitWorkout()` modifier:

```swift
import SwiftUI
import SonarFitKit

struct WorkoutView: View {
    @State private var showWorkout = false

    var body: some View {
        VStack {
            Text("Ready to workout?")

            Button("Start Squats") {
                showWorkout = true
            }
            .buttonStyle(.borderedProminent)
        }
        .sonarFitWorkout(
            config: WorkoutConfig(
                workoutType: .squat,
                sets: 3,
                reps: 10,
                restTime: 60,
                deviceType: .airpods
            ),
            isPresented: $showWorkout,
            onCompletion: { result in
                guard let result = result else { return }
                print("Workout \(result.status)")
                print("Completed \(result.totalRepsCompleted)/\(result.totalTargetReps) reps")
            },
            onPermissionError: { error in
                print("Permission error: \(error.localizedDescription)")
            }
        )
    }
}
```

### UIKit

Use the static `startWorkout()` method:

```swift
import UIKit
import SonarFitKit

class WorkoutViewController: UIViewController {

    @IBAction func startWorkoutTapped(_ sender: UIButton) {
        let config = WorkoutConfig(
            workoutType: .squat,
            sets: 3,
            reps: 10,
            restTime: 60,
            deviceType: .airpods
        )

        SonarFit.startWorkout(
            config: config,
            from: self,
            onCompletion: { result in
                guard let result = result else { return }
                print("Workout completed!")
                print("Total reps: \(result.totalRepsCompleted)")
                print("Duration: \(result.totalDuration)s")
            },
            onPermissionError: { error in
                self.showAlert(title: "Error", message: error.localizedDescription)
            }
        )
    }
}
```

## watchOS Integration

### Simple Watch App

Your Watch app's `ContentView.swift`:

```swift
import SwiftUI
import SonarFitKit

@main
struct YourWatchApp: App {
    var body: some Scene {
        WindowGroup {
            SonarFitWatchMainView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        SonarFitWatchMainView()
    }
}
```

**That's it!** The pre-built Watch UI handles everything:
- Exercise selection
- Set/rep configuration
- Real-time rep counting
- Rest timers
- Workout summary

## Configuration

### Workout Types

```swift
WorkoutType.squat
WorkoutType.benchpress
WorkoutType.deadlift
```

### Device Types

```swift
DeviceType.airpods  // AirPods Pro/Max
DeviceType.watch    // Apple Watch
DeviceType.none     // Auto-detect
```

### Workout Configuration

```swift
let config = WorkoutConfig(
    workoutType: .squat,         // Exercise type
    sets: 3,                     // Number of sets
    reps: 10,                    // Target reps per set
    restTime: 60,                // Rest between sets (seconds)
    countdownDuration: 3,        // Countdown before each set
    autoReLift: true,            // Auto-start next set
    deviceType: .airpods         // Motion tracking device
)
```

### Theme Customization

```swift
let theme = SonarFitTheme(colors: SonarFitTheme.Colors(
    primary: UIColor.systemIndigo,
    accent: UIColor.systemPink,
    background: UIColor.systemBackground,
    textPrimary: UIColor.label,
    textSecondary: UIColor.secondaryLabel,
    success: UIColor.systemGreen,
    error: UIColor.systemRed
))

SonarFitSDK.configure(theme: theme, debugMode: false)
```

## Examples

### Example 1: Multiple Workouts

```swift
struct WorkoutListView: View {
    @State private var selectedWorkout: WorkoutType?
    @State private var showWorkout = false

    let workouts: [(WorkoutType, String)] = [
        (.squat, "Squats"),
        (.benchpress, "Bench Press"),
        (.deadlift, "Deadlifts")
    ]

    var body: some View {
        List(workouts, id: \.0) { workout in
            Button(action: {
                selectedWorkout = workout.0
                showWorkout = true
            }) {
                Text(workout.1)
            }
        }
        .sonarFitWorkout(
            config: WorkoutConfig(
                workoutType: selectedWorkout ?? .squat,
                sets: 3,
                reps: 10,
                deviceType: .airpods
            ),
            isPresented: $showWorkout,
            onCompletion: { result in
                guard let result = result else { return }
                print("Completed: \(result.totalRepsCompleted) reps")
            }
        )
    }
}
```

### Example 2: Custom Rest Times

```swift
let beginnerConfig = WorkoutConfig(
    workoutType: .squat,
    sets: 3,
    reps: 8,
    restTime: 90,
    deviceType: .airpods
)

let advancedConfig = WorkoutConfig(
    workoutType: .squat,
    sets: 5,
    reps: 12,
    restTime: 45,
    deviceType: .airpods
)
```

### Example 3: Result Handling

```swift
.sonarFitWorkout(
    config: config,
    isPresented: $showWorkout,
    onCompletion: { result in
        guard let result = result else { return }

        switch result.status {
        case .completed:
            print("Perfect! All sets completed")
            print("Total reps: \(result.totalRepsCompleted)")
            print("Duration: \(result.totalDuration)s")

        case .stoppedEarly:
            let percentage = result.completionPercentage * 100
            print("Good effort! \(Int(percentage))% complete")
        }

        for (index, set) in result.sets.enumerated() {
            print("Set \(index + 1): \(set.repsCompleted) reps")
        }
    }
)
```

### Example 4: Apple Watch Workouts

```swift
struct WatchWorkoutView: View {
    @State private var showWorkout = false

    var body: some View {
        Button("Start Watch Workout") {
            showWorkout = true
        }
        .sonarFitWorkout(
            config: WorkoutConfig(
                workoutType: .squat,
                sets: 3,
                reps: 10,
                restTime: 60,
                deviceType: .watch
            ),
            isPresented: $showWorkout,
            onCompletion: { result in
                guard let result = result else { return }
                print("Watch workout completed")
            }
        )
    }
}
```

## Troubleshooting

### "No such module 'SonarFitKit'"

Make sure you've added the package dependency and selected **SonarFitKit** from the product list.

### Motion Tracking Not Working

1. Ensure permissions are granted in Info.plist
2. Check that AirPods Pro/Max or Apple Watch are connected
3. Verify correct `deviceType` in WorkoutConfig
4. Enable debug mode to see sensor status:
   ```swift
   SonarFitSDK.configure(theme: theme, debugMode: true)
   ```

### Build Errors After Update

1. **Clean build folder**: Product → Clean Build Folder (Cmd+Shift+K)
2. **Reset package cache**: File → Packages → Reset Package Caches
3. **Update packages**: File → Packages → Update to Latest Package Versions

### Package Resolution Issues

If SPM can't resolve the package:

1. Check your internet connection
2. Verify the repository URL is correct
3. Try removing and re-adding the package
4. Check Xcode's account settings for GitHub access

## Migration from v1.0.x

If you're upgrading from v1.0.x:

### What Changed

- **Installation**: Now uses Swift Package Manager for simplified setup
- **Import statement**: Still `import SonarFitKit` (no change for clients!)
- **API**: Fully backward compatible - no code changes needed

### How to Upgrade

1. Update package version to `1.1.0` in Xcode
2. Clean build folder
3. Rebuild project

That's it! Your existing code continues to work without any changes.

## Support

- **Email**: support@sonarfit.com
- **Issues**: [GitHub Issues](https://github.com/sonarfit/sonarfit-ios/issues)
- **API Reference**: [Documentation](https://sonarfit.github.io/sonarfit-ios/)

## What's Next?

- Check out the [Examples](Examples/) folder for complete sample apps
- Read the [CHANGELOG](CHANGELOG.md) for latest updates
- Join our community for tips and support

---

© 2025 SonarFit. All rights reserved.
