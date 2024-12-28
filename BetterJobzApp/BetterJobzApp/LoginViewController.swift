//
//  LoginViewController.swift
//  BetterJobzApp
//
//  Created by BP-36-201-01 on 03/12/2024.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Check if a user is already logged in
        if let currentUser = Auth.auth().currentUser {
            // Ensure the user's email is available
            guard let email = currentUser.email else {
                print("Error: Email not found for the current user.")
                return
            }

            DispatchQueue.main.async {
                // Navigate based on the user type
                if email.lowercased().contains("employee") {
                    self.performSegue(withIdentifier: "goToEmpHome", sender: self)
                } else {
                    self.performSegue(withIdentifier: "showDashboardSegue", sender: self)
                }
            }
        }
    }

    

    
    //Employee Login Credentials : tom.employee@gmail.com , password : 123456
    //Job Seeker Login Credentials : Johndoe@Gmail.com , Password : JDoe123
    
    
    @IBOutlet weak var Username: UITextField!
    
    @IBOutlet weak var Password: UITextField!
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        // Validate username and password fields
            guard let username = Username.text, !username.isEmpty,
                  let password = Password.text, !password.isEmpty else {
                showAlert(title: "Missing Field Data", message: "Please fill in all required fields")
                return
            }

            // Attempt to sign in the user
            Auth.auth().signIn(withEmail: username, password: password) { [weak self] authResult, error in
                guard let self = self else { return }

                if let error = error {
                    // Show error alert if login fails
                    self.showAlert(title: "Error", message: error.localizedDescription)
                    return
                }

                DispatchQueue.main.async {
                    // Perform navigation based on user type
                    if username.lowercased().contains("employee") {
                        self.performSegue(withIdentifier: "goToEmpHome", sender: sender)
                    } else {
                        self.performSegue(withIdentifier: "showDashboardSegue", sender: sender)
                    }
                }

                // Log user ID for debugging purposes
                if let user = Auth.auth().currentUser {
                    print("Logged in as UID: \(user.uid)")
                }
            }
    }

    // Helper function to show an alert
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

   
}
