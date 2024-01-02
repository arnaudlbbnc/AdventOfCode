//
//  GetAgencies.swift
//
//
//  Created by Arnaud LE BOURBLANC on 11/12/2023.
//

import Foundation

public struct GetAgencies {

    public init() {}

    public func execute(date: String) async -> [AgencyProtocol] {
        var users = await GetLeaderboardUsers().execute(date: date)
        users = users.filter { $0.score > 0 }
        return extractAgenciesFromUsers(users)
    }

    private func extractAgenciesFromUsers(_ users: [UserProtocol]) -> [AgencyModel] {
        guard !users.isEmpty else { return [] }
        let usersPerAgency = Dictionary(grouping: users, by: \.agency)
        return usersPerAgency.map { (location: AgencyLocation, users: [UserProtocol]) in
            let score = users.reduce(0) { $0 + $1.score }
            let stars = users.reduce(0) { $0 + $1.stars }
            return AgencyModel(location: location, participants: users.count, stars: stars, score: score)
        }.filter {
            $0.location != .unknown
        }
    }
}
