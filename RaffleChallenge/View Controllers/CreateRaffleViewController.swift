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
    
    
    //MARK:- Variables/Constants
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func createRaffleButtonPressed(_ sender: UIButton) {
        if let raffleName = raffleNameTextField.text {
            if let secretToken = secretTokenTextField.text {
                RaffleAPIClient.createRaffle(name: raffleName, secretToken: secretToken) { (result) in
                    switch result {
                    case .failure(let appError):
                        print("Unable to create raffle: \(appError)")
                    case .success:
                        DispatchQueue.main.async {
                            print("Raffle created successfully!")
                            self.navigationController?.popViewController(animated: true)
                        }
                        //TODO: Show alert - remind user to remember the secret token to select a winner...!
                    }
                }
            } else {
                print("Secret token empty, All fields required")
            }
        } else {
            print("Raffle name empty, all fields required")
        }
    }
    
}
