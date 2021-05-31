//
//  RaffleCollectionViewCell.swift
//  RaffleChallenge
//
//  Created by Gregory Keeley on 5/29/21.
//

import UIKit

class RaffleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var raffleNameLabel: UILabel!
    @IBOutlet weak var numOfParticipantsLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var winnerNameLabel: UILabel!
    
    public func configureCell(for raffle: RaffleViewModel) {
        // TODO: Convert created date to a readable format for label
        raffleNameLabel.text = "\(raffle.name)"
        // TODO: Fetch all participants for a number here
        numOfParticipantsLabel.text = "\(raffle.numOfParticipants ?? 0) entries"
        let createdDate = Date.convertStringISO8601ToFormattedString(strDate: raffle.createdAt)
        createdDateLabel.text = "\(createdDate)"
        if let winnerID = raffle.winnerID {
            winnerNameLabel.text = ("Winner ID: \(winnerID)")
        } else {
            winnerNameLabel.text = "No winner selected"
        }
    }
}
