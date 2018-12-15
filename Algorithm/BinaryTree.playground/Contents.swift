//: Playground - noun: a place where people can play

import UIKit

func example(of: String, _ action: () -> (Void)){
    print("Example of \(of)")
    action()
}

var tree: BinaryNode<Int> {
    let zero = BinaryNode(0)
    let one = BinaryNode(1)
    let five = BinaryNode(5)
    let seven = BinaryNode(7)
    let eight = BinaryNode(8)
    let nine = BinaryNode(9)
    seven.leftChild = one
    one.leftChild = zero
    one.rightChild = five
    seven.rightChild = nine
    nine.leftChild = eight
    print("leaf node: \(zero.isLeafNode)")
    return seven
}




example(of: "tree diagram") {
    print(tree)
}

print(tree.findHeight(tree: tree))

example(of: "in-order traversal") {
    tree.traverseInOrder { print($0) }
}
example(of: "pre-order traversal") {
    tree.travelsePreOrder { print($0) }
}
example(of: "post-order traversal") {
    tree.travelsePostOrder { print($0) }
}



