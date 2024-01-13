//
//  TimestampsModel.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 07/01/2024.
//

import Foundation

struct TimestampsModel: TimestampsProtocol {
    var user: UserProtocol
    var starsDuration: [TimestampDayProtocol]
}
