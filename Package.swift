// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CheckAppVersionKit",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "CheckAppVersionKit",
            targets: ["CheckAppVersionKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/leoho0722/SwiftHelpers.git", from: Version(0, 0, 16))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "CheckAppVersionKit",
            dependencies: [
                .product(name: "SwiftHelpers", package: "SwiftHelpers")
            ]
        ),
        .testTarget(
            name: "CheckAppVersionKitTests",
            dependencies: ["CheckAppVersionKit"]
        ),
    ]
)
