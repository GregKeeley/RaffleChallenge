//
//  ParticipantModel.swift
//  RaffleChallenge
//
//  Created by Gregory Keeley on 5/28/21.
//

import Foundation

struct Participant: Codable {
    
    var participantID: Int
    var raffleID: String, firstName: String, lastName: String, email: String, phone: String?, registeredAt: String
    
    private enum CodingKeys: String, CodingKey {
        case participantID = "id"
        case raffleID = "raffle_id"
        case firstName = "firstname"
        case lastName = "lastname"
        case email
        case phone
        case registeredAt = "registered_at"
    }
}

extension Participant {
    init(_ dictionary: [String: Any]) {
        self.participantID = dictionary["id"] as? Int ?? -1
        self.raffleID = dictionary["raffleID"] as? String ?? "No raffle ID available"
        self.firstName = dictionary["firstName"] as? String ?? "No name available"
        self.lastName = dictionary["lastName"] as? String ?? "Last name not avaiable"
        self.email = dictionary["email"] as? String ?? "email not available"
        self.phone = dictionary["phone"] as? String ?? "No phone number available"
        self.registeredAt = dictionary["regiesteredAt"] as? String ?? "No registration data available"
    }
}
