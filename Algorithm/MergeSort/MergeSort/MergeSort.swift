//
//  MergeSord.swift
//  MergeSort
//
//  Created by 강준영 on 07/03/2019.
//  Copyright © 2019 강준영. All rights reserved.
//

import Foundation

func mergeSort<Element: Comparable>(items: [Element]) -> [Element] {
    guard items.count > 1 else {
        return items
    }
    let middle = items.count / 2
    let leftCards = mergeSort(items: Array(items[..<middle]))
    let rightCards = mergeSort(items:Array(items[middle...]))
    return merge(left: leftCards, right: rightCards)
}

func merge<Element: Comparable>(left: [Element], right: [Element]) -> [Element] {
    var result = [T]()
    var leftIndex = 0
    var rightIndex = 0
    while(leftIndex < left.count && rightIndex < right.count) {
        if left[leftIndex] > right[rightIndex] {
            result.append(right[rightIndex])
            rightIndex += 1
        } else if left[leftIndex] < right[rightIndex] {
            result.append(left[leftIndex])
            leftIndex += 1
        } else {
            result.append(left[leftIndex])
            leftIndex += 1
            result.append(right[rightIndex])
            rightIndex += 1
        }
    }
    
    if leftIndex < left.count  {
        result.append(contentsOf: left[leftIndex...])
    }
    if rightIndex < right.count {
        result.append(contentsOf: right[rightIndex...])
    }
    return result
}




