import Foundation


/// Definition for singly-linked list.
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

extension ListNode {
    /// Returns the size of the list, assuming the current node is the head
    /// O(n)
    var count: Int {
        var count = 0
        var current: ListNode? = self
        while current != nil {
            count += 1
            current = current?.next
        }
        return count
    }
    
    /// Returns the item at the given index, or `nil` if the index is invalid.
    /// O(n)
    func item(at index: Int) -> ListNode? {
        guard index >= 0 else { return nil }
        var counter = index
        var node: ListNode? = self
        while counter > 0 {
            node = node?.next
            counter -= 1
        }
        return node
    }
}

class Solution {
    
    /// Removes the n-th node from the end of the list.
    ///
    /// This works by counting the number of nodes in
    /// the list (O(size)), then finding the node
    /// before the index `n`.
    ///
    /// * If the identified node is the `head`, we just return
    ///   the `next` node in the list.
    ///
    /// * If the identified node isn't the `head` of the
    ///   list, we simply redirect the nodes
    ///   around the element we wish to exclude.
    ///
    /// - Parameters:
    ///   - head: the lists head
    ///   - n: the index of the node to remove
    /// - Returns: a list with the node at the given index removed.
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        guard let head = head else {
            return nil
        }
        
        let size = head.count
        if let before = head.item(at: size - n - 1) {
            let after = before.next?.next
            before.next = after
            return head
        } else {
            return head.next
        }
    }
}
