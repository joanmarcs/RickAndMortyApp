// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Data",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "Data", targets: ["Data"])
    ],
    targets: [
        .target(name: "Data", path: "Sources/Data"),
        .testTarget(
            name: "DataTests",
            dependencies: ["Data"],
            path: "Tests/DataTests"
        )
    ]
)

