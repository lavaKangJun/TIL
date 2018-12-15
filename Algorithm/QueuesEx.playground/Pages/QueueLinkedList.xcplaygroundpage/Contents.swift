import Foundation


print("*****QueueArray*****")
var arrayQueue = QueueArray<String>()
arrayQueue.enqueue("Ray")
arrayQueue.enqueue("Brian")
arrayQueue.enqueue("Eric")
arrayQueue.reversed()
print(arrayQueue)
arrayQueue.dequeue()
print(arrayQueue)
arrayQueue.peek

print("*****QueueLinkedList*****")
var listQueue = QueueLinkedList<String>()
listQueue.enqueue("Ray")
listQueue.enqueue("Brian")
listQueue.enqueue("Eric")
print(listQueue)
listQueue.dequeue()
print(listQueue)


print("*****Queue*****")


//var monopolyQueue = QueueArray<String>()
//monopolyQueue.enqueue("Vincent")
//monopolyQueue.enqueue("Remel")
//monopolyQueue.enqueue("Lukiih")
//monopolyQueue.enqueue("Allison")
//print(queue)
//
//print("===== boardgame =======")
//monopolyQueue.nextPlayer()
//print(monopolyQueue)
//monopolyQueue.nextPlayer()
//print(monopolyQueue)
//monopolyQueue.nextPlayer()
//print(monopolyQueue)
//monopolyQueue.nextPlayer()
//print(monopolyQueue)


print("challenge")
