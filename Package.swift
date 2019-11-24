// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "proxawdl",
    products: [
        .executable(name: "proxawdl", targets: ["proxawdl"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "proxawdl"),
    ],
    swiftLanguageVersions: [4]
)