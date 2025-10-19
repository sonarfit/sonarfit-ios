// swift-tools-version: 5.9
import PackageDescription

let version = "1.1.0"
let baseURL = "https://github.com/sonarfit/sonarfit-ios/releases/download/v\(version)"

let package = Package(
    name: "SonarFitSDK",
    platforms: [
        .iOS(.v17),
        .watchOS(.v10)
    ],
    products: [
        // Only expose SonarFitKit - clients import this one module
        .library(
            name: "SonarFitKit",
            targets: ["SonarFitKit"]
        )
    ],
    targets: [
        // Core framework - shared by iOS and watchOS
        .binaryTarget(
            name: "SonarFitCore",
            url: "\(baseURL)/SonarFitCore.xcframework.zip",
            checksum: "445fd0a3a4d86a6979a1edbe0340a7f73c858ccdebf6c354e5adcc1abd4e8c5a"
        ),

        // Connectivity framework - shared by iOS and watchOS
        .binaryTarget(
            name: "SonarFitConnectivity",
            url: "\(baseURL)/SonarFitConnectivity.xcframework.zip",
            checksum: "a115a15cb4cd06cbf9252a0c7fac638d7ebc2d3f934ffd5bb007e9ce2909c502"
        ),

        // iOS UI framework
        .binaryTarget(
            name: "SonarFitUI",
            url: "\(baseURL)/SonarFitUI.xcframework.zip",
            checksum: "436e020fa088c5453b73c86bb9ce4ff676666878e7dbb61853f34df6a4c5b5f9"
        ),

        // watchOS UI framework
        .binaryTarget(
            name: "SonarFitWatchUI",
            url: "\(baseURL)/SonarFitWatchUI.xcframework.zip",
            checksum: "f0b357a489bcfe1b6fb6e814a177077be25bed4fbbe27f6c146c2b882f5f07c6"
        ),

        // Main SDK umbrella framework with @_exported imports
        // This is what clients actually interact with
        .binaryTarget(
            name: "SonarFitKit",
            url: "\(baseURL)/SonarFitKit.xcframework.zip",
            checksum: "d361c2c20591e30150c0437955964d8ae2abf7fffe240738f2fbcfc780aa9d90"
        )
    ]
)
