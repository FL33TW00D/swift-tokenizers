// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "Tokenizers",
    products: [
        .library(
            name: "Tokenizers",
            targets: ["Tokenizers"]),
    ],
    dependencies: [
        .package(url: "https://github.com/FL33TW00D/swift-hub.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "CTokenizers",
            linkerSettings: [
                .linkedLibrary("tokenizers_sys"),
                .unsafeFlags(["-Ldependencies"])
            ]
        ),
        .target(
            name: "Tokenizers",
            dependencies: [
                "CTokenizers",
                .product(name: "Hub", package: "swift-hub")
            ]
        ),
.testTarget(
    name: "TokenizersTests",
    dependencies: [
        "Tokenizers",
        .product(name: "Hub", package: "swift-hub")
    ]
)
    ]
)
