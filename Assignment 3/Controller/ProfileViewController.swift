//
//  ProfileVoewController.swift
//  Assignment 3
//
//  Created by vinay bayyapunedi on 10/05/23.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {

    var user: User?
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBAction func returnToLoginPage(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Retrieve user information from the database
        if let userID = user?.id {
            let db = YourDatabaseConnection()
            let query = "SELECT email, username, password FROM users WHERE id = \(userID)"
            if let result = db.executeQuery(query) {
                if result.next() {
                    let email = result.string(forColumn: "email")
                    let username = result.string(forColumn: "username")
                    let password = result.string(forColumn: "password")
                    emailLabel.text = email
                    userNameLabel.text = username
                    passwordLabel.text = password
                }
            }
        }
    }
}
