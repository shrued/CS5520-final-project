//
//  RecordingScreenViewController.swift
import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class RecordingScreenViewController: UIViewController {
    var currentUser: FirebaseAuth.User?
    var handleAuth: AuthStateDidChangeListenerHandle?
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handleAuth = Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            if let user = user {
                // User is signed in
                self?.currentUser = user
            } else {
                // No user is signed in
                self?.currentUser = nil
                self?.presentAlert(title: "Error", message: "Please sign in to save your recording.")
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let handleAuth = handleAuth {
            Auth.auth().removeStateDidChangeListener(handleAuth)
        }
    }
    
    //MARK: save button action tapped...
    @objc func onSaveButtonTapped() {
        guard let caloriesFoodName = recordingScreen.textFieldFoodName.text,
              let caloriesAmountStr = recordingScreen.textFieldFoodAmount.text,
              let sugarAmountStr = recordingScreen.textFieldSugarAmount.text,
              let sodiumAmountStr = recordingScreen.textFieldSodiumAmount.text,
              let waterAmountStr = recordingScreen.textFieldWaterAmount.text,
              let caloriesAmount = Double(caloriesAmountStr),
              let sugarAmount = Double(sugarAmountStr),
              let sodiumAmount = Double(sodiumAmountStr),
              let waterAmount = Double(waterAmountStr) else {
            self.presentAlert(title: "Error", message: "Please enter all fields correctly")
            return
        }

        let recordingInfo = RecordingInfo(foodName: caloriesFoodName, caloriesAmount: caloriesAmount, sugarAmount: sugarAmount, sodiumAmount: sodiumAmount, waterAmount: waterAmount)
        saveRecordingInfoToFireStore(recordingInfo: recordingInfo)
    }
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }
    
    
    //MARK: logic to add recording info to Firestore...
    func saveRecordingInfoToFireStore(recordingInfo: RecordingInfo) {
        guard let userEmail = currentUser?.email else {
            presentAlert(title: "Error", message: "User not logged in")
            return
        }

        let collectionRecInfo = database.collection("users").document(userEmail).collection("recordingInfo")
        showActivityIndicator()
        
        do {
            try collectionRecInfo.addDocument(from: recordingInfo) { error in
                self.hideActivityIndicator()
                if let error = error {
                    self.presentAlert(title: "Error", message: "Unable to save recording info: \(error.localizedDescription)")
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        } catch {
            hideActivityIndicator()
            presentAlert(title: "Error", message: "An error occurred while saving")
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
