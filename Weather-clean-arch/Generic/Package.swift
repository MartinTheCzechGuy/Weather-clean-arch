// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Generic",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "CitySearcher",
            targets: ["CitySearcher"]
        )
    ],
    dependencies: [
        .package(path: "../Infrastructure"),
        .package(url: "https://github.com/Swinject/Swinject.git", .upToNextMajor(from: "2.8.0")),
        .package(url: "https://github.com/Swinject/SwinjectAutoregistration.git", .upToNextMajor(from: "2.7.0")),
    ],
    targets: [
        .target(
            name: "CitySearcher",
            dependencies: [
                .product(name: "CombineExtensions", package: "Infrastructure"),
                "Swinject",
                "SwinjectAutoregistration"
            ]
        ),
        .testTarget(
            name: "GenericTests",
            dependencies: ["CitySearcher"]),
    ]
)
