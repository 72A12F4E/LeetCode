class Solution {
    // Naievite works again, but not very well.
    // O(n^3)
    func threeSumClosestNaive(_ nums: [Int], _ target: Int) -> Int {
        guard nums.count >= 3 else { return -1 }
        let nums = nums.sorted()
        var closest: Int?
        for i in 0..<nums.count {
            for j in 0..<nums.count {
                for k in 0..<nums.count {
                    guard i != j && i != k && j != k else { continue }
                    let sum = nums[i] + nums[j] + nums [k]
                    if closest == nil { closest = sum }
                    guard let closestSum = closest else { return Int.min }
                    if closestSum == target { return target }
                    if abs(sum - target) < abs(closestSum - target) {
                        closest = sum
                    }
                }
            }
        }
        
        return closest!
    }
    
    // This is the same general "three pointer" approach of 3sum, except instead
    // of comparing to zero and aggregating all solutions, we just keep the
    // closest sum and compare to the target instead. O(n*log(n)) for sorting +
    // O(n^2) for the nested loops puts runtime at ~O(n^2)
    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        guard nums.count >= 3 else { return -1 }
        let nums = nums.sorted()
        var result = 0
        
        for i in 0..<nums.count - 2 {
            var j = i + 1
            var k = nums.count - 1
            while j < k {
                let sum = nums[i] + nums[j] + nums[k]
                if target < sum {
                    k -= 1
                } else {
                    j += 1
                }
                
                if abs(sum - target) < abs(result - target) {
                    result = sum
                }
            }
        }
        return result
    }
}