//
//  Model.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 25/11/2023.
//

import Foundation
import Leaderboard
import UIKit

struct Model {
    var location: AgencyLocation
    var participants: Int
    var score: Int
    var stars: Int

    private var scorePerParticipant: Double {
        Double(score) / Double(participants)
    }

    var scorePerParticipantRepresentation: String {
        String(format: "%.2f points moyen", scorePerParticipant)
    }

    var starsRepresentation: String {
        return "\(stars) ⭐️"
    }

    var scoreRepresentation: String {
        return "\(score) points"
    }

    var participantsRepresentation: String {
        return "\(participants) participants"
    }
}
