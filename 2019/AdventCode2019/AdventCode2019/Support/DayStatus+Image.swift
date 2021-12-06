//
//  DayStatus+Imag.swift
//  AdventCode2019
//
//  Created by Arnaud Le Bourblanc on 03/12/2019.
//  Copyright © 2019 Arnaud Le Bourblanc. All rights reserved.
//

import AdventCodeCore
import SwiftUI

extension DayStatus {
    func getImage() -> Image {
        var imageName: String
        switch self {
        case .done:
            imageName = "done"
        case .notDone:
            imageName = "notDone"
        }
        return Image(imageName)
    }
}
