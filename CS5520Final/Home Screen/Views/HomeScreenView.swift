//
//  HomeScreenView.swift
//  CS5520Final
//
//  Created by 陈语佳 on 12/4/23.
//

import UIKit

class HomeScreenView: UIView {
    
    var OverviewButton: UIButton!
    var RecordButton: UIButton!
    
    var TimerImage: UIImageView!
    var TimerLabel: UILabel!
    var resetButton: UIButton!
    var TimerMessage: UILabel!
    
    var ProgressLabel: UILabel!
    var ProgressMessage: UILabel!
    
    var ArticleButton: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupOverviewButton()
        setupRecordButton()
        setupTimerImage()
        setupTimerLabel()
        setupProgressLabel()
        setupProgressMessage()
        setupArticleButton()
        setupResetButton()
        setupTimerMessage()
        
        initConstraints()
    }
    
    func setupOverviewButton() {
        OverviewButton = UIButton(type: .system)
        OverviewButton.setTitle("Overview", for: .normal)
        OverviewButton.setTitleColor(.white, for: .normal)
        OverviewButton.titleLabel!.font = .systemFont(ofSize: 25.0, weight: .bold)
        OverviewButton.backgroundColor = .gray
        OverviewButton.frame = CGRect(x: 100, y: 100, width: 150, height: 50)
        OverviewButton.layer.cornerRadius = 5
        OverviewButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(OverviewButton)
    }
    
    func setupRecordButton() {
        RecordButton = UIButton(type: .system)
        RecordButton.setTitle("Recording", for: .normal)
        RecordButton.setTitleColor(.white, for: .normal)
        RecordButton.titleLabel!.font = .systemFont(ofSize: 25.0, weight: .bold)
        RecordButton.backgroundColor = .systemMint
        RecordButton.frame = CGRect(x: 100, y: 100, width: 150, height: 50)
        RecordButton.layer.cornerRadius = 4
        RecordButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(RecordButton)
    }
    
    func setupTimerImage() {
        TimerImage = UIImageView()
        TimerImage.image = UIImage(systemName: "clock")
        TimerImage.contentMode = .scaleToFill
        TimerImage.clipsToBounds = true
        TimerImage.layer.cornerRadius = 5
        TimerImage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(TimerImage)
    }
    
    func setupTimerLabel() {
        TimerLabel = UILabel()
        TimerLabel.text = "Intermittent fasting timer"
        TimerLabel.textColor = .brown
        TimerLabel.font = .systemFont(ofSize: 20)
        TimerLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(TimerLabel)
    }
    
    func setupResetButton() {
        resetButton = UIButton(type: .system)
        resetButton.setTitle("RESET TIMER", for: .normal)
        resetButton.titleLabel!.font = .systemFont(ofSize: 20.0, weight: .bold)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(resetButton)
    }
    
    func setupTimerMessage() {
        TimerMessage = UILabel()
        TimerMessage.text = "Press RESET TIMER to Start"
        TimerMessage.textColor = .white
        TimerMessage.backgroundColor = .gray
        TimerMessage.font = .systemFont(ofSize: 20, weight: .bold)
        TimerMessage.frame = CGRect(x: 100, y: 100, width: 300, height: 50)
        TimerMessage.layer.cornerRadius = 10
        TimerMessage.textAlignment = .center
        TimerMessage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(TimerMessage)
    }
    
    func setupProgressLabel() {
        ProgressLabel = UILabel()
        ProgressLabel.text = "Current Progress"
        ProgressLabel.textColor = .systemMint
        ProgressLabel.font = .systemFont(ofSize: 25, weight: .bold)
        ProgressLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(ProgressLabel)
    }
    
    func setupProgressMessage() {
        ProgressMessage = UILabel()
        ProgressMessage.text = "Please setup your current weight and goal weight!"
        ProgressMessage.textColor = .systemBrown
        ProgressMessage.font = .systemFont(ofSize: 16)
        ProgressMessage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(ProgressMessage)
    }
    
    func setupArticleButton() {
        ArticleButton = UIButton()
        ArticleButton.setTitle("", for: .normal)
        ArticleButton.setImage(UIImage(systemName: "book.fill"), for: .normal)
        ArticleButton.contentHorizontalAlignment = .fill
        ArticleButton.contentVerticalAlignment = .fill
        ArticleButton.imageView?.contentMode = .scaleAspectFit
        ArticleButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(ArticleButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            OverviewButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            OverviewButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            OverviewButton.widthAnchor.constraint(equalToConstant: 150),
            OverviewButton.heightAnchor.constraint(equalToConstant: 50),
            
            RecordButton.topAnchor.constraint(equalTo: OverviewButton.bottomAnchor, constant: 20),
            RecordButton.centerXAnchor.constraint(equalTo: OverviewButton.centerXAnchor),
            RecordButton.widthAnchor.constraint(equalToConstant: 150),
            RecordButton.heightAnchor.constraint(equalToConstant: 50),
            
            TimerImage.topAnchor.constraint(equalTo: RecordButton.bottomAnchor, constant: 32),
            TimerImage.centerXAnchor.constraint(equalTo: RecordButton.centerXAnchor),
            TimerImage.widthAnchor.constraint(equalToConstant: 100),
            TimerImage.heightAnchor.constraint(equalToConstant: 100),
            
            TimerLabel.topAnchor.constraint(equalTo: TimerImage.bottomAnchor, constant: 20),
            TimerLabel.centerXAnchor.constraint(equalTo: TimerImage.centerXAnchor),
            
            resetButton.topAnchor.constraint(equalTo: TimerLabel.bottomAnchor, constant: 20),
            resetButton.centerXAnchor.constraint(equalTo: TimerLabel.centerXAnchor),
            
            TimerMessage.topAnchor.constraint(equalTo: resetButton.bottomAnchor, constant: 20),
            TimerMessage.centerXAnchor.constraint(equalTo: resetButton.centerXAnchor),
            TimerMessage.widthAnchor.constraint(equalToConstant: 300),
            TimerMessage.heightAnchor.constraint(equalToConstant: 50),
            
            ProgressLabel.topAnchor.constraint(equalTo: TimerLabel.bottomAnchor, constant: 96),
            ProgressLabel.centerXAnchor.constraint(equalTo: TimerLabel.centerXAnchor),
            
            ProgressMessage.topAnchor.constraint(equalTo: ProgressLabel.bottomAnchor, constant: 20),
            ProgressMessage.centerXAnchor.constraint(equalTo: ProgressLabel.centerXAnchor),
            
            ArticleButton.topAnchor.constraint(equalTo: ProgressMessage.bottomAnchor, constant: 30),
            ArticleButton.centerXAnchor.constraint(equalTo: ProgressMessage.centerXAnchor)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
