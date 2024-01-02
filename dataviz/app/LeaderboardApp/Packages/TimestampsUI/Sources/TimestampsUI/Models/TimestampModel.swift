//
//  TimestampModel.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 02/01/2024.
//

import Foundation
import Leaderboard
import UIKit

struct TimestampModel {
    private var userId: String
    private var userFirstName: String
    private var userLastName: String
    private var firstStarDuration: TimeInterval
    private var secondStarDuration: TimeInterval?
    
    var imageName: String {
        if UIImage(named: userId) != nil {
            return userId
        }
        return "defaultUser"
    }

    var userName: String {
        "\(userFirstName) \(userLastName)"
    }

    var firstStarDurationRepresentation: String {
        guard let durationRepresentation = firstStarDuration.durationRepresentation else { return "  ⭐️ --" }
        return "  ⭐️ \(durationRepresentation)"
    }

    var secondStarDurationRepresentation: String {
        guard let durationRepresentation = secondStarDuration?.durationRepresentation else { return "⭐️⭐️ --" }
        return "⭐️⭐️ \(durationRepresentation)"
    }

    static func from(_ timestamp: TimestampProtocol) -> Self {
        Self(userId: timestamp.user.id,
             userFirstName: timestamp.user.firstname,
             userLastName: timestamp.user.lastname,
             firstStarDuration: timestamp.firstStarDuration,
             secondStarDuration: timestamp.secondStarDuration)
    }
}
