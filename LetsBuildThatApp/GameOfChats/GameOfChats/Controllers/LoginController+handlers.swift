//
//  LoginController+handlers.swift
//  GameOfChats
//
//  Created by 강준영 on 16/12/2018.
//  Copyright © 2018 강준영. All rights reserved.
//

import UIKit
import Firebase

extension LoginController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func handleRegister() {
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
            print("Form is not vaild")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) {
            (dataResult, error) in
            
            if error != nil {
                print("Register Error : \(error)")
                return
            }
            
            guard let uid = dataResult?.user.uid else {
                return
            }
            
            // Successfully authenticated user
            let imageName = NSUUID().uuidString
            let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).png")
            if let uploadData =  self.profileImageView.image?.pngData() {
                storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                    if error != nil {
                        print(error)
                        return
                    }
                    storageRef.downloadURL(completion: { [weak self]  (url, error) in
                        let values = ["name": name, "email": email, "profileImageURL": "\(url!)"]
                        self?.registerUserIntoDatabaseWithUID(uid: uid, values: values)
                        print(url)
                    })
                })
            }
            
        }
    }
    
    private func registerUserIntoDatabaseWithUID(uid: String, values: [String: String]) {
        let ref = Database.database().reference(fromURL: "https://gameofchats-a7ecf.firebaseio.com/")
        let userReference = ref.child("user").child(uid)
        userReference.updateChildValues(values, withCompletionBlock: { [weak self](err, ref) in
            if err != nil {
                print("updateUserError: \(err)")
                return
            }
            self?.dismiss(animated: true, completion: nil)
            print("Saved user successfully into firebase db")
            
        })
    }
    
    @objc func handleLoginRegisterChange() {
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        registerButton.setTitle(title, for: .normal)
        
        //change height of inputContainerView
        inputContainerViewHeightAnchor?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 100: 150
        
        //change height of nameTextField
        nameTextFieldHeightAnchor?.isActive = false
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1/3)
        nameTextFieldHeightAnchor?.isActive = true
        
        emailTextFieldHeightAnchor?.isActive = false
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        emailTextFieldHeightAnchor?.isActive = true
        
        passwordTextFieldHeightAnchor?.isActive = false
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        passwordTextFieldHeightAnchor?.isActive = true
    }
    
    @objc func handleSelectProfileImageView() {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
         present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var selectedImageFromPicker: UIImage?
        if let originImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImageFromPicker = originImage
        } else if let editImage = info[UIImagePickerController.InfoKey.editedImage]  as? UIImage {
            selectedImageFromPicker = editImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            profileImageView.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
