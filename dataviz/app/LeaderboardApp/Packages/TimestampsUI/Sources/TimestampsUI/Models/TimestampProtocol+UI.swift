//
//  TimestampProtocol+UI.swift
//
//
//  Created by Arnaud LE BOURBLANC on 25/11/2023.
//

import Foundation
import Leaderboard

extension TimestampProtocol {
    var firstStarDurationRepresentation: String {
        firstStarDuration.durationRepresentation ?? "--"
    }

    var secondStarDurationRepresentation: String {
        secondStarDuration?.durationRepresentation ?? "--"
    }
}
