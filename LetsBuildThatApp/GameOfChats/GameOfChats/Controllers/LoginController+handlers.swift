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
                print("Register Error : \(error!)")
                return
            }
            
            guard let uid = dataResult?.user.uid else {
                return
            }
            
            // Successfully authenticated user
            let imageName = NSUUID().uuidString
            let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).jpg")
            // png -> jpg (size problem)
           // if let uploadData == self.profileImageView.image?.pngData(){
            if let profileImage = self.profileImageView.image, let uploadData = profileImage.jpegData(compressionQuality: 0.1) {
                storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                    if error != nil {
                        print(error!)
                        return
                    }
                    storageRef.downloadURL(completion: { [weak self]  (url, error) in
                        guard let url = url else {
                            return
                        }
                        let values = ["name": name, "email": email, "profileImageURL": "\(url)"]
                        self?.registerUserIntoDatabaseWithUID(uid: uid, values: values)
                    })
                })
            }
        }
    }
    
    private func registerUserIntoDatabaseWithUID(uid: String, values: [String: String]) {
        let ref = Database.database().reference()
        let userReference = ref.child("user").child(uid)
        userReference.updateChildValues(values, withCompletionBlock: { [weak self](err, ref) in
            if err != nil {
                print("updateUserError: \(err!)")
                return
            }
            
            let user = User()
            user.name = values["name"] as? String
            user.profileImageURL = values["profileImageURL"] as? String
            self?.messageController?.setupNavBarWithUser(user: user)
            self?.dismiss(animated: true, completion: nil)
            print("Saved user successfully into firebase db")
            
        })
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
