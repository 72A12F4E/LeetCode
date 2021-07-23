
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}
 
class Solution {
    
    // Builds a new list by picking the smallest node
    // and inserting it at the end of the list. Kinda
    // naive and works, but runs pretty slow.
    func mergeKListsNaive(_ lists: [ListNode?]) -> ListNode? {
        var lists = lists
        
        var result: ListNode?
        var insertionPoint = result
        
        while !lists.isEmpty {
            lists = lists.compactMap { $0 }
            let (index, node) = lists.enumerated().min { (arg0, arg1) in
                let (_, left) = arg0
                let (_, right) = arg1
                if let left = left, let right = right {
                    return left.val < right.val
                }
                return false
            }!
            
            if result == nil {
                result = node
                insertionPoint = node
            } else {
                insertionPoint?.next = node
                insertionPoint = insertionPoint?.next
            }
            
            lists[index] = lists[index]?.next
            lists.removeAll(where: { $0 == nil })
        }
        
        return result
    }
    
    /// Does the merges in a treelike pattern.
    /// We have an implementation of merge2 from LeetCode 21,
    /// so we just repeatedly apply it to pairs of nodes until
    /// we're done. For example, the merges may look like this
    /// * [a, b, c, d, e]
    /// * [ab, cd, e]
    /// * [abcd, e]
    /// * [abcde]
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        func merge(a: ListNode?, b: ListNode?) -> ListNode? {
            var a = a
            var b = b
            guard a != nil else { return b }
            guard b != nil else { return a }
            
            let head: ListNode?
            
            if a!.val < b!.val {
                head = a
                a = a?.next
            } else {
                head = b
                b = b?.next
            }
            var tail = head
            while true {
                if a != nil, b != nil {
                    if a!.val < b!.val {
                        tail?.next = ListNode(a!.val)
                        tail = tail?.next
                        a = a?.next
                    } else {
                        tail?.next = ListNode(b!.val)
                        tail = tail?.next
                        b = b?.next
                    }
                } else if a != nil {
                    tail?.next = ListNode(a!.val)
                    tail = tail?.next
                    a = a?.next
                } else if b != nil {
                    tail?.next = ListNode(b!.val)
                    tail = tail?.next
                    b = b?.next
                } else {
                    break
                }
            }
            
            return head
        }
        
        if lists.isEmpty {
            return nil
        } else if lists.count == 1 {
            return lists[0]
        } else {
            // merge pairs
            var merged: [ListNode?] = []
            let size = lists.count
            for i in stride(from: 0, to: size, by: 2) {
                let left = lists[i]
                var right: ListNode?
                if i + 1 < size {
                    right = lists[i + 1]
                }
                merged.append(merge(a: left, b: right))
            }
            return mergeKLists(merged)
        }
    }
}
