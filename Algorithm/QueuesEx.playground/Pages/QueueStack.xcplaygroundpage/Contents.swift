import Foundation

print("*****Queue Double Stack*****")
var queue = QueueStack<String>()
queue.enqueue("Ray")
queue.enqueue("Brian")
queue.enqueue("Eric")
print(queue)
queue.dequeue()
print(queue)
print(queue.peek)
