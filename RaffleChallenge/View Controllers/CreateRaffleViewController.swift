//
//  CreateRaffleViewController.swift
//  RaffleChallenge
//
//  Created by Gregory Keeley on 5/30/21.
//

import UIKit

class CreateRaffleViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var raffleNameTextField: UITextField!
    @IBOutlet weak var secretTokenTextField: UITextField!
    @IBOutlet weak var createRaffleButton: UIButton!
    
    weak var createdNewRaffleDelegate: CreatedNewRaffleDelegate?
    //MARK:- Variables/Constants
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    //MARK:- Functions
    func configureUI() {
        createRaffleButton.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        createRaffleButton.layer.cornerRadius = 4
    }
    
    //MARK:- IBActions
    @IBAction func createRaffleButtonPressed(_ sender: UIButton) {
        guard let raffleName = raffleNameTextField.text, !raffleName.isEmpty, let secretToken = secretTokenTextField.text, !secretToken.isEmpty else {
            showAlert(title: "Something is missing", message: "Please fill out the name and secret password")
            return
        }
        showAlert(title: "Don't forget your password", message: "You won't be able to select a winner without the secret password: \(secretToken)") { _ in
            RaffleAPIClient.createRaffle(name: raffleName, secretToken: secretToken) { (result) in
                switch result {
                case .failure(let appError):
                    self.showAlert(title: "Something went wrong, please try again", message: "\(appError.localizedDescription)")
                case .success:
                    DispatchQueue.main.async {
                        self.createdNewRaffleDelegate?.newRaffleCreated()
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
        
    }
}
