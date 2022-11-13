extension TreeNode {
    func visitInOrder(_ visitor: (Int) -> Void) {
        left?.visitInOrder(visitor)
        visitor(val)
        right?.visitInOrder(visitor)
    }
    
    public convenience init(array values: [Int]) {
        self.init()
        let midIndex = values.count / 2
        self.val = values[midIndex]
        
        let leftRange = values.startIndex..<midIndex
        let rightRange = (midIndex + 1)..<values.endIndex
        if !leftRange.isEmpty {
            self.left = TreeNode(array: Array(values[leftRange]))
        }
        if !rightRange.isEmpty {
            self.right = TreeNode(array: Array(values[rightRange]))
        }
    }
}

class Solution {
    func balanceBST(_ root: TreeNode?) -> TreeNode? {
        var array: [Int] = []
        root?.visitInOrder { value in
            array.append(value)
        }
        return TreeNode(array: array)
    }
}