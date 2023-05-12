//
//  DataStore.swift
//  Assignment 3
//
//  Created by vinay bayyapunedi on 12/05/23.
//

import Foundation


struct Plan: Codable {
    
    var planID: Int
    var planName: String
    var amount: Int
    var transactionTime: Int
    var paymentType: String
}

class DataStore {
    
    static let shared = DataStore()
    
    var storedPlans: [Plan] = [
        Plan(planID: 1, planName: "plan1", amount: 60, transactionTime: 6, paymentType: "Cash"),
        Plan(planID: 2, planName: "plan2", amount: 40, transactionTime: 2, paymentType: "Card")
    ]
    
    var planID: Int = 3
    
    var descriptionPlan: Plan = Plan(planID: 0, planName: "Dummy", amount: 0, transactionTime: 0, paymentType: "Dummy")
    
    
    func findPlanByID(ID: Int) -> Plan {
        
        for plan in storedPlans {
            
            if (plan.planID == ID) {
                return plan
            }
        }
        
        return Plan(planID: 0, planName: "Error", amount: 0, transactionTime: 0, paymentType: "Error")
    }
    
    func addNewPlan(name: String, money: Int, time: Int, payType: String) {
        storedPlans.append(Plan(planID: planID, planName: name, amount: money, transactionTime: time, paymentType: payType))
        planID += 1
    }
    
    func getPlanStoredLocation(planID: Int) -> Int {
        guard storedPlans.count > 1 else {
            return 0
        }
        
        for index in (0...storedPlans.count - 1) {
            if storedPlans[index].planID == planID {
                return index
            }
        }// end of for loop
        
        return 0
    }
    
}
