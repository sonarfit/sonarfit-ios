# SonarFit SDK Integration Guide

Complete guide to integrating the SonarFit SDK into your iOS and watchOS applications.

## On-device & offline

Rep detection runs **entirely on-device** — motion sensing and counting happen locally on
the watch/phone, and detection works **offline**: your API key carries a signed licence the
SDK verifies locally, so there's no activation call and a first launch with no connection
still initialises and counts reps. Nothing is sent during a workout.

For billing, the SDK sends an anonymous workout count (no user identity). On the **privacy
tier** that's an aggregate count with no device identifier. See the
[README](README.md#what-leaves-the-device) for the breakdown.

## How long does it take?

**A basic iOS integration typically takes 30–60 minutes:** add the Swift package,
enable the required capabilities (motion permission, HealthKit, Background Modes — see
the checklist below), initialize the SDK with your API key, and drop in one workout view.
Add roughly **30 minutes** for an Apple Watch companion.

Budget extra time for **on-device testing**: motion tracking needs a physical device with
AirPods Pro/Max or an Apple Watch — it can't run in the Simulator. Requesting an API key
(at [sonarfit.com](https://sonarfit.com)) is a separate, one-time step and isn't counted
in the times above. The key works immediately, including offline — there's nothing to
activate over the network.

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
3. Select **Version** → **Up to Next Major** → **2.5.0**
4. Click **Add Package**
5. Select **SonarFitKit** from the product list
6. Click **Add Package**

**That's it!** The SDK and all its dependencies are automatically configured. No manual framework embedding required.

### Requirements

- **iOS 17.0+** / **watchOS 10.0+**
- **Xcode 16.0+**
- **Swift 5.9+**
- **AirPods Pro/Max** or **Apple Watch** (for motion tracking)
- **HealthKit capability** (required for workout session management)
- **Background Modes** (required for continuous tracking)

### Quick Setup Checklist

**iOS App:**
- ✅ Add NSMotionUsageDescription to Info.plist
- ✅ Enable HealthKit capability (with Background Delivery)
- ✅ Add Background Modes: fetch, processing
- ✅ Import SonarFitKit in your code

**watchOS App (if applicable):**
- ✅ Enable HealthKit capability (with Background Delivery)
- ✅ Add WKBackgroundModes: self-care, workout-processing
- ✅ Import SonarFitKit in your code

## Quick Start

### 1. Initialize the SDK

In your app's main file (e.g., `YourApp.swift`):

```swift
import SwiftUI
import SonarFitKit

@main
struct YourApp: App {

    init() {
        // The API key carries a signed offline licence — this verifies
        // locally, so init succeeds with no network, even on a first launch
        // in airplane mode. When online, the licence renews silently.
        SonarFitSDK.initialize(apiKey: "your_api_key_here") { success, error in
            if success {
                print("SonarFit SDK initialized")
            } else {
                print("Failed: \(error?.localizedDescription ?? "Unknown error")")
            }
        }

        let theme = SonarFitTheme(colors: SonarFitTheme.Colors(
            background: UIColor.systemBackground,
            primary: UIColor.systemBlue,
            textOnBackground: UIColor.label,
            subtextOnBackground: UIColor.secondaryLabel,
            textOnPrimary: UIColor.white,
            timerWarning: UIColor.systemOrange
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

### 2. Configure iOS App Requirements

**A. Add Privacy Usage Description**

Add to your **Info.plist** or target settings:

```xml
<key>NSMotionUsageDescription</key>
<string>This app uses motion sensors to track your workout reps and provide real-time feedback</string>
```

**B. Enable HealthKit Capability**

1. Select your iOS app target
2. Go to **Signing & Capabilities**
3. Click **+ Capability**
4. Add **HealthKit**
5. Enable **Background Delivery** under HealthKit

**C. Add Background Modes**

In your **Info.plist**:

```xml
<key>UIBackgroundModes</key>
<array>
    <string>fetch</string>
    <string>processing</string>
</array>
```

**D. Entitlements**

Your app should have these entitlements (automatically added when you enable HealthKit):

```xml
<key>com.apple.developer.healthkit</key>
<true/>
<key>com.apple.developer.healthkit.background-delivery</key>
<true/>
```

### 3. Configure watchOS App Requirements (If Using Watch)

**A. Enable HealthKit Capability**

1. Select your Watch app target
2. Go to **Signing & Capabilities**
3. Click **+ Capability**
4. Add **HealthKit**
5. Enable **Background Delivery** under HealthKit

**B. Add Watch Background Modes**

In your **Watch App Info.plist**:

```xml
<key>WKBackgroundModes</key>
<array>
    <string>self-care</string>
    <string>workout-processing</string>
</array>
```

**C. Watch Entitlements**

Your Watch app should have these entitlements (automatically added when you enable HealthKit):

```xml
<key>com.apple.developer.healthkit</key>
<true/>
<key>com.apple.developer.healthkit.background-delivery</key>
<true/>
```

**Note:** watchOS apps do NOT need NSMotionUsageDescription

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

## Running inside your own HKWorkoutSession (host-session mode)

If your **watch app already owns an `HKWorkoutSession`** (heart rate, active energy, saving to
Apple Fitness), SonarFit can run inside it. watchOS allows one active workout session per
process, so in this mode SonarFit never creates, pauses, ends or takes the delegate of any
session, writes nothing to HealthKit, and does not use session mirroring. Your session supplies
the background wake lock; SonarFit talks to the phone over WatchConnectivity.

**Watch target** — once at launch, before `enableSonarFitWorkouts()`:

```swift
SonarFit.configureWatchSession(.hostProvided(current: { MyWorkoutManager.shared.session }))
```

Optional but recommended, from your own `HKWorkoutSessionDelegate`, so SonarFit can flush an
active set if you pause or end mid-set:

```swift
func workoutSession(_ session: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState,
                    from fromState: HKWorkoutSessionState, date: Date) {
    SonarFit.hostWorkoutSession(session, didChangeTo: toState, from: fromState)
}
```

**iOS target** — declare the same ownership at init:

```swift
SonarFitSDK.initialize(apiKey: "sk_live_...", watchSessionOwnership: .hostProvided) { ok, error in }
```

Rules in this mode:
- Your session must be **running** when the user starts a SonarFit set. Otherwise Start is
  refused with `SonarFitWatchSessionError.hostSessionNotRunning` (published on the watch as
  `WatchWorkoutSessionManager.shared.lastStartError`, logged on the phone as a watch error).
- Workouts start **on the watch**. `SonarFit.launchWatchApp(config:)` /
  `launchWatchAndStart()` throw `WatchLaunchError.unsupportedInHostSessionMode`.
- Configure **both** targets; the phone logs a warning at the start handshake if they differ.
- Leave the mode at its default (`.sdkOwned`) if SonarFit should manage the session itself.

### Headless rep detection (your Watch UI, SonarFit as a rep stream)

If your Watch app owns the whole workout flow — sets, rest timers, its own screens — use headless
detection instead of `enableSonarFitWorkouts()`. SonarFit shows no UI and keeps no set or rest
state; it counts reps between your start and your stop. It runs inside a workout session: your
own (host-session mode, above) or one SonarFit opens for you (see "If your Watch app does not own
a workout session" below).

```swift
// Watch target, per set
let detection = try SonarFit.startRepDetection(
    exercise: .bicepCurl,          // SonarFit.supportedWatchExercises; others throw .unsupportedExercise
    targetReps: 10,                // required: the set's target from your UI
    onRep: { count in viewModel.reps = count },          // running count, main queue
    onTargetReached: { viewModel.completeSet() }         // optional auto-complete
)

let result = detection.stop()      // when you decide the set is done
result.reps                        // the set's rep count — a rep in flight at the tap is included,
                                   // nothing after the tap ever is
detection.cancel()                 // or discard the set entirely
```

One detection at a time: starting another before `stop()` or `cancel()` throws
`detectionAlreadyActive`. Supported exercises today: squat, deadlift, bench press, shoulder press,
bicep curl.

**Goals instead of a bare number.** If your programme uses a rep range, or the set has no
target, pass a goal:

```swift
try SonarFit.startRepDetection(exercise: .squat, goal: .range(lo: 8, hi: 12), onRep: { … })
try SonarFit.startRepDetection(exercise: .squat, goal: .open, onRep: { … })   // count until stop()
```

`.fixed(n)` is identical to `targetReps: n`. With a range, the count keeps climbing past the low
end and stops at the high end; `onTargetReached` fires at the low end. `.open` counts until you
stop. The goal tells SonarFit when the set is expected to end; it never changes which reps are
counted.

**If your Watch app does not own a workout session.** Leave the session mode at its default and
bracket your sets with a headless workout. SonarFit starts its own `HKWorkoutSession` (the
background wake lock, heart rate, and the Fitness save) and one bracket is one workout:

```swift
try SonarFit.startHeadlessWorkout()                          // once, when the user begins
let set = try SonarFit.startRepDetection(exercise: .squat, goal: .fixed(10), onRep: { … })
… set.stop() … more sets …
try SonarFit.endHeadlessWorkout(save: true)                  // once, when the user finishes (false = discard)
```

`startRepDetection` throws `headlessWorkoutNotStarted` outside a bracket in this mode, and the
two bracket calls throw `wrongSessionMode` in host-session mode, where your own running session
is the bracket.

Optionally, on iOS, observe the same stream for your phone UI:

```swift
SonarFit.observeHeadlessDetection { event in
    switch event {
    case .setStarted(let exercise, let targetReps, _): …
    case .rep(let count, _):                            …
    case .setEnded(let result, _):                      … // result.reps
    default: break
    }
}
```

### Native Watch app with a Flutter (or React Native) phone app

Headless watch detection lives entirely in the native Watch target, which links this Swift
package (`SonarFitKit`, watchOS 10+) and uses either path above. The phone app, whatever it is
written in, only has to initialise the SDK with the same key so licensing and usage metering
work: Flutter `SonarFit.initialize(apiKey)` from the `sonarfit_flutter` plugin (2.6.0+), which
also exposes `SonarFit.headlessEvents` if the phone UI should mirror the sets live.

Checklist for this shape:

**Watch target (Swift)**
1. Add this package to the Watch target and `import SonarFitKit`.
2. `SonarFitSDK.initialize(apiKey:)` at launch, with the same key as the phone.
3. Pick the session mode once: `SonarFit.configureWatchSession(.hostProvided(current: { yourSession }))`
   if your app owns the `HKWorkoutSession`; nothing to configure if SonarFit should own it.
4. Per set: `SonarFit.startHeadlessWorkout()` (SonarFit-owned only), then
   `SonarFit.startRepDetection(exercise:goal:onRep:onTargetReached:)`; on finish, `stop()` on
   the returned handle, then `SonarFit.endHeadlessWorkout(save:)` (SonarFit-owned only).
5. The watch shows and buzzes its own count as each rep completes.

**Phone app (Flutter)**
1. `SonarFit.initialize(apiKey)` from `sonarfit_flutter` at launch. That is all the phone must
   do: licensing, usage metering and the upload of each set's recording happen inside the SDK.
2. Optionally listen to `SonarFit.headlessEvents` to mirror set started, live count and set ended.

## Configuration

### Workout Types

```swift
// AirPods Pro/Max or Apple Watch:
WorkoutType.squat
WorkoutType.deadlift

// Apple Watch only:
WorkoutType.benchpress
WorkoutType.shoulderPress
WorkoutType.bicepCurl
```

### Device Types

```swift
DeviceType.airpods  // AirPods Pro/Max
DeviceType.watch    // Apple Watch
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
    background: UIColor.systemBackground,
    primary: UIColor.systemIndigo,
    textOnBackground: UIColor.label,
    subtextOnBackground: UIColor.secondaryLabel,
    textOnPrimary: UIColor.white,
    timerWarning: UIColor.systemPink
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
        (.deadlift, "Deadlifts"),
        // Apple Watch only:
        (.benchpress, "Bench Press"),
        (.shoulderPress, "Shoulder Press"),
        (.bicepCurl, "Bicep Curls")
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

1. **Verify iOS requirements:**
   - NSMotionUsageDescription added to Info.plist
   - HealthKit capability enabled with Background Delivery
   - Background Modes (fetch, processing) added to Info.plist
2. **Verify watchOS requirements (if using Watch):**
   - HealthKit capability enabled with Background Delivery
   - WKBackgroundModes (self-care, workout-processing) added to Watch App Info.plist
3. Check that AirPods Pro/Max or Apple Watch are connected
4. Verify correct `deviceType` in WorkoutConfig
5. Enable debug mode to see sensor status:
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

1. Update package version to `2.5.0` in Xcode
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

© 2026 SonarFit. All rights reserved.
