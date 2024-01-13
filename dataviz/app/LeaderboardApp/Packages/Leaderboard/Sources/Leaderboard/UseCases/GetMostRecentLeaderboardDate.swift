//
//  GetMostRecentLeaderboardDate.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 22/12/2023.
//

import Foundation
import Github

public struct GetMostRecentLeaderboardDate {
    private let repositoryOwner = "arnaudlbbnc"
    private let repositoryName = "AdventOfCode"
    private let folderPath = "dataviz/leaderboard/2023/formatted"
    private let branchName = "dataviz"

    public init() {}

    public func execute() async -> String? {
        var day: String? = nil
        do {
            let filenames = try await GetRepositoryFolderContent().execute(repositoryOwner: repositoryOwner, repositoryName: repositoryName, folderPath: folderPath, branchName: branchName)
            day = extractMostRecentDay(filenames: filenames)
        } catch let error {
            print("oopsie \(error.localizedDescription)")
        }
        return day
    }

    private func extractMostRecentDay(filenames: [String]) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-M-d"
        let dailyFiles = filenames.compactMap { (filename: String) -> Date? in
            var filename = filename
            filename.removeLast(5)
            return dateFormatter.date(from: filename)
        }

        let dailyFilesSorted = dailyFiles.sorted(by: >)

        guard let firstDailyFile = dailyFilesSorted.first else { return nil }

        return dateFormatter.string(from: firstDailyFile)
    }
}
