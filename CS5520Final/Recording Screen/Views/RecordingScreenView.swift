//
//  RecordingScreenView.swift
//
//  Created by Hanru Chen on 12/1/23.
//

import UIKit

class RecordingScreenView: UIView {

    var labelTitle: UILabel!
    var labelAdd: UILabel!
    var labelCalories: UILabel!
    var textFieldFoodName: UITextField!
    var textFieldFoodAmount: UITextField!
    var labelSugar: UILabel!
    var textFieldSugarAmount: UITextField!
    var labelSodium: UILabel!
    var textFieldSodiumAmount: UITextField!
    var labelWater: UILabel!
    var textFieldWaterAmount: UITextField!
    var buttonSave: UIButton!
    var gradientLayer: CAGradientLayer!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setuplabelTitle()
        setuplabelAdd()
        setuplabelCalories()
        setuptextFieldFoodName()
        setuptextFieldFoodAmount()
        setuplabelSugar()
        setuptextFieldSugarAmount()
        setuplabelSodium()
        setuptextFieldSodiumAmount()
        setuplabelWater()
        setuptextFieldWaterAmount()
        setupbuttonSave()
        setupGradientBackground()
        
        initConstraints()
    }
    
    func setupGradientBackground() {
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 0.56, green: 0.74, blue: 0.56, alpha: 1.00).cgColor, // Soft green
            UIColor(red: 0.67, green: 0.84, blue: 0.90, alpha: 1.00).cgColor  // Soft blue
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setuplabelTitle() {
        labelTitle = UILabel()
        labelTitle.text = "Recording Page"
        labelTitle.textColor = .black
        labelTitle.font = UIFont(name: "BradleyHandITCTT-Bold", size: 30)
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelTitle)
    }
    
    func setuplabelAdd() {
        labelAdd = UILabel()
        labelAdd.text = "Add manually"
        labelAdd.textColor = .black
        labelAdd.font = UIFont(name: "Chalkduster", size: 20)
        labelAdd.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelAdd)
    }
    
    func setuplabelCalories() {
        labelCalories = UILabel()
        labelCalories.text = "Calories intake"
        labelCalories.textColor = .black
        labelCalories.font = UIFont(name: "Noteworthy-Light", size: 18)
        labelCalories.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelCalories)
    }
    
    func setuptextFieldFoodName() {
        textFieldFoodName = UITextField()
        textFieldFoodName.placeholder = "Food Name"
        textFieldFoodName.textColor = .black
        textFieldFoodName.borderStyle = .roundedRect
        textFieldFoodName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldFoodName)
    }
    
    func setuptextFieldFoodAmount() {
        textFieldFoodAmount = UITextField()
        textFieldFoodAmount.placeholder = "Amount"
        textFieldFoodAmount.textColor = .black
        textFieldFoodAmount.borderStyle = .roundedRect
        textFieldFoodAmount.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldFoodAmount)
    }
    
    func setuplabelSugar() {
        labelSugar = UILabel()
        labelSugar.text = "Sugar intake"
        labelSugar.textColor = .black
        labelSugar.font = UIFont(name: "Noteworthy-Light", size: 18)
        labelSugar.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelSugar)
    }
    
    func setuptextFieldSugarAmount() {
        textFieldSugarAmount = UITextField()
        textFieldSugarAmount.placeholder = "Amount"
        textFieldSugarAmount.textColor = .black
        textFieldSugarAmount.borderStyle = .roundedRect
        textFieldSugarAmount.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldSugarAmount)
    }
    
    func setuplabelSodium() {
        labelSodium = UILabel()
        labelSodium.text = "Sodium intake"
        labelSodium.textColor = .black
        labelSodium.font = UIFont(name: "Noteworthy-Light", size: 18)
        labelSodium.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelSodium)
    }
    
    func setuptextFieldSodiumAmount() {
        textFieldSodiumAmount = UITextField()
        textFieldSodiumAmount.placeholder = "Amount"
        textFieldSodiumAmount.textColor = .black
        textFieldSodiumAmount.borderStyle = .roundedRect
        textFieldSodiumAmount.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldSodiumAmount)
    }
    
    func setuplabelWater() {
        labelWater = UILabel()
        labelWater.text = "Water intake"
        labelWater.textColor = .black
        labelWater.font = UIFont(name: "Noteworthy-Light", size: 18)
        labelWater.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelWater)
    }
    
    func setuptextFieldWaterAmount() {
        textFieldWaterAmount = UITextField()
        textFieldWaterAmount.placeholder = "Amount"
        textFieldWaterAmount.textColor = .black
        textFieldWaterAmount.borderStyle = .roundedRect
        textFieldWaterAmount.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldWaterAmount)
    }
    
    func styleTextField(textField: UITextField) {
        textField.layer.cornerRadius = 10
        textField.layer.shadowOpacity = 0.1
        textField.layer.shadowRadius = 4
        textField.layer.shadowOffset = CGSize(width: 0, height: 2)
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray4.cgColor
        textField.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        textField.layer.masksToBounds = false
    }
    
    func setupbuttonSave() {
        buttonSave = UIButton(configuration: .filled(), primaryAction: nil)
        
        // Custom coral color using rgb values
        let coralColor = UIColor(red: 1.00, green: 0.50, blue: 0.31, alpha: 1.00)
        // Set the button title and image using UIButtonConfiguration
        var config = buttonSave.configuration
        config?.title = "Save"
        config?.image = UIImage(systemName: "square.and.arrow.down.fill")
        config?.imagePadding = 10 // Space between the image and the title
        config?.baseBackgroundColor = coralColor // Using the custom coral color for the button
        config?.baseForegroundColor = UIColor.white // Button text color
        config?.cornerStyle = .medium // Rounded corners (you can also use .capsule for fully rounded ends)
        
        buttonSave.configuration = config
        
        // Custom font for the button title
        buttonSave.titleLabel?.font = UIFont.systemFont(ofSize: 24) // Set the desired font size
        
        // Add shadows
        buttonSave.layer.shadowOpacity = 0.3
        buttonSave.layer.shadowRadius = 5
        buttonSave.layer.shadowOffset = CGSize(width: 0, height: 4)
        buttonSave.layer.shadowColor = UIColor.black.cgColor
        buttonSave.layer.masksToBounds = false
        buttonSave.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(buttonSave)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            labelTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            labelTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            labelAdd.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 20),
            labelAdd.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            labelCalories.topAnchor.constraint(equalTo: labelAdd.bottomAnchor, constant: 20),
            labelCalories.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            textFieldFoodName.topAnchor.constraint(equalTo: labelCalories.bottomAnchor, constant: 10),
            textFieldFoodName.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textFieldFoodName.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5, constant: -30),
            
            textFieldFoodAmount.topAnchor.constraint(equalTo: labelCalories.bottomAnchor, constant: 10),
            textFieldFoodAmount.leadingAnchor.constraint(equalTo: textFieldFoodName.trailingAnchor, constant: 10),
            textFieldFoodAmount.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            labelSugar.topAnchor.constraint(equalTo: textFieldFoodName.bottomAnchor, constant: 20),
            labelSugar.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            textFieldSugarAmount.topAnchor.constraint(equalTo: labelSugar.bottomAnchor, constant: 10),
            textFieldSugarAmount.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textFieldSugarAmount.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            labelSodium.topAnchor.constraint(equalTo: textFieldSugarAmount.bottomAnchor, constant: 20),
            labelSodium.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            textFieldSodiumAmount.topAnchor.constraint(equalTo: labelSodium.bottomAnchor, constant: 10),
            textFieldSodiumAmount.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textFieldSodiumAmount.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            labelWater.topAnchor.constraint(equalTo: textFieldSodiumAmount.bottomAnchor, constant: 20),
            labelWater.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            textFieldWaterAmount.topAnchor.constraint(equalTo: labelWater.bottomAnchor, constant: 10),
            textFieldWaterAmount.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textFieldWaterAmount.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            buttonSave.heightAnchor.constraint(equalToConstant: 60),
            buttonSave.widthAnchor.constraint(equalToConstant: 200),
            buttonSave.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonSave.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20)
            ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

