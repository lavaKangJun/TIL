//: Playground - noun: a place where people can play

import UIKit

print("*****using queue of array*****")
var queue = QueueArray<String>()
queue.enqueue("Ray")
queue.enqueue("Brian")
queue.enqueue("Eric")
print(queue)
queue.dequeue()
print(queue)
queue.peek
