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
    private let getFastestUsers = GetFastestUser()
    private let getTimestamps = GetTimestamps()

    func retrieveUsers() async -> [UserProtocol]? {
        guard let mostRecentLeaderboardDate = await getMostRecentLeaderboardDate.execute() else { return nil }

        let mostRecentAdventDay = await getMostRecentAdventDay.execute()
        let users = await getLeaderboardUsers.execute(date: mostRecentLeaderboardDate)
        let fastestUser = await getFastestUsers.execute(day: mostRecentAdventDay,
                                                        users: users)
        print("Fastest first star is \(fastestUser.0?.firstname ?? "") \(fastestUser.0?.lastname ?? "")")
        print("Fastest second star is \(fastestUser.1?.firstname ?? "") \(fastestUser.1?.lastname ?? "")")

        let timestamps = await getTimestamps.execute(day: mostRecentAdventDay, users: users)
        return users
    }
}
