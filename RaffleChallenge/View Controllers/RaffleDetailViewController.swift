//
//  RaffleDetailViewController.swift
//  RaffleChallenge
//
//  Created by Gregory Keeley on 5/30/21.
//

import UIKit

protocol AddParticipantToRaffleDelegate: AnyObject {
    func participantAddedToRaffle()
}

class RaffleDetailViewController: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var raffleNameLabel: UILabel!
    @IBOutlet weak var noOfWinnersLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var winnerNameLabel: UILabel!
    @IBOutlet weak var raffleIDLabel: UILabel!
    @IBOutlet weak var selectWinnerButton: UIButton!
    @IBOutlet weak var selectWinnerLockButton: UIButton!
    @IBOutlet weak var enterRaffleButton: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK:- Variables/Constants
    var raffleID: Int?
    var raffle: RaffleViewModel? {
        didSet {
            updateUI()
        }
    }
    var participants: [Participant]? {
        didSet {
            updateUI()
        }
    }
    var raffleViewModels = [RaffleViewModel]()

    //MARK:- View Lifecycles
    override func viewWillAppear(_ animated: Bool) {
        fetchRaffleData()
        fetchRaffleParticipants()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    //MARK:- Functions
    func configureView() {
        raffleNameLabel.adjustsFontSizeToFitWidth = true
        noOfWinnersLabel.adjustsFontSizeToFitWidth = true
        winnerNameLabel.adjustsFontSizeToFitWidth = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "RaffleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "raffleCell")
    }
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
                    let raffleViewModel = RaffleViewModel(raffle: data, participantCount: self.participants?.count ?? -1)
                    self.raffle = raffleViewModel
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
    func updateUI() {
        raffleIDLabel.text = ("#\(raffleID ?? -1)")
        raffleNameLabel.text = raffle?.name
        let createdDate = Date.convertStringISO8601ToFormattedString(strDate: raffle?.createdAt ?? "No Date Available")
        createdDateLabel.text = createdDate
        if let winnerID = raffle?.winnerID {
            winnerNameLabel.text = ("\(winnerID)")
            selectWinnerButton.isEnabled = false
            selectWinnerLockButton.imageView?.image = UIImage(systemName: "lock.open")
            selectWinnerLockButton.isEnabled = false
            enterRaffleButton.isEnabled = false
        } else {
            winnerNameLabel.text = "No Winner, enter now!"
            selectWinnerButton.isEnabled = true
            selectWinnerLockButton.imageView?.image = UIImage(systemName: "lock")
            selectWinnerLockButton.isEnabled = true
            enterRaffleButton.isEnabled = true
        }
        noOfWinnersLabel.text = ("\(participants?.count ?? 0)")
    }
    //MARK:- @IBActions
    @IBAction func selectWinnerButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Ready to select a winner?", message: "Enter Password", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Secret Key"
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            RaffleAPIClient.selectRaffleWinner(secret: textField?.text ?? "", raffleID: self.raffle?.id ?? -1) { (result) in
                switch result {
                case .failure(let appError):
                    print("Something went wrong selecting a winner: \(appError)")
                case .success(_):
                    print("A winner has been selected!")
                    self.fetchRaffleData()
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (_) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func enterRaffleButtonPressed(_ sender: UIButton) {
        let enterRaffleViewController = self.storyboard?.instantiateViewController(identifier: "enterRaffleViewController") as! EnterRaffleViewController
        enterRaffleViewController.raffleID = raffle?.id
        enterRaffleViewController.addedParticipantDelegate = self
        navigationController?.present(enterRaffleViewController, animated: true)
    }
    
    
}

extension RaffleDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let raffle = raffleViewModels[indexPath.row]
        let raffleDetailViewController = self.storyboard?.instantiateViewController(identifier: "raffleDetailViewController") as! RaffleDetailViewController
        raffleDetailViewController.raffleID = raffle.id
        raffleDetailViewController.raffleViewModels = raffleViewModels
        // TODO: Currently, the view controllers will keep stacking - Change this to pop the view controller before pushing the new VC?
        navigationController?.pushViewController(raffleDetailViewController, animated: true)
    }
}
extension RaffleDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize = collectionView.frame.size
        let maxHeight = maxSize.height * 0.90
        let maxWidth = maxSize.width / 5
        return CGSize(width: maxWidth, height: maxHeight)
    }
}
extension RaffleDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "raffleCell", for: indexPath) as? RaffleCollectionViewCell else {
            fatalError("Failed to dequeue reusable cell")
        }
        let raffle = raffleViewModels[indexPath.row]
        cell.configureCell(for: raffle, row: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return raffleViewModels.count
    }
    
}

extension RaffleDetailViewController: AddParticipantToRaffleDelegate {
    func participantAddedToRaffle() {
        fetchRaffleData()
        fetchRaffleParticipants()
    }
}
