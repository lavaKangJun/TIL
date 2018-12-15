//: Playground - noun: a place where people can play

import UIKit

func example(of: String, excute: @escaping() -> (Void)){
    print("-- Example: \(of) --")
    excute()
}


example(of: "creating a tree") {
    let beverages = TreeNode("Beverages")
    
    let hot = TreeNode("hot")
    let cold = TreeNode("cold")
    
    beverages.add(hot)
    beverages.add(cold)
}


func makeBeverageTree() -> TreeNode<String>{
    let tree = TreeNode("Beverages")

    let hot = TreeNode("hot")
    let cold = TreeNode("cold")

    let tea = TreeNode("tea")
    let coffee = TreeNode("coffee")
    let chocolate = TreeNode("chocolate")

    let blackTea = TreeNode("blackTea")
    let greenTea = TreeNode("greenTea")
    let chaiTea = TreeNode("chaiTea")

    let soda = TreeNode("soda")
    let milk = TreeNode("milk")

    let gingerAle = TreeNode("gingerAle")
    let bitterLemon = TreeNode("bitterLemon")

    tree.add(hot)
    tree.add(cold)

    hot.add(tea)
    hot.add(coffee)
    hot.add(chocolate)

    cold.add(soda)
    cold.add(milk)

    tea.add(blackTea)
    tea.add(greenTea)
    tea.add(chaiTea)

    soda.add(gingerAle)
    soda.add(bitterLemon)

    return tree
}

example(of: "depth-first travelsal") {
    let tree = makeBeverageTree()
    tree.forEachDepthFirst{ print($0.value) }
}


example(of: "level-order-travelsal") {
    let tree = makeBeverageTree()
    tree.forEachLevelOrder{ print($0.value)
    }
    // print(tree.children.last?.value)
}

example(of: "searching for a node") {
    let tree = makeBeverageTree()
   
    if let searchResult1 = tree.search("gingerAle") {
        print("Found: \(searchResult1.value)")
    } else {
        print("Couldn't found gingerAle")
    }
    
    if let searchResult2 = tree.search("WKDBluie") {
        print("Found: \(searchResult2)")
    } else {
        print("Couldn't found WKDBluie")
    }
    
}

