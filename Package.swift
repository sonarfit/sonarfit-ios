// swift-tools-version: 5.9
import PackageDescription

let version = "2.6.0"
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
            checksum: "d71c6951d324d8202b455534544c5465cf97e1ada55e843d4a379a80f355eb1c"
        ),
        .binaryTarget(
            name: "SonarFitConnectivity",
            url: "\(baseURL)/SonarFitConnectivity.xcframework.zip",
            checksum: "d4fb98b51f8133b569fc8cb2a6e8531e77e5cd60d8bf0c43e5f6aa784f0ed1fd"
        ),
        .binaryTarget(
            name: "SonarFitUI",
            url: "\(baseURL)/SonarFitUI.xcframework.zip",
            checksum: "5ca639a6f00030b6352c1c1548ecbbeb407a42fdb67f70ab2d490aab23ca452c"
        ),
        .binaryTarget(
            name: "SonarFitWatchUI",
            url: "\(baseURL)/SonarFitWatchUI.xcframework.zip",
            checksum: "fcb2688c5378dbd6d0a078ebcfbb6fd4ab8d28a7cf7e6117cce45b1826a9f024"
        ),
        .binaryTarget(
            name: "SonarFitKit",
            url: "\(baseURL)/SonarFitKit.xcframework.zip",
            checksum: "67bfa05a8b6fe5856e933fdd62f1a38849490e1e24adbe952a7ed0e0af3ff8f3"
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
