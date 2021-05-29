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
    
    public func configureCell(for raffle: Raffle) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let date = dateFormatter.date(from: raffle.createdAt)
        
        raffleNameLabel.text = raffle.name
        //TODO: Fetch all participants for a number here
        // numOfParticipantsLabel.text = ""
        createdDateLabel.text = "\(String(describing: date?.description))"
    }
}
