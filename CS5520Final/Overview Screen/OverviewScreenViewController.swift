//
//  OverviewScreenViewController.swift
//  CS5520Final
//
//  Created by Hanru Chen on 12/2/23.
//

import UIKit
import DGCharts
import FirebaseFirestore
import FirebaseAuth

class OverviewScreenViewController: UIViewController {
    var overviewScreenView = OverviewScreenView()
    
    override func loadView() {
        view = overviewScreenView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUserProfile()
        fetchDailyIntakeData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layoutIfNeeded() // force the layout of subviews before view appears
        overviewScreenView.buttonProfile.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        overviewScreenView.buttonUpdate.addTarget(self, action: #selector(saveWeightButtonTapped), for: .touchUpInside)
        
        fetchDailyIntakeData()
        fetchUserProfile()
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
        
        profileDocument.getDocument { (document, error) in
            if let document = document, document.exists {
                let profileData = try? document.data(as: ProfileInfo.self)
                if let profileData = profileData {
                    self.updateProgressbar(currentWeight: profileData.weight, goalWeight: profileData.goalWeight) // MARK: suppose goalweight
                }
            } else {
                self.presentAlert(title: "Error", message: "Document does not exist")
            }
        }
        
    }
        
        // MARK: Fetch daily intake data...
    func fetchDailyIntakeData() {
        guard let userEmail = Auth.auth().currentUser?.email else {
            presentAlert(title: "Error", message: "User not logged in")
            return
        }
            
            // get today's date
        let today = Date()
        let formatter = DateFormatter() //
        formatter.dateFormat = "yyyy-MM-dd"
        let todayStr = formatter.string(from: today) // "2020-12-23 make it a string"
            
        // get data from Firestore fetching the collection "users" -> document "userEmail" -> collection "recordingInfo"
        let collectionRecInfo = Firestore.firestore().collection("users").document(userEmail).collection("recordingInfo")
        // get all documents where date = today
        collectionRecInfo.whereField("date", isEqualTo: todayStr).getDocuments { (querySnapshot, error) in
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
        let progress = (currentWeight - goalWeight) / currentWeight
        overviewScreenView.weightProgressBar.setProgress(Float(progress), animated: true)
    }

        
    // MARK: Update chart data...
    func updateIntakeChartData(calories: Double, sugar: Double, sodium: Double, water: Double) {
            
        // update chart data
        let dataSet = BarChartDataSet(entries: [
            BarChartDataEntry(x: 1, y: calories),
            BarChartDataEntry(x: 2, y: sugar),
            BarChartDataEntry(x: 3, y: sodium),
            BarChartDataEntry(x: 4, y: water)
            ], label: "Daily Intake")
            
        dataSet.colors = [NSUIColor.systemBlue]
            
        let data = BarChartData(dataSet: dataSet)
        overviewScreenView.chartViewIntakes.data = data
            
            // refresh chart
        overviewScreenView.chartViewIntakes.notifyDataSetChanged()
    }
        
        // MARK: Present alert...
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }
}
