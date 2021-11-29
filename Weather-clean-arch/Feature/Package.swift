// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Feature",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "CitySearch",
            targets: ["CitySearch"]
        )
    ],
    dependencies: [
        .package(path: "../Infrastructure"),
        .package(path: "../Generic"),
        .package(url: "https://github.com/Swinject/Swinject.git", .upToNextMajor(from: "2.8.0")),
        .package(url: "https://github.com/Swinject/SwinjectAutoregistration.git", .upToNextMajor(from: "2.7.0")),
    ],
    targets: [
        .target(
            name: "CitySearch",
            dependencies: [
                .product(name: "CitySearcher", package: "Generic"),
                "Swinject",
                "SwinjectAutoregistration"
            ]
        ),
        .testTarget(
            name: "FeatureTests",
            dependencies: ["CitySearch"
            ]
        ),
    ]
)
