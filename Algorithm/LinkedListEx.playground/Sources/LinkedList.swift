
import UIKit
import Swift

public struct LinkedList<Value> {
    
    public var head: Node<Value>?
    public var tail: Node<Value>?
    
    public init() {}
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public mutating func push(_ value: Value) {
      //  copyNodes()
        head = Node (value: value, next: head)
        if tail == nil {
            tail = head
        }
    }
    
    public mutating func append(_ value: Value) {
     //   copyNodes()
        guard !isEmpty else {
            push(value)
            return
        }
        tail!.next = Node(value: value)
        tail = tail!.next
    }
    
    public func node(at index: Int) -> Node<Value>? {
        
        var currentNode = head
        var currnetIndex = 0

        while currentNode != nil && currnetIndex < index {
            currentNode = currentNode!.next
            currnetIndex += 1
        }
        
        return currentNode
    }
    
    @discardableResult
    public mutating func insert(_ value: Value, after node: Node<Value>) -> Node<Value> {
         copyNodes()
        
        // === 는 값뿐만 아니라 타입까지 비교
        // == 값만 비교
        guard tail !== node else {
            append(value)
            return tail!
        }
        
        node.next = Node(value: value, next: node.next)
        return node.next!
    }
    
    //@discardableResult: Return of call not used 경고 해결 방법
    @discardableResult
    public mutating func pop() -> Value? {
         copyNodes()
        defer {
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        return head?.value
    }
    
    @discardableResult
    public mutating func removeLast() -> Value? {
        
         copyNodes()
        
        // 노드가 없는경우
        guard let head = head else {
            return nil
        }
        // 노드가 1개인 경우
        guard head.next != nil else {
           return pop()
        }
        
        var prev = head
        var current = head
        
        while let next = current.next {
            prev = current
            current = next
        }
        
        prev.next = nil
        tail = prev
        return current.value
    }
    
    @discardableResult
    public mutating func remove(after node: Node<Value>) -> Value? {
        
        copyNodes()
        
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }
        return node.next?.value
    }
    
    private mutating func copyNodes() {
        
        guard isKnownUniquelyReferenced(&head) else {
            return
        }
        
        guard var oldNode = head else {
            return
        }
        
        head = Node(value: oldNode.value)
        var newNode = head
        
        while let nextOldNode = oldNode.next {
            newNode!.next = Node(value: nextOldNode.value)
            newNode = newNode!.next
            
            oldNode = nextOldNode
        }
        
        tail = newNode
    }
    
    
    
    /////////////////////////////////////
    //////////Challenge//////////////////
    ////1
    public mutating func reverse() -> LinkedList? {
        
        var newList = LinkedList<Value>()
            while !isEmpty {
                newList.push(pop()!)
            }
        return newList
    }
    ////2
    public mutating func reverseTotal(){
    }
    
    public mutating func middleNode() -> Node<Value>? {
        
        if isEmpty {
            return nil
        } else {
            
            var count = 0
            var middleIndex: Int = 0
            var currentNode = head
            var currnetIndex = 0
            
            while !isEmpty {
                count += 1
                pop()
            }
            
            middleIndex = count / 2
            
            while currentNode != nil && currnetIndex < middleIndex {
                currentNode = currentNode!.next
                currnetIndex += 1
            }
            
            print("middleIndex: \(middleIndex)")
            return currentNode
        }
    }
}

extension LinkedList: CustomStringConvertible {
    
    public var description: String {
        guard let head = head else {
            return "Empty list"
        }
        return String(describing: head)
    }
}

extension LinkedList: Collection {
    
    public struct Index: Comparable {
    
        public var node: Node<Value>?
        
        static public func ==(lhs: Index, rhs: Index) ->  Bool {
            switch (lhs.node, rhs.node) {
            case let (left?, right?):
                return left.next === right.next
            case (nil, nil):
                return true
            default:
                return false
            }
        }
        
        static public func <(lhs: Index, rhs: Index) -> Bool {
            guard lhs != rhs else {
                return false
            }
            let nodes = sequence(first: lhs.node) { $0?.next }
            return nodes.contains { $0 === rhs.node }
        }
    }
    
    public var startIndex: Index {
        return Index(node: head)
    }
    
    public var endIndex: Index {
        return Index(node: tail?.next)
    }
    
    public func index(after i: Index) -> Index {
        return
            Index(node: i.node?.next)
    }
    
    public subscript(position: Index) -> Value {
        return position.node!.value
    }
    

}

extension LinkedList {
    
    public mutating func map<T>(transform: (Element) -> T) -> LinkedList<T> {
        
        var transformedList: LinkedList<T> = LinkedList<T>()
        
        for item in self {
            transformedList.append(transform(item))
        }
        return transformedList
    }
    
    public mutating func filter(includeValue: (Value) -> Bool) -> LinkedList<Value> {
        
        var filteredList: LinkedList<Value> = LinkedList<Value>()
        
        for value in self {
            if includeValue(value) {
                filteredList.append(value)
            }
        }
        return filteredList
    }
}

