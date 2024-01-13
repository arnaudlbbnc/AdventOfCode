//
//  Structure.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 26/11/2023.
//

import Common
import Foundation

struct Structure {
    var first: Model?
    var second: Model?
    var third: Model?
    var rest: [Model]

    static func from(models: [Model]) -> Self {
        let rest = models[safe: 3..<models.count]
        return Self(first: models[safe: 0],
                    second: models[safe: 1],
                    third: models[safe: 2],
                    rest: rest)
    }

    static func vide() -> Self {
        Structure(rest: [])
    }
}
