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
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currEmail = ""
    var database = Firestore.firestore()
    
    override func loadView() {
        view = profileScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        handleAuth = Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            guard let self = self else { return }

            if let user = user {
                currEmail = user.email!
                let profileCollection = database.collection("users").document(currEmail).collection("profileInfo")
                profileCollection.getDocuments(completion: {QuerySnapshot, error in
                    if error == nil {
                        if let documents = QuerySnapshot?.documents{
                            let docNum = documents.count
                            if docNum == 0 {
                                self.presentAlert(title: "WARNING", message: "NO PROFILE INFO FOUND!")
                            } else {
                                //MARK: Update information when profile info is found!
                                do {
                                    let profileDetail = try documents[0].data(as: ProfileInfo.self)
                                    self.profileScreen.nameLabel.text = "Name: " + profileDetail.name
                                    self.profileScreen.ageLabel.text = "Age: " + String(profileDetail.age)
                                    self.profileScreen.genderLabel.text = "Gender: " + profileDetail.gender
                                    self.profileScreen.weightLabel.text = "Weight: " + String(profileDetail.weight) + " lbs"
                                    self.profileScreen.heightLabel.text = "Height: " + String(profileDetail.height)
                                    self.profileScreen.goalLabel.text = "Goal: " + String(profileDetail.goal) + " lbs"
                                } catch{
                                    print(error)
                                }
                            }
                        }
                    }})
            } else {
                // No user is signed in
                    // Redirect to the login screen
                    self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Remove the authentication state listener when the view is no longer visible
        if let handleAuth = handleAuth {
            Auth.auth().removeStateDidChangeListener(handleAuth)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile Page"
        
        profileScreen.editButton.addTarget(self, action: #selector(oneditButtonTapped), for: .touchUpInside)
        // MARK: Pop back to login screen and logout the current user.
        profileScreen.logoutButton.addTarget(self, action: #selector(onLogOutButtonTapped), for: .touchUpInside)
        
        
    }
    
    @objc func onLogOutButtonTapped(){
        let logoutAlert = UIAlertController(title: "Logging out!", message: "Are you sure want to log out?",
            preferredStyle: .actionSheet)
        logoutAlert.addAction(UIAlertAction(title: "Yes, log out!", style: .default, handler: {(_) in
                do{
                    try Auth.auth().signOut()
                }catch{
                    print("Error occured!")
                }
            })
        )
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(logoutAlert, animated: true)
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
    
    // MARK: Present alert...
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }
}
