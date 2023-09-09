
//Definition for singly-linked list.
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int, next: ListNode? = nil) {
        self.val = val
        self.next = next
    }
}

class Solution {
    func hasCycle(_ head: ListNode?) -> Bool {
        var visited: Set<ObjectIdentifier> = []
        var iter = head
        while let current = iter {
            if visited.contains(ObjectIdentifier(current)) {
                return true
            } else {
                visited.insert(current)
            }
            iter = current.next
        }
        return false
    }
}


let list = ListNode(1, next: ListNode(2))
let solution = Solution()
solution.hasCycle(list)
