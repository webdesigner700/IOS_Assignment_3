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
    
    var db : OpaquePointer?
    
    var path : String = "A3.db"
    
    init() {
        self.db = createDB()
        self.createTable()
    }
    
    func createDB() -> OpaquePointer? {
        let fileURL = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(path)
        
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
            return nil
        } else {
            print("database opened successfully")
            return db
        }
    }
    
    func createTable() {
        let createTableQuery = """
            CREATE TABLE IF NOT EXISTS Users (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                email TEXT UNIQUE,
                username TEXT UNIQUE,
                password TEXT
            );
        """
        
        var createTableStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, createTableQuery, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Users table created successfully")
            } else {
                print("error creating users table")
            }
        } else {
            print("error preparing create table statement")
        }
        
        sqlite3_finalize(createTableStatement)
    }
    
    func insertUser(email: String, username: String, password: String) {
        let insertStatement = "INSERT INTO Users (email, username, password) VALUES ('\(email)', '\(username)', '\(password)');"
        
        if sqlite3_exec(db, insertStatement, nil, nil, nil) == SQLITE_OK {
            print("User inserted successfully.")
        } else {
            print("User insertion failed.")
        }
    }
    
    func loginUser(email: String, password: String) -> Bool {
        let loginUserQuery = "SELECT COUNT(*) FROM Users WHERE email = ? AND password = ?;"
        var loginUserStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, loginUserQuery, -1, &loginUserStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(loginUserStatement, 1, email, -1, nil)
            sqlite3_bind_text(loginUserStatement, 2, password, -1, nil)
            
            if sqlite3_step(loginUserStatement) == SQLITE_ROW {
                let count = sqlite3_column_int(loginUserStatement, 0)
                if count > 0 {
                    print("User logged in successfully")
                    return true
                } else {
                    print("Incorrect email or password")
                    return false
                }
            } else {
                print("error retrieving user data")
                return false
            }
        } else {
            print("error preparing login user statement")
            return false
        }
        
        sqlite3_finalize(loginUserStatement)
    }
    
    func userExists(email: String) -> Bool {
        let userExistsQuery = "SELECT COUNT(*) FROM Users WHERE email = ?;"
        var statement: OpaquePointer?
        var userCount = 0
        
        if sqlite3_prepare_v2(db, userExistsQuery, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, email, -1, nil)
            
            if sqlite3_step(statement) == SQLITE_ROW {
                userCount = Int(sqlite3_column_int(statement, 0))
            }
        }
        
        sqlite3_finalize(statement)
        
        return userCount > 0
    }
    
    func signUp(email: String?, username: String?, password: String?, completion: @escaping (Bool) -> Void) {
        guard let email = email, let username = username, let password = password else {
            completion(false)
            return
        }
        
        if userExists(email: email) {
            completion(false)
            return
        }
        
        insertUser(email: email, username: username, password: password)
        completion(true)
    }
    
    func login(username: String, password: String, completion: @escaping (Bool) -> Void) {
        let query = "SELECT * FROM users WHERE username = ? AND password = ?;"
        
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            // Bind parameters to the statement
            sqlite3_bind_text(statement, 1, (username as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (password as NSString).utf8String, -1, nil)
            
            // Execute the statement
            if sqlite3_step(statement) == SQLITE_ROW {
                // User found, login successful
                completion(true)
            } else {
                // User not found, login failed
                completion(false)
            }
        } else {
            // Statement preparation failed
            print("Error preparing statement: \(String(cString: sqlite3_errmsg(db)))")
            completion(false)
        }
        
        // Reset the statement and finalize it
        sqlite3_reset(statement)
        sqlite3_finalize(statement)
    }
    
    func retrieveUniqueUserData(forUsername username: String) -> (username: String, email: String, password: String)? {
        let query = "SELECT username, email, password FROM Users WHERE username = ?;"
        var statement: OpaquePointer?

        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            // Bind parameters to the statement
            sqlite3_bind_text(statement, 1, (username as NSString).utf8String, -1, nil)

            // Execute the statement
            if sqlite3_step(statement) == SQLITE_ROW {
                // User found, retrieve data
                let username = String(cString: sqlite3_column_text(statement, 0))
                let email = String(cString: sqlite3_column_text(statement, 1))
                let password = String(cString: sqlite3_column_text(statement, 2))

                return (username, email, password)
            } else {
                // User not found
                return nil
            }
        } else {
            // Statement preparation failed
            print("Error preparing statement: \(String(cString: sqlite3_errmsg(db)))")
            return nil
        }
        
        // Reset the statement and finalize it
        sqlite3_reset(statement)
        sqlite3_finalize(statement)
    }

}


