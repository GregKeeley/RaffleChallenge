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
        print("Create raffle button pressed")
    }
    
}
