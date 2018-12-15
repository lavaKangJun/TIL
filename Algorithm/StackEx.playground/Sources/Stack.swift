import Foundation
import Swift

public struct Stack<Element> {
    
    private var storage: [Element] = []
    
    public init() {}
    
    public init(_ elements: [Element]) {
        storage = elements
    }
    
    public var isEmpty: Bool {
        return peek() == nil
    }
    
    public mutating func push(_ element: Element) {
        storage.append(element)
    }
    
    @discardableResult
    public mutating func pop() -> Element? {
        return storage.popLast()
    }
    
    public func peek() -> Element? {
        return storage.last
    }
}

extension Stack: CustomStringConvertible {
    
    public var description: String {
        let topDriver = "-----top-----\n"
        let buttonDriver = "\n-------------"
        
        let stackElement = storage
            .map{ "\($0)"}
            .reversed()
            .joined(separator: "\n")
        return topDriver + stackElement + buttonDriver
        
    }
}

extension Stack: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        storage = elements
    }
}

extension Stack {
    
    public mutating func checkBalance(_ sentence: String ) -> Stack<Element> {
        var sentenceArray = Array(sentence)
        var reversedParenthese: Stack<Element> = []
        
        for index in sentenceArray.indices {
            if sentenceArray[index] == ")" ||  sentenceArray[index] == "(" {
                reversedParenthese.push(sentenceArray[index])
            }
        }
        return reversedParenthese
    
    }
}
