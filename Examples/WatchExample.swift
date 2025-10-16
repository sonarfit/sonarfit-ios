import SwiftUI
import SonarFitSDK

// Example for existing Watch apps - add SonarFit with one line
struct ExistingWatchApp: View {
    var body: some View {
        VStack {
            Text("My Watch App")
                .font(.headline)

            // Your existing watch app content here
            Button("My Feature") {
                // Your existing functionality
            }
        }
        .enableSonarFitWorkouts()  // ← Add this line for SonarFit integration!
    }
}

// Example for dedicated fitness Watch apps - full SonarFit interface
struct FitnessWatchApp: View {
    var body: some View {
        SonarFitWatchMainView()  // Complete SonarFit workout interface
    }
}

#Preview("Existing Watch App") {
    ExistingWatchApp()
}

#Preview("Fitness Watch App") {
    FitnessWatchApp()
}

