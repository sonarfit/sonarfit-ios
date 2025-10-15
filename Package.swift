// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SonarFitSDK",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "SonarFitSDK",
            targets: ["SonarFitSDK"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "SonarFitSDK",
            url: "https://github.com/sonarfit/sonarfit-ios/releases/download/v1.0.0/SonarFitSDK-1.0.0.xcframework.zip",
            checksum: "a27df9b9bd7dabb435056c10d6cf5758ca862fe256c39edb96ede6ffb628c741"
        )
    ]
)