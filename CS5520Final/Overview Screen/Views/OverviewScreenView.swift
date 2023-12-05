//
//  OverviewScreenView.swift
//  CS5520Final
//
//  Created by Hanru Chen on 12/2/23.
//

import UIKit
import Charts
import DGCharts

class OverviewScreenView: UIView {
    var labelOverview: UILabel!
    var buttonProfile: UIButton!
    var labelCurrentWeight: UILabel!
    var textFieldWeightChanges: UITextField!
    var buttonUpdate: UIButton!
    var chartViewProgress: LineChartView!
    var chartViewIntakes: BarChartView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupLabelOverView()
        setupButtonProfile()
        setupLabelCurrentWeight()
        setupTextFieldWeightChanges()
        setupButtonUpdate()
        setupChartViewProgress()
        setupChartViewIntakes()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: setup label overview...
    func setupLabelOverView() {
        labelOverview = UILabel()
        labelOverview.text = "Overview"
        labelOverview.textColor = .black
        labelOverview.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        labelOverview.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelOverview)
    }
    
    // MARK: setup button profile...
    func setupButtonProfile() {
        buttonProfile = UIButton(type: .system)
        let image = UIImage(systemName: "person.circle")?.withRenderingMode(.alwaysOriginal)
        buttonProfile.setImage(image, for: .normal)
        buttonProfile.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonProfile)
    }
    
    // MARK: setup label current weight...
    func setupLabelCurrentWeight() {
        labelCurrentWeight = UILabel()
        labelCurrentWeight.text = "Current Weight"
        labelCurrentWeight.textColor = .black
        labelCurrentWeight.font = UIFont.systemFont(ofSize: 18)
        labelCurrentWeight.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelCurrentWeight)
    }
    
    // MARK: setup text field weight changes...
    func setupTextFieldWeightChanges() {
        textFieldWeightChanges = UITextField()
        textFieldWeightChanges.placeholder = "Enter weight changes"
        textFieldWeightChanges.borderStyle = .roundedRect
        textFieldWeightChanges.keyboardType = .decimalPad
        textFieldWeightChanges.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldWeightChanges)
    }
    
    // MARK: setup button update...
    func setupButtonUpdate() {
        buttonUpdate = UIButton()
        buttonUpdate.setTitle("Update", for: .normal)
        buttonUpdate.backgroundColor = .systemBlue
        buttonUpdate.setTitleColor(.white, for: .normal)
        buttonUpdate.layer.cornerRadius = 10
        buttonUpdate.clipsToBounds = true
        buttonUpdate.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonUpdate)
    }
    
    // MARK: setup chart view progress...
    func setupChartViewProgress() {
        chartViewProgress = LineChartView()
        chartViewProgress.noDataText = "No data available"
        chartViewProgress.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(chartViewProgress)
    }
    
    // MARK: setup stack view intake labels...
    func setupChartViewIntakes() {
        chartViewIntakes = BarChartView()
        chartViewIntakes.noDataText = "No intake data available"
        chartViewIntakes.chartDescription.enabled = false
        chartViewIntakes.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(chartViewIntakes)
    }
    
    // MARK: Init constraints...
    func initConstraints() {
        NSLayoutConstraint.activate([
            labelOverview.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            labelOverview.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            buttonProfile.topAnchor.constraint(equalTo: labelOverview.bottomAnchor, constant: 10),
            buttonProfile.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            labelCurrentWeight.topAnchor.constraint(equalTo: buttonProfile.bottomAnchor, constant: 20),
            labelCurrentWeight.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            labelCurrentWeight.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            textFieldWeightChanges.topAnchor.constraint(equalTo: labelCurrentWeight.bottomAnchor, constant: 10),
            textFieldWeightChanges.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textFieldWeightChanges.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6),
            
            buttonUpdate.centerYAnchor.constraint(equalTo: textFieldWeightChanges.centerYAnchor),
            buttonUpdate.leadingAnchor.constraint(equalTo: textFieldWeightChanges.trailingAnchor, constant: 10),
            buttonUpdate.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            buttonUpdate.heightAnchor.constraint(equalToConstant: 40),
            
            chartViewProgress.topAnchor.constraint(equalTo: textFieldWeightChanges.bottomAnchor, constant: 20),
            chartViewProgress.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            chartViewProgress.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            chartViewProgress.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3),
            
            chartViewIntakes.topAnchor.constraint(equalTo: chartViewProgress.bottomAnchor, constant: 20),
            chartViewIntakes.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            chartViewIntakes.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            chartViewIntakes.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2)
        ])
    }
}
