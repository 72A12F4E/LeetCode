import Foundation

//Definition for a binary tree node.
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

// Since this is a BST, the common ancstor will be strictly between
// the lower & higher of the p & q's values. ~O(log(n)) since this is
// just a binary search.
class Solution {
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        guard let p = p, let q = q, let root = root else {
            return nil
        }
        
        let lower = p.val < q.val ? p : q
        let higher = p.val < q.val ? q : p
        
        if higher.val < root.val {
            return lowestCommonAncestor(root.left, lower, higher)
        } else if lower.val > root.val {
            return lowestCommonAncestor(root.right, lower, higher)
        }
        
        return root
    }
}


// The slow way, by computing parent relationships for each `TreeNode`
// O(n + k^2) where n is number of nodes, and k is max(depth(p), depth(q))
extension TreeNode: Hashable {
    public static func ==(lhs: TreeNode, rhs: TreeNode) -> Bool {
        ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}

class SolutionSlow {
    
    var parents: [TreeNode: TreeNode] = [:]
    
    func calculateParents(_ root: TreeNode?) {
        guard let root = root else { return }
        
        if let left = root.left {
            parents[left] = root
            calculateParents(left)
        }
        if let right = root.right {
            parents[right] = root
            calculateParents(right)
        }
    }
    
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        guard let p = p, let q = q else { return nil }
        calculateParents(root)
        
        let pAncestry = Array(sequence(first: p) {
            self.parents[$0]
        })
        
        let qAncestry = Array(sequence(first: q) {
            self.parents[$0]
        })
        
        for ancestor in pAncestry {
            if qAncestry.contains(ancestor) {
                return ancestor
            }
        }
        
        return root
    }
}
