# SonarFit iOS SDK Examples

Example projects demonstrating how to integrate and use the SonarFit iOS SDK.

## 🚀 Quick Test Example

Create a new iOS app and test the SDK integration:

```swift
import SwiftUI
import SonarFitSDK

@main
struct TestApp: App {
    init() {
        SonarFitSDK.initialize()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @State private var showWorkout = false

    var body: some View {
        VStack(spacing: 20) {
            Text("SonarFit SDK Test")
                .font(.largeTitle)

            Text("Version: \(SonarFitSDKVersion.current)")
                .font(.caption)
                .foregroundColor(.secondary)

            Button("Start Test Workout") {
                showWorkout = true
            }
            .buttonStyle(.borderedProminent)
            .sonarFitWorkout(
                config: WorkoutConfig(
                    workoutType: .squat,
                    sets: 2,
                    reps: 5,
                    restTime: 30,
                    countdownDuration: 3,
                    autoReLift: false,
                    deviceType: .phone
                ),
                isPresented: $showWorkout,
                onCompletion: { result in
                    print("Test workout completed: \(result?.status ?? "dismissed")")
                },
                onPermissionError: { error in
                    print("Permission error: \(error.localizedDescription)")
                }
            )
        }
        .padding()
    }
}
```

## 📋 Setup Steps

1. **Add Package**: `https://github.com/sonarfit/sonarfit-ios`
2. **Add Privacy Permissions**: See [Integration Guide](../INTEGRATION.md)
3. **Copy Example**: Use code above
4. **Test**: Run on device/simulator

## 📱 Full Examples Coming Soon

- **BasicIntegration** - Complete app with multiple workout types
- **WorkoutCustomization** - Advanced configuration options
- **WatchApp** - Watch connectivity integration

## 📞 Need Help?

- [Integration Guide](../INTEGRATION.md)
- [Issues](https://github.com/sonarfit/sonarfit-ios/issues)