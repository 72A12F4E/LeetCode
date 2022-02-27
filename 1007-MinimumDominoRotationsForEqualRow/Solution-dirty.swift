/// In a row of dominoes, tops[i] and bottoms[i] represent the top and bottom
/// halves of the ith domino. (A domino is a tile with two numbers from 1 to
/// 6 - one on each half of the tile.)
///
/// We may rotate the ith domino, so that tops[i] and bottoms[i] swap values.
///
/// Return the minimum number of rotations so that all the values in tops are
/// the same, or all the values in bottoms are the same.
///
/// If it cannot be done, return -1.

/// I implemented this one blind, and I feel like it is not efficient
/// and I could do a lot better. The frequency map feels kinda expensive,
/// and I could build the `zip`'d ' data structure a lot sooner. I'm gonna
/// spend some time trying to optimize this.

class Solution {
    func minDominoRotations(_ tops: [Int], _ bottoms: [Int]) -> Int {
        let all = (tops + bottoms)
        var required = tops.count
        
        /// Find most common elements
        var frequency = [Int: Int]()
        for num in all {
            if let count = frequency[num] {
                frequency[num] = count + 1
            } else {
                frequency[num] = 1
            }
        }
        
        let mostCommon = frequency.sorted {
            $0.value > $1.value
        }.map {
            $0.key
        }
        
        for common in mostCommon {
            /// Validate the rotations are even possible
            var topCount = 0
            var bottomCount = 0
            for (top, bottom) in zip(tops, bottoms) {
                if top == bottom && top == common {
                    required -= 1
                    continue
                }
                if top == common {
                    topCount += 1
                }
                if bottom == common {
                    bottomCount += 1
                }
            }
            
            // If not possible, exit. We're sorted, remember?
            guard topCount + bottomCount >= required else { return -1 }
            
            return min(topCount, bottomCount)
        }
        
        return -1
    }
}

let solution = Solution()
/// Input: `tops = [2,1,2,4,2,2], bottoms = [5,2,6,2,3,2]`
/// Output: `2`
/// Explanation:
/// The first figure represents the dominoes as given by tops and bottoms:
/// before we do any rotations.
/// If we rotate the second and fourth dominoes, we can make every value in the
/// top row equal to 2, as indicated by the second figure.
solution.minDominoRotations([2,1,2,4,2,2], [5,2,6,2,3,2]) // 2

/// Input: tops = [3,5,1,2,3], bottoms = [3,6,3,3,4]
/// Output: -1
/// Explanation:
/// In this case, it is not possible to rotate the dominoes to make one row of
/// values equal.
solution.minDominoRotations([3,5,1,2,3], [3,6,3,3,4]) // -1
