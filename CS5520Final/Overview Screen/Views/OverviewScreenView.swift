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
    var labelCurrentWeightValue: UILabel!
    var textFieldWeightChanges: UITextField!
    var buttonUpdate: UIButton!
    var chartViewProgress: LineChartView!
    var chartViewIntakes: BarChartView!

    var gradientLayer: CAGradientLayer!
    
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
        setupLabelCurrentWeightValue()
        
        setupGradientBackground()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupGradientBackground() {
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 0.68, green: 0.93, blue: 0.93, alpha: 1.00).cgColor, // Soft green
            UIColor(red: 0.94, green: 0.97, blue: 0.98, alpha: 1.00).cgColor  // Light blue
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }

    
    // MARK: setup label overview...
    func setupLabelOverView() {
        labelOverview = UILabel()
        labelOverview.text = "Overview"
        labelOverview.textColor = .black
        labelOverview.font = UIFont(name: "BradleyHandITCTT-Bold", size: 36)
        labelOverview.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelOverview)
    }
    
    // MARK: setup button profile...
    func setupButtonProfile() {
        buttonProfile = UIButton(type: .system)

        // Create a configuration for the button
        var config = UIButton.Configuration.plain()
        config.title = "Profile"
        config.image = UIImage(systemName: "person.circle")
        config.imagePlacement = .top  // Place image above the title
        config.imagePadding = 8       // Padding between the image and the title

        
        // Apply the configuration to the button
        buttonProfile.configuration = config
        buttonProfile.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonProfile)
    }
    
    // MARK: setup label current weight...
    func setupLabelCurrentWeight() {
        labelCurrentWeight = UILabel()
        labelCurrentWeight.text = "Current Weight"
        labelCurrentWeight.textColor = .black
        labelCurrentWeight.font = UIFont(name: "Noteworthy-Light", size: 20)
        labelCurrentWeight.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelCurrentWeight)
    }
    
    func setupLabelCurrentWeightValue() {
        labelCurrentWeightValue = UILabel()
        labelCurrentWeightValue.textColor = .black
        labelCurrentWeightValue.font = UIFont(name: "Noteworthy-Light", size: 20)
        labelCurrentWeightValue.textAlignment = .right
        labelCurrentWeightValue.text = "0 lbs" //default
        labelCurrentWeightValue.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelCurrentWeightValue)
    }
    
    func setCurrentWeight(_ weight: Double) {
        labelCurrentWeightValue.text = "\(weight) lbs"
        // "\(weight) lbs"
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
        buttonUpdate.backgroundColor = UIColor(red: 0.22, green: 0.45, blue: 0.89, alpha: 1.00)
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
        styleChart(chartViewProgress)
        chartViewProgress.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(chartViewProgress)
    }
    
    // MARK: setup stack view intake labels...
    func setupChartViewIntakes() {
        chartViewIntakes = BarChartView()
        chartViewIntakes.noDataText = "No intake data available"
        styleChart(chartViewIntakes)
        chartViewIntakes.chartDescription.enabled = false
        chartViewIntakes.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(chartViewIntakes)
    }

    func styleChart(_ chart: ChartViewBase) {
        chart.layer.cornerRadius = 10
        chart.layer.shadowOpacity = 0.2
        chart.layer.shadowRadius = 3
        chart.layer.shadowOffset = CGSize(width: 0, height: 2)
        chart.layer.shadowColor = UIColor.black.cgColor
    }
    
    // MARK: Init constraints...
    func initConstraints() {
        NSLayoutConstraint.activate([
            labelOverview.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            labelOverview.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            buttonProfile.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonProfile.topAnchor.constraint(equalTo: labelOverview.bottomAnchor, constant: 10),
            
            labelCurrentWeight.topAnchor.constraint(equalTo: buttonProfile.bottomAnchor, constant: 20),
            labelCurrentWeight.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            labelCurrentWeightValue.centerYAnchor.constraint(equalTo: labelCurrentWeight.centerYAnchor),
            labelCurrentWeightValue.leadingAnchor.constraint(greaterThanOrEqualTo: labelCurrentWeight.trailingAnchor, constant: 10),
            labelCurrentWeightValue.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
    }
}
