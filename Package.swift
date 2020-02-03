// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "SketchGen",
    platforms: [.macOS(.v10_13)],
    products: [
        .executable(name: "sketchgen", targets: ["SketchGen"]),
        .library(name: "SketchGen", targets: ["SketchGen"]),
    ],
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
