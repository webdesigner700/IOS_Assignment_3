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
    
    let removeButtonTag = 200
    
    var numberOfUpdatedButtons = 0
    
    var userName:String?

    //var descriptionButtonChecker = false
    
    var tag = 0
    
//    var newPlans:[Plan] = [
//        Plan(planID: 1, planName: "plan1", amount: 60, transactionTime: 6, paymentType: "Cash"),
//        Plan(planID: 2, planName: "plan2", amount: 40, transactionTime: 2, paymentType: "Card")]
    
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeframeLabel: UILabel!
//
    //@IBOutlet weak var planIDLabel: UILabel!
    //    @IBOutlet weak var tableDisplayedPlanName: UILabel!
    
    @IBOutlet weak var planDetailsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        planDetailsTable.delegate = self
        planDetailsTable.dataSource = self
        
        userNameLabel.text = userName
        
        timeframeLabel.text = DataStore.shared.timeframe
        
        
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
        
        //self.viewDidLoad()
        
//        planDetailsTable.delegate = self
//        planDetailsTable.dataSource = self
        
        //userNameLabel.text = userName
        
        planDetailsTable.reloadData()
        timeframeLabel.text = DataStore.shared.timeframe
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "goToProfilePage" {
//            let VC = segue.destination as! ProfileViewController
//            VC.userName = userNameLabel.text!
//        }
//        else if segue.identifier == "goToNewExpenses" {
//            let VC = segue.destination as! NewPlanViewController
//            VC.planType = "Expense"
//        }
//        else if segue.identifier == "goToNewInflux" {
//            let VC = segue.destination as! NewPlanViewController
//            VC.planType = "Influx"
//        }
//    }
    
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
    
    @IBAction func removeButtonPressed(_ sender: UIButton){
        
        print("This button has tag of \(sender.tag)")
        
        let descriptionPlan = DataStore.shared.findPlanByID(ID: sender.tag)
        //        let descriptionPlan = DataStore.shared.findPlanByID(ID: Int(planIDText)!)
        //
        DataStore.shared.descriptionPlan = descriptionPlan
        //
        //descriptionButtonChecker = true
        
        sender.tag = removeButtonTag
        print("Now this button should have default tag of \(removeButtonTag)")
        //
        let NewPlanViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewPlanViewController") as! NewPlanViewController
        //
        self.navigationController?.pushViewController(NewPlanViewController, animated: true)
        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        guard DataStore.shared.storedPlans.count > 0 else {
            return
        }
        
        DataStore.shared.storedPlans.remove(at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
//        let thisCell = planDetailsTable.cellForRow(at: indexPath)?.viewWithTag(idTag) as? UILabel
//        let thisPlanID = thisCell?.text
//        print("Removing plan with ID \(thisPlanID)")
        planDetailsTable.deleteRows(at: [indexPath], with: .fade)
        
//        let indexPath = IndexPath(row: sender.tag, section: 0)
//        //let rowNumber = sender.tag
//        //let thisPlanIDLabel = planDetailsTable.cellForRow(at: indexPath)?.viewWithTag(sender.tag) as? UILabel
//        let thisPlanIDLabel = sender.superview?.viewWithTag(sender.tag) as? UILabel
//        //let thisPlanIDLabel = cell?.viewWithTag(planNameTag) as? UILabel
//        let planIDText: String = thisPlanIDLabel?.text ?? "Error String"
//        print(planIDText)

//        let indexPath = IndexPath(row: 0, section: 0)
//        let cell = tableView.cellForRow(at: indexPath)

//        let descriptionPlan = DataStore.shared.findPlanByID(ID: sender.tag)
////        let descriptionPlan = DataStore.shared.findPlanByID(ID: Int(planIDText)!)
//
//        DataStore.shared.descriptionPlan = descriptionPlan
//
//        descriptionButtonChecker = true
//
//        let NewPlanViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewPlanViewController") as! NewPlanViewController
//
//        self.navigationController?.pushViewController(NewPlanViewController, animated: true)
        
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
        
        //if (numberOfUpdatedButtons){
            if let removeButton = cell.viewWithTag(removeButtonTag) as? UIButton {

                print("Found a button with default tag, linking up with plan \(plan.planID)")
                
                removeButton.tag = plan.planID
                //removeButton.tag = indexPath.row

                //print("Adding button with tag \(plan.planID) into array")

                removeButton.addTarget(self, action: #selector(removeButtonPressed), for: .touchUpInside)
                // this runs when the button is pressed on
            }
            else if (DataStore.shared.storedPlans.count > 0){
                let storedPlans = DataStore.shared.storedPlans
                for index in (0...storedPlans.count - 1) {
                    print("Searching for any buttons linked by tag \(storedPlans[index].planID)")
                    if let removeButton = cell.viewWithTag(storedPlans[index].planID) as? UIButton {
                        print("Found this plan is linked with button tag \(removeButton.tag)")
                        print("Updating the button tag with planID \(plan.planID)")
                        removeButton.tag = plan.planID
                        break
                    }
    //
                }// end of for loop
            }
            else{
                print("No button is found during this round")
            }
//        }
//        else{
//            descriptionButtonChecker = false
//        }
        

        return cell
    }
    
}

class CustomTableViewCell: UITableView {
    
}
