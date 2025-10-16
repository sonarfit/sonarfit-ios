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
            url: "https://github.com/sonarfit/sonarfit-ios/releases/download/v1.0.1/SonarFitSDK-1.0.1.xcframework.zip",
            checksum: "8d5c8bff3a7afb4901150e49f951d91e0943189d49b3668f407597d7e15ee4c1"
        )
    ]
)
