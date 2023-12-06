//
//  EditScreenViewController.swift
//  CS5520Final
//
//  Created by 陈语佳 on 12/5/23.
//

import UIKit
import PhotosUI

class EditScreenViewController: UIViewController {
    
    var pickedImage: UIImage?
    var editScreen = EditScreenView()
    var delegate:ProfileScreenViewController!
    
    override func loadView() {
        view = editScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Edit Profile"
        editScreen.takePhoto.menu = getMenuImagePicker()
        
        self.navigationItem.hidesBackButton = true
        
        editScreen.saveButton.addTarget(self, action: #selector(onButtonSaveTapped), for: .touchUpInside)
    }
    
    @objc func onButtonSaveTapped() {
        var name:String = ""
        if let nameText = editScreen.textfieldName.text{
            if !nameText.isEmpty {
                name = nameText
            }
            else {
                presentAlert(title: "Error", message: "Name cannot be empty!")
            }
        }
        
        var age:Int = 0
        if let ageText = editScreen.textfieldAge.text{
            if !ageText.isEmpty {
                age = Int(ageText)!
            }
            else {
                presentAlert(title: "Error", message: "Age cannot be empty!")
            }
        }
        
        var gender:String = ""
        if let genderText = editScreen.textfieldGender.text{
            if !genderText.isEmpty {
                gender = genderText
            }
            else {
                presentAlert(title: "Error", message: "Gender cannot be empty!")
            }
        }
        
        var weight:Double = 0.0
        if let weightText = editScreen.textfieldWeight.text{
            if !weightText.isEmpty {
                weight = Double(weightText)!
            }
            else {
                presentAlert(title: "Error", message: "Weight cannot be empty!")
            }
        }
        
        var height:String = ""
        if let heightText = editScreen.textfieldHeight.text{
            if !heightText.isEmpty {
                height = heightText
            }
            else {
                presentAlert(title: "Error", message: "Height cannot be empty!")
            }
        }
        
        var goal:Double = 0.0
        if let goalText = editScreen.textfieldGoal.text{
            if !goalText.isEmpty {
                goal = Double(goalText)!
            }
            else {
                presentAlert(title: "Error", message: "Goal cannot be empty!")
            }
        }
        
        let Profile = ProfileInfo(name: name, age: age, gender: gender, weight: weight, height: height, goal: goal)
        delegate.profile = Profile
        delegate.profileScreen.profileImage.image = pickedImage
        delegate.delegateOnEditProfile()
        
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: menu for buttonTakePhoto setup...
    func getMenuImagePicker() -> UIMenu{
        let menuItems = [
            UIAction(title: "Camera",handler: {(_) in
                self.pickUsingCamera()
            }),
            UIAction(title: "Gallery",handler: {(_) in
                self.pickPhotoFromGallery()
            })
        ]
        
        return UIMenu(title: "Select source", children: menuItems)
    }
    
    //MARK: take Photo using Camera...
    func pickUsingCamera(){
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .camera
        cameraController.allowsEditing = true
        cameraController.delegate = self
        present(cameraController, animated: true)
    }
    
    //MARK: pick Photo using Gallery...
    func pickPhotoFromGallery(){
        //MARK: Photo from Gallery...
        var configuration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.any(of: [.images])
        configuration.selectionLimit = 1
        
        let photoPicker = PHPickerViewController(configuration: configuration)
        
        photoPicker.delegate = self
        present(photoPicker, animated: true, completion: nil)
    }
    
    // MARK: Present alert...
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }
}

extension EditScreenViewController:PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        print(results)
        
        let itemprovider = results.map(\.itemProvider)
        
        for item in itemprovider{
            if item.canLoadObject(ofClass: UIImage.self){
                item.loadObject(
                    ofClass: UIImage.self,
                    completionHandler: { (image, error) in
                        DispatchQueue.main.async{
                            if let uwImage = image as? UIImage{
                                self.editScreen.takePhoto.setImage(
                                    uwImage.withRenderingMode(.alwaysOriginal),
                                    for: .normal
                                )
                                self.pickedImage = uwImage
                            }
                        }
                    }
                )
            }
        }
    }
}

//MARK: adopting required protocols for UIImagePicker...
extension EditScreenViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[.editedImage] as? UIImage{
            self.editScreen.takePhoto.setImage(
                image.withRenderingMode(.alwaysOriginal),
                for: .normal
            )
            self.pickedImage = image
        }else{
            // Do your thing for No image loaded...
        }
    }
}