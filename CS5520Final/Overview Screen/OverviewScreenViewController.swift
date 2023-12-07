//
//  OverviewScreenViewController.swift
//  CS5520Final
//
//  Created by Hanru Chen on 12/2/23.
//

import Foundation
import UIKit
import DGCharts
import FirebaseFirestore
import FirebaseAuth

class OverviewScreenViewController: UIViewController {
    var overviewScreenView = OverviewScreenView()
    var handleAuth: AuthStateDidChangeListenerHandle?
    
    override func loadView() {
        view = overviewScreenView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handleAuth = Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            guard let self = self else { return }
            if let user = user {
                // User is signed in
                self.fetchUserProfile()
                self.fetchDailyIntakeData()
            } else {
                // No user is signed in
                self.presentAlert(title: "Error", message: "Please sign in to see your overview.")
                // Optionally, redirect to the login screen
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
        
        self.view.layoutIfNeeded() // force the layout of subviews before view appears
        overviewScreenView.buttonProfile.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        overviewScreenView.buttonUpdate.addTarget(self, action: #selector(saveWeightButtonTapped), for: .touchUpInside)
    }
    
    @objc func profileButtonTapped() {
        // navigate to Profile Screen
        let profileController = ProfileScreenViewController()
        navigationController?.pushViewController(profileController, animated: true)
    }
    
    // save new weight to the firestore database
    @objc func saveWeightButtonTapped() {
        guard let newWeightString = overviewScreenView.textFieldWeightChanges.text,
              let newWeight = Double(newWeightString) else {
            presentAlert(title: "Error", message: "Please enter a valid weight")
            return
        }

        guard let userEmail = Auth.auth().currentUser?.email else {
            presentAlert(title: "Error", message: "User not logged in")
            return
        }

        // Reference to Firestore
        let db = Firestore.firestore()

        // Reference to the specific document in the profileInfo subcollection
        let profileDetailsDocument = db.collection("users").document(userEmail).collection("profileInfo").document("profileDetails")

        // Update the weight in the ProfileInfo document
        profileDetailsDocument.updateData(["weight": newWeight]) { error in
            if let error = error {
                self.presentAlert(title: "Error", message: "Failed to update weight: \(error.localizedDescription)")
            } else {
                self.presentAlert(title: "Success", message: "Weight updated successfully")
                // Optionally, update the UI to reflect the change
                self.overviewScreenView.setCurrentWeight(newWeight)
                self.fetchUserProfile()
            }
        }
    }
        
    func fetchUserProfile() {
        guard let userEmail = Auth.auth().currentUser?.email else {
            presentAlert(title: "Error", message: "User not logged in")
            return
        }

        let db = Firestore.firestore()
        let profileDocument = db.collection("users").document(userEmail).collection("profileInfo").document("profileDetails")

        profileDocument.getDocument { [weak self] (document, error) in
            guard let self = self else { return }

            if let document = document, document.exists {
                if let profileData = try? document.data(as: ProfileInfo.self) {
                    // Update the UI with the latest profile data
                    self.updateUIWithProfile(profileData)
                }
            } else {
                self.presentAlert(title: "Error", message: "Document does not exist")
            }
        }
    }

    func updateUIWithProfile(_ profile: ProfileInfo) {
        // Update the current weight label
        overviewScreenView.labelCurrentWeightValue.text = "\(profile.weight) lbs"
        // Update the progress bar
        updateProgressBar(currentWeight: profile.weight, goalWeight: profile.goal)
        // Update other UI elements as needed based on the profile
    }

        
        // MARK: Fetch daily intake data...
    func fetchDailyIntakeData() {
        guard let userEmail = Auth.auth().currentUser?.email else {
            presentAlert(title: "Error", message: "User not logged in")
            return
        }
            
            // get today's date
        let today = Date()
        let startOfDay = Calendar.current.startOfDay(for: today)
        
        let startTimestamp = Timestamp(date: startOfDay)
        
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
        let endTimestamp = Timestamp(date: endOfDay)
        
        let collectionRecInfo = Firestore.firestore().collection("users").document(userEmail).collection("recordingInfo")
        // get all documents where date = today
        collectionRecInfo.whereField("date", isGreaterThanOrEqualTo: startTimestamp)
                         .whereField("date", isLessThan: endTimestamp).getDocuments { (querySnapshot, error) in
            if let error = error {
                self.presentAlert(title: "Error", message: error.localizedDescription)
                return
            } else {
                var totalCalories = 0.0
                var totalSugar = 0.0
                var totalSodium = 0.0
                var totalWater = 0.0
                    
                    // loop through all documents and get the data
                for document in querySnapshot!.documents {
                    let data = document.data()
                    totalCalories += data["caloriesAmount"] as? Double ?? 0
                    totalSugar += data["sugarAmount"] as? Double ?? 0
                    totalSodium += data["sodiumAmount"] as? Double ?? 0
                    totalWater += data["waterAmount"] as? Double ?? 0
                }
                    // update chart data
                self.updateIntakeChartData(calories: totalCalories, sugar: totalSugar, sodium: totalSodium, water: totalWater)
            }
        }
    }
        
        
    func updateProgressBar(currentWeight: Double, goalWeight: Double) {
        let weightDifference = abs(currentWeight - goalWeight)
        
        // Define a maximum difference which represents the range of the progress bar.
        let maxDifference = 500.0

        let progress: Double

        if weightDifference >= maxDifference {
            // If the difference is greater than or equal to the max, no progress is made.
            progress = 0
        } else {
            // Calculate progress as the inverse ratio of the difference to the maximum.
            progress = 1 - (weightDifference / maxDifference)
        }

        overviewScreenView.weightProgressBar.setProgress(Float(progress), animated: true)
    }




        
    // MARK: Update chart data...
    func updateIntakeChartData(calories: Double, sugar: Double, sodium: Double, water: Double) {
        let entries = [
            BarChartDataEntry(x: 0, y: calories),
            BarChartDataEntry(x: 1, y: sugar),
            BarChartDataEntry(x: 2, y: sodium),
            BarChartDataEntry(x: 3, y: water)
        ]

        let dataSet = BarChartDataSet(entries: entries, label: "Daily Intake")
        dataSet.colors = [NSUIColor.systemBlue]

        let data = BarChartData(dataSet: dataSet)
        overviewScreenView.chartViewIntakes.data = data

        // Define the labels to display under each bar
        let labels = ["Calories", "Sugar", "Sodium", "Water"]
        
        // Set the formatter for the xAxis to use these labels
        overviewScreenView.chartViewIntakes.xAxis.valueFormatter = IndexAxisValueFormatter(values: labels)
        overviewScreenView.chartViewIntakes.xAxis.granularity = 1
        overviewScreenView.chartViewIntakes.xAxis.labelPosition = .bottom

        // Refresh chart
        overviewScreenView.chartViewIntakes.notifyDataSetChanged()
    }
        
        // MARK: Present alert...
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }
}
