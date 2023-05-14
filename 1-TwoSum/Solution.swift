class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        // Holds number -> index
        var dict: [Int: Int] = [:]
        for (index, num) in nums.enumerated() {
            let diff = target - num
            if let otherIndex = dict[diff] {
                return [otherIndex, index]
            } else {
                dict[num] = index
            }
        }
        fatalError()
    }
}