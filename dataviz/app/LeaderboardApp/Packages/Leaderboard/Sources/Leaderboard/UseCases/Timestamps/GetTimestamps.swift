//
//  GetTimestamps.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 17/12/2023.
//

import Common
import Foundation

public struct GetTimestamps {
    public init() {}
    
    public func execute(day: Int,
                        users: [UserProtocol]) async -> [TimestampProtocol] {

        let calendar = Calendar.current
        let dateComponents = DateComponents(year: 2023, month: 12, day: day, hour: 6)
        guard let dayTimeInterval = calendar.date(from: dateComponents)?.timeIntervalSince1970 else { return [] }

        return users.compactMap {
            guard let timestampForDay = $0.timestamps["\(day)"],
                  let firstStarTimestamp = timestampForDay[safe: 0] else { return nil }
            var secondStarDuration: TimeInterval? = nil
            if let secondStarTimestamp = timestampForDay[safe: 1] {
                secondStarDuration = secondStarTimestamp - firstStarTimestamp
            }
            let timeStampsDay = TimestampDayModel(day: day, 
                                                  firstStarDuration: firstStarTimestamp - dayTimeInterval,
                                                  secondStarDuration: secondStarDuration)
            return TimestampModel(user: $0,
                                  starsDuration: timeStampsDay)
        }.sorted {
            $0.starsDuration.firstStarDuration <= $1.starsDuration.firstStarDuration
        }
    }
}
