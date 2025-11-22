// swift-tools-version: 5.9
import PackageDescription

let version = "2.0.0"
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
            targets: ["SonarFitKitWrapper"]
        )
    ],
    targets: [
        // Binary targets (actual XCFrameworks)
        .binaryTarget(
            name: "SonarFitCore",
            url: "\(baseURL)/SonarFitCore.xcframework.zip",
            checksum: "7a83d33ad12cfa5441bb3a48a56c36d13b8729a3d37d5d8f770571dd0ba0ad2f"
        ),
        .binaryTarget(
            name: "SonarFitConnectivity",
            url: "\(baseURL)/SonarFitConnectivity.xcframework.zip",
            checksum: "858e50c01fc53d637cc2cfbe6a87470eb69a63c9fdba77eb7c59960ba6c78f64"
        ),
        .binaryTarget(
            name: "SonarFitUI",
            url: "\(baseURL)/SonarFitUI.xcframework.zip",
            checksum: "d50e60932b6aece00f893d8f7d14f405e84b4705fe311d6093047759db5a9525"
        ),
        .binaryTarget(
            name: "SonarFitWatchUI",
            url: "\(baseURL)/SonarFitWatchUI.xcframework.zip",
            checksum: "99c93a56446e2154fbcc625e392e10a9c3d8f8eb5f8f794fa58d107ec17028aa"
        ),
        .binaryTarget(
            name: "SonarFitKit",
            url: "\(baseURL)/SonarFitKit.xcframework.zip",
            checksum: "82d6cc40a68b664c811d1ee4c99006ced038f2ba9b78cbb41be95b7078f6d004"
        ),

        // Wrapper target that declares dependencies
        .target(
            name: "SonarFitKitWrapper",
            dependencies: [
                "SonarFitKit",
                "SonarFitCore",
                "SonarFitConnectivity",
                .target(name: "SonarFitUI", condition: .when(platforms: [.iOS])),
                .target(name: "SonarFitWatchUI", condition: .when(platforms: [.watchOS]))
            ],
            path: "Sources/SonarFitKitWrapper"
        )
    ]
)
