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

class MessagesController: UITableViewController {

    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        let image = #imageLiteral(resourceName: "new_message")
        navigationItem.rightBarButtonItems  = [UIBarButtonItem(image: image, style: .plain , target: self, action: #selector(handleNewMessage))/*, UIBarButtonItem(title: "GoChat", style: .plain , target: self, action: #selector(showChatController))*/]
        
        // tableview line not visible
        tableView.tableFooterView = UIView()
        
        checkIfUserLogin()
        
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: cellId)
        
        observeMessages()
    }
    
    var messages = [Message]()
    var messageDictionary = [String: Message]()
    
    func observeMessages() {
        let ref = Database.database().reference().child("message")
        
        ref.observe(.childAdded, with: { [weak self] (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let message = Message()
                message.fromId = dictionary["fromId"] as? String
                message.toId = dictionary["toId"] as? String
                message.text = dictionary["text"] as? String
                message.timeStamp = dictionary["timeStamp"] as? Double
                
                if let toId = message.toId {
                    self?.messageDictionary[toId] = message
                    self?.messages = Array((self?.messageDictionary.values)!)
                    self?.messages.sorted(by: { (message1, message2) -> Bool in
                        return Int(message1.timeStamp!) < Int(message2.timeStamp!)
                    })
                }
                // main Thread
                DispatchQueue.main.async {
                     self?.tableView.reloadData()
                }
            }
        }, withCancel: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell  = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserTableViewCell
        
        let message = messages[indexPath.row]
        cell.message = message
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    @objc func handleNewMessage() {
        let newMessageController = NewMessageController()
        newMessageController.messageController = self
        // nitializes and returns a newly created navigation controller.
        let navController = UINavigationController(rootViewController: newMessageController)
        present(navController, animated: true, completion: nil)
    }
    
    func checkIfUserLogin() {
        // user is not logged in
        if Auth.auth().currentUser?.uid == nil {
            performSelector(onMainThread: #selector(handleLogout), with: nil, waitUntilDone: false)
        } else {
           fetchUserAndSetupNavBarTitle()
        }
    }
    
    func fetchUserAndSetupNavBarTitle() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        Database.database().reference().child("user").child(uid).observeSingleEvent(of: .value) { [weak self] (snapShot) in
            if let dictionary = snapShot.value as? [String: AnyObject] {
                let user = User()
                user.name = dictionary["name"] as? String
                user.profileImageURL = dictionary["profileImageURL"] as? String
                self?.setupNavBarWithUser(user: user)
            }
        }
    }
    
    func setupNavBarWithUser(user: User) {
        let titleView = UIView()
        
        titleView.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        
        let profileImage = UIImageView()
        profileImage.contentMode = .scaleAspectFill
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.layer.cornerRadius = 20
        profileImage.layer.masksToBounds = true
        if let profilImage = user.profileImageURL {
            profileImage.loadImageUsingCacheWithUrlString(urlString: profilImage)
        }

        titleView.addSubview(profileImage)

        NSLayoutConstraint.activate([
            profileImage.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            profileImage.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 40),
            profileImage.heightAnchor.constraint(equalToConstant: 40)
            ])

        let nameLabel = UILabel()
        titleView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = user.name
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 8),
            nameLabel.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalTo: profileImage.heightAnchor)
            ])
        
        self.navigationItem.titleView = titleView
        
        
    }
    
    @objc func showChatControllerForUser(user: User) {
        let chatLogController = ChatLogController(collectionViewLayout: UICollectionViewFlowLayout() )
        chatLogController.user = user
        navigationController?.pushViewController(chatLogController, animated: true)
    }
    
    @objc func handleLogout() {
        
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginVC = LoginController()
        // Presents a view controller modally.
        loginVC.messageController = self
        present(loginVC, animated: true, completion: nil)
    }
    
    
    
}


