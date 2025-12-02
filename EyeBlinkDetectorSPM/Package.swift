// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EyeBlinkDetector",
    defaultLocalization: "ko",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "EyeBlinkDetector",
            targets: ["EyeBlinkDetector"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "EyeBlinkDetector",
            dependencies: [],
            resources: [
                .process("Resources/Assets.xcassets"),
                .process("Resources/Info.plist")
            ],
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: "EyeBlinkDetectorTests",
            dependencies: ["EyeBlinkDetector"]
        ),
    ]
)
