//
//  Model.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 23/12/2023.
//

import Foundation
import Leaderboard

struct Model {
    var day: Int
    var timestamps: [TimestampProtocol]

    init(day: Int = 1, timestamps: [TimestampProtocol] = []) {
        self.day = day
        self.timestamps = timestamps
    }
}
