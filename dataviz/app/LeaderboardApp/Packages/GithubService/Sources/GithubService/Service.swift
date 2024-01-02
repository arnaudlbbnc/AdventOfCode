//
//  Service.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 12/11/2023.
//

import Common
import Foundation
import Github

public struct Service {
    var session = URLSession.shared

    public init() {}
}

extension Service: ServiceProtocol {
    public func getRepositoryFolderContent(repositoryOwner: String,
                                           repositoryName: String,
                                           folderPath: String,
                                           branchName: String) async throws -> [String] {
        guard let url = URL(string: "https://api.github.com/repos/\(repositoryOwner)/\(repositoryName)/contents/\(folderPath)?ref=\(branchName)") else {
            throw URLError(.unsupportedURL)
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("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", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("2022-11-28", forHTTPHeaderField: "X-GitHub-Api-Version")

        let (data, response) = try await session.data(for: urlRequest)
        guard let response = response as? HTTPURLResponse else { throw URLError(.badServerResponse) }
        guard response.statusCode == 200 else { throw URLError(.badServerResponse) }
        let folderResponses = try JSONDecoder().decode([FolderResponse].self, from: data)
        return folderResponses.map { $0.name }
    }

    public func getFileContent(repositoryOwner: String,
                               repositoryName: String,
                               filePath: String,
                               branchName: String) async throws -> Data? {
        guard let url = URL(string: "https://api.github.com/repos/\(repositoryOwner)/\(repositoryName)/contents/\(filePath)?ref=\(branchName)") else {
            throw URLError(.unsupportedURL)
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("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", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("2022-11-28", forHTTPHeaderField: "X-GitHub-Api-Version")

        let (data, response) = try await session.data(for: urlRequest)
        guard let response = response as? HTTPURLResponse else { throw URLError(.badServerResponse) }
        guard response.statusCode == 200 else { throw URLError(.badServerResponse) }
        let fileResponse = try JSONDecoder().decode(FileReponse.self, from: data)
        return fileResponse.content.base64DecodedData()
    }
}
