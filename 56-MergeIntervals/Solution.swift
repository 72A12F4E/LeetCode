class Solution {
    func merge_in_place(_ ints: [[Int]]) -> [[Int]] {
        var intervals = ints.sorted { lhs, rhs in
            lhs[0] < rhs[0]
        }
        
        var index = intervals.startIndex.advanced(by: 1)
        while index != intervals.endIndex {
            var previous = intervals[index - 1]
            var current = intervals[index]
            if previous[1] >= current[0] {
                intervals[index - 1] = []
                intervals[index] = [
                    min(previous[0], current[0]),
                    max(previous[1], current[1])
                ]
            }
            
            index = index.advanced(by: 1)
        }
        intervals.removeAll(where: \.isEmpty)
        return intervals
    }
    
    func merge_new_array(_ ints: [[Int]]) -> [[Int]]{
        var intervals = ints.sorted { lhs, rhs in
            lhs[0] < rhs[0]
        }
        var result: [[Int]] = [intervals.first!]
        for interval in intervals.dropFirst() {
            guard let previous = result.last else { continue }
            if interval[0] <= previous[1] {
                result.removeLast()
                let merged = [
                    min(previous[0], interval[0]),
                    max(previous[1], interval[1])
                ]
                result.append(merged)
            } else {
                result.append(interval)
            }
        }
        return result
    }
    
    func merge_but_is_too_complex_for_leetcode_to_judge(_ ints: [[Int]]) -> [[Int]] {
        ints.sorted { lhs, rhs in
            lhs[0] < rhs[0]
        }.reduce([[Int]]()) { partialResult, range -> [[Int]] in
            guard let previous = partialResult.last,
                  range[0] <= previous[1]
            else {
                return partialResult + [range]
            }
            return partialResult.dropLast() + [
                [min(previous[0], range[0]), max(previous[1], range[1])]
            ]
        }
    }
}

let solution = Solution()
solution.merge([[1,4],[5,6]]) // [[1, 4], [5, 6]]
solution.merge([[1,3],[2,6],[8,10],[15,18]]) // [[1, 6], [8, 10], [15, 18]]
solution.merge([[1,4],[2,3]]) // [[1, 4]]
solution.merge([[0,0],[1,2],[5,5],[2,4],[3,3],[5,6],[5,6],[4,6],[0,0],[1,2],[0,2],[4,5]]) // [[0, 6]]
