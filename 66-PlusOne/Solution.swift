class Solution {
    func plusOne(_ digits: [Int]) -> [Int] {
        var copy = digits
        var index = digits.endIndex - 1
        var carry = true
        
        while carry && index >= copy.startIndex {
            copy[index] += 1
            if copy[index] == 10 {
                copy[index] = 0
                carry = true
            } else {
                carry = false
            }
            index -= 1
        }
        
        if carry {
            return [1] + copy
        }
        return copy
    }
}

let solution = Solution()
solution.plusOne([4, 3, 2, 1])
solution.plusOne([9])
solution.plusOne([8,9,9,9])
