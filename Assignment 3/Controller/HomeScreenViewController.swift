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
    let descriptionTag = 102
    
    var userName:String?

    var descriptionButtonChecker = false
    
//    var newPlans:[Plan] = [
//        Plan(planID: 1, planName: "plan1", amount: 60, transactionTime: 6, paymentType: "Cash"),
//        Plan(planID: 2, planName: "plan2", amount: 40, transactionTime: 2, paymentType: "Card")]
    
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeframeLabel: UILabel!
//
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
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        print("now this button has tag of \(sender.tag)")
        //print("the plan name would be \(tableDisplayedPlanName!)")
        let descriptionPlan = DataStore.shared.findPlanByID(ID: sender.tag)
        
        DataStore.shared.descriptionPlan = descriptionPlan
        
        descriptionButtonChecker = true
        
        let NewPlanViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewPlanViewController") as! NewPlanViewController
        
        self.navigationController?.pushViewController(NewPlanViewController, animated: true)
    
        
        
//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if segue.identifier == "goToPlanDescription" {
//                let VC = segue.destination as! NewPlanViewController
//                VC.planNameTextField.text = plan.planName
//                VC.amountTextField.text = String(plan.amount)
//                VC.paymentTypeTextField.text = plan.paymentType
//            }
//        }
        
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
        
        print("Now this cell is processing plan at index path row \(indexPath.row)")
        print(plan)
        print("The button in this cell has tag: \(cell.viewWithTag(descriptionTag)!.tag)")
        
        if let planNameLabel = cell.viewWithTag(planNameTag) as? UILabel {
            planNameLabel.text = plan.planName
        }
        
        if let amountLabel = cell.viewWithTag(amountTag) as? UILabel {
            amountLabel.text = String(plan.amount)
        }
        
        if let descriptionButton = cell.viewWithTag(descriptionTag) as? UIButton {
            
            print("before changing button tag, the data are:")
            print("button tag is \(descriptionButton.tag)")
            print("plan id is \(plan.planID)")
            
            descriptionButton.tag = plan.planID
            
            print("after changing, the button tag:")
            print(descriptionButton.tag)
            
            print("--------")
            
            descriptionButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            // this runs when the button is pressed on
        }
        
        print("--------|")

        return cell
    }
}

class CustomTableViewCell: UITableView {
    
}
