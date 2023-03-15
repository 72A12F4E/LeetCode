class Solution {
    func partitionDisjoint_exceedsTimeLimit(_ nums: [Int]) -> Int {
        for index in 1..<nums.count {
            let left = nums[0..<index]
            let right = nums[index...]
            if left.max()! <= right.min()! {
                return index
            }
        }
        return -1
    }
    
    // Optimized by dynamically adjusting the max & min as needed
    func partitionDisjoint(_ nums: [Int]) -> Int {
        var leftMax = nums.first!
        var rightMin = nums.dropFirst().min()!
        for index in 1..<nums.count {
            let left = nums[0..<index]
            let right = nums[index...]
            // update left max
            if left.last! > leftMax {
                leftMax = left.last!
            }
            // update right min
            if left.last! == rightMin {
                rightMin = right.min()!
            }
            
            if leftMax <= rightMin {
                return index
            }
        }
        return -1
    }
}

let solution = Solution()
solution.partitionDisjoint([5,0,3,8,6]) // 3
solution.partitionDisjoint([1,1,1,0,6,12]) // 4
solution.partitionDisjoint([1,1]) // 1
