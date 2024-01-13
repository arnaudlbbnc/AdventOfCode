//
//  TimestampsProtocol.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 07/01/2024.
//

import Foundation

public protocol TimestampsProtocol {
    var user: UserProtocol { get }
    var starsDuration: [TimestampDayProtocol] { get }
}
