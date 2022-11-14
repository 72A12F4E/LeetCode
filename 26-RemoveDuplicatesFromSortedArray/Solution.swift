class Solution {
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        guard nums.count > 1 else  {
            return nums.count
        }
        
        // Iterate over nums. When you encounter a new value,
        // store the value into the next available slot. 
        var slot = 0
        for index in 1..<nums.count {
            if nums[slot] != nums[index] {
                slot += 1
                nums[slot] = nums[index]
            }
        }
        
        return slot + 1
    }
}