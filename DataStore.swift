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
        Plan(planID: 2, planName: "plan2", amount: 40, transactionTime: 2, paymentType: "Card")]
    
    var descriptionPlan: Plan = Plan(planID: 0, planName: "Dummy", amount: 0, transactionTime: 0, paymentType: "Dummy")
    
    
    func findPlanByID(ID: Int) -> Plan {
        
        for plan in storedPlans {
            
            if (plan.planID == ID) {
                return plan
            }
        }
        
        return Plan(planID: 0, planName: "Error", amount: 0, transactionTime: 0, paymentType: "Error")
    }
    
    
}
