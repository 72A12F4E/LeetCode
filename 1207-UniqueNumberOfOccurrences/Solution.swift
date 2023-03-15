class Solution {
    func uniqueOccurrences(_ arr: [Int]) -> Bool {
        var dict: [Int: Int] = [:]
        for value in arr {
            if let count = dict[value] {
                dict[value] = count + 1
            } else {
                dict[value] = 1
            }
        }
        
        return dict.values.count == Set(dict.values).count
    }
}