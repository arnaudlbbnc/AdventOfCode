//
//  UserModel.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 13/11/2023.
//

import Foundation

struct UserModel: UserProtocol, Decodable {
    var id: String
    var aocUsername: String
    var firstname: String
    var lastname: String
    var score: Int
    var stars: Int
    var timestamps: [String: [TimeInterval]]
    var agency: AgencyLocation

    enum CodingKeys: String, CodingKey {
        case id
        case aocUsername
        case firstname
        case lastname
        case score = "localScore"
        case stars
        case timestamps
        case agency
    }
}
