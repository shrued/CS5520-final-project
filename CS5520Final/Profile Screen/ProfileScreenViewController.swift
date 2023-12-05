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
    
    override func loadView() {
        view = profileScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        checkUser()
    }
    
    func checkUser() {
        guard let userEmail = Auth.auth().currentUser?.email else {
            presentAlert(title: "Error", message: "User not logged in")
            navigationController?.popViewController(animated: true)
            return
        }
    }
    
    // MARK: Present alert...
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
