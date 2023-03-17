
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

// Code

extension ListNode {
    var last: ListNode {
        var last: ListNode = self
        while let next = last.next {
            last = next
        }
        return last
    }
    
    func append(_ node: ListNode?) {
        last.next = node
    }
    
    func copyValue() -> ListNode {
        ListNode(val)
    }
}

class Solution {
    // Yeah, its not in-place or optimized or anything, but it works.
    func partition(_ head: ListNode?, _ x: Int) -> ListNode? {
        // Make two lists, `left` and `right`
        var left: ListNode?
        var right: ListNode?
        
        // Traverse the list, and sort the values into `left` if
        // the value is smaller, or `right` if the value is larger
        var current = head
        while let node = current {
            if node.val < x {
                if let left = left {
                    left.append(node.copyValue())
                } else {
                    left = node.copyValue()
                }
            } else {
                if let right = right {
                    right.append(node.copyValue())
                } else {
                    right = node.copyValue()
                }
            }
            current = node.next
        }

        // Connect the two lists together
        if let left = left {
            left.last.next = right
        } else {
            left = right // What if `left` is empty?
        }
        
        return left
    }
}

// Test Code

extension ListNode: CustomStringConvertible {
    public var description: String {
        var values: [Int] = []
        var node: ListNode? = self
        while let current = node {
            values.append(current.val)
            node = current.next
        }
        return values.description
    }
}

extension ListNode {
    static func makeList(_ arr: [Int]) -> ListNode? {
        guard !arr.isEmpty else { return nil }
        let nodes = arr.map { ListNode($0) }
        for index in 1..<nodes.count {
            nodes[index - 1].next = nodes[index]
        }
        return nodes.first
    }
}

let solution = Solution()
let list = ListNode.makeList([1,4,3,2,5,2])
solution.partition(list, 3)
solution.partition(.makeList([1]), 0)
