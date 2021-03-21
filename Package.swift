// swift-tools-version:5.1
// My personal machine is still on 10.14.6 for 32 bit compatability.
// I would have included the test files as resources otherwise.

import PackageDescription

let package = Package(
    name: "SpeedRoommatingEventRepository",
    platforms: [
        .macOS(.v10_12), // for quicker testing
        .iOS(.v11)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "SpeedRoommatingEventRepository",
            targets: ["SpeedRoommatingEventRepository"]),
    ],
    dependencies: [],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "SpeedRoommatingEventRepository",
            dependencies: []),
        .testTarget(
            name: "SpeedRoommmatingEventRepositoryTests",
            dependencies: ["SpeedRoommatingEventRepository"],
            path: "Tests"
//            resources: [
//                .copy("bad_event_test.json"),
//                .copy("event_test.json")
//            ]
        ),
    ]
)
