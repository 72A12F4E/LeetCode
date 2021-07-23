class Solution {
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var a = l1
        var b = l2
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
}
