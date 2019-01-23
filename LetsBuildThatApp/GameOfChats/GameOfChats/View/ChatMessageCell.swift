//
//  ChatMessageCell.swift
//  GameOfChats
//
//  Created by 강준영 on 23/01/2019.
//  Copyright © 2019 강준영. All rights reserved.
//

import UIKit

class ChatMessageCell: UICollectionViewCell {
    var textField: UITextField = {
        let tv = UITextField()
        tv.text = "This is Message"
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(textField)
        NSLayoutConstraint.activate([
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textField.topAnchor.constraint(equalTo: self.topAnchor),
            textField.widthAnchor.constraint(equalToConstant: 200),
            textField.heightAnchor.constraint(equalTo: self.heightAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
