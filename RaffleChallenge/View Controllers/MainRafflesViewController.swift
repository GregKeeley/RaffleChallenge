//
//  ViewController.swift
//  RaffleChallenge
//
//  Created by Gregory Keeley on 5/28/21.
//

import UIKit

class MainRafflesViewController: UIViewController {
    //MARK:-  IBOulets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK:- Variables/Constants
    var raffles = [Raffle]() {
        didSet {
            print(raffles.count)
            dump(raffles)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        fetchAllRaffles()
    }
    //MARK:- Functions
    func configureViewController() {
        navigationItem.title = "All Raffles"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
    }
    func fetchAllRaffles() {
        RaffleAPIClient.fetchAllRaffles { (results) in
            switch results {
            case .failure(let appError):
                //TODO: Add show alert here to display error to user
            print("Could not fetch all raffles: \(appError)")
            case .success(let raffleData):
                self.raffles = raffleData
            }
        }
    }
}

