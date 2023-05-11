
import Foundation

class Solution {
    func eraseOverlapIntervals(_ ints: [[Int]]) -> Int {
        guard !ints.isEmpty else { return 0 }
        let intervals = ints.sorted(by: { lhs, rhs in
            lhs[0] < rhs[0]
        })
        
        var previous = intervals.first!
        var result = 0
        for interval in intervals.dropFirst() {
            if interval[0] < previous[1] {
                result += 1
                // This check makes sure we keep the smaller
                // of the two intervals when we continue search
                // keeping the smaller one means we are less likely
                // to overlap later, and we'll get an optimal result
                if interval[1] <= previous[1] {
                    previous = interval
                }
            } else {
                previous = interval
            }
        }
        return result
    }
}



let solution = Solution()
solution.eraseOverlapIntervals([[1,2],[2,3],[3,4],[1,3]]) // 1
solution.eraseOverlapIntervals([[1,2],[1,2],[1,2]]) // 2
