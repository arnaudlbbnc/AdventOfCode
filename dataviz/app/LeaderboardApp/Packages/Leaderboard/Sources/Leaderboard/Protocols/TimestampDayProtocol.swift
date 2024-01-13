//
//  TimestampDayProtocol.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 07/01/2024.
//

import Foundation

public protocol TimestampDayProtocol {
    var day: Int { get }
    var firstStarDuration: TimeInterval { get }
    var secondStarDuration: TimeInterval? { get }
}
