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
        
        initConstraints()
    }
    
    
    func setuplabelTitle() {
        labelTitle = UILabel()
        labelTitle.text = "Recording Page"
        labelTitle.textColor = .black
        labelTitle.font = UIFont.systemFont(ofSize: 30)
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelTitle)
    }
    
    func setuplabelAdd() {
        labelAdd = UILabel()
        labelAdd.text = "Add manually"
        labelAdd.textColor = .black
        labelAdd.font = UIFont.systemFont(ofSize: 20)
        labelAdd.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelAdd)
    }
    
    func setuplabelCalories() {
        labelCalories = UILabel()
        labelCalories.text = "Calories intake"
        labelCalories.textColor = .black
        labelCalories.font = UIFont.systemFont(ofSize: 18)
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
        labelSugar.font = UIFont.systemFont(ofSize: 18)
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
        labelSodium.font = UIFont.systemFont(ofSize: 18)
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
        labelWater.font = UIFont.systemFont(ofSize: 18)
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
    
    func setupbuttonSave() {
        buttonSave = UIButton()
        buttonSave.setTitle("Save", for: .normal)
        buttonSave.setImage(.add, for: .normal)
        buttonSave.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        buttonSave.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSave)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            labelTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            labelTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            labelAdd.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 20),
            labelAdd.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            labelCalories.topAnchor.constraint(equalTo: labelAdd.bottomAnchor, constant: 20),
            labelCalories.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            textFieldFoodName.topAnchor.constraint(equalTo: labelCalories.bottomAnchor, constant: 10),
            textFieldFoodName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textFieldFoodName.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5, constant: -30),
            
            textFieldFoodAmount.topAnchor.constraint(equalTo: labelCalories.bottomAnchor, constant: 10),
            textFieldFoodAmount.leadingAnchor.constraint(equalTo: textFieldFoodName.trailingAnchor, constant: 10),
            textFieldFoodAmount.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            labelSugar.topAnchor.constraint(equalTo: textFieldFoodName.bottomAnchor, constant: 20),
            labelSugar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            textFieldSugarAmount.topAnchor.constraint(equalTo: labelSugar.bottomAnchor, constant: 10),
            textFieldSugarAmount.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textFieldSugarAmount.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            labelSodium.topAnchor.constraint(equalTo: textFieldSugarAmount.bottomAnchor, constant: 20),
            labelSodium.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            textFieldSodiumAmount.topAnchor.constraint(equalTo: labelSodium.bottomAnchor, constant: 10),
            textFieldSodiumAmount.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textFieldSodiumAmount.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            labelWater.topAnchor.constraint(equalTo: textFieldSodiumAmount.bottomAnchor, constant: 20),
            labelWater.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            textFieldWaterAmount.topAnchor.constraint(equalTo: labelWater.bottomAnchor, constant: 10),
            textFieldWaterAmount.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textFieldWaterAmount.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            buttonSave.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            buttonSave.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

