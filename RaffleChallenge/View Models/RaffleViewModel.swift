//
//  RaffleViewModel.swift
//  RaffleChallenge
//
//  Created by Gregory Keeley on 5/28/21.
//

import Foundation

struct RaffleViewModel {
    let id: Int
    var numOfParticipants: Int?
    let name: String, createdAt: String, raffledAt: String?, winnerID: Int?
    
    init(raffle: Raffle, participantCount: Int) {
        self.id = raffle.id
        self.name = raffle.name
        self.createdAt = Date.convertStringISO8601ToFormattedString(strDate: raffle.createdAt)
        self.raffledAt = Date.convertStringISO8601ToFormattedString(strDate: raffle.raffledAt ?? "")
        self.winnerID = raffle.winnerID
        self.numOfParticipants = participantCount
    }
}
