//
//  ServiceProtocol.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 12/11/2023.
//

import Foundation

public protocol ServiceProtocol {
    func getRepositoryFolderContent(repositoryOwner: String,
                                    repositoryName: String,
                                    folderPath: String,
                                    branchName: String) async throws -> [String]
    func getFileContent(repositoryOwner: String,
                        repositoryName: String,
                        filePath: String,
                        branchName: String) async throws -> Data?
}
