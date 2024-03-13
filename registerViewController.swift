//
//  registerViewController.swift
//  Uplift
//
//  Created by Mohammed Ali on 11/20/23.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class registerViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordTextFieldConfirmation: UITextField!
    var db: Firestore!
    
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        nameTextField.delegate = self
        usernameTextField.delegate = self
        emailAddressTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextFieldConfirmation.delegate = self

    }
    
    
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        guard let name = nameTextField.text,
            let username = usernameTextField.text,
            let email = emailAddressTextField.text,
            let password = passwordTextField.text,
            let confirmPassword = passwordTextFieldConfirmation.text else {
            return
        }
        if password != confirmPassword {
            return
        }
                checkUsernameAvailability(username: username) { isAvailable in
                    if isAvailable {
                        self.registerUser(name: name, username: username, email: email, password: password)
                        self.dismiss(animated: true, completion: nil)
                    } else {
                    }
                }
        
    }
    func checkUsernameAvailability(username: String, completion: @escaping (Bool) -> Void) {
            let usersRef = db.collection("users")
            usersRef.whereField("username", isEqualTo: username).getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error checking username availability: \(error.localizedDescription)")
                    completion(false)
                } else {
                    completion(snapshot?.documents.isEmpty ?? true)
                }
            }
        }

        func registerUser(name: String, username: String, email: String, password: String) {
            let usersRef = db.collection("users")
            
            let userData = ["name": name, "username": username, "email": email, "password": password, "contributions": 0] as [String : Any]

            usersRef.addDocument(data: userData) { error in
                if let error = error {
                    print("Error adding user to Firestore: \(error.localizedDescription)")
                } else {
                    print("User registered successfully!")
                    
                    
                }
            }
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    
    


}
