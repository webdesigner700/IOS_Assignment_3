//
//  ViewController.swift
//  Assignment 3
//
//  Created by vinay bayyapunedi on 08/05/23.
//

//import Foundation
//import UIKit
//
//class ViewController: UIViewController {
//
//    @IBOutlet weak var mainLabel: UILabel!
//
//    @IBOutlet weak var userNameTextField: UITextField!
//
//    @IBOutlet weak var passwordTextField: UITextField!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        self.hideKeyboardWhenTappedAround()
//    }
//
//    // we have to send the uername to the home screen
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "goToHomePage" {
//            let VC = segue.destination as! HomeScreenViewController
//            VC.userName = userNameTextField.text!
//        }
//    }
//
//
//}
//
//extension UIViewController {
//    func hideKeyboardWhenTappedAround() {
//        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
//    }
//
//    @objc func dismissKeyboard() {
//        view.endEditing(true)
//    }
//}


import Foundation
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let username = userNameTextField.text, let password = passwordTextField.text else {
            return
        }

        if isValid(username: username, password: password) {
            performSegue(withIdentifier: "goToHomePage", sender: nil)
        } else {
            showAlert(message: "Invalid username or password.")
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToHomePage" {
            let VC = segue.destination as! HomeScreenViewController
            VC.userName = userNameTextField.text!
        }
    }

    private func isValid(username: String, password: String) -> Bool {
        // Implement your data store validation logic here
        // Return true if the entered username and password are valid, false otherwise
        // For example:
        let validUsername = "johndoe"
        let validPassword = "password"
        return username == validUsername && password == validPassword
    }

    private func showAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
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
