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
    var raffleViewModels = [RaffleViewModel]() {
        didSet {
            DispatchQueue.main.async {
                self.navigationItem.title = "All \(self.raffleViewModels.count) Raffles"
                if !self.stillLoading {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    var stillLoading: Bool = false
    let refreshControl = UIRefreshControl()
    
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
        collectionView.dragInteractionEnabled = true
        collectionView.register(UINib(nibName: "RaffleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "raffleCell")
        collectionView.register(IndicatorCollectionViewCell.self, forCellWithReuseIdentifier: "indicator")
        collectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshControlFunctions(_:)), for: .valueChanged)
    }
    @objc func refreshControlFunctions(_ sender: Any) {
        raffleViewModels.removeAll()
        fetchAllRaffles()
        refreshControl.endRefreshing()
    }
    func configureViewController() {
        navigationItem.title = "All Raffles"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func fetchAllRaffles() {
        RaffleAPIClient.fetchAllRaffles { (results) in
            self.stillLoading = true
            switch results {
            case .failure(let appError):
                self.showAlert(title: "Something wetn", message: ("\(appError.localizedDescription)"))
            case .success(let raffleData):
                var dataRaffleViewModels = [RaffleViewModel]() {
                    didSet {
                        print(dataRaffleViewModels.count)
                    }
                }
                // Parsing through each Raffle
//                DispatchQueue.main.async {
                    let sortedRaffles = raffleData.sorted { $0.createdAt > $1.createdAt }
                    for raffle in sortedRaffles {
                        var raffleViewModel = RaffleViewModel(raffle: raffle, participantCount: 0)
                        // Fetching participants for each Raffle
                        raffleViewModel.numOfParticipants = self.fetchParticipantsForRaffle(raffleID: raffle.id)
                        dataRaffleViewModels.append(raffleViewModel)
                    }
                    self.stillLoading = false
                    self.raffleViewModels = dataRaffleViewModels
//                }
                
                
            }
        }
        
    }
    func fetchParticipantsForRaffle(raffleID: Int) -> Int {
        var numOfParticipants = 0
        RaffleAPIClient.fetchParticipantsForRaffle(raffleID: raffleID) { (result) in
            switch result {
            case .failure(let appError):
                print("Could not fetch participants: \(appError)")
            case .success(let data):
                numOfParticipants = data.count
            }
        }
        return numOfParticipants
    }
    //MARK:- @IBActions
    @IBAction func createRaffleButtonPressed(_ sender: UIBarButtonItem) {
        let createRaffleViewController = self.storyboard?.instantiateViewController(identifier: "createRaffleViewController") as! CreateRaffleViewController
        createRaffleViewController.createdNewRaffleDelegate = self
        navigationController?.pushViewController(createRaffleViewController, animated: true)
    }
}

//MARK:- Collection View Data Source
extension MainRafflesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.raffleViewModels.count > 0) ? (self.raffleViewModels.count + 1) : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row != raffleViewModels.count {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "raffleCell", for: indexPath) as? RaffleCollectionViewCell else {
                fatalError("Dequeue reusable cell error")
            }
            let raffle = raffleViewModels[indexPath.row]
            cell.layer.cornerRadius = 4
            cell.configureCell(for: raffle, row: indexPath.row)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "indicator", for: indexPath) as! IndicatorCollectionViewCell
            if stillLoading {
                cell.indicator.startAnimating()
            } else {
                cell.indicator.stopAnimating()
            }
            return cell
        }
    }
}

//MARK:- Collection View Delegate
extension MainRafflesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let raffle = raffleViewModels[indexPath.row]
        let raffleDetailViewController = self.storyboard?.instantiateViewController(identifier: "raffleDetailViewController") as! RaffleDetailViewController
        raffleDetailViewController.raffleID = raffle.id
        raffleDetailViewController.raffleViewModels = raffleViewModels
        navigationController?.pushViewController(raffleDetailViewController, animated: true)
    }
}
extension MainRafflesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemHeight: CGFloat = maxSize.height * 0.15
        let itemWidth: CGFloat = maxSize.width * 0.95
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
}

extension MainRafflesViewController: CreatedNewRaffleDelegate {
    func newRaffleCreated() {
        raffleViewModels.removeAll()
        fetchAllRaffles()
        collectionView.reloadData()
    }
}
