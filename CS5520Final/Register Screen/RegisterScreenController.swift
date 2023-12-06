//
//  RegisterScreenController.swift
//  CS5520Final
//
//  Created by Shruti Saravanan on 12/6/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterScreenController: UIViewController {
    
    let registerView = RegisterScreenView()
    let childProgressView = ProgressSpinnerViewController()

    override func loadView() {
        view = registerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        registerView.buttonRegister.addTarget(self, action: #selector(onRegisterTapped), for: .touchUpInside)
        title = "Register"
    }
    
    
    @objc func hideKeyboardOnTap(){
        view.endEditing(true)
    }

    @objc func onRegisterTapped(){
        registerNewAccount()
    }
}

extension RegisterScreenController {
    
    func registerNewAccount() {
        showActivityIndicator()

        guard let name = registerView.textFieldName.text, !name.isEmpty else {
            showAlert(message: "Name is required.")
            hideActivityIndicator()
            return
        }

        guard let email = registerView.textFieldEmail.text, !email.isEmpty, email.isValidEmail() else {
            showAlert(message: "Please enter a valid email address.")
            hideActivityIndicator()
            return
        }

        guard let password = registerView.textFieldPassword.text, !password.isEmpty, password.isValidPassword() else {
            showAlert(message: "Please enter a valid password. Password must be at least 6 characters.")
            hideActivityIndicator()
            return
        }

        guard let repeatPassword = registerView.textFieldRepeatPassword.text, !repeatPassword.isEmpty, repeatPassword == password else {
            showAlert(message: "Passwords do not match.")
            hideActivityIndicator()
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error == nil {
                self.setNameOfTheUserInFirebaseAuth(name: name)
            } else {
                self.showAlert(message: error?.localizedDescription ?? "Unknown error")
                self.hideActivityIndicator()
            }
        }
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Validation Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func setNameOfTheUserInFirebaseAuth(name: String) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges(completion: { [weak self] (error) in
            guard let self = self else { return }

            if let error = error {
                print("Error occurred: \(error.localizedDescription)")
                self.hideActivityIndicator()
            } else {
                if let email = Auth.auth().currentUser?.email {
                    self.addUserToFirestore(name: name, email: email)
                } else {
                    print("Error: Unable to get user's email.")
                    self.hideActivityIndicator()
                }
            }
        })
    }

    private func addUserToFirestore(name: String, email: String) {
        let userData: [String: Any] = [
            "name": name,
            "email": email
        ]

        Firestore.firestore().collection("users").document(email).setData(userData) { [weak self] error in
            guard let self = self else { return }

            if let error = error {
                print("Error adding user to Firestore: \(error.localizedDescription)")
            } else {
                print("User data added to Firestore")
                self.hideActivityIndicator()

                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func showActivityIndicator(){
        addChild(childProgressView)
        view.addSubview(childProgressView.view)
        childProgressView.didMove(toParent: self)
    }
    
    func hideActivityIndicator(){
        childProgressView.willMove(toParent: nil)
        childProgressView.view.removeFromSuperview()
        childProgressView.removeFromParent()
    }
}

extension String {
    func isValidEmail() -> Bool {
        return self.contains("@") && self.contains(".")
    }

    func isValidPassword() -> Bool {
        return self.count >= 6
    }
}

