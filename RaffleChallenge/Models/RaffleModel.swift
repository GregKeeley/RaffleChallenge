//
//  RaffleModel.swift
//  RaffleChallenge
//
//  Created by Gregory Keeley on 5/28/21.
//

import Foundation

struct Raffle: Codable {
    
    var id: Int
    var name: String, createdAt: String, raffledAt: String?, winnerID: Int?, secretToken: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case createdAt = "created_at"
        case raffledAt = "raffled_at"
        case winnerID = "winner_id"
        case secretToken = "secret_token"
    }
}

extension Raffle {
    init(_ dictionary: [String: Any]) {
        self.id = dictionary["id"] as? Int ?? -1
        self.name = dictionary["name"] as? String ?? "Name not available"
        self.createdAt = dictionary["createdAt"] as? String ?? "Created date not available"
        self.raffledAt = dictionary["raffledAt"] as? String ?? "Raffle date not available"
        self.winnerID = dictionary["winnerID"] as? Int ?? -1
        self.secretToken = dictionary["secretToken"] as? String ?? "Secret token not available"
    }
}
