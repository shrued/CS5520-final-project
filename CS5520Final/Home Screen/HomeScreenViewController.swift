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
    var currEmail = ""
    
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
                self.currEmail = userEmail
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
                
                let timerInfo = self.database.collection("users").document(userEmail).collection("timer")
                timerInfo.getDocuments(completion: {QuerySnapshot, error in
                    if error == nil {
                        if let documents = QuerySnapshot?.documents{
                            let docNum = documents.count
                            if docNum == 0 {
                                let time = Time(time: self.timer)
                                let timeDoc = timerInfo.document("TimerInfo")
                                do {
                                    try timeDoc.setData(from: time, completion: {(error) in
                                        if error == nil {
                                            
                                        }})
                                } catch {
                                    print(error)
                                }
                                
                            } else {
                                self.showTimer()
                            }
                        }
                    }})
            }
                
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home Page"
        self.navigationItem.hidesBackButton = true
        
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonTapped))
        navigationItem.leftBarButtonItem = logoutButton
        
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
    
    func showTimer() {
        currEmail = (Auth.auth().currentUser?.email)!
        let time = database.collection("users").document(currEmail).collection("timer")

        time.getDocuments(completion: {QuerySnapshot, error in
            if error == nil {
                if let documents = QuerySnapshot?.documents {
                    do {
                        let timerInfo = try documents[0].data(as: Time.self)
                        self.timer = timerInfo.time
                        if self.timer != 0 {
                            let currentTime = Date()
                            let secondsSinceEpochInt = Int(currentTime.timeIntervalSince1970)
                            let elapsedTime = secondsSinceEpochInt - self.timer
                            let eatingPeriod = 8 * 3600
                            let fastingPeriod = 16 * 3600
                            let totalPeriod = 24 * 3600

                            // Check if elapsed time is negative or beyond 24 hours
                            if elapsedTime < 0 || elapsedTime >= totalPeriod {
                                // Reset timer
                                self.timer = secondsSinceEpochInt
                                let newTime = Time(time: self.timer)
                                try time.document("TimerInfo").setData(from: newTime)
                                self.homeScreen.TimerMessage.text = "08:00:00"
                            } else {
                                // Calculate remaining time and update TimerMessage
                                let remainingTime: Int
                                if elapsedTime < eatingPeriod {
                                    remainingTime = eatingPeriod - elapsedTime
                                } else {
                                    remainingTime = fastingPeriod - (elapsedTime - eatingPeriod)
                                }
                                let hour = remainingTime / 3600
                                let minutes = (remainingTime % 3600) / 60
                                let seconds = remainingTime % 60
                                self.homeScreen.TimerMessage.text = String(format: "%02d:%02d:%02d", hour, minutes, seconds)
                            }
                        }
                    } catch {
                        print(error)
                    }
                }
            }
        })
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
        let secondsSinceEpochInt = Int(currentDate.timeIntervalSince1970)
        timer = secondsSinceEpochInt
        
        let timerInfo = self.database.collection("users").document(currEmail).collection("timer").document("TimerInfo")
        let time = Time(time: self.timer)
        do {
            try timerInfo.setData(from: time, completion: {(error) in
                if error == nil{
                    
                }})
        } catch{
            print(error)
        }

        
        
        showTimer()
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
    
    @objc func logoutButtonTapped() {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let error {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}
