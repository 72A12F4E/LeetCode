// Still a work in progress that could use some optimization

class Solution {
    struct Attempt: Hashable {
        let first: Int
        let second: Int
        let third: Int
        let fourth: Int
    }
    
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        let nums = nums.sorted()
        var offsetAttempts: Set<Attempt> = []
        var numAttempts: Set<[Int]> = []
        
        var results: [[Int]] = []
        for (firstOffset, firstNum) in nums.enumerated() {
            for (secondOffset, secondNum) in nums.enumerated() where firstOffset < secondOffset {
                for (thirdOffset, thirdNum) in nums.enumerated() where secondOffset < thirdOffset {
                    for (fourthOffset, fourthNum) in nums.enumerated() where thirdOffset < fourthOffset {
                        // Check offsets for uniqueness
                        let offsetAttempt = Attempt(
                            first: firstOffset,
                            second: secondOffset,
                            third: thirdOffset,
                            fourth: fourthOffset
                        )
                        let offsetUnique = offsetAttempts.insert(offsetAttempt).inserted
                        guard offsetUnique else { continue }
                        
                        // Check the nums for uniqueness
                        let numAttempt = [firstNum, secondNum, thirdNum, fourthNum].sorted()
                        let numsUnique = numAttempts.insert(numAttempt).inserted
                        guard numsUnique else { continue }
                        
                        guard firstNum + secondNum + thirdNum + fourthNum == target else {
                            continue
                        }
                        
                        results.append(numAttempt)
                    }
                }
            }
        }
        
        return results
    }
}
