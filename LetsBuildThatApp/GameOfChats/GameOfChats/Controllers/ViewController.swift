//
//  ViewController.swift
//  GameOfChats
//
//  Created by 강준영 on 29/11/2018.
//  Copyright © 2018 강준영. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        let image = #imageLiteral(resourceName: "new_message")
        navigationItem.rightBarButtonItem  = UIBarButtonItem(image: image, style: .plain , target: self, action: #selector(handleNewMessage))
        
        // tableview line not visible
        tableView.tableFooterView = UIView()
        
        checkIfUserLogin()
    }
    
    @objc func handleNewMessage() {
        let newMessageController = NewMessageController()
        
        // nitializes and returns a newly created navigation controller.
        let navController = UINavigationController(rootViewController: newMessageController)
        present(navController, animated: true, completion: nil)
    }
    
    func checkIfUserLogin() {
        // user is not logged in
        if Auth.auth().currentUser?.uid == nil {
            performSelector(onMainThread: #selector(handleLogout), with: nil, waitUntilDone: false)
        } else {
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("user").child(uid!).observeSingleEvent(of: .value) { (snapShot) in
                if let dictionary = snapShot.value as? [String: AnyObject] {
                    self.navigationItem.title = dictionary["name"] as? String
                }
            }
        }
    }
    
    @objc func handleLogout() {
        
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginVC = LoginController()
        // Presents a view controller modally.
        present(loginVC, animated: true, completion: nil)
    }
    
    
    
}


