//
//  DataStore.swift
//  Assignment 3
//
//  Created by vinay bayyapunedi on 12/05/23.
//



//import Foundation
//
//struct Plan: Codable {
//
//    var planID: Int
//    var planName: String
//    var amount: Int
//    var transactionTime: Int
//    var paymentType: String
//}
//
//struct User: Codable {
//    var username: String
//    var password: String
//    var planIDs: [Int] // stores the IDs of the plans associated with the user
//}
//
//class DataStore {
//
//    static let shared = DataStore()
//
//    var storedPlans: [Plan] = [
//        Plan(planID: 0, planName: "plan1", amount: 60, transactionTime: 6, paymentType: "Cash"),
//        Plan(planID: 1, planName: "plan2", amount: 40, transactionTime: 2, paymentType: "Card")
//    ]
//
//    var buttonIDs: [Int] = []
//
//    var planID: Int = 2
//
//    var descriptionPlan: Plan = Plan(planID: 0, planName: "Dummy", amount: 0, transactionTime: 0, paymentType: "Dummy")
//
//    var timeframe: String = "Weekly"
//    var timeSelecterLocation: Int = 2
//
//    var allowanceNote: String?
//
//    private init(){
//        // put stuff that need to be initialised when the program start running
//        timeframe = "Weekly"
//    }
//
//    func findPlanByID(ID: Int) -> Plan {
//
//        for plan in storedPlans {
//            if (plan.planID == ID) {
//                return plan
//            }
//        }
//        return Plan(planID: 0, planName: "Error", amount: 0, transactionTime: 0, paymentType: "Error")
//    }
//
//    func addNewPlan(name: String, money: Int, time: Int, payType: String) {
//        storedPlans.append(Plan(planID: planID, planName: name, amount: money, transactionTime: time, paymentType: payType))
//        planID += 1
//
//    }
//
//    func getPlanStoredLocation(planID: Int) -> Int {
//        guard storedPlans.count > 1 else {
//            return -1 // return something that is out of bound to prevent incorrect logic operation in main menu
//        }
//
//        for index in (0...storedPlans.count - 1) {
//            if storedPlans[index].planID == planID {
//                return index
//            }
//        }// end of for loop
//
//        return 0
//    }
//
//    func removePlanByID(planID: Int) {
//        guard storedPlans.count > 0 else {
//            return
//        }
//
//        for index in (0...storedPlans.count - 1) {
//
//            if storedPlans[index].planID == planID {
//                storedPlans.remove(at: index)
//                //self.planID -= 1
//                return
//            }
//        }// end of for loop
//    }
//
//    func addPlanToUser(user: inout User, planID: Int) {
//        user.planIDs.append(planID)
//    }
//
//}



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
    
    var buttonIDs: [Int] = []
    
    var planID: Int = 2
    
    var descriptionPlan: Plan = Plan(planID: 0, planName: "Dummy", amount: 0, transactionTime: 0, paymentType: "Dummy")
    
    var timeframe: String = "Weekly"
    var timeSelecterLocation: Int = 2
    
    var allowanceNote: String?
    
    var currentUser: User? = nil
    
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
    
    func authenticateUser(username: String, password: String) -> Bool {
        guard let users = loadUsers() else { return false }
        
        for user in users {
            if user.username == username && user.password == password {
                currentUser = user
                return true
            }
        }
        
        return false
    }
    
    func loadUsers() -> [User]? {
        if let data = UserDefaults.standard.data(forKey: "users"),
           let users = try? PropertyListDecoder().decode([User].self, from: data) {
            return users
        }
        return nil
    }
    
    func saveUsers(_ users: [User]) {
        let data = try? PropertyListEncoder().encode(users)
        UserDefaults.standard.set(data, forKey: "users")
    }
    
    func loadCurrentUser() -> User? {
        if let data = UserDefaults.standard.data(forKey: "currentUser"), let user = try? PropertyListDecoder().decode(User.self, from: data) {
            return user
        }
        return nil
    }
    
    func saveCurrentUser(_ user: User) {
        let data = try? PropertyListEncoder().encode(user)
        UserDefaults.standard.set(data, forKey: "currentUser")
    }
    
    func login(username: String, password: String) -> Bool {
        if let users = loadUsers() {
            for user in users {
                if user.username == username && user.password == password {
                    saveCurrentUser(user)
                    return true
                }
            }
        }
        return false
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: "currentUser")
    }

    func getPlansForCurrentUser() -> [Plan] {
        var plansForUser: [Plan] = []
        if let currentUser = loadCurrentUser() {
            for planID in currentUser.planIDs {
                let plan = DataStore.shared.findPlanByID(ID: planID)
                plansForUser.append(plan)
            }
        }
        return plansForUser
    }
    
}



