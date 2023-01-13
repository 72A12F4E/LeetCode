class Solution {
    func countOccurences(_ arr: [Int]) -> [Int: Int] {
        var occurences: [Int: Int] = [:]
        for i in arr {
            if let occurence = occurences[i] {
                occurences[i] = occurence + 1
            } else {
                occurences[i] = 1
            }
        }
        return occurences
    }
    
    func minSetSize(_ arr: [Int]) -> Int {
        // count occurences
        let occurences = countOccurences(arr).sorted { left, right in
            left.value > right.value
        }
        
        var size = arr.count
        var removals = 0
        for occurence in occurences {
            size -= occurence.value
            removals += 1
            if size <= arr.count / 2 {
                return removals
            }
        }
        return removals
    }
}