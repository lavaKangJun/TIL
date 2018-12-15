import Foundation

public class TreeNode<T> {
    public var value: T
    public var children: [TreeNode] = []
    
    public init(_ value: T) {
        self.value = value
    }
    
    public func add(_ child: TreeNode) {
        children.append(child)
    }
}

extension TreeNode {
    public func forEachDepthFirst(visit: (TreeNode) -> (Void)) {
        visit(self)
        print("slef:\(self.value)")
        children.forEach{
            print("$0: \($0.value)")
            $0.forEachDepthFirst(visit: visit)
        }
    }
}

extension TreeNode {
    public func forEachLevelOrder(visit: (TreeNode) -> (Void)) {
        visit(self)
        var queue = Queue<TreeNode>()
        children.forEach { queue.enqueue($0); print("enquqe: \($0.value)") }
        print(queue)
        while let node = queue.dequeue() {
            visit(node)
         //   print("node children: \(node.children)")
            // 각노드의 children들을 계속해서 queue뒤에 넣어준다.
            node.children.forEach { queue.enqueue($0) }
        //    print("queue: \(queue)")
        }
    }
}

extension TreeNode where T: Equatable {
    public func search(_ value: T) -> TreeNode? {
        var result: TreeNode?
        forEachLevelOrder{ node in
            if node.value == value {
                result = node
            }
        }
        return result
    }
}
