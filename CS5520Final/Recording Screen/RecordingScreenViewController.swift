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
    let childProgressView = ProgressSpinnerViewController()
    
    override func loadView() {
        view = recordingScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recording Screen"
        recordingScreen.buttonSave.addTarget(self, action: #selector(onSaveButtonTapped), for: .touchUpInside)
    }

    //MARK: save button action tapped...
    @objc func onSaveButtonTapped() {
        let caloriesFoodName = recordingScreen.textFieldFoodName.text
        let caloriesAmount = recordingScreen.textFieldFoodAmount.text
        let sugarAmount = recordingScreen.textFieldSugarAmount.text
        let sodiumAmount = recordingScreen.textFieldSodiumAmount.text
        let waterAmount = recordingScreen.textFieldWaterAmount.text
        
        if caloriesFoodName == "" || caloriesAmount == "" || sugarAmount == "" || sodiumAmount == "" || waterAmount == "" {
            
            let alert = UIAlertController(title: "Error", message: "Please fill in all fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alert, animated: true)
        } else {
            let recordingInfo = RecordingInfo(foodName: caloriesFoodName!, caloriesAmount: caloriesAmount!, sugarAmount: sugarAmount!, sodiumAmount: sodiumAmount!, waterAmount: waterAmount!)
            
            saveRecordingInfoToFireStore(recordingInfo: recordingInfo)
        }
    }
    
    //MARK: logic to add recording info to Firestore...
    func saveRecordingInfoToFireStore(recordingInfo: RecordingInfo) {
        if let userEmail = currentUser!.email{
            let collectionRecInfo = database
                .collection("users")
                .document(userEmail)
                .collection("recordingInfo")
            
            showActivityIndicator()
            
            do{
                try collectionRecInfo.addDocument(from: recordingInfo, completion: {(error) in
                    if error == nil{
                        self.hideActivityIndicator()
                        self.navigationController?.popViewController(animated: true)
                    }
                })
            }catch {
                // show error message
                let alert = UIAlertController(title: "Error", message: "Unable to save recording info", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                present(alert, animated: true)
            }
        }
    }
}

extension RecordingScreenViewController: ProgressSpinnerDelegate {
    func showActivityIndicator(){
        addChild(childProgressView)
        view.addSubview(childProgressView.view)
        childProgressView.didMove(toParent: self)
    }
    
    func hideActivityIndicator(){
        childProgressView.willMove(toParent: nil)
        childProgressView.view.removeFromSuperview()
        childProgressView.removeFromParent()
    }
}
