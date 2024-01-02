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
    private let getTimestamps = GetTimestamps()

    func retrieveTimestamps() async -> Model? {
        guard let mostRecentLeaderboardDate = await getMostRecentLeaderboardDate.execute() else { return nil }

        let mostRecentAdventDay = await getMostRecentAdventDay.execute()
        let users = await getLeaderboardUsers.execute(date: mostRecentLeaderboardDate)
        let timestamps = await getTimestamps.execute(day: mostRecentAdventDay, users: users)
        return Model(day: mostRecentAdventDay, timestamps: timestamps)
    }

    func retrieveTimestamps(day: Int) async -> Model? {
        guard let mostRecentLeaderboardDate = await getMostRecentLeaderboardDate.execute() else { return nil }

        let users = await getLeaderboardUsers.execute(date: mostRecentLeaderboardDate)
        let timestamps = await getTimestamps.execute(day: day, users: users)
        return Model(day: day, timestamps: timestamps)
    }
}
