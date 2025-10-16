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
            url: "https://github.com/sonarfit/sonarfit-ios/releases/download/v1.0.1/SonarFitSDK-1.0.0.xcframework.zip",
            checksum: "1535d72cc39aa9f1a49158a7fd3b91e5d438e6a7cc321bc3dfdbdb0b37cd078c"
        )
    ]
)
