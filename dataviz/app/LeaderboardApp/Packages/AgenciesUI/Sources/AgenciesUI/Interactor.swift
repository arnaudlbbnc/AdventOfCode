//
//  Interactor.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 11/12/2023.
//

import Leaderboard
import Foundation

struct Interactor {
    private let getMostRecentLeaderboardDate = GetMostRecentLeaderboardDate()
    private let getAgencies = GetAgencies()

    func retrieveAgencies() async -> [AgencyProtocol]? {
        guard let mostRecentLeaderboardDate = await getMostRecentLeaderboardDate.execute() else { return nil }
        return await getAgencies.execute(date: mostRecentLeaderboardDate)
            .sorted(by: { $0.location.name < $1.location.name })
    }
}
