//
//  AgencyLocation+UI.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 11/12/2023.
//

import Foundation
import Leaderboard

extension AgencyLocation {
    var name: String {
        switch self {
        case .belgium:
            "Belgium"
        case .bordeaux:
            "Bordeaux"
        case .luxembourg:
            "Luxembourg"
        case .lille:
            "Lille"
        case .nantes:
            "Nantes"
        case .paris:
            "Paris"
        case .strasbourg:
            "Strasbourg"
        case .sfeir:
            "SFEIR"
        case .unknown:
            ""
        }
    }

    var imageName: String {
        return rawValue
    }
}
