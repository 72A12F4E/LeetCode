// A split of an integer array is good if:
//
// The array is split into three non-empty contiguous subarrays - named left,
// mid, right respectively from left to right. The sum of the elements in left
// is less than or equal to the sum of the elements in mid, and the sum of the
// elements in mid is less than or equal to the sum of the elements in right.
// Given nums, an array of non-negative integers, return the number of good ways
// to split nums. As the number may be too large, return it modulo 109 + 7.
//

extension Sequence where Element: AdditiveArithmetic {
    func sum() -> Element { reduce(.zero, +) }
}

class Solution {
    func waysToSplit(_ nums: [Int]) -> Int {
        // sum of left <= sum of mid <= sum of right
        var validSplits = 0
        
        // The dumb solution just iterate everything
        // cubic runtime with the redundant sums. Def can be optimized
        for rightSplit in 2..<nums.endIndex {
            for midSplit in 1..<rightSplit {
                let left = nums[0..<midSplit]
                let mid = nums[midSplit..<rightSplit]
                let right = nums[rightSplit..<nums.endIndex]
                if left.sum() <= mid.sum() && mid.sum() <= right.sum() {
                    validSplits += 1
                }
            }
        }

        return validSplits % 1000000007
    }
}

let solution = Solution()
solution.waysToSplit([1,2,2,2,5,0])
