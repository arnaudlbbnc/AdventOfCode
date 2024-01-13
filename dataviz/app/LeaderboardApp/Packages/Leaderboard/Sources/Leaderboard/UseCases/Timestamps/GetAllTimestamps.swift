//
//  GetAllTimestamps.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 07/01/2024.
//

import Common
import Foundation

public struct GetAllTimestamps {
    public init() {}

    public func execute(maxDay: Int,
                        users: [UserProtocol]) async -> [TimestampsProtocol] {
        guard maxDay > 0 && maxDay < 26 else { return [] }
        let calendar = Calendar.current

        return users.compactMap {
            var timestampsPerDay = [TimestampDayModel]()
            for day in 0...maxDay {
                let dateComponents = DateComponents(year: 2023, month: 12, day: day, hour: 6)
                guard let dayTimeInterval = calendar.date(from: dateComponents)?.timeIntervalSince1970 else { continue }

                guard let timestampForDay = $0.timestamps["\(day)"],
                      let firstStarTimestamp = timestampForDay[safe: 0] else { continue }
                var secondStarDuration: TimeInterval? = nil
                if let secondStarTimestamp = timestampForDay[safe: 1] {
                    secondStarDuration = secondStarTimestamp - firstStarTimestamp
                }
                timestampsPerDay.append(TimestampDayModel(day: day,
                                                          firstStarDuration: firstStarTimestamp - dayTimeInterval,
                                                          secondStarDuration: secondStarDuration))
            }
            return TimestampsModel(user: $0,
                                   starsDuration: timestampsPerDay)
        }
    }
}
