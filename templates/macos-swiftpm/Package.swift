// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "__APP_NAME__",
    platforms: [.macOS(.v14)],
    products: [
        .executable(name: "__APP_NAME__", targets: ["__APP_NAME__"]),
    ],
    targets: [
        .executableTarget(
            name: "__APP_NAME__",
            path: "Sources/__APP_NAME__"
        ),
    ]
)
