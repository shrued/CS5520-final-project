//
//  RecordingScreenViewController.swift
//  CS5520Final
//
//  Created by Hanru Chen on 12/2/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class RecordingScreenViewController: UIViewController {
    var currentUser: FirebaseAuth.User?
    let database = Firestore.firestore()
    let recordingScreen = RecordingScreenView()
    
    override func loadView() {
        view = recordingScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recording Screen"
    }

}
