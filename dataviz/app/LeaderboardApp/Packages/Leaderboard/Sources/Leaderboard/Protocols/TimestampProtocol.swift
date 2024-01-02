//
//  TimestampProtocol.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 17/12/2023.
//

import Foundation

public protocol TimestampProtocol {
    var user: UserProtocol { get }
    var firstStarDuration: TimeInterval { get }
    var secondStarDuration: TimeInterval? { get }
}
