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
    var db: DatabaseHelper!
    var username: String!

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var uniqueUsername: UILabel!
    @IBOutlet weak var uniqueEmail: UILabel!
    @IBOutlet weak var uniquePassword: UILabel!
    
    @IBAction func returnToLoginPage(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Retrieve user information from the database
        let dbHelper = DatabaseHelper()
        print(dbHelper) // check if dbHelper is nil
        
        userNameLabel.text = username

        if let retrievedUniqueUserData = dbHelper.retrieveUniqueUserData(forUsername: username) {
            uniqueUsername.text = retrievedUniqueUserData.username
            uniqueEmail.text = retrievedUniqueUserData.email
            uniquePassword.text = retrievedUniqueUserData.password
        } else {
            print("User not found")
            // You can display an error message or go back to the previous screen here
        }
    }
    
    /*@IBAction func archivedPlanButtonPressed(_ sender: UIButton) {
        
        let ArchiveViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ArchiveViewController") as! ArchiveViewController
                //
                self.navigationController?.pushViewController(ArchiveViewController, animated: true)
        
    }*/
    
}
