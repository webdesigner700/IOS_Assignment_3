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

    var descriptionPlan: Plan?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        planTypeLabel.text = planType
        
        if (DataStore.shared.descriptionPlan.planName != "Dummy") {
            self.descriptionPlan = DataStore.shared.descriptionPlan
            DataStore.shared.descriptionPlan = Plan(planID: 0, planName: "Dummy", amount: 0, transactionTime: 0, paymentType: "Dummy")
            
            planNameTextField.text = self.descriptionPlan!.planName
            amountTextField.text = String(self.descriptionPlan!.amount)
            transactionTimeTextField.text = String(self.descriptionPlan!.transactionTime)
            paymentTypeTextField.text = self.descriptionPlan!.paymentType
        }
        
    }
    
    @IBAction func savePlanButtonPressed(_ sender: UIButton) {
        
        if (planType == "Expense" || planType == "Influx"){ // create new money plan
            DataStore.shared.addNewPlan(
                name: planNameTextField.text ?? "",
                money: Int(amountTextField.text ?? "0") ?? 0,
                time: Int(transactionTimeTextField.text ?? "0") ?? 0,
                payType: paymentTypeTextField.text ?? ""
            )
        }
        else{ // update existing records with newest information
            let index = DataStore.shared.getPlanStoredLocation(planID: descriptionPlan!.planID)
            DataStore.shared.storedPlans[index].planName = planNameTextField.text ?? ""
            DataStore.shared.storedPlans[index].amount = Int(amountTextField.text ?? "0") ?? 0
            DataStore.shared.storedPlans[index].transactionTime = Int(transactionTimeTextField.text ?? "0") ?? 0
            DataStore.shared.storedPlans[index].paymentType = paymentTypeTextField.text ?? ""
        }
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
