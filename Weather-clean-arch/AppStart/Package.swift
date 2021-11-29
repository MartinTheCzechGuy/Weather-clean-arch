// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "AppStart",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "AppStart",
            targets: ["AppStart"]
        ),
    ],
    dependencies: [
        .package(path: "../Infrastructure"),
        .package(path: "../Generic"),
        .package(path: "../Feature"),
        .package(url: "https://github.com/Swinject/Swinject.git", .upToNextMajor(from: "2.8.0")),
        .package(url: "https://github.com/Swinject/SwinjectAutoregistration.git", .upToNextMajor(from: "2.7.0")),
    ],
    targets: [
        .target(
            name: "AppStart",
            dependencies: [
                .product(name: "InstanceProvider", package: "Infrastructure"),
                .product(name: "CitySearcher", package: "Generic"),
                .product(name: "CitySearch", package: "Feature"),
                "Swinject",
                "SwinjectAutoregistration"
            ]
        ),
        .testTarget(
            name: "AppStartTests",
            dependencies: ["AppStart"]
        ),
    ]
)
