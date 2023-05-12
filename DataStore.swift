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
    
    var storedPlans: [Plan] = []
    
    var allowanceCalculationPeriod: Int = 0 // 0 is Daily, 1 is Weekly, 2 is Monthly
    
    let KEY_MONEY_PLAN = "moneyPlan"
    
    var assignID: Int = 0
    
    func updateAllowancePeriod(period: Int) {
        allowanceCalculationPeriod = period
    }
    
    func addPlan(/*ID: Int, */name: String, amounts: Int, time: Int, payType: String) {
        storedPlans.append(Plan(planID: assignID, planName: name, amount: amounts, transactionTime: time, paymentType: payType))
        assignID += 1
    }
    
    func removePlanByID(ID: Int){
        // Remove this bubble from storedBubble array
        for index in (0...storedPlans.count - 1) {
            if storedPlans[index].planID == ID {
                storedPlans.remove(at: index)
                return
            }
        }// end of for loop
    }
    
    func savePlan(){
        let defaults = UserDefaults.standard
        defaults.set(try? PropertyListEncoder().encode(storedPlans), forKey: KEY_MONEY_PLAN)
    }
    
    // retrieve previous result from user default
    func readGameResults() -> [Plan] {
        let defaults = UserDefaults.standard
        if let savedArrayData = defaults.value(forKey: KEY_MONEY_PLAN) as? Data {
            if let array = try? PropertyListDecoder().decode(Array<Plan>.self, from: savedArrayData){
                return array
            } else {
                return []
            }
        } else {
            return []
        }
        //return array
    }
    
    func clearGameResults(){
        let defaults = UserDefaults.standard
        //defaults.set(gameResultArray, forKey: KEY_GAME_RESULT)
        let emptyArray: [Plan] = []
        //DataStore.shared.gameResultArray
        storedPlans = emptyArray
        defaults.set(try? PropertyListEncoder().encode(emptyArray), forKey: KEY_MONEY_PLAN)
    }
    
}
