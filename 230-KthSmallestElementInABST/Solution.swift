import Foundation

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

extension TreeNode {
    func traverseInOrder(
        visitor: (TreeNode) -> Void,
        cancel: () -> Bool
    ) {
        if cancel() { return }
        left?.traverseInOrder(visitor: visitor, cancel: cancel)
        if cancel() { return }
        visitor(self)
        if cancel() { return }
        right?.traverseInOrder(visitor: visitor, cancel: cancel)
    }
}

class Solution {
    func kthSmallest(_ root: TreeNode?, _ k: Int) -> Int {
        var count = 0
        var current: TreeNode!
        
        root?.traverseInOrder { node in
            current = node
            count += 1
        } cancel: {
            count >= k
        }
        
        return current.val
    }
}
