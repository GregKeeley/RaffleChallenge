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
    var raffles = [Raffle]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        fetchAllRaffles()
        
    }
    //MARK:- Functions
    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "RaffleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "raffleCell")
    }
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
                DispatchQueue.main.async {
                    self.raffles = raffleData
                    self.collectionView.reloadData()
                }
            }
        }
    }
}

//MARK:- Collection View Data Source
extension MainRafflesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return raffles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "raffleCell", for: indexPath) as? RaffleCollectionViewCell else {
            fatalError("Dequeue reusable cell error")
        }
        let raffle = raffles[indexPath.row]
        cell.configureCell(for: raffle)
        return cell
    }
    
    //MARK:- Collection View Delegate
}
extension MainRafflesViewController: UICollectionViewDelegate {
    
}
