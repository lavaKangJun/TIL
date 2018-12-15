//: Playground - noun: a place where people can play

import UIKit

func example(of: String, action: () -> Void) {
    print(of)
    action()
}

example(of: "insert and contains"){
    let trie = Trie<String>()
    trie.insert("cute")
    trie.insert("cut")
    
    print("\n**Before Removing**")
    if trie.contains("cut") {
        print("contain cut!")
    }
    if trie.contains("cute") {
        print("contain cute!")
    }
    
    print("\n** After Removing **")
    trie.remove("cut")
    assert(!trie.contains("cut"))
    assert(trie.contains("cute"))
    print("cute is still in the trie")
    
}

example(of: "prefix matching") {
    let trie = Trie<String>()
    trie.insert("car")
    trie.insert("card")
    trie.insert("care")
    trie.insert("cared")
    trie.insert("cars")
    trie.insert("carbs")
    trie.insert("carapace")
    trie.insert("cargo")
    
    print("\nCollections starting with \"car\"")
    let prefixedWithCar = trie.collections(startWith: "car")
    print(prefixedWithCar)
    
    print("\nCollections starting with \"care\"")
    let prefixedWithCare = trie.collections(startWith: "care")
    print(prefixedWithCare)
}

