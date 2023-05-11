//
//  ProfileVoewController.swift
//  Assignment 3
//
//  Created by vinay bayyapunedi on 10/05/23.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {

    
    var userName:String?

    @IBOutlet weak var userNameLabel: UILabel!
    
    
    @IBAction func returnToLoginPage(_ sender: UIButton) {
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameLabel.text = userName
    }


}
