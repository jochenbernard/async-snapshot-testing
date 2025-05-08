// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "AsyncSnapshotTesting",
    products: [
        .library(
            name: "AsyncSnapshotTesting",
            targets: ["AsyncSnapshotTesting"]
        )
    ],
    targets: [
        .target(name: "AsyncSnapshotTesting"),
        .testTarget(
            name: "AsyncSnapshotTestingTests",
            dependencies: ["AsyncSnapshotTesting"]
        )
    ]
)
