# SonarFit iOS SDK

Automatic rep counting from motion sensors — for iOS and Apple Watch apps. **On-device. Works offline. Your UI or ours.**

## What it does

Add automatic rep counting to any iOS or watchOS app. SonarFit detects and counts exercise reps from Apple Watch or AirPods Pro/Max motion sensors, in real time. Drop in our workout UI, or run it headless and feed the live rep count into your own screens.

- **Apple Watch** — squats, deadlifts, bench press, shoulder press, bicep curls
- **AirPods Pro/Max** — squats, deadlifts

## On-device & offline

**Detection is 100% on-device.** Motion sensing and rep counting run locally on the watch/phone, and detection has **no network dependency** — it works in a basement gym with no signal, and nothing is sent *during* a workout.

**It works offline from the very first launch.** Your API key contains a signed licence the SDK verifies locally — there's no activation call to make. A brand-new install in airplane mode initialises and counts reps. When the device is next online, the licence renews silently in the background (valid 90 days between renewals, so an offline stretch never interrupts anyone).

### What leaves the device

- **Usage summary (for billing):** a small, **anonymous** count of workouts plus the SDK version, with an anonymous device identifier so we can count unique users. No names, accounts, or health data.
- **Raw motion recordings (optional, for detection improvement):** if enabled under your integration agreement, the SDK uploads per-set motion recordings to improve rep-detection accuracy. This is configurable per client and can be turned off — no personally-identifying data, and never during a workout.

> **Privacy-first app?** On the **privacy tier**, both are off: usage is an anonymous **aggregate** count with **no device identifier**, and **no raw motion is collected** — nothing identifying a user or device leaves the device. Ask us to enable it for your account.

## Quick start — your own UI (headless)

No SonarFit UI. Create a workout, observe the live rep count, read the result.

```swift
import SonarFitKit

// Once, at launch — the key carries the offline licence.
SonarFitSDK.initialize(apiKey: "sk_live_…") { success, error in }

// Per exercise: your UI, our counting.
let workout = try SonarFit.createWorkout(
    config: WorkoutConfig(workoutType: .squat, sets: 1, reps: 10, deviceType: .watch)
)
workout.start()

// SwiftUI: observe the published rep count as it increments.
Text("\(workout.currentSetRepsCompleted) / \(workout.config.reps)")

// Or UIKit / any framework: conform to the delegate for rep + set-complete callbacks.
```

Pass a target `reps` and the SDK stops counting once it's hit — no post-set over-reporting. You drive everything else in your own flow.

## Quick start — pre-built UI

Prefer a ready-made workout screen? One modifier:

```swift
Button("Start Workout") { showWorkout = true }
.sonarFitWorkout(
    config: WorkoutConfig(workoutType: .squat, sets: 3, reps: 10, deviceType: .airpods),
    isPresented: $showWorkout
) { result in
    print("Workout completed!")
}
```

## Installation

Swift Package Manager:

1. Xcode → **File → Add Package Dependencies…**
2. URL: `https://github.com/sonarfit/sonarfit-ios`
3. **Up to Next Major** → **2.5.0**
4. Add **SonarFitKit**.

```swift
import SonarFitKit   // single import, all modules included
```

## Requirements

- **iOS 17.0+** / **watchOS 10.0+**, **Xcode 16.0+**, **Swift 5.9+**
- **Apple Watch or AirPods Pro/Max** for motion tracking (a physical device — motion isn't available in the Simulator)
- HealthKit + Background Modes capabilities ([checklist in the Integration Guide](INTEGRATION.md))

## Get started

- 👉 **[Integration Guide](INTEGRATION.md)** — full setup, headless + pre-built, watchOS companion
- 👉 **[Examples](Examples/)** — copy-paste SwiftUI and UIKit
- 📚 **[API Reference](https://sonarfit.github.io/sonarfit-ios/)**

## Support

- 📧 support@sonarfit.com
- 🐛 [GitHub Issues](https://github.com/sonarfit/sonarfit-ios/issues)

## License

© 2026 SonarFit. All rights reserved. Commercial SDK — [get a key](https://sonarfit.com).
