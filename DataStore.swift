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
    
    var storedPlans: [Plan] = []
    var storedUsers: [User] = []
    // other properties and methods
    
    private var lastPlanID: Int = 0
    private var lastUserID: Int = 0
    
    func addNewUser(username: String, password: String) {
        let newUser = User(username: username, password: password, planIDs: [])
        storedUsers.append(newUser)
    }
    
    func getUserByUsername(username: String) -> User? {
        for user in storedUsers {
            if user.username == username {
                return user
            }
        }
        return nil // user not found
    }
    
    func addPlanToUser(user: User, planID: Int) {
        user.planIDs.append(planID)
    }
    
    func getPlansForUser(user: User) -> [Plan] {
        var plans: [Plan] = []
        for planID in user.planIDs {
            let plan = findPlanByID(ID: planID)
            plans.append(plan)
        }
        return plans
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
        let newPlanID = lastPlanID + 1
        storedPlans.append(Plan(planID: newPlanID, planName: name, amount: money, transactionTime: time, paymentType: payType))
        lastPlanID = newPlanID
    }
    
    func removePlanByID(planID: Int) {
        storedPlans.removeAll(where: { $0.planID == planID })
    }
    
    func authenticateUser(username: String, password: String) -> User? {
        return storedUsers.first(where: { $0.username == username && $0.password == password })
    }
    
}
