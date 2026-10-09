// swift-tools-version: 5.9
import PackageDescription

let version = "2.7.2"
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
            checksum: "44f12d0dcd7626f3a1c2aaecf77a38289b7f7547fbe930b74f4221cc454b91c8"
        ),
        .binaryTarget(
            name: "SonarFitConnectivity",
            url: "\(baseURL)/SonarFitConnectivity.xcframework.zip",
            checksum: "a458d5e935cfd9f83a3bc13a0eaad1c92d423cc40aba4e5dab810e727982a7f3"
        ),
        .binaryTarget(
            name: "SonarFitUI",
            url: "\(baseURL)/SonarFitUI.xcframework.zip",
            checksum: "75f11e5b01ddd2713e0ac274597dc8492cf8e42ae5b474829d9ebfb47b01c3fd"
        ),
        .binaryTarget(
            name: "SonarFitWatchUI",
            url: "\(baseURL)/SonarFitWatchUI.xcframework.zip",
            checksum: "bee7ae49a269a7e520902cf14367540b18712df76ea2399247c71d604b014924"
        ),
        .binaryTarget(
            name: "SonarFitKit",
            url: "\(baseURL)/SonarFitKit.xcframework.zip",
            checksum: "5d27cd4961673da5ffc4202ea96bf836b8306bff80d52aef67195c70c8ff154e"
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
