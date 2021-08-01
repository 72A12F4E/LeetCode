import Foundation

class Solution {
    
    /// This algorithm runs in 1 pass of the list
    ///  O(size)
    ///
    ///  1. Maintain two pointers, `a` & `b`.
    ///  2. Move `b` until it is `n` nodes ahead of `a`.
    ///  3. Advance both until `b` is at the list's end.
    ///  4. Redirect the list path around the node to skip (at `a.next`)
    ///  5. Return the modified list.
    ///
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        // Create a "start" node in front of the head of the list.
        // This helps deal with an edge case later where we might
        // want to remove the `head`.
        let start: ListNode? = ListNode(-1, head)
        var a = start
        var b = start
        // advance `b` to position `n` in the list
        for _ in 0...n {
            b = b?.next
        }
        
        // Advance both pointers until b is at the end.
        while b != nil {
            a = a?.next
            b = b?.next
        }
        
        // redirect node `a` around the node we want to skip.
        a?.next = a?.next?.next
        return start?.next
    }
}
