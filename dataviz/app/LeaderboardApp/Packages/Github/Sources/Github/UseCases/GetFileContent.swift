//
//  GetFileContent.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 12/11/2023.
//

import DependencyResolver
import Foundation

public struct GetFileContent {
    @Inject private var service: ServiceProtocol?

    public init() {}

    public func execute(repositoryOwner: String,
                        repositoryName: String,
                        filePath: String,
                        branchName: String) async throws -> Data? {
        guard let service else { return nil }
        return try await service.getFileContent(repositoryOwner: repositoryOwner, repositoryName: repositoryName, filePath: filePath, branchName: branchName)
    }
}
