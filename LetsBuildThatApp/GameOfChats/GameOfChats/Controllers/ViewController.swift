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
        
        // tableview line not visible
        tableView.tableFooterView = UIView()
        
        // user is not logged in
        if Auth.auth().currentUser?.uid == nil {
            performSelector(onMainThread: #selector(handleLogout), with: nil, waitUntilDone: false)
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


