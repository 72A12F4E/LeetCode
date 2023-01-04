func transpose(_ array: [[Character]]) -> [[Character]] {
    var transposed: [[Character]] = []
    for row in 0..<array.first!.count {
        var newRow: [Character] = []
        for col in 0..<array.count {
            newRow.append(array[col][row])
        }
        transposed.append(newRow)
    }
    return transposed
}

class Solution {
    func minDeletionSize(_ strs: [String]) -> Int {
        transpose(strs.map(Array.init))
            .filter {
                $0 != $0.sorted()
            }.count
    }
}

Solution().minDeletionSize(["cba","daf","ghi"])
Solution().minDeletionSize(["zyx","wvu","tsr"])
