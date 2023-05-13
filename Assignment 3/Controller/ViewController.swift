//
//  ViewController.swift
//  Assignment 3
//
//  Created by vinay bayyapunedi on 08/05/23.
//

import Foundation
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!

    @IBOutlet weak var userNameTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()
    }

    // we have to send the uername to the home screen

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToHomePage" {
            let VC = segue.destination as! HomeScreenViewController
            VC.userName = userNameTextField.text!
        }
    }


}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


//import Foundation
//import UIKit
//
//class LoginViewController: UIViewController {
//
//    @IBOutlet weak var mainLabel: UILabel!
//    @IBOutlet weak var userNameTextField: UITextField!
//    @IBOutlet weak var passwordTextField: UITextField!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.hideKeyboardWhenTappedAround()
//    }
//
//    @IBAction func loginButtonTapped(_ sender: Any) {
//        guard let username = userNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
//              let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
//              !username.isEmpty, !password.isEmpty else {
//            showAlert(message: "Please enter both username and password.")
//            return
//        }
//
//        let user = User(username: username, password: password, planIDs: [])
//        let dataStore = UserStore()
//        if let existingUser = dataStore.getUser(username: username) {
//            // User exists, validate password
//            if existingUser.password == user.password {
//                // Successful login
//                performSegue(withIdentifier: "goToHomePage", sender: nil)
//            } else {
//                // Invalid password
//                showAlert(message: "Invalid password.")
//            }
//        } else {
//            // User does not exist, add to datastore
//            dataStore.addUser(user: user)
//            performSegue(withIdentifier: "goToHomePage", sender: nil)
//        }
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "goToHomePage" {
//            guard let destinationVC = segue.destination as? HomeScreenViewController,
//                  let username = userNameTextField.text else { return }
//            destinationVC.userName = username
//        }
//    }
//
//    private func showAlert(message: String) {
//        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
//        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//        alertController.addAction(alertAction)
//        present(alertController, animated: true, completion: nil)
//    }
//}
//
//extension UIViewController {
//    func hideKeyboardWhenTappedAround() {
//        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
//    }
//
//    @objc func dismissKeyboard() {
//        view.endEditing(true)
//    }
//}
//
////struct User {
////    let username: String
////    let password: String
////    let planIDs: [String]
////}
//
//class UserStore {
//    private var users: [User] = []
//
//    func addUser(user: User) {
//        users.append(user)
//    }
//
//    func getUser(username: String) -> User? {
//        return users.first(where: { $0.username == username })
//    }
//}


