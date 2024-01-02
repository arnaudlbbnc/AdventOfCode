//
//  GetFastestUser.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 12/11/2023.
//

import Foundation

public struct GetFastestUser {

    public init() {}

    public func execute(day: Int,
                        users: [UserProtocol]) async -> (UserProtocol?, UserProtocol?) {
        let day = "\(day)"
        
        let fastestUsersFirstStar = users.sorted { user1, user2 -> Bool in
            guard let user2MostRecentTimestamp = user2.timestamps[day] else { return true }
            guard let user1MostRecentTimestamp = user1.timestamps[day] else { return false }
            guard user2MostRecentTimestamp.count > 0 else { return true }
            guard user1MostRecentTimestamp.count > 0 else { return false }
            return user1MostRecentTimestamp[0] <= user2MostRecentTimestamp[0]
        }

        let fastestUsersSecondStar = users.sorted { user1, user2 -> Bool in
            guard let user2MostRecentTimestamp = user2.timestamps[day] else { return true }
            guard let user1MostRecentTimestamp = user1.timestamps[day] else { return false }
            guard user2MostRecentTimestamp.count > 1 else { return true }
            guard user1MostRecentTimestamp.count > 1 else { return false }
            return user1MostRecentTimestamp[1] <= user2MostRecentTimestamp[1]
        }

        return (fastestUsersFirstStar.first, fastestUsersSecondStar.first)
    }
}
