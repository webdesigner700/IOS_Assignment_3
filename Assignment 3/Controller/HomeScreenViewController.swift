//
//  HomeScreenViewController.swift
//  Assignment 3
//
//  Created by vinay bayyapunedi on 10/05/23.
//

import Foundation
import UIKit

class HomeScreenViewController: UIViewController {
    
    var userName:String?
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameLabel.text = userName
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToProfilePage" {
            let VC = segue.destination as! ProfileViewController
            VC.userName = userNameLabel.text!
        }
    }


}
