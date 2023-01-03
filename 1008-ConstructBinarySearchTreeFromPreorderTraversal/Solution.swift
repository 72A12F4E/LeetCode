// Provided code

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

// Solution

extension TreeNode {
    func insert(_ value: Int) {
        if value < val {
            if let left = left {
                left.insert(value)
            } else {
                left = TreeNode(value)
            }
        } else {
            if let right = right {
                right.insert(value)
            } else {
                right = TreeNode(value)
            }
        }
    }
}

class Solution {
    func bstFromPreorder(_ preorder: [Int]) -> TreeNode? {
        let root = TreeNode(preorder.first!)
        for value in preorder.dropFirst() {
            root.insert(value)
        }
        return root
    }
}
