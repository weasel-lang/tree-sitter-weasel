// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "TreeSitterWeasel",
    products: [
        .library(name: "TreeSitterWeasel", targets: ["TreeSitterWeasel"]),
    ],
    dependencies: [
        .package(url: "https://github.com/tree-sitter/swift-tree-sitter", from: "0.9.0"),
    ],
    targets: [
        .target(
            name: "TreeSitterWeasel",
            dependencies: [],
            path: ".",
            sources: [
                "src/parser.c",
                "src/scanner.c",
            ],
            resources: [
                .copy("queries")
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .testTarget(
            name: "TreeSitterWeaselTests",
            dependencies: [
                .product(name: "SwiftTreeSitter", package: "swift-tree-sitter"),
                "TreeSitterWeasel",
            ],
            path: "bindings/swift/TreeSitterWeaselTests"
        )
    ],
    cLanguageStandard: .c11
)
