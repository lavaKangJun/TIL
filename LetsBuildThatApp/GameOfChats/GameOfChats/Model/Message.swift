//
//  Message.swift
//  GameOfChats
//
//  Created by 강준영 on 02/01/2019.
//  Copyright © 2019 강준영. All rights reserved.
//

import UIKit
import Firebase

class Message: NSObject {
    var fromId: String?
    var text: String?
    var timeStamp: Double?
    var toId: String?
    
    func chatPartnerId() -> String? {
        return fromId ==  Auth.auth().currentUser?.uid ? toId : fromId
    }
}
