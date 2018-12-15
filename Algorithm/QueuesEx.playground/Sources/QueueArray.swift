import Foundation
import Swift

public struct QueueArray<T>: Queue {
    private var array: [T] = []
    public init() {}
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var peek: T? {
        return array.first
    }
    
//    public var current: T? {
//        get {
//            return array.last
//        }
//
//        set {
//            current = newValue
//        }
//    }
    
    public mutating func enqueue(_ element: T) -> Bool {
        array.append(element)
        return true
    }
    
    public mutating func dequeue() -> T? {
        return isEmpty ? nil : array.removeFirst()
    }
    
    public mutating func removeLast() -> T? {
        return isEmpty ? nil : array.removeLast()
    }
    
    public mutating func removeAll() {
        if !array.isEmpty {
            for _ in array.indices {
                self.dequeue()
            }
        }
    }
}

extension QueueArray: CustomStringConvertible {
    public var description: String {
        return String(describing: array)
    }
}

//extension QueueArray: BoardGameManager {
//    // 숙제
//    public mutating func nextPlayer() -> T? {
//        if !self.isEmpty {
//            if current == self.array.last {
//                current = self.array.first
//            } else if (current == self.array.first) {
//                current
//            }
//            self.array.currentIndex = current
//            return array[current]
//        } else {
//            return nil
//        }
//    }
//}


extension QueueArray {
    public mutating func reversed() -> QueueArray {
        var queue = self
        var reversedQueue = queue
        reversedQueue.removeAll()
        while !queue.isEmpty {
            if let empty = queue.removeLast() {
                reversedQueue.enqueue(empty)
            }
        }
        queue = reversedQueue
        return queue
    }
}
