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
            navigationItem.title = "All Raffles(\(raffles.count))"
        }
    }
    
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
    @IBAction func createRaffleButtonPressed(_ sender: UIBarButtonItem) {
        let createRaffleViewController = CreateRaffleViewController()
        show(createRaffleViewController, sender: self)
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
    
}

//MARK:- Collection View Delegate
extension MainRafflesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let raffle = raffles[indexPath.row]
        let raffleDetailViewController = self.storyboard?.instantiateViewController(identifier: "raffleDetailViewController") as! RaffleDetailViewController
        raffleDetailViewController.raffleID = raffle.id
        navigationController?.pushViewController(raffleDetailViewController, animated: true)
        
    }
}
extension MainRafflesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemHeight: CGFloat = maxSize.height * 0.15
        let itemWidth: CGFloat = maxSize.width
        return CGSize(width: itemWidth, height: itemHeight)
    }

}
