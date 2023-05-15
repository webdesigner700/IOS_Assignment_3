//
//  HomeScreenViewController.swift
//  Assignment 3
//
//  Created by vinay bayyapunedi on 10/05/23.
//

import Foundation
import UIKit

class HomeScreenViewController: UIViewController {
    
    let NEW_PLAN = "newPlan"
    
    let planNameTag = 100
    let amountTag = 101
    let payTag = 102
    let timeTag = 103
    
    var userName:String?

    var descriptionButtonChecker = false
    
    var tag = 0
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeframeLabel: UILabel!
    @IBOutlet weak var allowanceAmountLabel: UILabel!
    
    @IBOutlet weak var planDetailsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        planDetailsTable.delegate = self
        planDetailsTable.dataSource = self
        
        userNameLabel.text = userName
        
        timeframeLabel.text = DataStore.shared.timeFrame
        
        allowanceAmountLabel.text = "\( DataStore.shared.calculatedAllowanceAmount!)"
        
        // Remove the default back button
        navigationItem.hidesBackButton = true
        
        // Create a custom bar button item for the log out button
        let logOutButton = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(logOut))
        
        // Set the custom button as the left bar button item
        navigationItem.leftBarButtonItem = logOutButton
    }
    
    @objc func logOut() {
        // Reset the user session
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        UserDefaults.standard.synchronize()

        // Navigate to the login screen
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "ViewController")
        let navController = UINavigationController(rootViewController: loginVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        planDetailsTable.reloadData()
        timeframeLabel.text = DataStore.shared.timeFrame
        DataStore.shared.calculateAllowance()
        allowanceAmountLabel.text = "\( DataStore.shared.calculatedAllowanceAmount!)"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToProfilePage" {
            if let userName = userNameLabel?.text {
                let VC = segue.destination as! ProfileViewController
//                VC.userName = userName
            }
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
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        guard DataStore.shared.storedPlans.count > 0 else {
            return
        }
        
        DataStore.shared.storedPlans.remove(at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        planDetailsTable.deleteRows(at: [indexPath], with: .fade)
        
        
    }
    

}

// These are extensions for the TableView that are essential

extension HomeScreenViewController:UITableViewDelegate {
    
}

extension HomeScreenViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return DataStore.shared.storedPlans.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let plan = DataStore.shared.storedPlans[indexPath.row]
        //let idLabel = cell.viewWithTag(idTag) as? UILabel
        
        print("Now this cell is processing plan at index path row \(indexPath.row)")
        print(plan)
        
        
        
        if let planNameLabel = cell.viewWithTag(planNameTag) as? UILabel {
            planNameLabel.text = plan.planName
        }
        
        if let amountLabel = cell.viewWithTag(amountTag) as? UILabel {
            amountLabel.text = String(plan.amount)
        }
        
        if let idLabel = cell.viewWithTag(payTag) as? UILabel {
            idLabel.text = String(plan.paymentType)
        }
        
        if let idLabel = cell.viewWithTag(timeTag) as? UILabel {
            idLabel.text = String(plan.transactionTime)
        }
        
//        if let descriptionButton = cell.viewWithTag(descriptionTag) as? UIButton {
//
//
//            descriptionButton.tag = indexPath.row
//
//            //print("Adding button with tag \(plan.planID) into array")
//
//            descriptionButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
//            // this runs when the button is pressed on
//        }

        return cell
    }
    
}

class CustomTableViewCell: UITableView {
    
}
