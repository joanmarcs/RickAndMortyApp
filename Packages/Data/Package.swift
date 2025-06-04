// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Data",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "Data", targets: ["Data"])
    ],
    dependencies: [
        .package(path: "../Domain"),
        .package(path: "../Networking")
    ],
    targets: [
        .target(name: "Data",
                dependencies: ["Domain", "Networking"],
                path: "Sources/Data"),
        .testTarget(
            name: "DataTests",
            dependencies: ["Data"],
            path: "Tests/DataTests"
        )
    ]
)

