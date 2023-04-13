
//Definition for a binary tree node.
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

class SolutionFunctional {
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        root.flatMap { node in
            TreeNode(node.val, invertTree(node.right), invertTree(node.left))
        }
    }
}

class SolutionOptimized {
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        guard var root = root else { return nil }
        let tmp = root.right
        root.right = invertTree(root.left)
        root.left = invertTree(tmp)
        return root
    }
}
