// Given an integer array nums, return an array answer such that answer[i]
// is equal to the product of all the elements of nums except nums[i].
//
// The product of any prefix or suffix of nums is guaranteed to fit
// in a 32-bit integer.
//
// You must write an algorithm that runs in O(n) time and without using the
// division operation.

// Overall, wasn't a fan of this one. It felt like too
// much of a mathematical "gotcha" with the constraints.
class Solution {
    func productExceptSelf_naive(_ nums: [Int]) -> [Int] {
        // In this case, we iterate O(n^2) over the array
        // to calculate the products, and skip the current
        // element based on the requirements
        var products = Array(repeating: 1, count: nums.count)
        for index in 0..<nums.count {
            for (offset, num) in nums.enumerated() where index != offset {
                products[index] *= num
            }
        }
        return products
    }
    
    func productExceptSelf_in_linear_time(_ nums: [Int]) -> [Int] {
        // The arrays store the product so far, starting from
        // either the start or end. After we calculate this,
        // we can use the values at these locations to form
        // the product, excluding the current number.
        let count = nums.count
        var prefix = Array(repeating: 1, count: count)
        var suffix = Array(repeating: 1, count: count)
        
        for index in 1..<count {
            prefix[index] = prefix[index - 1] * nums[index - 1]
        }
        
        for index in (0..<count - 1).reversed() {
            suffix[index] = suffix[index + 1] * nums[index + 1]
        }
        
        var result = Array(repeating: 0, count: count)
        for index in 0..<count {
            result[index] = prefix[index] * suffix[index]
        }
        return result
    }
}

let solution = Solution()
solution.productExceptSelf([1, 2, 3, 4])
solution.productExceptSelf([-1,1,0,-3,3])
