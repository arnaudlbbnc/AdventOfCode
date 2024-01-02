//
//  Model.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 25/11/2023.
//

import Foundation
import UIKit

struct Model {
    var id: String
    var rank: Int
    var name: String
    var score: Int
    var stars: Int

    var imageName: String {
        if UIImage(named: id) != nil {
            return id
        }
        return "defaultUser"
    }

    var scoreRepresentation: String {
        return "\(stars) ⭐️ / \(score) points"
    }
}
