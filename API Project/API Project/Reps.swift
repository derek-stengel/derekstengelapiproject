//
//  Reps.swift
//  API Project
//
//  Created by Derek Stengel on 4/30/24.
//

import Foundation

struct Representatives: Decodable {
    var repName: String
    var repState: String
    var repLink: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case state = "state"
        case link = "link"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        repName = try values.decode(String.self, forKey: CodingKeys.name)
        repState = try values.decode(String.self, forKey: CodingKeys.state)
        repLink = try values.decode(String.self, forKey: CodingKeys.link)
    }
}
