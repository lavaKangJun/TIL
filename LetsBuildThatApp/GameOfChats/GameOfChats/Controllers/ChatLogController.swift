//
//  ChatLogController.swift
//  GameOfChats
//
//  Created by 강준영 on 24/12/2018.
//  Copyright © 2018 강준영. All rights reserved.
//

import UIKit
import Firebase

class ChatLogController: UICollectionViewController, UITextFieldDelegate, UICollectionViewDelegateFlowLayout {

    var user: User? {
        didSet {
            navigationItem.title = user?.name
            observeMessage()
        }
    }
    
    lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter Message..."
        textField.delegate = self
        return textField
    }()
    
    var message = [Message]()
    
    let cellId = "cellId"
    
    func observeMessage() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let userMessageRef = Database.database().reference().child("user-messages").child(uid)
        userMessageRef.observe(.childAdded, with: { (snapshot) in
            let messageId = snapshot.key
            let messageRef = Database.database().reference().child("message").child(messageId)
            messageRef.observeSingleEvent(of: .value, with: { [weak self] (snapshot) in
                guard let dictionary = snapshot.value as? [String: AnyObject] else {
                    return
                }
                
                let message = Message()
                message.fromId = dictionary["fromId"] as? String
                message.text =  dictionary["text"] as? String
                message.timeStamp = dictionary["timeStamp"] as? Double
                message.toId = dictionary["toId"] as? String
                
                if message.chatPartnerId() == self?.user?.id {
                    self?.message.append(message)
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                    }
                }
            }, withCancel: nil)
        }, withCancel: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        collectionView.register(ChatMessageCell.self, forCellWithReuseIdentifier: cellId)
        
        setupInputComponents()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return message.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatMessageCell
        
        cell.textField.text = message[indexPath.item].text
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
    
    func setupInputComponents() {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 50),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        let sendButton = UIButton(type: .system)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.setTitle("Send", for: .normal)
        sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        containerView.addSubview(sendButton)
        
        NSLayoutConstraint.activate([
            sendButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 50),
            sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor)
            ])

        containerView.addSubview(inputTextField)
        
        NSLayoutConstraint.activate([
            inputTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            inputTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor),
            inputTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            inputTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor)
            ])
        
        let separatorLine = UIView()
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        separatorLine.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        containerView.addSubview(separatorLine)
        
        NSLayoutConstraint.activate([
            separatorLine.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            separatorLine.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 1),
            separatorLine.topAnchor.constraint(equalTo: containerView.topAnchor)
            ])
    }
    
    @objc func handleSend() {
        let ref = Database.database().reference().child("message")
        let childRef = ref.childByAutoId()
        guard let textContents = self.inputTextField.text else {
            return
        }
        let toId = user!.id!
        let fromId = Auth.auth().currentUser!.uid
        let timeStamp = Date().toMillis()
        let values = ["text": textContents, "toId": toId, "fromId": fromId, "timeStamp": timeStamp] as [String : Any]
        
        childRef.updateChildValues(values) { (error, ref) in
            if error != nil {
                print(error)
                return
            }
            
            let userMessageRef = Database.database().reference().child("user-messages").child(fromId)
            print("userMessageRef: \(userMessageRef)")
            let messageId = childRef.key
            if let messageId  = messageId {
                userMessageRef.updateChildValues([messageId: 1])
                }
            
            let recipientUserMessageRef = Database.database().reference().child("user-messages").child(toId)
            print("recipientUserMessageRef: \(recipientUserMessageRef)")
            recipientUserMessageRef.updateChildValues([messageId: 1])
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleSend()
        return true
    }

}
