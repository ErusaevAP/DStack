// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DStack",
    products: [
        .library(name: "DSExtensions", targets: ["DSExtensions"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "DSExtensions",
            dependencies: []
        )
    ],
    swiftLanguageVersions: [4]
)
