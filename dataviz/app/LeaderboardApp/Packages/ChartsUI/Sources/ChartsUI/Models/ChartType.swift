//
//  ChartType.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 07/01/2024.
//

import Foundation

enum ChartType {
    case stars
    case firstStar
    case secondStar

    var title: String {
        return switch self {
        case .stars:
            "Nombre d'étoiles par jour"
        case .firstStar:
            "Temps moyen pour obtenir la première étoile"
        case .secondStar:
            "Temps moyen pour obtenir la seconde étoile"
        }
    }
}
