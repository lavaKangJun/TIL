import Foundation

public protocol BoardGameManager {
    
    associatedtype Player
    mutating func nextPlayer() -> Player?
}
