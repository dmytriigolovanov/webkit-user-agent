// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WebKitUserAgent",
    platforms: [.iOS(.v9), .macOS(.v10_11)],
    products: [
        .library(
            name: "WebKitUserAgent",
            targets: ["WebKitUserAgent"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "WebKitUserAgent",
            path: "WebKitUserAgent/Sources"),
        .testTarget(
            name: "WebKitUserAgentTests",
            dependencies: ["WebKitUserAgent"],
            path: "WebKitUserAgent/Tests")
    ],
    swiftLanguageVersions: [.v5]
)
