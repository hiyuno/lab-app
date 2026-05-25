// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "LeonTweets",
    platforms: [.macOS(.v14)],
    products: [
        .executable(name: "LeonTweets", targets: ["LeonTweets"]),
    ],
    targets: [
        .target(
            name: "LeonTweetsCore",
            path: "Sources/LeonTweetsCore"
        ),
        .executableTarget(
            name: "LeonTweets",
            dependencies: ["LeonTweetsCore"],
            path: "Sources/LeonTweets"
        ),
        .testTarget(
            name: "LeonTweetsTests",
            dependencies: ["LeonTweetsCore"],
            path: "Tests/LeonTweetsTests"
        ),
    ]
)
