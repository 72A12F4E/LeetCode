// The lesson here?
//
// Equality follows the transitive property, but non-equality doesn't. 🤪
//
class Solution {
    func unequalTriplets(_ nums: [Int]) -> Int {
        var triplets = 0
        let count = nums.count
        for i in 0..<count - 2 {
            for j in (i + 1)..<count - 1 where nums[i] != nums[j] {
                for k in (j + 1)..<count {
                    if nums[j] != nums[k] && nums[i] != nums[k] {
                        triplets += 1
                    }
                }
            }
        }
        return triplets
    }
}


let solution = Solution()
solution.unequalTriplets([4,4,2,4,3])
solution.unequalTriplets([2,1,1])
