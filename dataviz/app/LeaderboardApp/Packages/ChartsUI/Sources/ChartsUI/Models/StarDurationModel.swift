//
//  StarDurationModel.swift
//
//
//  Created by Arnaud LE BOURBLANC on 07/01/2024.
//

import Foundation
import Leaderboard

struct StarDurationModel {
    var day: Int
    var averageDuration: TimeInterval

    var averageDurationRepresentation: String {
        return averageDuration.durationRepresentation ?? ""
    }

    init(day: Int = 1, durations: [TimeInterval] = []) {
        self.day = day
        self.averageDuration = durations.reduce(0, +) / Double(durations.count)
    }
}
