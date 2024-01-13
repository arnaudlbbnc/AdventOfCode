//
//  StarsModel.swift
//
//
//  Created by Arnaud LE BOURBLANC on 23/12/2023.
//

import Foundation
import Leaderboard

struct StarsModel {
    var day: Int
    var stars: Int

    init(day: Int = 1, timestamps: [TimestampDayProtocol] = []) {
        self.day = day
        self.stars = timestamps.reduce(0) {
            $0 + 1 + ($1.secondStarDuration != nil ? 1 : 0)
        }
    }
}
