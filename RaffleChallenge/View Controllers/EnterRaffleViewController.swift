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
        guard let firstName = firstNameTextField.text, !firstName.isEmpty, let lastName = lastNameTextField.text, !lastName.isEmpty, let emailAddress = emailAddressTextField.text, !emailAddress.isEmpty else {
            showAlert(title: "First name, Last name and Email are required", message: "Please check all fields have been filled")
            return
        }
        let phoneNumber = phoneNumberTextField.text
        RaffleAPIClient.addParticipantToRaffle(firstName: firstName, lastName: lastName, email: emailAddress, phone: phoneNumber, raffleID: raffleID ?? -1) { (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self.showAlert(title: "Something went wrong", message: "\(appError)")
                }
            case .success(let response):
                DispatchQueue.main.async {
                    self.addedParticipantDelegate?.participantAddedToRaffle()
                    self.showAlert(title: "\(response.title ?? "Error")", message: "\(response.content ?? "Error")") { _ in
                        self.dismiss(animated: true)
                    }
                    
                }
            }
        }
    }
    
}
