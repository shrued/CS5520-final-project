//
//  ProfileScreenViewController.swift
//  CS5520Final
//
//  Created by 陈语佳 on 12/4/23.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ProfileScreenViewController: UIViewController {
    var profileScreen = ProfileScreenView()
    var profile = ProfileInfo(name: "USER", age: 0, gender: "GENDER", weight: 200.0, height: "6ft", goal: 150.0)
    
    override func loadView() {
        view = profileScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile Page"
        
        checkUser()
        
        profileScreen.editButton.addTarget(self, action: #selector(oneditButtonTapped), for: .touchUpInside)
        
        // MARK: Pop back to login screen and logout the current user.
        // profileScreen.logoutButton.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
    }
    
    @objc func oneditButtonTapped() {
        let editController = EditScreenViewController()
        editController.delegate = self
        navigationController?.pushViewController(editController, animated: true)
    }
    
    func delegateOnEditProfile() {
        profileScreen.nameLabel.text = "Name: " + profile.name
        profileScreen.ageLabel.text = "Age: \(profile.age)"
        profileScreen.genderLabel.text = "Gender: " + profile.gender
        profileScreen.weightLabel.text = "Weight: \(profile.weight)"
        profileScreen.heightLabel.text = "Height: \(profile.height)"
        profileScreen.goalLabel.text = "Goal: \(profile.goal)"
    }
    
    func checkUser() {
        guard let userEmail = Auth.auth().currentUser?.email else {
            presentAlert(title: "Error", message: "User not logged in")
            // navigationController?.popViewController(animated: true)
            return
        }
    }
    
    // MARK: Present alert...
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }
}
