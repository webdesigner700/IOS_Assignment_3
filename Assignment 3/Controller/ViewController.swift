//
//  ViewController.swift
//  Assignment 3
//
//  Created by vinay bayyapunedi on 08/05/23.
//

import Foundation
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // we have to send the uername to the home screen
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToHomePage" {
            let VC = segue.destination as! HomeScreenViewController
            VC.userName = userNameTextField.text!
        }
    }


}
