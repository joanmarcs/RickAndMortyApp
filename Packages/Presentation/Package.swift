// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Presentation",
    defaultLocalization: "en",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "Presentation",
                 targets: ["Presentation"])
    ],
    dependencies: [
        .package(path: "../Domain"),
        .package(path: "../Data"),
        .package(path: "../Networking")
    ],
    targets: [
        .target(name: "Presentation",
                dependencies: ["Domain", "Data", "Networking"],
                path: "Sources/Presentation",
                resources: [
                    .process("Resources")
                ]),
        .testTarget(
            name: "PresentationTests",
            dependencies: ["Presentation"],
            path: "Tests/PresentationTests"
        )
    ]
)
