//
//  OverviewScreenViewController.swift
//  CS5520Final
//
//  Created by Hanru Chen on 12/2/23.
//

import UIKit
import DGCharts

class OverviewScreenViewController: UIViewController {
    var overviewScreenView = OverviewScreenView()
    
    override func loadView() {
        view = overviewScreenView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overviewScreenView.buttonProfile.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        overviewScreenView.buttonUpdate.addTarget(self, action: #selector(saveWeightButtonTapped), for: .touchUpInside)
    }
    
    @objc func profileButtonTapped() {
        // navigate to Profile Screen
    }
    
    @objc func saveWeightButtonTapped() {
        // validate and save weight info to Firestore
        // update weight on Profile screen and Overview screen
    }
    
    
    
    
    // MARK: Update chart data...
    func updateIntakeChartData(calories: Double, sugar: Double, sodium: Double, water: Double) {
        let dataSet = BarChartDataSet(entries: [
            BarChartDataEntry(x: 1, y: calories),
            BarChartDataEntry(x: 2, y: sugar),
            BarChartDataEntry(x: 3, y: sodium),
            BarChartDataEntry(x: 4, y: water)
        ], label: "Daily Intake")
        
        dataSet.colors = [NSUIColor.systemBlue]
        
        let data = BarChartData(dataSet: dataSet)
        overviewScreenView.chartViewIntakes.data = data
        
        overviewScreenView.chartViewIntakes.notifyDataSetChanged()
    }
    
    func updateProgressChart() {
        
    }
}
