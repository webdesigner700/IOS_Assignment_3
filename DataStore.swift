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

struct User: Codable {
    var username: String
    var password: String
    var planIDs: [Int] // stores the IDs of the plans associated with the user
}

class DataStore {
    
    static let shared = DataStore()
    
    var storedPlans: [Plan] = [
        Plan(planID: 0, planName: "plan1", amount: 60, transactionTime: 6, paymentType: "Cash"),
        Plan(planID: 1, planName: "plan2", amount: 40, transactionTime: 2, paymentType: "Card")
    ]
    
    var planID: Int = 2
    
    var descriptionPlan: Plan = Plan(planID: 0, planName: "Dummy", amount: 0, transactionTime: 0, paymentType: "Dummy")
    
    var timeframe: String = "Weekly"
    
    private init(){
        // put stuff that need to be initialised when the program start running
        timeframe = "Weekly"
    }
    
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
            return -1 // return something that is out of bound to prevent incorrect logic operation in main menu
        }
        
        for index in (0...storedPlans.count - 1) {
            if storedPlans[index].planID == planID {
                return index
            }
        }// end of for loop
        
        return 0
    }
    
    func removePlanByID(planID: Int) {
        guard storedPlans.count > 0 else {
            return
        }
        
        for index in (0...storedPlans.count - 1) {
            print("index is \(index)")
            print("planID is \(planID)")
            print(storedPlans[index].planID)
            if storedPlans[index].planID == planID {
                storedPlans.remove(at: index)
                return
            }
        }// end of for loop
    }
    
}
