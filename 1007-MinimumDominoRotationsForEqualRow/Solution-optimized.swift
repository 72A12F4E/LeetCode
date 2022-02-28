///
/// Optimized solution: O(2*n)
///
/// Look at every domino, and see if they contain a value from the
/// 1st domino. If so, count the number of flips to put all values on
/// either the bottom or top row.
///
class Solution {
    func minDominoRotations(_ tops: [Int], _ bottoms: [Int]) -> Int {
        var minFlips = Int.max
        for target in [tops[0], bottoms[0]] {
            var possible = true
            var topCount = 0
            var bottomCount = 0
            for i in 0..<tops.count {
                let top = tops[i]
                let bottom = bottoms[i]
                /// If a bone doesn't have the target number, exit early.
                if top != target && bottom != target {
                    possible = false
                    break
                }
                
                /// Skip over doubles; they're useless.
                if top == bottom { continue }
                
                /// increment the top & bottom values
                /// if they match the target value.
                if top == target {
                    topCount += 1
                } else {
                    bottomCount += 1
                }
            }
            
            /// Only calculate `minFlips` if we know its
            /// possible for a solution to exist.
            if possible {
                minFlips = min(min(topCount, bottomCount), minFlips)
            }
        }
        return minFlips == Int.max ? -1 : minFlips
    }
}

let solution = Solution()
solution.minDominoRotations([2,1,2,4,2,2], [5,2,6,2,3,2]) // 2
solution.minDominoRotations([3,5,1,2,3], [3,6,3,3,4]) // -1
solution.minDominoRotations([1,2,1,1,1,2,2,2], [2,1,2,2,2,2,2,2]) // 1
