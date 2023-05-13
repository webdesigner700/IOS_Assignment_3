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



import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var loginFormView: UIView!
    @IBOutlet weak var usernameLogin: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordLogin: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signUpFormView: UIView!
    @IBOutlet weak var emailSignUp: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameSignUp: UILabel!
    @IBOutlet weak var signUpUsernameTextField: UITextField!
    @IBOutlet weak var passwordSignUp: UILabel!
    @IBOutlet weak var signUpPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Show the login view by default
        usernameLogin.isHidden = false
        usernameTextField.isHidden = false
        passwordLogin.isHidden = false
        passwordTextField.isHidden = false
        loginButton.isHidden = false
        emailSignUp.isHidden = true
        emailTextField.isHidden = true
        usernameSignUp.isHidden = true
        signUpUsernameTextField.isHidden = true
        passwordSignUp.isHidden = true
        signUpPasswordTextField.isHidden = true
        signUpButton.isHidden = true

        // Add a target to the segmented control to handle changes
        segmentedControl.addTarget(self, action: #selector(handleSegmentedControlChange), for: .valueChanged)
    }

    @objc func handleSegmentedControlChange() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            // Show the login view and hide the sign-up view
            usernameLogin.isHidden = false
            usernameTextField.isHidden = false
            passwordLogin.isHidden = false
            passwordTextField.isHidden = false
            loginButton.isHidden = false
            emailSignUp.isHidden = true
            emailTextField.isHidden = true
            usernameSignUp.isHidden = true
            signUpUsernameTextField.isHidden = true
            passwordSignUp.isHidden = true
            signUpPasswordTextField.isHidden = true
            signUpButton.isHidden = true
        case 1:
            // Show the sign-up view and hide the login view
            usernameLogin.isHidden = true
            usernameTextField.isHidden = true
            passwordLogin.isHidden = true
            passwordTextField.isHidden = true
            loginButton.isHidden = true
            emailSignUp.isHidden = false
            emailTextField.isHidden = false
            usernameSignUp.isHidden = false
            signUpUsernameTextField.isHidden = false
            passwordSignUp.isHidden = false
            signUpPasswordTextField.isHidden = false
            signUpButton.isHidden = false
        default:
            break
        }
    }
    
    func login(username: String?, password: String?, completion: @escaping (Bool) -> Void) {
        // Check if the username and password are not nil
        guard let username = username, let password = password else {
            completion(false)
            return
        }
        
        // Query the database to check if the user exists and the password is correct
        let query = "SELECT * FROM users WHERE username = ? AND password = ?"
        let params = [username, password]
        executeQuery(query: query, params: params) { result in
            if result.success, let rows = result.rows, rows.count == 1 {
                // User exists and password is correct
                completion(true)
            } else {
                // User does not exist or password is incorrect
                completion(false)
            }
        }
    }

    @IBAction func signUpButtonTapped(_ sender: Any) {
        // Validate the input fields and create a new account
        let email = emailTextField.text
        let username = signUpUsernameTextField.text
        let password = signUpPasswordTextField.text
        
        // Call the sign up function from the database manager
        DatabaseHelper.shared.signUp(email: email, username: username, password: password) { success in
            if success {
                // Signup successful, perform segue to next screen
                self.performSegue(withIdentifier: "signupSuccessfulSegue", sender: self)
            } else {
                // Signup failed, display error message
                let alertController = UIAlertController(title: "Error", message: "Unable to create account.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
        
}


