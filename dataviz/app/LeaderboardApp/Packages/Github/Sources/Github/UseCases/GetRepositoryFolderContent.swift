//
//  GetRepositoryFolderContent.swift
//
//
//  Created by Arnaud LE BOURBLANC on 12/11/2023.
//

import DependencyResolver
import Foundation

public struct GetRepositoryFolderContent {
    @Inject private var service: ServiceProtocol?

    public init() {}

    public func execute(repositoryOwner: String,
                        repositoryName: String,
                        folderPath: String,
                        branchName: String) async throws -> [String] {
        guard let service else { return [] }
        return try await service.getRepositoryFolderContent(repositoryOwner: repositoryOwner, repositoryName: repositoryName, folderPath: folderPath, branchName: branchName)
    }
}
