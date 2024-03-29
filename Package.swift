// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Apodini-REST-SmartLights",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .executable(name: "SmartLights", targets: ["SmartLights"])
    ],
    dependencies: [
        .package(url: "https://github.com/Apodini/Apodini.git", .upToNextMinor(from: "0.5.0")),
        .package(url: "https://github.com/vapor/fluent-sqlite-driver.git", from: "4.1.0"),
        .package(name: "SemVer", url: "https://github.com/RougeWare/Swift-SemVer.git", from: "2.0.0")
    ],
    targets: [
        .executableTarget(
            name: "SmartLights",
            dependencies: [
                .product(name: "Apodini", package: "Apodini"),
                .product(name: "ApodiniREST", package: "Apodini"),
                .product(name: "ApodiniOpenAPI", package: "Apodini"),
                .product(name: "ApodiniDatabase", package: "Apodini"),
                .product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver"),
                .product(name: "SemVer", package: "SemVer")
            ]
        )
    ]
)
