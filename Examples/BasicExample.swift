import SwiftUI
import SonarFitSDK

@main
struct BasicExampleApp: App {
    init() {
        // Initialize SDK with your API key
        SonarFitSDK.initialize(apiKey: "sk_live_your_api_key_here") { success, error in
            if success {
                print("✅ SonarFit SDK initialized")
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
}

struct ContentView: View {
    @State private var showWorkout = false

    var body: some View {
        VStack(spacing: 20) {
            Text("SonarFit SDK Example")
                .font(.largeTitle)
                .padding()

            Text("Version: \(SonarFitSDKVersion.current)")
                .font(.caption)
                .foregroundColor(.secondary)

            Button("Start Squat Workout") {
                showWorkout = true
            }
            .buttonStyle(.borderedProminent)
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
                    print("Reps: \(result.totalRepsCompleted)/\(result.totalTargetReps)")
                    print("Completion: \(Int(result.completionPercentage * 100))%")
                },
                onPermissionError: { error in
                    print("Permission error: \(error.localizedDescription)")
                }
            )
        }
        .padding()
    }
}

#Preview {
    ContentView()
}