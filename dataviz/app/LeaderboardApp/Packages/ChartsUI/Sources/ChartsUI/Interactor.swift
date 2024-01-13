//
//  Interactor.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 11/12/2023.
//

import Leaderboard
import Foundation

struct Interactor {
    private let getMostRecentAdventDay = GetMostRecentAdventDay()
    private let getMostRecentLeaderboardDate = GetMostRecentLeaderboardDate()
    private let getLeaderboardUsers = GetLeaderboardUsers()
    private let getAllTimestamps = GetAllTimestamps()

    private let dayAsTimestamp: TimeInterval = 24 * 60 * 60

    func retrieveTotalStarsPerDay() async -> [StarsModel]? {
        guard let mostRecentLeaderboardDate = await getMostRecentLeaderboardDate.execute() else { return nil }

        let mostRecentAdventDay = await getMostRecentAdventDay.execute()
        let users = await getLeaderboardUsers.execute(date: mostRecentLeaderboardDate)
        let timestamps = await getAllTimestamps.execute(maxDay: mostRecentAdventDay, users: users)
        let timestampsFlatten = timestamps.flatMap {
            $0.starsDuration
        }
        let timestampsPerDay = Dictionary(grouping: timestampsFlatten, by: \.day)
        return timestampsPerDay.map {
            StarsModel(day: $0, timestamps: $1)
        }
    }

    func retrieveFirstStarDurationPerDay() async -> [StarDurationModel]? {
        guard let mostRecentLeaderboardDate = await getMostRecentLeaderboardDate.execute() else { return nil }

        let mostRecentAdventDay = await getMostRecentAdventDay.execute()
        let users = await getLeaderboardUsers.execute(date: mostRecentLeaderboardDate)
        let timestamps = await getAllTimestamps.execute(maxDay: mostRecentAdventDay, users: users)
        let timestampsFlatten = timestamps.flatMap {
            $0.starsDuration
        }
        let timestampsPerDay = Dictionary(grouping: timestampsFlatten, by: \.day)
        return timestampsPerDay.map {
            let durationsWithinADay = $1.map(\.firstStarDuration).filter { $0 < dayAsTimestamp }
            return StarDurationModel(day: $0, durations: durationsWithinADay)
        }.sorted {
            $0.day <= $1.day
        }
    }

    func retrieveSecondStarDurationPerDay() async -> [StarDurationModel]? {
        guard let mostRecentLeaderboardDate = await getMostRecentLeaderboardDate.execute() else { return nil }

        let mostRecentAdventDay = await getMostRecentAdventDay.execute()
        let users = await getLeaderboardUsers.execute(date: mostRecentLeaderboardDate)
        let timestamps = await getAllTimestamps.execute(maxDay: mostRecentAdventDay, users: users)
        let timestampsFlatten = timestamps.flatMap {
            $0.starsDuration
        }
        let timestampsPerDay = Dictionary(grouping: timestampsFlatten, by: \.day)
        return timestampsPerDay.map {
            let durationsWithinADay = $1.compactMap(\.secondStarDuration).filter { $0 < dayAsTimestamp }
            return StarDurationModel(day: $0, durations: durationsWithinADay)
        }.sorted {
            $0.day <= $1.day
        }
    }
}
