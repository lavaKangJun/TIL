//: Playground - noun: a place where people can play

import UIKit


func example(of: String ,action: () -> Void) {
    print("--Example of: \(of)--")
    action()
}

example(of: "buildings BST") {
    var bst = BinarySearchTree<Int>()
    for value in 0..<5 {
        bst.insert(value)
    }
    print(bst)
}

var exampleTree: BinarySearchTree<Int> {
    var bst = BinarySearchTree<Int>()
    bst.insert(3)
    bst.insert(1)
    bst.insert(4)
    bst.insert(0)
    bst.insert(2)
    bst.insert(5)
    return bst
}

example(of: "buildings BST") {
    print(exampleTree)
}

example(of: "finding a node Version1") {
    if exampleTree.contains(5) {
        print("Found!")
    } else {
        print("Could not find..")
    }
}


example(of: "finding a node Version2") {
    if exampleTree.contains(value: 5) {
        print("Found!")
    } else {
        print("Could not find..")
    }
}

example(of: "removing node") {
    var tree = exampleTree
    tree.remove(3)
    print(tree)
}
