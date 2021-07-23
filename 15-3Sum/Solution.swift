class Solution {
    /// Naive solution of just trying all the pairs & removing duplicates.
    /// Three nested loops means a runtime of O(n^3). Not very good at all.
    /// Plus, we can still end up with dupes, so we keep our solutions sorted
    /// and need to pass the entire solution through a Set to get rid of those.
    func threeSumNaive(_ nums: [Int]) -> [[Int]] {
        let sorted = nums.sorted()
        var solutions: [[Int]] = []
        for (i, x) in sorted.enumerated() {
            for (j, y) in sorted.enumerated() where i != j {
                for (k, z) in sorted.enumerated() where i != k && j != k {
                    if x + y + z == 0 {
                        solutions.append([x, y, z].sorted())
                    }
                }
            }
        }
        return Array(Set(solutions))
    }
    
    ///
    /// The strategy here is sorting and iterating over the entire array.
    /// Since the array is sorted, we can make the assumption that we can 
    /// "hone in" on a set of matching elements (j and k) that will fulfill
    /// the condition `i + j + k == 0`
    /// 
    /// Inside the loop, start `j` at the 1st unvisited element, and start `k` at 
    /// the end. Check and see if we have a valid sum. If we do, keep it! 
    ///
    /// If not, we either choose to move `j` forward or move `k` backward
    /// based on if the sum is negative or positive. If its negative we move `j`,
    /// since we need to "average up" our sum. If the sum is positive, we overshot,
    /// so we move `k` to "average down" the sum.
    ///
    /// Eventually, we'll exhaust all of the possibilities for a specific `i`, and we'll 
    /// finish an iteration of the outer loop. 
    ///
    /// When all of the `i`'s  are checked, we're done!
    ///
    /// The general rule for doubly nested loops is O(n^2)
    func threeSum(_ nums: [Int]) -> [[Int]] {
        guard nums.count >= 3 else { return [] }
        let nums = nums.sorted()
        var solutions: [[Int]] = []
        
        for i in 0..<nums.count {
            // Skip the `i` number if we had two matching numbers in a row
            if nums.indices.contains(i - 1), nums[i] == nums[i - 1] { continue }

            // Start `j` and `k` at both ends of the unvisited part of the array
            var j = i + 1
            var k = nums.count - 1
            // "Hone in" on a solution
            while j < k {
                let sum = nums[i] + nums[j] + nums[k]
                if sum == 0 {
                    solutions.append([nums[i], nums[j], nums[k]])
                    
                    // Skip the `j` number if we had two matching numbers in a row
                    repeat {
                        j += 1
                    } while j < k && nums[j] == nums[j - 1]
                } else if sum < 0 {
                    j += 1 // "average up"
                } else {
                    k -= 1 // "average down"
                }
            }
        }
        
        return solutions
    }
}