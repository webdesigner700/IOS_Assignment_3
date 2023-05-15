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
    
    var originalAllowanceAmount: Int = 0
    
    var calculatedAllowanceAmount: Int?
    
    var timeFrame: String?
    
    private init() {
        
        calculatedAllowanceAmount = originalAllowanceAmount
        timeFrame = "Monthly"
    }

    var storedPlans: [Plan] = []

    var buttonIDs: [Int] = []

    var planID: Int = 2

    var descriptionPlan: Plan = Plan(planID: 0, planName: "Dummy", amount: 0, transactionTime: 0, paymentType: "Dummy")
    
    var timeSelecterLocation: Int = 2

    var allowanceNote: String?

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

            if storedPlans[index].planID == planID {
                storedPlans.remove(at: index)
                //self.planID -= 1
                return
            }
        }// end of for loop
    }

    func addPlanToUser(user: inout User, planID: Int) {
        user.planIDs.append(planID)
    }

}
