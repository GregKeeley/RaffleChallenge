//
//  AddParticipantResponseModel.swift
//  RaffleChallenge
//
//  Created by Gregory Keeley on 5/31/21.
//

import Foundation

struct AddParticipantResponseModel: Codable {
    // A typical response (Success, or failure) will have:
    // - type, success, title, content
    // Unless something goes wrong, then it will only return the message
    let type: String?, success: Bool?, title: String?, content: String?, message: String?
    
    private enum CodingKeys: String, CodingKey {
        case type
        case success
        case title
        case content
        case message
    }
}
