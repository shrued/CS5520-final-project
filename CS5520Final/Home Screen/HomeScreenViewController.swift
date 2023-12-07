//
//  HomeScreenViewController.swift
//  CS5520Final
//
//  Created by 陈语佳 on 12/4/23.
//

import UIKit

class HomeScreenViewController: UIViewController {

    var homeScreen = HomeScreenView()
    
    override func loadView() {
        view = homeScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home Page"
        
        
        homeScreen.OverviewButton.addTarget(self, action: #selector(onButtonOverviewTapped),
                                for: .touchUpInside)
        homeScreen.RecordButton.addTarget(self, action: #selector(onButtonRecordingTapped),
                                for: .touchUpInside)
        homeScreen.ArticleButton.addTarget(self, action: #selector(onButtonArticlesTapped), for: .touchUpInside)
    }
    
    @objc func onButtonOverviewTapped() {
        let overviewController = OverviewScreenViewController()
        navigationController?.pushViewController(overviewController, animated: true)
    }
    
    @objc func onButtonRecordingTapped() {
        let recordingController = RecordingScreenViewController()
        navigationController?.pushViewController(recordingController, animated: true)
    }
    
    @objc func onButtonArticlesTapped() {
        let articlesController = ArticlesScreenController()
        navigationController?.pushViewController(articlesController, animated: true)
    }
}
