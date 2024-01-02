//
//  AgencyProtocol.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 13/11/2023.
//

import Foundation

public protocol AgencyProtocol {
    var location: AgencyLocation { get }
    var participants: Int { get }
    var stars: Int { get }
    var score: Int { get }
}
