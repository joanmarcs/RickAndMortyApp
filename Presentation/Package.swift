// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Presentation",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "Presentation", targets: ["Presentation"])
    ],
    targets: [
        .target(name: "Presentation", path: "Sources/Presentation")
    ]
)
