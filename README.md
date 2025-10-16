# SonarFit iOS SDK

AI-powered fitness tracking and workout analysis SDK for iOS applications.

## 🏋️ What is SonarFit?

Transform any iOS app into a smart fitness coach with AI-powered motion tracking. SonarFit automatically detects and counts exercise reps using AirPods Pro/Max or Apple Watch sensors, providing real-time feedback for squats, bench press, and deadlifts (more to follow).

## ✨ Features

- **🤖 AI-Powered Rep Counting** - Automatic rep detection and counting
- **📱 Multi-Device Support** - AirPods Pro, AirPods Max and Apple Watch integration
- **⏱️ Smart Rest Timers** - Built-in rest periods between sets
- **🔄 Watch Connectivity** - Seamless iPhone-Watch workout sync
- **🎨 Pre-built UI** - Ready-to-use SwiftUI workout interfaces

## 🚀 Quick Integration

```swift
Button("Start Workout") { showWorkout = true }
.sonarFitWorkout(
    config: WorkoutConfig(
        workoutType: .squat,
        sets: 3,
        reps: 10,
        deviceType: .airpods
    ),
    isPresented: $showWorkout
) { result in
    print("Workout completed!")
}
```

## 📋 Requirements

- **iOS 17.0+**
- **Xcode 15.0+**
- **Swift 5.9+**
- **AirPods Pro/Max or Apple Watch** (for motion tracking)

## 🛠️ Supported Exercises

- Squats 
- Bench Press 
- Deadlifts

## 📖 Get Started

**Ready to integrate?** Follow our complete setup guide:

👉 **[Integration Guide](INTEGRATION.md)** - Everything you need to get started

**Want to see it in action?** Check out working examples:

👉 **[Example Code](Examples/)** - Copy-paste ready code

## 📞 Support & Resources

- 🐛 **Issues**: [GitHub Issues](https://github.com/sonarfit/sonarfit-ios/issues)
- 📚 **Documentation**: [Complete API Reference](https://sonarfit.github.io/sonarfit-ios/)
- 📧 **Support**: support@sonarfit.com

## 📄 License

© 2025 SonarFit. All rights reserved.
