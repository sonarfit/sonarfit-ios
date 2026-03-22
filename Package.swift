// swift-tools-version: 5.9
import PackageDescription

let version = "2.1.3"
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
            checksum: "20619f8b104971811cbbbfa39cfe90f041209712d221dee9c3e06417a4cf2d52"
        ),
        .binaryTarget(
            name: "SonarFitConnectivity",
            url: "\(baseURL)/SonarFitConnectivity.xcframework.zip",
            checksum: "07e18bf4c40363529f3135342bd316becf2b0d37cb0c9ee61808650f8c4c0e97"
        ),
        .binaryTarget(
            name: "SonarFitUI",
            url: "\(baseURL)/SonarFitUI.xcframework.zip",
            checksum: "c6abdffb8cf7136ad8c74eb3bddfd86c8d3f2229bffda13d7bc491e6cd7006b8"
        ),
        .binaryTarget(
            name: "SonarFitWatchUI",
            url: "\(baseURL)/SonarFitWatchUI.xcframework.zip",
            checksum: "6b87de7c733b724dcd8b3ff07dfa0859ec99d175030021f2a73377977a0d8cbf"
        ),
        .binaryTarget(
            name: "SonarFitKit",
            url: "\(baseURL)/SonarFitKit.xcframework.zip",
            checksum: "523fa37d343c69c2ecaed1dcb5e608912f4f6d50fd41f8811aa9bdeb89f05237"
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
