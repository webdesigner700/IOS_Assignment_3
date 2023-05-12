//
//  HomeScreenViewController.swift
//  Assignment 3
//
//  Created by vinay bayyapunedi on 10/05/23.
//

import Foundation
import UIKit


struct Plan: Codable {
    
    var planName: String
    var amount: Int
    var transactionTime: Int
    var paymentType: String
}

let NEW_PLAN = "newPlan"

class HomeScreenViewController: UIViewController {
    
    var userName:String?
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var planDetailsTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameLabel.text = userName
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToProfilePage" {
            let VC = segue.destination as! ProfileViewController
            VC.userName = userNameLabel.text!
        }
        else if segue.identifier == "goToNewExpenses" {
            let VC = segue.destination as! NewPlanViewController
            VC.planType = "Expense"
        }
        else if segue.identifier == "goToNewInflux" {
            let VC = segue.destination as! NewPlanViewController
            VC.planType = "Influx"
        }
    }

}
