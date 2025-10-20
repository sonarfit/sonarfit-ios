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
            checksum: "808e0ad14cb7cbc4497e7108cf68100e6fcd471ef662966c46566408760b4ae3"
        ),

        // Connectivity framework - shared by iOS and watchOS
        .binaryTarget(
            name: "SonarFitConnectivity",
            url: "\(baseURL)/SonarFitConnectivity.xcframework.zip",
            checksum: "78d89f2f817169a62be50c768f917901b0f30719f8b187cc5451728c99c61153"
        ),

        // iOS UI framework
        .binaryTarget(
            name: "SonarFitUI",
            url: "\(baseURL)/SonarFitUI.xcframework.zip",
            checksum: "3c39bf1977e62e3742a01eb2b77b0b57316976db2fea54702b2ea34305c6d317"
        ),

        // watchOS UI framework
        .binaryTarget(
            name: "SonarFitWatchUI",
            url: "\(baseURL)/SonarFitWatchUI.xcframework.zip",
            checksum: "cc217ef78743b1a67eee980e344ba14e0f7c04bcee1a8ff1139d690f608c9d2f"
        ),

        // Main SDK umbrella framework with @_exported imports
        // This is what clients actually interact with
        .binaryTarget(
            name: "SonarFitKit",
            url: "\(baseURL)/SonarFitKit.xcframework.zip",
            checksum: "c79de3c9a8defeb71f3fa2eb01a9cf8a02cf409e40fcf9ebddce9b7b3ae01763"
        )
    ]
)
