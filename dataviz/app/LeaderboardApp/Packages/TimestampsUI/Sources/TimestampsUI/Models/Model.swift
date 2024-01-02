//
//  Model.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 23/12/2023.
//

import Common
import Foundation
import Leaderboard

struct Model {
    var day: Int
    var first: TimestampModel?
    var second: TimestampModel?
    var third: TimestampModel?
    var rest: [TimestampModel]

    init(day: Int = 1, timestamps: [TimestampProtocol] = []) {
        self.day = day
        self.first = timestamps[safe: 0].map { TimestampModel.from($0) }
        self.second = timestamps[safe: 1].map { TimestampModel.from($0) }
        self.third = timestamps[safe: 2].map { TimestampModel.from($0) }
        if timestamps.count < 3 {
            self.rest = []
        } else {
            self.rest = timestamps[safe: 3..<timestamps.count].map { TimestampModel.from($0) }
        }
    }
}
