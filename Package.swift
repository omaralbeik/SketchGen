// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SketchGen",
    dependencies: [
        .package(
            url: "https://github.com/jakeheis/SwiftCLI",
            from: "6.0.0"
        ),
        .package(
            url: "https://github.com/stencilproject/Stencil",
            from: "0.13.0"
        ),
    ],
    targets: [
        .target(
            name: "SketchGen",
            dependencies: [
                "SwiftCLI",
                "Stencil",
            ]
        ),
        .testTarget(
            name: "SketchGenTests",
            dependencies: ["SketchGen"]
        ),
    ]
)
