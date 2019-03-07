//
//  main.swift
//  MergeSort
//
//  Created by 강준영 on 07/03/2019.
//  Copyright © 2019 강준영. All rights reserved.
//

import Foundation

var cardArray = [Card]()

var card1 = Card(suit: Suit.clubs, rank: 7)
cardArray.append(card1)
var card2 = Card(suit: Suit.dimaonds, rank: 2)
cardArray.append(card2)
var card3 = Card(suit: Suit.hearts, rank: 6)
cardArray.append(card3)
var card4 = Card(suit: Suit.spades, rank: 3)
cardArray.append(card4)
var card5 = Card(suit: Suit.clubs, rank: 9)
cardArray.append(card5)

print(cardArray.sorted())
print(mergeSort(items: cardArray))
