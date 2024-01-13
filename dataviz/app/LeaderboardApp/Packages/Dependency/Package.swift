// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Dependency",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Dependency",
            targets: ["Dependency"])
    ],
    dependencies: [
        .package(url: "https://github.com/arnaudlbbnc/DependencyResolver", exact: Version(0, 1, 1)),
        .package(name: "Github", path: "../Github"),
        .package(name: "GithubService", path: "../GithubService")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Dependency",
            dependencies: [
                "DependencyResolver",
                "Github",
                "GithubService"
            ]
        )
    ]
)
