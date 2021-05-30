//
//  RaffleDetailViewController.swift
//  RaffleChallenge
//
//  Created by Gregory Keeley on 5/30/21.
//

import UIKit

class RaffleDetailViewController: UIViewController {
    
    //MARK:- Variables/Constants
    var raffleID: Int?
    var raffle: Raffle?
    var participants: [Participant]?
    
    //MARK:- Initializer
    init(raffleID: Int) {
        self.raffleID = raffleID
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRaffleData()
        fetchRaffleParticipants()
    }
    
    //MARK:- Functions
    func fetchRaffleData() {
        guard let id = raffleID else {
            print("No raffle id")
            return
        }
        RaffleAPIClient.fetchRaffle(raffleID: id) { (result) in
            switch result {
            case .failure(let appError):
                print("Could not fetch raffle: \(appError)")
            case .success(let data):
                DispatchQueue.main.async {
                    self.raffle = data
                }
            }
        }
    }
    func fetchRaffleParticipants() {
        guard let id = raffleID else {
            print("Could not get participants for raffle")
            return
        }
        RaffleAPIClient.fetchParticipantsForRaffle(raffleID: id) { (result) in
            switch result {
            case .failure(let appError):
                print("Failed to fetch participants: \(appError)")
            case .success(let data):
                DispatchQueue.main.async {
                    self.participants = data
                }
            }
        }
    }
}
