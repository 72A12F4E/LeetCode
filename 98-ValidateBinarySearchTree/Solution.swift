import Foundation

// Definition for a binary tree node.
public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

class Solution {
    func isValidBST(root: TreeNode?, range: ClosedRange<Int>) -> Bool {
        guard let root = root else { return true }
        var flag = true
        if let left = root.left {
            flag = flag &&
                left.val < root.val &&
                range.contains(left.val) &&
                isValidBST(root: left, range: range.lowerBound...(root.val - 1))
        }
        if let right = root.right {
            flag = flag &&
                root.val < right.val &&
                range.contains(right.val) &&
                isValidBST(root: right, range: (root.val + 1)...range.upperBound)
        }
        return flag
    }
    
    func isValidBST(_ root: TreeNode?) -> Bool {
        isValidBST(root: root, range: Int.min...Int.max)
    }
}
