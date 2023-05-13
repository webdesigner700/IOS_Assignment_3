//
//  DatabaseHelper.swift
//  Assignment 3
//
//  Created by Grace Rufina Solibun on 14/5/2023.
//

import Foundation
import SQLite3

class DatabaseHelper {
    
    static let shared = DatabaseHelper()
    private var database: Connection?
    
    private let usersTable = Table("users")
    private let id = Expression<Int>("id")
    private let email = Expression<String>("email")
    private let username = Expression<String>("username")
    private let password = Expression<String>("password")
    
    private init() {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            database = try Connection("\(path)/users.sqlite3")
            createTable()
        } catch {
            print("Error creating database: \(error)")
        }
    }
    
    func createTable() {
        guard let database = database else { return }
        
        do {
            try database.run(usersTable.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(email, unique: true)
                table.column(username, unique: true)
                table.column(password)
            })
        } catch {
            print("Error creating table: \(error)")
        }
    }
    
    func insertUser(email: String, username: String, password: String) {
        guard let database = database else { return }
        
        let insert = usersTable.insert(self.email <- email, self.username <- username, self.password <- password)
        
        do {
            try database.run(insert)
            print("User inserted successfully")
        } catch {
            print("Error inserting user: \(error)")
        }
    }
    
    func getUser(username: String) -> (email: String, password: String)? {
        guard let database = database else { return nil }
        
        let query = usersTable.filter(self.username == username)
        
        do {
            if let user = try database.pluck(query) {
                let email = user[self.email]
                let password = user[self.password]
                return (email, password)
            } else {
                print("User not found")
                return nil
            }
        } catch {
            print("Error retrieving user: \(error)")
            return nil
        }
    }
    
}
