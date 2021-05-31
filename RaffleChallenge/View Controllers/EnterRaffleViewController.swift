//
//  EnterRaffleViewController.swift
//  RaffleChallenge
//
//  Created by Gregory Keeley on 5/30/21.
//

import UIKit

class EnterRaffleViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    //MARK:- Variables/Constants
    var raffleID: Int?
    var instantanceOfRaffleDetailViewController: RaffleDetailViewController!
    weak var addedParticipantDelegate: AddParticipantToRaffleDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func enterRaffleButtonPressed(_ sender: UIButton) {
        guard let firstName = firstNameTextField.text, let lastName = lastNameTextField.text, let emailAddress = emailAddressTextField.text else {
            print("All fields required")
            return
        }
        let phoneNumber = phoneNumberTextField.text
        RaffleAPIClient.addParticipantToRaffle(firstName: firstName, lastName: lastName, email: emailAddress, phone: phoneNumber, raffleID: raffleID ?? -1) { (result) in
            switch result {
            case .failure(let appError):
                print("Error adding participant: \(appError)")
            case .success(_):
                print("Participant added!")
                DispatchQueue.main.async {
                    self.addedParticipantDelegate?.participantAddedToRaffle()
                    self.dismiss(animated: true)
                }
            }
        }
    }
    
}
