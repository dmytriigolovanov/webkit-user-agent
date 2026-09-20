// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WebKitUserAgent",
    platforms: [.iOS(.v15), .macOS(.v12), .visionOS(.v1)],
    products: [
        .library(
            name: "WebKitUserAgent",
            targets: ["WebKitUserAgent"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "WebKitSafeKVC",
            path: "WebKitSafeKVC",
            publicHeadersPath: "Headers"),
        .target(
            name: "WebKitUserAgent",
            dependencies: ["WebKitSafeKVC"],
            path: "WebKitUserAgent"),
        .testTarget(
            name: "WebKitUserAgentTests",
            dependencies: ["WebKitUserAgent", "WebKitSafeKVC"],
            path: "WebKitUserAgentTests")
    ],
    swiftLanguageVersions: [.v5]
)
