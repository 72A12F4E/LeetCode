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

// Just dump it into an array, and compare the arrays lol
extension TreeNode {
    func asArray() -> [Int?] {
        [val] + (left?.asArray() ?? [nil]) + (right?.asArray() ?? [nil])
    }
}

class Solution {
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        p?.asArray() == q?.asArray()
    }
}

// Actually recrusively traverse the tree & compare
class Solution {
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        if p == nil && q == nil {
            return true
        }
        guard let p = p, let q = q else {
            return false
        }
        return p.val == q.val &&
            isSameTree(p.left, q.left) &&
            isSameTree(p.right, q.right)
    }
}