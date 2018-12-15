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




