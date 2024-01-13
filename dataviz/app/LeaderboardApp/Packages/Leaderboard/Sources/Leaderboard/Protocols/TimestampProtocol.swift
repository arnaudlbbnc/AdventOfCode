//
//  TimestampProtocol.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 17/12/2023.
//

import Foundation

public protocol TimestampProtocol {
    var user: UserProtocol { get }
    var starsDuration: TimestampDayProtocol { get }
}
