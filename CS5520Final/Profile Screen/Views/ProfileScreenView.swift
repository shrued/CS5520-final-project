//
//  ProfileScreenView.swift
//  CS5520Final
//
//  Created by 陈语佳 on 12/4/23.
//

import UIKit

class ProfileScreenView: UIView {
    
    var profileImage: UIImageView!
    var nameLabel: UILabel!
    var ageLabel: UILabel!
    var genderLabel: UILabel!
    var weightLabel: UILabel!
    var heightLabel: UILabel!
    var goalLabel: UILabel!
    
    var editButton: UIButton!
    var orLabel: UILabel!
    var logoutButton: UIButton!
    
    var gradientLayer: CAGradientLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        
        setupGradientBackground()
        setupprofileImage()
        setupnameLabel()
        setupageLabel()
        setupgenderLabel()
        setupweightLabel()
        setupheightLabel()
        setupgoalLabel()
        setuporLabel()
        setupEditButton()
        setupLogoutButton()
        
        initConstraints()
    }
    
    func setupGradientBackground() {
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 0.67, green: 0.88, blue: 0.69, alpha: 1.00).cgColor, // Warm Green
            UIColor(red: 0.98, green: 0.89, blue: 0.49, alpha: 1.00).cgColor  // Warm Yellow
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setupprofileImage() {
        profileImage = UIImageView()
        profileImage.image = UIImage(systemName: "person")
        profileImage.contentMode = .scaleToFill
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = 10
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(profileImage)
    }
    
    func setupnameLabel() {
        nameLabel = UILabel()
        nameLabel.text = "name: USERNAME"
        nameLabel.font = UIFont(name: "Noteworthy-Light", size: 20)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameLabel)
    }
    
    func setupageLabel() {
        ageLabel = UILabel()
        ageLabel.text = "age: AGE"
        ageLabel.font = UIFont(name: "Noteworthy-Light", size: 20)
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(ageLabel)
    }
    
    func setupgenderLabel() {
        genderLabel = UILabel()
        genderLabel.text = "gender: GENDER"
        genderLabel.font = UIFont(name: "Noteworthy-Light", size: 20)
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(genderLabel)
    }
    
    func setupweightLabel() {
        weightLabel = UILabel()
        weightLabel.text = "weight: WEIGHT"
        weightLabel.font = UIFont(name: "Noteworthy-Light", size: 20)
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(weightLabel)
    }
    
    func setupheightLabel() {
        heightLabel = UILabel()
        heightLabel.text = "height: HEIGHT"
        heightLabel.font = UIFont(name: "Noteworthy-Light", size: 20)
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(heightLabel)
    }
    
    func setupgoalLabel() {
        goalLabel = UILabel()
        goalLabel.text = "goal weight: GOAL WEIGHT"
        goalLabel.font = UIFont(name: "Noteworthy-Light", size: 20)
        goalLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(goalLabel)
    }
    
    func setupEditButton() {
        editButton = UIButton(type: .system)
        editButton.setTitle("Edit Profile", for: .normal)
        editButton.setTitleColor(.white, for: .normal)
        editButton.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        editButton.backgroundColor = UIColor(red: 0.50, green: 0.80, blue: 0.64, alpha: 1.00) // Soft Green
        editButton.layer.cornerRadius = 10
        editButton.layer.shadowColor = UIColor.darkGray.cgColor
        editButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        editButton.layer.shadowOpacity = 0.5
        editButton.layer.shadowRadius = 2
        editButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(editButton)
    }
    
    func setuporLabel() {
        orLabel = UILabel()
        orLabel.text = "or"
        orLabel.font = .systemFont(ofSize: 20)
        orLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(orLabel)
    }
    
    func setupLogoutButton() {
        logoutButton = UIButton(type: .system)
        logoutButton.setTitle("Log Out", for: .normal)
        logoutButton.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        logoutButton.setTitleColor(UIColor.systemRed, for: .normal)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(logoutButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            profileImage.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 150),
            profileImage.heightAnchor.constraint(equalToConstant: 150),
            
            nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 16),
            nameLabel.centerXAnchor.constraint(equalTo: profileImage.centerXAnchor),
            
            ageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            ageLabel.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor),
            
            genderLabel.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 16),
            genderLabel.centerXAnchor.constraint(equalTo: ageLabel.centerXAnchor),
            
            weightLabel.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 16),
            weightLabel.centerXAnchor.constraint(equalTo: genderLabel.centerXAnchor),
            
            heightLabel.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 16),
            heightLabel.centerXAnchor.constraint(equalTo: weightLabel.centerXAnchor),
            
            goalLabel.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 16),
            goalLabel.centerXAnchor.constraint(equalTo: heightLabel.centerXAnchor),
            
            editButton.topAnchor.constraint(equalTo: goalLabel.bottomAnchor, constant: 32),
            editButton.centerXAnchor.constraint(equalTo: goalLabel.centerXAnchor),
            editButton.widthAnchor.constraint(equalToConstant: 150),
            editButton.heightAnchor.constraint(equalToConstant: 50),
            
            orLabel.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 12),
            orLabel.centerXAnchor.constraint(equalTo: editButton.centerXAnchor),
            
            logoutButton.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 12),
            logoutButton.centerXAnchor.constraint(equalTo: orLabel.centerXAnchor)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
    }
}
