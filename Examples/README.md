# SonarFit iOS SDK Examples

Example projects demonstrating how to integrate and use the SonarFit iOS SDK.

## 📱 Available Examples

### Coming Soon
- **BasicIntegration** - Simple iOS app showing SDK integration
- **SwiftUIExample** - Complete SwiftUI app with workout flow
- **WorkoutCustomization** - Custom workout types and configurations

## 🚀 Quick Test

For immediate testing, create a new iOS app and add this to your ContentView:

```swift
import SwiftUI
import SonarFitSDK

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("SonarFit SDK Test")
                .font(.largeTitle)

            Text("Version: \(SonarFitSDKVersion.current)")
                .font(.caption)
                .foregroundColor(.secondary)

            Button("Start Workout") {
                print("SonarFit SDK loaded successfully!")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
```

## 📋 Setup Steps

1. **Add Package**: `https://github.com/sonarfit/sonarfit-ios`
2. **Import SDK**: `import SonarFitSDK`
3. **Run Example**: Copy code above
4. **Verify**: Check console for success message

## 📞 Need Help?

- [Integration Guide](../INTEGRATION.md)
- [Issues](https://github.com/sonarfit/sonarfit-ios/issues)
- Email: support@sonarfit.com