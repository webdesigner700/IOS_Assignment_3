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
                VC.userName = userName
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
