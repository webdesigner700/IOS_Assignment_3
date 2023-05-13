//
//  NewPlanViewController.swift
//  Assignment 3
//
//  Created by vinay bayyapunedi on 10/05/23.
//

import Foundation
import UIKit

class NewPlanViewController: UIViewController {
    
    var planType:String?
    
    @IBOutlet weak var planNameTextField: UITextField!
    @IBOutlet weak var planTypeLabel: UILabel!
    @IBOutlet weak var transactionTimeTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var paymentTypeTextField: UITextField!
    @IBOutlet weak var removePlanButton: UIButton!
    @IBOutlet weak var mathSymbolLabel: UILabel!
    
    var descriptionPlan: Plan?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        removePlanButton.isHidden = true
        
        if (DataStore.shared.descriptionPlan.planName != "Dummy") {
            self.descriptionPlan = DataStore.shared.descriptionPlan
            DataStore.shared.descriptionPlan = Plan(planID: 0, planName: "Dummy", amount: 0, transactionTime: 0, paymentType: "Dummy")
            planNameTextField.text = self.descriptionPlan!.planName
            amountTextField.text = String(self.descriptionPlan!.amount)
            transactionTimeTextField.text = String(self.descriptionPlan!.transactionTime)
            paymentTypeTextField.text = self.descriptionPlan!.paymentType
        }
        
        if (planType != nil){
            planTypeLabel.text = "New Money \(planType!)"
            if (planType == "Influx"){
                mathSymbolLabel.text = "+"
            }
            else if (planType == "Expense"){
                mathSymbolLabel.text = "-"
            }
        }
        else if (descriptionPlan != nil){
            
            planTypeLabel.text = "View Plan Detail"
            //removePlanButton.isHidden = false
            
            if (descriptionPlan!.amount >= 0){
                mathSymbolLabel.text = "+"
            }
            else{
                mathSymbolLabel.text = "-"
            }
        }
        
    }
    
    @IBAction func savePlanButtonPressed(_ sender: UIButton) {
        
        if (planType == "Expense"){ // create new money plan
            let actualAmount = (0 - (Int(amountTextField.text ?? "0") ?? 0))
            DataStore.shared.addNewPlan(name: planNameTextField.text ?? "", money: actualAmount, time: Int(transactionTimeTextField.text ?? "0") ?? 0, payType: paymentTypeTextField.text ?? ""
            )
        }
        else if (planType == "Influx"){
            DataStore.shared.addNewPlan(
                name: planNameTextField.text ?? "",
                money: Int(amountTextField.text ?? "0") ?? 0,
                time: Int(transactionTimeTextField.text ?? "0") ?? 0,
                payType: paymentTypeTextField.text ?? ""
            )
        }
        else{ // update existing records with newest information
            let index = DataStore.shared.getPlanStoredLocation(planID: descriptionPlan!.planID)
            print(descriptionPlan!)
            if (index >= 0){
                DataStore.shared.storedPlans[index].planName = planNameTextField.text ?? ""
                DataStore.shared.storedPlans[index].amount = Int(amountTextField.text ?? "0") ?? 0
                DataStore.shared.storedPlans[index].transactionTime = Int(transactionTimeTextField.text ?? "0") ?? 0
                DataStore.shared.storedPlans[index].paymentType = paymentTypeTextField.text ?? ""
            }
                        
        }
                
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func removePlanButtonPressed(_ sender: UIButton) {
        
        // Following code for creating alert window is from an online tutorial,
        // Link: www.appsdeveloperblog.com/how-to-show-an-alert-in-swift
        
        // Create Alert
        let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to delete this?", preferredStyle: .alert)
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            DataStore.shared.removePlanByID(planID: self.descriptionPlan!.planID)
            // Go back to previous screen, which should be the main menu in current context
            
            self.navigationController?.popViewController(animated: true)
            // Update UI here to make the table display with empty results
        })
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
        }
        //Add OK and Cancel button to an Alert object
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        // Present alert message to user
        self.present(dialogMessage, animated: true, completion: nil)
        
        
    }
    
}
