//
//  Card.swift
//  MergeSort
//
//  Created by 강준영 on 07/03/2019.
//  Copyright © 2019 강준영. All rights reserved.
//

import Foundation

enum Suit: String {
    case spades = "spades"
    case hearts = "hearts"
    case clubs = "clubs"
    case dimaonds = "dimaonds"
}

struct Card: Comparable {
    var suit: Suit
    var rank: Int
    
    static func < (lhs: Card, rhs: Card) -> Bool {
        return lhs.rank < rhs.rank
    }
}



