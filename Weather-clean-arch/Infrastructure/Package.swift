// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Infrastructure",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "InstanceProvider",
            targets: ["InstanceProvider"]
        ),
        .library(
            name: "CombineExtensions",
            targets: ["CombineExtensions"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Swinject/Swinject.git", .upToNextMajor(from: "2.8.0")),
        .package(url: "https://github.com/Swinject/SwinjectAutoregistration.git", .upToNextMajor(from: "2.7.0")),
    ],
    targets: [
        .target(
            name: "InstanceProvider",
            dependencies: [
                "Swinject",
                "SwinjectAutoregistration"
            ]
        ),
        .target(
            name: "CombineExtensions",
            dependencies: [
                "Swinject",
                "SwinjectAutoregistration"
            ]
        ),
        .testTarget(
            name: "InfrastructureTests",
            dependencies: ["InstanceProvider", "CombineExtensions"]
        ),
    ]
)
