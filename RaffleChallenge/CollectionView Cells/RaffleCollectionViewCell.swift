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
    
    var newBkgdColor = [#colorLiteral(red: 0.5962100465, green: 0.6218987595, blue: 1, alpha: 1), #colorLiteral(red: 0.3254901961, green: 0.6392156863, blue: 0.5529411765, alpha: 1), #colorLiteral(red: 0.8692667692, green: 0.7807532388, blue: 0.2816842362, alpha: 1), #colorLiteral(red: 0.4392156863, green: 0.7568627451, blue: 0.8823529412, alpha: 1), #colorLiteral(red: 0.5960784314, green: 0.6980392157, blue: 0.368627451, alpha: 1), #colorLiteral(red: 0.8588235294, green: 0.6823529412, blue: 0.2816842362, alpha: 1)]
    
    public func configureCell(for raffle: RaffleViewModel, row: Int) {
        contentView.backgroundColor = newBkgdColor[row % newBkgdColor.count]
        raffleNameLabel.text = "\(raffle.name)"
        numOfParticipantsLabel.text = "\(raffle.numOfParticipants) entries"
        let createdDate = Date.convertStringISO8601ToFormattedString(strDate: raffle.createdAt)
        createdDateLabel.text = "\(createdDate)"
        if let winnerID = raffle.winnerID {
            winnerNameLabel.text = ("Winner ID: \(winnerID)")
        } else {
            winnerNameLabel.text = "No winner selected"
        }
    }
}
