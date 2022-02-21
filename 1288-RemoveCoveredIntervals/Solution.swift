// Given an array intervals where intervals[i] = [li, ri] represent the interval [li, ri), remove all intervals that are covered by another interval in the list.
//
// The interval [a, b) is covered by the interval [c, d) iff c <= a and b <= d.
//
// Return the number of remaining intervals.
//
class Solution {
    func removeCoveredIntervals(_ intervals: [[Int]]) -> Int {
        /// Sort the list to ensure that adjacent intervals will be compared
        /// with eachother. Make sure the wider interval gets precedence by
        /// comparing the 'right' values.
        var intervals: [[Int]?] = intervals.sorted { lhs, rhs in
            if lhs[0] < rhs[0] {
                return true
            } else if lhs[0] == rhs[0] {
                return lhs[1] > rhs[0]
            }
            return false
        }
        
        /// For each interval in the list, compare and see if of the
        /// intervals ahead of it are covered. If they are covered, set
        /// the covered interval to `nil`.
        for i in 0..<intervals.count {
            guard let first = intervals[i] else { continue}
            for j in (i + 1)..<intervals.count {
                guard let next = intervals[j] else { continue }
                
                /// If the intervals don't overlap, continue on break out
                /// and continue with the next interval to compare
                guard first[0] <= next[0],
                    next[1] <= first[1] else {
                    break
                }
                
                intervals[j] = nil
            }
        }
        /// Filter out the `nil` elements and return the count
        return intervals.compactMap { $0 }.count
    }
}