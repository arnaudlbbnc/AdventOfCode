//
//  GetMostRecentAdventDay.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 18/12/2023.
//

import Foundation
import Github

public struct GetMostRecentAdventDay {
    private let repositoryOwner = "arnaudlbbnc"
    private let repositoryName = "AdventOfCode"
    private let folderPath = "dataviz/leaderboard/2023/formatted"
    private let branchName = "dataviz"

    public init() {}

    public func execute() async -> Int {
        var day: Int? = nil
        do {
            let filenames = try await GetRepositoryFolderContent().execute(repositoryOwner: repositoryOwner, repositoryName: repositoryName, folderPath: folderPath, branchName: branchName)
            day = extractMostRecentDay(filenames: filenames)
        } catch let error {
            print("oopsie \(error.localizedDescription)")
        }
        guard let day else {
            return 0
        }
        return min(day - 1, 25)
    }

    private func extractMostRecentDay(filenames: [String]) -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dailyFiles = filenames.filter { (filename: String) in
            filename.contains("-12-")
        }.compactMap { (filename: String) -> Date? in
            var filename = filename
            filename.removeLast(5)
            return dateFormatter.date(from: filename)
        }

        let dailyFilesSorted = dailyFiles.sorted(by: >)

        guard let firstDailyFile = dailyFilesSorted.first else { return nil }

        let dateComponents = Calendar.current.dateComponents([.day], from: firstDailyFile)
        return dateComponents.day
    }
}
