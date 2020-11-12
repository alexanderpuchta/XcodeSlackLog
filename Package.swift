// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "XcodeSlackLog",
    products: [
        .library(
            name: "XcodeSlackLog",
            targets: ["XcodeSlackLog"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-log.git",
            from: "1.0.0"
        )
    ],
    targets: [
        .target(
            name: "XcodeSlackLog",
            dependencies: [
                .product(
                    name: "Logging",
                    package: "swift-log"
                )
            ]
        ),
        .testTarget(
            name: "XcodeSlackLogTests",
            dependencies: ["XcodeSlackLog"]
        )
    ]
)
