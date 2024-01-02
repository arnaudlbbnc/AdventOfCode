//
//  GetLeaderboardUsers.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 17/12/2023.
//

import Foundation
import Github

public struct GetLeaderboardUsers {
    private let repositoryOwner = "arnaudlbbnc"
    private let repositoryName = "AdventOfCode"
    private let folderPath = "dataviz/leaderboard/2023/formatted"
    private let branchName = "dataviz"

    public init() {}

    public func execute(date: String) async -> [UserProtocol] {
        let fileName = "\(date).json"
        return await execute(fileName: fileName)
    }

    public func execute(fileName: String) async -> [UserProtocol] {
        var users: [UserModel] = []
        do {
            let fileContent = try await GetFileContent().execute(repositoryOwner: repositoryOwner, repositoryName: repositoryName, filePath: "\(folderPath)/\(fileName)", branchName: branchName)
            guard let fileContent else { return [] }
            users = try JSONDecoder().decode([UserModel].self, from: fileContent)
        } catch let error {
            print("oopsie \(error.localizedDescription)")
        }
        return users.sorted(by: { $0.score > $1.score })
    }
}
