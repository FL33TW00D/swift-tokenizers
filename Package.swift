// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "Tokenizers",
    products: [
        .library(
            name: "Tokenizers",
            targets: ["Tokenizers"]),
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
            dependencies: ["CTokenizers"]
        ),
        .testTarget(
            name: "TokenizersTests",
            dependencies: ["Tokenizers"]),
    ]
)
