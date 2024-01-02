//
//  TimeInterval+Format.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 23/12/2023.
//

import Foundation

public extension TimeInterval {
    private static var durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .dropAll
        return formatter
    }()

    var durationRepresentation: String? {
        return TimeInterval.durationFormatter.string(from: self)
    }
}
