// List Impl
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

class Solution {
    //
    //  No fun allowed clause in the problem statement :-[
    //
    //  You must solve the problem without modifying the values in the list's 
    //  nodes (i.e., only nodes themselves may be changed.)
    //
    //
    func swapPairs_recursive(_ head: ListNode?) -> ListNode? {
        guard let head = head else { return nil }
        guard let next = head.next else { return head }
        
        swap(&head.val, &next.val)
        _ = swapPairs_recursive(next.next)
        
        return head
    }
    
    func swapPairs_iterative(_ head: ListNode?) -> ListNode? {
        var current = head
        var next = current?.next
        
        while let c = current, let n = next {
            swap(&c.val, &n.val)
            current = n.next
            next = current?.next
        }
        
        return head
    }

    // The Real Solution

    func swapPairs(_ head: ListNode?) -> ListNode? {
        guard let head = head else { return nil }
        guard let next = head.next else { return head }
        
        let rest = next.next
        next.next = head
        head.next = swapPairs(rest)
        
        return next
    }
}

/// Test Code

func makeList(_ array: [Int]) -> ListNode? {
    makeList(array[...])
}
func makeList(_ slice: ArraySlice<Int>) -> ListNode? {
    guard let first = slice.first else {
        return nil
    }
    return ListNode(first, makeList(slice.dropFirst()))
}

extension ListNode: CustomStringConvertible {
    public var description: String {
        guard let next else {
            return "\(val)"
        }
        return "\(val), " + next.description
    }
}

let solution = Solution()
solution.swapPairs_recursive(makeList([1, 2, 3, 4, 5]))
solution.swapPairs_iterative(makeList([1, 2, 3, 4])) // [2,1,4,3]
