import SwiftUI
import SonarFitKit

// Example 1: Dedicated fitness Watch app - full SonarFit interface
@main
struct FitnessWatchApp: App {
    var body: some Scene {
        WindowGroup {
            SonarFitWatchMainView()
        }
    }
}

// Example 2: Add SonarFit to existing Watch app
struct ExistingWatchAppView: View {
    var body: some View {
        VStack {
            Text("My Watch App")
                .font(.headline)

            Button("My Feature") {
                // Your existing functionality
            }
        }
        .enableSonarFitWorkouts()
    }
}

#Preview("Fitness Watch App") {
    SonarFitWatchMainView()
}

#Preview("Existing Watch App") {
    ExistingWatchAppView()
}
