//: [Previous](@previous)

import Foundation

print("*****Queue RingBuffer*****")

var queueRingBuffer = QueueRingBuffer<String>(count: 10)
queueRingBuffer.enqueue("Ray")
queueRingBuffer.enqueue("Brian")
queueRingBuffer.enqueue("Eric")
print(queueRingBuffer)
queueRingBuffer.dequeue()
print(queueRingBuffer)
print(queueRingBuffer.peek)

