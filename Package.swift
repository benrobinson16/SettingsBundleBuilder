// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SettingsBundleBuilder",
    products: [
        .library(
            name: "SettingsBundleBuilder",
            targets: ["SettingsBundleBuilder"]
        ),
    ],
    dependencies: [
        // None
    ],
    targets: [
        .target(
            name: "SettingsBundleBuilder",
            dependencies: []
        ),
        .testTarget(
            name: "SettingsBundleBuilderTests",
            dependencies: ["SettingsBundleBuilder"]
        ),
    ]
)
