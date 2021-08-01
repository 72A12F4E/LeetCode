class Solution { 
    // Runs in O(n)
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        var left = nums.startIndex
        var right = nums.endIndex
        while left < right {
            if nums[left] == val {
                nums.swapAt(left, right - 1)
                right -= 1
            } else {
                left += 1
            }
        }
        return left
    }
}