class Solution {
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        var frequencyMap: [Int: Int] = [:]
        
        for num in nums {
            if frequencyMap[num] != nil {
                frequencyMap[num]? += 1
            } else {
                frequencyMap[num] = 1
            }
        }
        
        return Array(
            frequencyMap.sorted { lhs, rhs in
                lhs.value > rhs.value
            }.map(\.key)
            .prefix(k)
        )
    }
}

let solution = Solution()
solution.topKFrequent([1,1,1,2,2,3], 2)
