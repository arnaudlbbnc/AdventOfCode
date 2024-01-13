//
//  UserProtocol.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 13/11/2023.
//

import Foundation

public protocol UserProtocol {
    var id: String { get }
    var aocUsername: String { get }
    var firstname: String { get }
    var lastname: String { get }
    var score: Int { get }
    var stars: Int { get }
    var timestamps: [String: [TimeInterval]] { get }
    var agency: AgencyLocation { get }
}
