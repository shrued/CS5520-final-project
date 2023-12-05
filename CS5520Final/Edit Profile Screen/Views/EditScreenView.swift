//
//  EditScreenView.swift
//  CS5520Final
//
//  Created by 陈语佳 on 12/5/23.
//

import UIKit

class EditScreenView: UIView {
    var takePhoto: UIButton!
    var textfieldName: UITextField!
    var textfieldAge: UITextField!
    var textfieldGender: UITextField!
    var textfieldWeight: UITextField!
    var textfieldHeight: UITextField!
    var textfieldGoal: UITextField!
    
    var saveButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupTakePhoto()
        setuptextfieldName()
        setuptextfieldAge()
        setuptextfieldGender()
        setuptextfieldHeight()
        setuptextfieldWeight()
        setuptextfieldGoal()
        setupsaveButton()
        
        initConstraints()
    }
    
    func setupTakePhoto() {
        takePhoto = UIButton(type: .system)
        takePhoto.setTitle("", for: .normal)
        takePhoto.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        takePhoto.contentHorizontalAlignment = .fill
        takePhoto.contentVerticalAlignment = .fill
        takePhoto.imageView?.contentMode = .scaleAspectFit
        takePhoto.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(takePhoto)
    }
    
    func setuptextfieldName() {
        textfieldName = UITextField()
        textfieldName.placeholder = "Name"
        textfieldName.borderStyle = .roundedRect
        textfieldName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textfieldName)
    }
    
    func setuptextfieldAge() {
        textfieldAge = UITextField()
        textfieldAge.placeholder = "Age"
        textfieldAge.borderStyle = .roundedRect
        textfieldAge.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textfieldAge)
    }
    
    func setuptextfieldGender() {
        textfieldGender = UITextField()
        textfieldGender.placeholder = "Gender"
        textfieldGender.borderStyle = .roundedRect
        textfieldGender.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textfieldGender)
    }
    
    func setuptextfieldWeight() {
        textfieldWeight = UITextField()
        textfieldWeight.placeholder = "Weight"
        textfieldWeight.borderStyle = .roundedRect
        textfieldWeight.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textfieldWeight)
    }
    
    func setuptextfieldHeight() {
        textfieldHeight = UITextField()
        textfieldHeight.placeholder = "Height"
        textfieldHeight.borderStyle = .roundedRect
        textfieldHeight.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textfieldHeight)
    }
    
    func setuptextfieldGoal() {
        textfieldGoal = UITextField()
        textfieldGoal.placeholder = "Goal"
        textfieldGoal.borderStyle = .roundedRect
        textfieldGoal.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textfieldGoal)
    }
    
    func setupsaveButton() {
        saveButton = UIButton(type: .system)
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.titleLabel!.font = .systemFont(ofSize: 25.0, weight: .bold)
        saveButton.backgroundColor = .gray
        saveButton.frame = CGRect(x: 100, y: 100, width: 150, height: 50)
        saveButton.layer.cornerRadius = 10
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(saveButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            takePhoto.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            takePhoto.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            takePhoto.widthAnchor.constraint(equalToConstant: 150),
            takePhoto.heightAnchor.constraint(equalToConstant: 150),
            
            textfieldName.topAnchor.constraint(equalTo: takePhoto.bottomAnchor, constant: 20),
            textfieldName.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textfieldName.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            textfieldAge.topAnchor.constraint(equalTo: textfieldName.bottomAnchor, constant: 20),
            textfieldAge.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textfieldAge.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            textfieldGender.topAnchor.constraint(equalTo: textfieldAge.bottomAnchor, constant: 20),
            textfieldGender.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textfieldGender.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            textfieldWeight.topAnchor.constraint(equalTo: textfieldGender.bottomAnchor, constant: 20),
            textfieldWeight.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textfieldWeight.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            textfieldHeight.topAnchor.constraint(equalTo: textfieldWeight.bottomAnchor, constant: 20),
            textfieldHeight.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textfieldHeight.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            textfieldGoal.topAnchor.constraint(equalTo: textfieldHeight.bottomAnchor, constant: 20),
            textfieldGoal.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textfieldGoal.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            saveButton.topAnchor.constraint(equalTo: textfieldGoal.bottomAnchor, constant: 32),
            saveButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 150),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
