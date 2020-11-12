// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "XcodeSlackLog",
    platforms: [
        .iOS(.v10),
        .macOS(.v10_15)
    ],
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
        ),
        .package(
            url: "https://github.com/Alamofire/Alamofire.git",
            .upToNextMajor(from: "5.2.0")
        )
    ],
    targets: [
        .target(
            name: "XcodeSlackLog",
            dependencies: [
                .product(
                    name: "Logging",
                    package: "swift-log"
                ),
                .product(
                    name: "Alamofire",
                    package: "Alamofire"
                )
            ]
        ),
        .testTarget(
            name: "XcodeSlackLogTests",
            dependencies: ["XcodeSlackLog"]
        )
    ]
)
