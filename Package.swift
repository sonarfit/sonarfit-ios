// swift-tools-version: 5.9
import PackageDescription

let version = "2.9.0"
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
            checksum: "b857db30b57eb6beb4ab03c80a345a3567560a5a1c5ebdcf66dbed9769ab7eae"
        ),
        .binaryTarget(
            name: "SonarFitConnectivity",
            url: "\(baseURL)/SonarFitConnectivity.xcframework.zip",
            checksum: "084c946d9a6c49c85d4a8cb563551c9db5ca72d76990d10e3ec8ae9912c40f17"
        ),
        .binaryTarget(
            name: "SonarFitUI",
            url: "\(baseURL)/SonarFitUI.xcframework.zip",
            checksum: "94823df4e488107af6cffff1353f358faef498be6eddd0d1d588a2a0c255451e"
        ),
        .binaryTarget(
            name: "SonarFitWatchUI",
            url: "\(baseURL)/SonarFitWatchUI.xcframework.zip",
            checksum: "c0c0a4a075b6de58faa7e0a4d934621fd53340dccbaa60561a514dafa9939fce"
        ),
        .binaryTarget(
            name: "SonarFitKit",
            url: "\(baseURL)/SonarFitKit.xcframework.zip",
            checksum: "e66330990a3c69c1c40a386298f64f322bef93663e8b9db102564491ccaa4856"
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
