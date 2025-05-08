// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "AsyncSnapshotTesting",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "AsyncSnapshotTesting",
            targets: ["AsyncSnapshotTesting"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-snapshot-testing",
            from: "1.18.0"
        )
    ],
    targets: [
        .target(
            name: "AsyncSnapshotTesting",
            dependencies: [
                .product(
                    name: "SnapshotTesting",
                    package: "swift-snapshot-testing"
                )
            ]
        ),
        .testTarget(
            name: "AsyncSnapshotTestingTests",
            dependencies: ["AsyncSnapshotTesting"]
        )
    ]
)
