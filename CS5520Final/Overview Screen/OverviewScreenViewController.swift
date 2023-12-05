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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overviewScreenView.buttonProfile.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        overviewScreenView.buttonUpdate.addTarget(self, action: #selector(saveWeightButtonTapped), for: .touchUpInside)
        
        fetchDailyIntakeData()
    }
    
    @objc func profileButtonTapped() {
        // navigate to Profile Screen
        let profileController = ProfileScreenViewController()
        navigationController?.pushViewController(profileController, animated: true)
    }
    
    @objc func saveWeightButtonTapped() {
        // validate and save weight info to Firestore
        // update weight on Profile screen and Overview screen
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
    
    
    func updateProgressChart() {
        // TODO: update progress chart
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
