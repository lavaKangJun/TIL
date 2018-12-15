import Foundation
import Swift

public protocol Queue {
    associatedtype Element
    mutating func enqueue(_ elemet: Element) -> Bool
    mutating func dequeue() -> Element?
    var isEmpty: Bool {get}
    var peek: Element? {get}
  //  var curremt: Element? {get set}
}
