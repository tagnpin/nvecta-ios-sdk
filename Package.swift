// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NVECTASDK",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "NVECTASDK",
            targets: ["NVECTASDK", "notifyvisitors"]
        ),
        .library(
            name: "notifyvisitors",
            targets: ["notifyvisitors"]
        ),
        .library(
            name: "notifyvisitorsNudges",
            targets: ["notifyvisitorsNudges"]
        ),
        .library(
            name: "notifyvisitorsNotificationService",
            targets: ["notifyvisitorsNotificationService"]
        ),
        .library(
            name: "NVECTAAdTrackingSDK",
            targets: ["NVECTAAdTrackingSDK"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "NVECTASDK",
            path: "Frameworks/NVECTASDK.xcframework"
        ),
        .binaryTarget(
            name: "notifyvisitors",
            path: "Frameworks/notifyvisitors.xcframework"
        ),
        .binaryTarget(
            name: "notifyvisitorsNudges",
            path: "Frameworks/notifyvisitorsNudges.xcframework"
        ),
        .binaryTarget(
            name: "notifyvisitorsNotificationService",
            path: "Frameworks/notifyvisitorsNotificationService.xcframework"
        ),
        .binaryTarget(
            name: "NVECTAAdTrackingSDK",
            path: "Frameworks/NVECTAAdTrackingSDK.xcframework"
        )
    ]
)
