//
//  HomeScreenViewController.swift
//  CS5520Final
//
//  Created by 陈语佳 on 12/4/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseAuth

class HomeScreenViewController: UIViewController {

    var homeScreen = HomeScreenView()
    var flag = false
    var timer = 0
    var handleAuth: AuthStateDidChangeListenerHandle?
    var database = Firestore.firestore()
    
    override func loadView() {
        view = homeScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil {
                
            } else {
                let userEmail = (user?.email)!
                let profileCollection = self.database
                    .collection("users")
                    .document(userEmail)
                    .collection("profileInfo")
                
                profileCollection.getDocuments(completion: {QuerySnapshot, error in
                    if error == nil {
                        if let documents = QuerySnapshot?.documents{
                            let docNum = documents.count
                            if docNum == 0 {
                                self.homeScreen.ProgressMessage.text = "Please setup profile in Overview!"
                                self.presentAlert(title: "WARNING", message: "NO PROFILE INFO FOUND!")
                            } else {
                                //MARK: Update information when profile info is found!
                                do {
                                    let profileDetail = try documents[0].data(as: ProfileInfo.self)
                                    if profileDetail.weight - profileDetail.goal > 0 {
                                        self.homeScreen.ProgressMessage.text = "You have \(profileDetail.weight - profileDetail.goal) pounds to go!"
                                    } else {
                                        self.homeScreen.ProgressMessage.text = "Congratulations! You have reached your goal!"
                                    }
                                } catch{
                                    print(error)
                                }
                            }
                        }
                    }})
            }
                
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home Page"
        
        
        homeScreen.OverviewButton.addTarget(self, action: #selector(onButtonOverviewTapped),
                                for: .touchUpInside)
        homeScreen.RecordButton.addTarget(self, action: #selector(onButtonRecordingTapped),
                                for: .touchUpInside)
        homeScreen.ArticleButton.addTarget(self, action: #selector(onButtonArticlesTapped), for: .touchUpInside)
        homeScreen.resetButton.addTarget(self, action: #selector(onButtonResetTapped), for: .touchUpInside)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
    
    // MARK: Present alert...
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc func onButtonResetTapped() {
        flag = true
        let currentDate = Date()
        let secondsSinceEpoch = currentDate.timeIntervalSince1970
        let secondsSinceEpochInt = Int(currentDate.timeIntervalSince1970)
        timer = secondsSinceEpochInt
    }
    
    @objc func onButtonOverviewTapped() {
        let overviewController = OverviewScreenViewController()
        navigationController?.pushViewController(overviewController, animated: true)
    }
    
    @objc func onButtonRecordingTapped() {
        let recordingController = RecordingScreenViewController()
        navigationController?.pushViewController(recordingController, animated: true)
    }
    
    @objc func onButtonArticlesTapped() {
        let articlesController = ArticlesScreenController()
        navigationController?.pushViewController(articlesController, animated: true)
    }
}
