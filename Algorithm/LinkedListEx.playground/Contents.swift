//: Playground - noun: a place where people can play

import UIKit

func example(of string: String, excute: @escaping () -> (Void)) {
    print(string)
    excute()
}


example(of: "creating and linking nodes") {
    let node1 = Node(value: 1)
    let node2 = Node(value: 2)
    let node3 = Node(value: 3)
    
    node1.next = node2
    node2.next = node3
    print(node1)
}

print("creating and linking nodes")
let node1 = Node(value: 1)
let node2 = Node(value: 2)
let node3 = Node(value: 3)

node1.next = node2
node2.next = node3
print(node1)


print("push") // head-first insertion
var list = LinkedList<Int>()
list.push(3)
list.push(2)
list.push(1)

print(list)
var newlist = list.map{ $0 * 4 }  
print("list map: \(newlist)")

let filteredList = newlist.filter { (value: Int) -> Bool in
    return value > 8
}

print("list filter: \(filteredList)")

// tail-end insertion
print("append")

var list2 = LinkedList<Int>()
list2.append(1)
list2.append(2)
list2.append(3)

print(list2)

print("insert")
var list3 = LinkedList<Int>()

list3.push(3)
list3.push(2)
list3.push(1)

print("Before inserting: \(list3)")
var middleNode = list3.node(at: 1)!
for _ in 1...4 {
    middleNode = list3.insert(-1, after: middleNode)
}
print("After inserting: \(list3)")

print("pop")

var popList = LinkedList<Int>()

popList.push(3)
popList.push(2)
popList.push(1)

print("Before pop: \(popList)")
let popValue = popList.pop()
print("After pop: \(popList)")
print("Popped Value: " + String(describing: popValue))

print("remove Last")

var removeLastList = LinkedList<Int>()
removeLastList.push(3)
removeLastList.push(2)
removeLastList.push(1)

print("Before RemoveLast: \(removeLastList)")

var removeValue = removeLastList.removeLast()
print("After RemoveLast: \(removeLastList)")
print("RemoveLast value: \(String(describing: removeValue))")

print("removing a node after a particular node")
var removeAtList = LinkedList<Int>()
removeAtList.push(5)
removeAtList.push(4)
removeAtList.push(3)
removeAtList.push(2)
removeAtList.push(1)

print("Before removing a particular node: \(removeAtList)")
let index = 1
let node = removeAtList.node(at: index - 1)!
let removeNode = removeAtList.remove(after: node)

print("Remove Node Value: \(removeNode)")
print("Afer removint a particular node: \(removeAtList)")
print()


print("using Collection")
var collectionList = LinkedList<Int>()
for i in 0...9{
    collectionList.append(i)
}

print("list: \(collectionList)")
print("First Element: \(collectionList[collectionList.startIndex])")
print("Array containing first 3 element: \(Array(collectionList.prefix(3)))")
print("Array containing first 3 element: \(Array(collectionList.suffix(3)))")

let sum = collectionList.reduce(0, +)
print("sum of all values: \(sum)")


print("Array COW")
let array1 = [1, 2]
var array2 = array1

print("array1: \(array1)")
print("array2: \(array2)")

print("After adding 3 to array2")
array2.append(3)
print("array1: \(array1)")
print("array2: \(array2)")

print("LinkedLst COW")
var cowOfList1 = LinkedList<Int>()
cowOfList1.append(1)
cowOfList1.append(2)

print("cowOfList1 uniquely referenced: \(isKnownUniquelyReferenced(&cowOfList1.head))")

var cowOfList2 = cowOfList1
print("cowOfList1 uniquely referenced: \(isKnownUniquelyReferenced(&cowOfList1.head))")

print("cowOfList1: \(cowOfList1)")
print("cowOfList2: \(cowOfList2)")

print("After adding 3 to cowOfList2")
cowOfList2.append(3)
print("cowOfList1: \(cowOfList1)")
print("cowOfList2: \(cowOfList2)")

var cowOfList3 = LinkedList<Int>()
(1...3).forEach{ cowOfList3.append($0) }
var cowOfList4 = cowOfList3
print(cowOfList3)
print(cowOfList4)
print("After Push")
cowOfList4.push(0)
print(cowOfList3)
print(cowOfList4)

print()
////////////////////////////////////
//////LinkedList Challenge/////////
//////////////////////////////////

/////Chap1/////
var challengOneLinkedList = LinkedList<Int>()

challengOneLinkedList.push(3)
challengOneLinkedList.push(2)
challengOneLinkedList.push(1)

print("Before reverse: \(challengOneLinkedList)")
challengOneLinkedList =  challengOneLinkedList.reverse()!
print("After reverse: \(challengOneLinkedList)")

/////Chap2/////
var challengTwoLinkedList = LinkedList<Int>()

challengTwoLinkedList.push(4)
challengTwoLinkedList.push(3)
challengTwoLinkedList.push(2)
challengTwoLinkedList.push(1)
print("middleNode:\(String(describing: challengTwoLinkedList.middleNode()))")

challengTwoLinkedList.reverseTotal()
print("Reverse List Totally: \(challengTwoLinkedList)")









