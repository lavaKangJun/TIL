//: Playground - noun: a place where people can play

import UIKit

print("Check for balanced parentheses")
var stringForCheck = "((hello))()()"


print("*****using a stack*****")
var stack = Stack<Int>()
stack.push(1)
stack.push(2)
stack.push(3)
stack.push(4)

print(stack)

if let popElement = stack.pop() {
    assert(4 == popElement)
    print("Pop: \(popElement)")
}


print("\n*****initializing a stack from array*****")
var array = ["A", "B", "C", "D"]
var stackForArray = Stack(array)
print(stackForArray)
stackForArray.pop()
print(stackForArray)

print("\n*****initializing a stack from an array literal *****")
var stackForLiteral: Stack = [1.0, 2.0, 3.0, 4.0]
print(stackForLiteral)
stackForLiteral.pop()
print(stackForLiteral)
