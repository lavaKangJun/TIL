import Foundation

public class BinaryNode<Element> {
    public var value: Element
    public var leftChild: BinaryNode?
    public var rightChild: BinaryNode?
    
    public init(_ value: Element) {
        self.value = value
    }
}

extension BinaryNode: CustomStringConvertible {
    public var description: String {
        //  print("in description")
        return diagram(for: self)
    }
    private func diagram(for node: BinaryNode?,
                         _ top: String = "",
                         _ root: String = "",
                         _ bottom: String = "") -> String {
        guard let node = node else {
            return root + "nil\n"
        }
        if node.leftChild == nil && node.rightChild == nil {
            return root + "\(node.value)\n"
        }
        return diagram(for: node.rightChild,
                       top + " ", top + "┌──", top + "│ ")
            + root + "\(node.value)\n"
            + diagram(for: node.leftChild,
                      bottom + "│ ", bottom + "└──", bottom + " ")
    }
}

extension BinaryNode {
    
    public func traverseInOrder(visit: (Element) -> Void) {
        leftChild?.traverseInOrder(visit: visit)
        visit(value)
        rightChild?.traverseInOrder(visit: visit)
    }
}

extension BinaryNode {
    public func travelsePreOrder(visit: (Element) -> Void) {
        visit(value)
        leftChild?.travelsePreOrder(visit: visit)
        rightChild?.travelsePreOrder(visit: visit)
        
    }
}


extension BinaryNode {
    public func travelsePostOrder(visit: (Element) -> Void) {
        leftChild?.travelsePostOrder(visit: visit)
        rightChild?.travelsePostOrder(visit: visit)
        visit(value)
    }
}

extension BinaryNode {
    public var isLeafNode: Bool {
        if self.leftChild == nil || self.rightChild == nil {
            return true
        }
        return false
    }
}

extension BinaryNode {
    
}

//extension BinaryNode {
//
//    public var height: Int {
//        var newHeight: Int = 0
//
//        if self.isLeafNode {
//            return 0
//        }
////        if self.leftChild {
////           newHeight = newHeight + 1
////        }
////
////        if self.rightChild {
////            return self.rightChild.height + 1
////        }
////
////
////
////    public var isEmpty: Bool {
////        if self == nil {
////            return true
////        }
////        return false
////    }
////
////    public func recursiveLeftHeight() -> Int?{
////
////        if let self.leftChild {
////
////        } else {
////
////        }
////        return self.leftChild?.recursiveLeftHeight() + 1
////    }
////
////    public func recursiveRightHeight() -> Int?{
////
////        return self.rightChild?.recursiveRightHeight() + 1
////    }
//
////    public func findHeight() -> Int? {
////        var rootOfTree = self.value
////        return self.recursiveRightHeight()
//    }
//}
//
////extension Array {
////    public func arrayToTree() -> BinaryNode<Element>? {
////        var tempArray = self
////        tempArray.removeAll()
////
////        self.forEach{
////            tempArray.append(BinaryNode($0))
////        }
////          return nil
////    }
////}
////
////
//
//
//
//
//
//
//
//
//
//
//
//
