// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Apodini-REST-SmartLights",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "SmartLights", targets: ["SmartLights"]),
        .executable(name: "SmartLightsServer", targets: ["SmartLightsServer"])
    ],
    dependencies: [
        .package(url: "https://github.com/Apodini/Apodini.git", .branch("feature/relationship-adjustments")),
        .package(name: "SemVer", url: "https://github.com/RougeWare/Swift-SemVer.git", from: "2.0.0")
    ],
    targets: [
        .target(
            name: "SmartLights",
            dependencies: [
                .product(name: "Apodini", package: "Apodini"),
                .product(name: "ApodiniREST", package: "Apodini"),
                .product(name: "ApodiniDatabase", package: "Apodini"),
                .product(name: "SemVer", package: "SemVer")
            ]
        ),
        .target(
            name: "SmartLightsServer",
            dependencies: ["SmartLights"]
        )
    ]
)
