//
//  ViewController.swift
//  CS5520Final
//
//  Created by Shruti Saravanan on 12/1/23.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    let loginView = LoginView()

    override func loadView() {
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)

        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginView.registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    
    @objc func hideKeyboardOnTap(){
        view.endEditing(true)
    }

    @objc func loginButtonTapped() {
        guard let email = loginView.emailTextField.text, !email.isEmpty,
              let password = loginView.passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Please enter both email and password.")
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            guard let self = self else { return }

            if let error = error {
                print("Login error: \(error.localizedDescription)")
                self.showAlert(message: "Invalid email or password. Please try again.")
            } else {
                let chatListViewController = HomeScreenViewController()
                self.navigationController?.pushViewController(chatListViewController, animated: true)
            }
        }
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Login Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func registerButtonTapped() {
        let registerViewController = RegisterScreenController()
        navigationController?.pushViewController(registerViewController, animated: true)
    }
}
