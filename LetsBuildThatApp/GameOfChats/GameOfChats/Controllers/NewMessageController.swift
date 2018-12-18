//
//  NewMessageController.swift
//  GameOfChats
//
//  Created by 강준영 on 16/12/2018.
//  Copyright © 2018 강준영. All rights reserved.
//

import UIKit
import Firebase

class NewMessageController: UITableViewController {

    let cellId = "cellId"
    var users = [User]()
    var activity = UIActivityIndicatorView(style: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: cellId)
        
        self.view.addSubview(activity)
        activity.color = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        activity.frame = self.view.frame
        activity.center = self.view.center
        activity.startAnimating()
        
        fetchUser()
    }
    
    func fetchUser() {
        Database.database().reference().child("user").observe(.childAdded, with: { [weak self] (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let user = User()
                user.name = dictionary["name"] as? String
                user.email = dictionary["email"] as? String
                user.profileImage = dictionary["profileImageURL"] as? String
                self?.users.append(user)
                DispatchQueue.main.async {
                    self?.activity.stopAnimating()
                    self?.tableView.reloadData()
                }
            }
        }, withCancel: nil)
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK:- TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath ) as? UserTableViewCell else {
            return UITableViewCell()
        }
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        
        guard let urlString = user.profileImage else {
            return UITableViewCell()
        }
        cell.profileImageView.loadImageUsingCacheWithUrlString(urlString: urlString)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
